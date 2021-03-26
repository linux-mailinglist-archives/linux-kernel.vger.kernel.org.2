Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4188C349D25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCZACz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:02:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:15386 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhCZACp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:02:45 -0400
IronPort-SDR: j8JrjOHIpOKEpMKxaSpKeLIGSDVDu408q4RLfIVBtZJVn6Mk4MB4rcYIZVUT6Z5651nicAG7O0
 HpneMyGSNVmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="187748033"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="187748033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
IronPort-SDR: wN2owymOr8LuNbROqRY5grqOI0GqflWynmkq92DqloOFlO9DkdfPS4k+ss2TfBJymhpfMtG3Gn
 hBOppYjcZfwg==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="416265839"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=20=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>
Subject: [PATCH 2/4] mce/iter: Check for copyin failure & return error up stack
Date:   Thu, 25 Mar 2021 17:02:33 -0700
Message-Id: <20210326000235.370514-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210326000235.370514-1-tony.luck@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for failure from low level copy from user code. Doing this
requires some type changes from the unsigned "size_t" so some
signed type (so that "if (xxx < 0)" works!). I picked "loff_t"
but there may be some other more appropriate type.

Very likely more places need to be changed. These changes based
on a machine check copying user data for a write(2) system call
to an xfs file system where the stack trace looks like:

[  149.445163]  ? copyin+0x2d/0x40
[  149.448687]  ? iov_iter_copy_from_user_atomic+0xd6/0x3a0
[  149.454625]  ? iomap_write_actor+0xc7/0x190
[  149.459319]  ? iomap_apply+0x12a/0x440
[  149.463508]  ? iomap_write_begin+0x530/0x530
[  149.468276]  ? iomap_write_begin+0x530/0x530
[  149.473041]  ? iomap_file_buffered_write+0x62/0x90
[  149.478390]  ? iomap_write_begin+0x530/0x530
[  149.483157]  ? xfs_file_buffered_write+0xe0/0x340 [xfs]
[  149.489393]  ? new_sync_write+0x122/0x1b0
[  149.493879]  ? vfs_write+0x20a/0x350
[  149.497888]  ? ksys_write+0x5f/0xe0
[  149.501784]  ? do_syscall_64+0x33/0x40

---

Needs to be bundled with other patches for bisection safety
---
 fs/iomap/buffered-io.c |  8 +++++++-
 include/linux/uio.h    |  2 +-
 lib/iov_iter.c         | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 414769a6ad11..6cc28e3f32ff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -757,7 +757,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
-		size_t copied;		/* Bytes copied from user */
+		loff_t copied;		/* Bytes copied from user */
 
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
@@ -791,6 +791,12 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
+		if (copied < 0) {
+			unlock_page(page);
+			put_page(page);
+			return copied;
+		}
+
 		copied = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27ff8eb786dc..c2d82e8e309c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -111,7 +111,7 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 	};
 }
 
-size_t iov_iter_copy_from_user_atomic(struct page *page,
+loff_t iov_iter_copy_from_user_atomic(struct page *page,
 		struct iov_iter *i, unsigned long offset, size_t bytes);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f66c62aa7154..57e2f81c51ee 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -16,13 +16,18 @@
 #define PIPE_PARANOIA /* for now */
 
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
-	size_t left;					\
+	loff_t left;					\
 	size_t wanted = n;				\
 	__p = i->iov;					\
 	__v.iov_len = min(n, __p->iov_len - skip);	\
 	if (likely(__v.iov_len)) {			\
 		__v.iov_base = __p->iov_base + skip;	\
 		left = (STEP);				\
+		if (left < 0) {				\
+			wanted = left;			\
+			n = 0;				\
+			goto err;			\
+		}					\
 		__v.iov_len -= left;			\
 		skip += __v.iov_len;			\
 		n -= __v.iov_len;			\
@@ -36,10 +41,16 @@
 			continue;			\
 		__v.iov_base = __p->iov_base;		\
 		left = (STEP);				\
+		if (left < 0) {				\
+			wanted = left;			\
+			n = 0;				\
+			break;				\
+		}					\
 		__v.iov_len -= left;			\
 		skip = __v.iov_len;			\
 		n -= __v.iov_len;			\
 	}						\
+err:							\
 	n = wanted - n;					\
 }
 
@@ -975,7 +986,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t iov_iter_copy_from_user_atomic(struct page *page,
+loff_t iov_iter_copy_from_user_atomic(struct page *page,
 		struct iov_iter *i, unsigned long offset, size_t bytes)
 {
 	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
-- 
2.29.2

