Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE43B33BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFXQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:20:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDDEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:18:26 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwS37-00Br5k-1Q; Thu, 24 Jun 2021 16:17:53 +0000
Date:   Thu, 24 Jun 2021 16:17:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <YNSwMRscemv3CBpf@zeniv-ca.linux.org.uk>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <20210624150911.GA25097@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624150911.GA25097@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:09:11PM +0100, Catalin Marinas wrote:
> On Thu, Jun 24, 2021 at 12:15:46PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 24, 2021 at 08:04:07AM +0100, Christoph Hellwig wrote:
> > > On Thu, Jun 24, 2021 at 04:24:46AM +0100, Matthew Wilcox wrote:
> > > > On Thu, Jun 24, 2021 at 11:10:41AM +0800, Chen Huang wrote:
> > > > > In userspace, I perform such operation:
> > > > > 
> > > > >  	fd = open("/tmp/test", O_RDWR | O_SYNC);
> > > > >         access_address = (char *)mmap(NULL, uio_size, PROT_READ, MAP_SHARED, uio_fd, 0);
> > > > >         ret = write(fd, access_address + 2, sizeof(long));
> > > > 
> > > > ... you know that accessing this at unaligned offsets isn't going to
> > > > work.  It's completely meaningless.  Why are you trying to do it?
> > > 
> > > We still should not cause an infinite loop in kernel space due to a
> > > a userspace programmer error.
> > 
> > They're running as root and they've mapped some device memory.  We can't
> > save them from themself.  Imagine if they'd done this to the NVMe BAR.

> We could change raw_copy_from_user() to fall back to 1-byte read in case
> of a fault or fix this corner case in the generic code. A quick hack,
> re-attempting the access with one byte:

No.  If nothing else, iov_iter_single_seg_count() is a bad kludge.
What's more, this "do a single-byte copy" fallback is punishing
a much more common case (memory pressure evicting the page) for the sake
of a corner case specific to one architecture that should've been dealt
with in its raw_copy_from_user().

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

For some context, see include/linux/uaccess.h and description of requirements
for raw_copy_from_user() in there.
