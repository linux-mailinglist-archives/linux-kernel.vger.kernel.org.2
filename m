Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED13B12E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 06:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFWEaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 00:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFWEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:30:24 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6709AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 21:28:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvuUD-00BPOp-9G; Wed, 23 Jun 2021 04:27:37 +0000
Date:   Wed, 23 Jun 2021 04:27:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <YNK4OSdoo/4wjhd7@zeniv-ca.linux.org.uk>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <YNKhjkuzXEJrBUA8@zeniv-ca.linux.org.uk>
 <92fa298d-9d88-0ca4-40d9-13690dcd42f9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fa298d-9d88-0ca4-40d9-13690dcd42f9@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:24:54AM +0800, Xiaoming Ni wrote:
> On 2021/6/23 10:50, Al Viro wrote:
> > On Wed, Jun 23, 2021 at 10:39:31AM +0800, Chen Huang wrote:
> > 
> > > Then when kernel handles the alignment_fault, it will not panic. As the
> > > arm64 memory model spec said, when the address is not a multiple of the
> > > element size, the access is unaligned. Unaligned accesses are allowed to
> > > addresses marked as Normal, but not to Device regions. An unaligned access
> > > to a Device region will trigger an exception (alignment fault).
> > > 	
> > > do_alignment_fault
> > >      do_bad_area
> > > 	__do_kernel_fault
> > >             fixup_exception
> > > 
> > > But that fixup cann't handle the unaligned copy, so the
> > > copy_page_from_iter_atomic returns 0 and traps in loop.
> > 
> > Looks like you need to fix your raw_copy_from_user(), then...
> > .
> > 
> 
> Exit loop when iov_iter_copy_from_user_atomic() returns 0.
> This should solve the problem, too, and it's easier.

It might be easier, but it's not going to work correctly.
If the page gets evicted by memory pressure, you are going
to get spurious short write.

Besides, it's simply wrong - write(2) does *NOT* require an
aligned source.  It (and raw_copy_from_user()) should act the
same way memcpy(3) does.
