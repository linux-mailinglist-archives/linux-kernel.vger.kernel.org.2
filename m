Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0311B3B3251
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhFXPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFXPLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:11:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66DDD613C3;
        Thu, 24 Jun 2021 15:09:14 +0000 (UTC)
Date:   Thu, 24 Jun 2021 16:09:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <20210624150911.GA25097@arm.com>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNRpYli/5/GWvaTT@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 12:15:46PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 24, 2021 at 08:04:07AM +0100, Christoph Hellwig wrote:
> > On Thu, Jun 24, 2021 at 04:24:46AM +0100, Matthew Wilcox wrote:
> > > On Thu, Jun 24, 2021 at 11:10:41AM +0800, Chen Huang wrote:
> > > > In userspace, I perform such operation:
> > > > 
> > > >  	fd = open("/tmp/test", O_RDWR | O_SYNC);
> > > >         access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
> > > >         ret = write(fd, access_address + 2, sizeof(long));
> > > 
> > > ... you know that accessing this at unaligned offsets isn't going to
> > > work.  It's completely meaningless.  Why are you trying to do it?
> > 
> > We still should not cause an infinite loop in kernel space due to a
> > a userspace programmer error.
> 
> They're running as root and they've mapped some device memory.  We can't
> save them from themself.  Imagine if they'd done this to the NVMe BAR.

Ignoring the MMIO case for now, I can trigger the same infinite loop
with MTE (memory tagging), something like:

	char *a;

	a = mmap(0, page_sz, PROT_READ | PROT_WRITE | PROT_MTE,
		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	/* tag 0 is the default, set tag 1 for the next 16 bytes */
	set_tag((unsigned long)(a + 16) | (1UL << 56));

	/* uaccess to a[16] expected to fail */
	bytes = write(fd, a + 14, 8);

The iov_iter_fault_in_readable() check succeeds since a[14] has tag 0.
However, the copy_from_user() attempts an unaligned 8-byte load which
fails because of the mismatched tag from a[16]. The loop continues
indefinitely.

copy_from_user() is not required to squeeze in as much as possible. So I
think the 1-byte read per page via iov_iter_fault_in_readable() is not
sufficient to guarantee progress unless copy_from_user() also reads at
least 1 byte.

We could change raw_copy_from_user() to fall back to 1-byte read in case
of a fault or fix this corner case in the generic code. A quick hack,
re-attempting the access with one byte:

------------------8<-------------------------
diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..67059071460c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3686,8 +3686,18 @@ ssize_t generic_perform_write(struct file *file,
 			 * because not all segments in the iov can be copied at
 			 * once without a pagefault.
 			 */
-			bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_single_seg_count(i));
+			unsigned long single_seg_bytes =
+				min_t(unsigned long, PAGE_SIZE - offset,
+				      iov_iter_single_seg_count(i));
+
+			/*
+			 * Check for intra-page faults (arm64 MTE, SPARC ADI)
+			 * and fall back to single byte.
+			 */
+			if (bytes > single_seg_bytes)
+				bytes = single_seg_bytes;
+			else
+				bytes = 1;
 			goto again;
 		}
 		pos += copied;
------------------8<-------------------------

Or a slightly different hack, trying to detect if the first segment was
crossing a page boundary:

------------------8<-------------------------
diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..7d1c03f5f559 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3678,16 +3678,24 @@ ssize_t generic_perform_write(struct file *file,
 
 		iov_iter_advance(i, copied);
 		if (unlikely(copied == 0)) {
+			struct iovec v = iov_iter_iovec(i);
+
 			/*
 			 * If we were unable to copy any data at all, we must
-			 * fall back to a single segment length write.
+			 * fall back to a single segment length write or a
+			 * single byte write (for intra-page faults - arm64
+			 * MTE or SPARC ADI).
 			 *
 			 * If we didn't fallback here, we could livelock
-			 * because not all segments in the iov can be copied at
-			 * once without a pagefault.
+			 * because not all segments in the iov or data within
+			 * a segment can be copied at once without a fault.
 			 */
-			bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_single_seg_count(i));
+			if (((unsigned long)v.iov_base & PAGE_MASK) ==
+			    ((unsigned long)(v.iov_base + bytes) & PAGE_MASK))
+				bytes = 1;
+			else
+				bytes = min_t(unsigned long, PAGE_SIZE - offset,
+					      iov_iter_single_seg_count(i));
 			goto again;
 		}
 		pos += copied;
------------------8<-------------------------

-- 
Catalin
