Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123643B1959
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFWLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhFWLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D614C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/GACbFUQBsL3k4dufWqeympRiym3hWqjCaP9FTsmnJ4=; b=U9X4VQnXQPkXPJ39J6DWS3cOey
        d2rYg1uiuzUSKa2STWp7meESuGlq97IGwyOpE3fq9roWMn8HAmCHcE9Tki8Bnmn5yBw8z86WX4Osm
        DGW9oFDxxAKNwb6xcjLoKMFkSksdyCUhhM9v9huiN7qL3Gm2gx+EguwtsIjvGChIHzrJS10YYW+mm
        VsDukwoGemLtc6Ow1A4va747/uqarC5Pb5Fi+KPQ8uUugl2djIan4bZoXh6uHMArR5e6WjVljIAay
        D2ynNMwyscuEqSe8mZC5SaboEUwGzdkLHrW9ZylVI+Ipg1GjOELfFAqTwBxR3x1TxmKHyWLAdqeob
        7Z/YtKmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1Po-00FNnk-3j; Wed, 23 Jun 2021 11:51:38 +0000
Date:   Wed, 23 Jun 2021 12:51:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <YNMgRJrNNomLXf3M@casper.infradead.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <YNKhjkuzXEJrBUA8@zeniv-ca.linux.org.uk>
 <92fa298d-9d88-0ca4-40d9-13690dcd42f9@huawei.com>
 <YNK4OSdoo/4wjhd7@zeniv-ca.linux.org.uk>
 <20210623093220.GA3718@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623093220.GA3718@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:32:21AM +0100, Catalin Marinas wrote:
> On Wed, Jun 23, 2021 at 04:27:37AM +0000, Al Viro wrote:
> > On Wed, Jun 23, 2021 at 11:24:54AM +0800, Xiaoming Ni wrote:
> > > On 2021/6/23 10:50, Al Viro wrote:
> > > > On Wed, Jun 23, 2021 at 10:39:31AM +0800, Chen Huang wrote:
> > > > 
> > > > > Then when kernel handles the alignment_fault, it will not panic. As the
> > > > > arm64 memory model spec said, when the address is not a multiple of the
> > > > > element size, the access is unaligned. Unaligned accesses are allowed to
> > > > > addresses marked as Normal, but not to Device regions. An unaligned access
> > > > > to a Device region will trigger an exception (alignment fault).
> > > > > 	
> > > > > do_alignment_fault
> > > > >      do_bad_area
> > > > > 	__do_kernel_fault
> > > > >             fixup_exception
> > > > > 
> > > > > But that fixup cann't handle the unaligned copy, so the
> > > > > copy_page_from_iter_atomic returns 0 and traps in loop.
> > > > 
> > > > Looks like you need to fix your raw_copy_from_user(), then...
> > > 
> > > Exit loop when iov_iter_copy_from_user_atomic() returns 0.
> > > This should solve the problem, too, and it's easier.
> > 
> > It might be easier, but it's not going to work correctly.
> > If the page gets evicted by memory pressure, you are going
> > to get spurious short write.
> > 
> > Besides, it's simply wrong - write(2) does *NOT* require an
> > aligned source.  It (and raw_copy_from_user()) should act the
> > same way memcpy(3) does.
> 
> On arm64, neither memcpy() nor raw_copy_from_user() are expected to work
> on Device mappings, we have memcpy_fromio() for this but only for
> ioremap(). There's no (easy) way to distinguish in the write() syscall
> how the source buffer is mapped. generic_perform_write() does an
> iov_iter_fault_in_readable() check but that's not sufficient and it also
> breaks the cases where you can get intra-page faults (arm64 MTE or SPARC
> ADI). I think in the general case it's racy anyway (another thread doing
> an mprotect(PROT_NONE) after the readable check passed).
> 
> So I think generic_perform_write() returning -EFAULT if copied == 0
> would make sense (well, unless it breaks other cases I'm not aware of).

It does break other cases -- that's what happens if the page has gone
missing after being faulted in.  You need to fix your copy_from_user().
