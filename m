Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2233B340C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhFXQmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhFXQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:42:31 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE62C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:40:11 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwSOK-00BrRG-Mi; Thu, 24 Jun 2021 16:39:48 +0000
Date:   Thu, 24 Jun 2021 16:39:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <YNS1VN2okAHo3b+0@zeniv-ca.linux.org.uk>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk>
 <7896a3c7-2e14-d0f4-dbb9-286b6f7181b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7896a3c7-2e14-d0f4-dbb9-286b6f7181b5@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 05:38:35PM +0100, Robin Murphy wrote:
> On 2021-06-24 17:27, Al Viro wrote:
> > On Thu, Jun 24, 2021 at 02:22:27PM +0100, Robin Murphy wrote:
> > 
> > > FWIW I think the only way to make the kernel behaviour any more robust here
> > > would be to make the whole uaccess API more expressive, such that rather
> > > than simply saying "I only got this far" it could actually differentiate
> > > between stopping due to a fault which may be recoverable and worth retrying,
> > > and one which definitely isn't.
> > 
> > ... and propagate that "more expressive" information through what, 3 or 4
> > levels in the call chain?
> > 
> >  From include/linux/uaccess.h:
> > 
> >   * If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes starting
> >   * at to must become equal to the bytes fetched from the corresponding area
> >   * starting at from.  All data past to + size - N must be left unmodified.
> >   *
> >   * If copying succeeds, the return value must be 0.  If some data cannot be
> >   * fetched, it is permitted to copy less than had been fetched; the only
> >   * hard requirement is that not storing anything at all (i.e. returning size)
> >   * should happen only when nothing could be copied.  In other words, you don't
> >   * have to squeeze as much as possible - it is allowed, but not necessary.
> > 
> > arm64 instances violate the aforementioned hard requirement.  Please, fix
> > it there; it's not hard.  All you need is an exception handler in .Ltiny15
> > that would fall back to (short) byte-by-byte copy if the faulting address
> > happened to be unaligned.  Or just do one-byte copy, not that it had been
> > considerably cheaper than a loop.  Will be cheaper than propagating that extra
> > information up the call chain, let alone paying for extra ->write_begin()
> > and ->write_end() for single byte in generic_perform_write().
> 
> And what do we do if we then continue to fault with an external abort
> because whatever it is that warranted being mapped as Device-type memory in
> the first place doesn't support byte accesses?

If it does not support byte access, it would've failed on fault-in.
