Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922E83DF6EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhHCVfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhHCVfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:35:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A32C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+CGFH2KuXULxjiGsSPbBmX3Z4HJgTBGPotNROlzN7oA=; b=H/SNooprUGPWyJ6gAapA29Ymxe
        89vwATnDaX4E3F8Vuz2X6+8122oyuPdvLjI4obaTc63TbEeSeJPzzKeClCr6f3t1zyMyQv3xOoNDw
        1f2kCM6I+8BbNUhvKxeWH2QIUGQJ4xXf7+ys5jTfFYen1x3JEdrc22iZN+viX+3h5h7hM6AHmFIFP
        9nTwwr7TW6IGgCtSYsKR1DkSRPKYtItSG/dtQlQRl+c2+oLgfRW6SoOg07xtZWuLpc9nkpwoLAwkk
        NmZJBOSMGMG1o74g7BygKsQGZsD7l+ZXe8hnirUibJUOds2ETuH9QMB7B3ybnLfWkuudIhCc5B4Zj
        47bN07eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB23Q-00572u-ST; Tue, 03 Aug 2021 21:34:35 +0000
Date:   Tue, 3 Aug 2021 22:34:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <YQm2ZM9+cWmBFJH7@casper.infradead.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org>
 <YQQsz/tvrQpqAbpX@google.com>
 <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
 <20210730184400.GA1521057@agluck-desk2.amr.corp.intel.com>
 <c75cf4b5-fe56-54cf-681f-6e5b6b83d0e2@intel.com>
 <259e12df49b9495cb6b326e52c9ffe51@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <259e12df49b9495cb6b326e52c9ffe51@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:35:38PM +0000, Luck, Tony wrote:
> >	xa_store_range(&epc_page_ranges,
> >		       section->phys_addr,
> >		       section->end_phys_addr, ...);
> >
> > ... you did it based on PFNs:
> >
> >	xa_store_range(&epc_page_ranges,
> >		       section->phys_addr     >> PAGE_SHIFT,
> >		       section->end_phys_addr >> PAGE_SHIFT, ...);
> >
> > SGX sections are at *least* page-aligned, so this should be fine.
> 
> I found xa_dump() (hidden inside #ifdef XA_DEBUG)
> 
> Trying both with and without the >> PAGE_SHIFT made no difference
> to the number of lines of console output that xa_dump() spits out.
> 266 either way.
> 
> There are only two ranges on this system
> 
> [   11.937592] sgx: EPC section 0x8000c00000-0x807f7fffff
> [   11.945811] sgx: EPC section 0x10000c00000-0x1007fffffff
> 
> So I'm a little bit sad that xarray appears to have broken them up
> into a bunch of pieces.

That's inherent in the (current) back end data structure, I'm afraid.
As a radix tree, it can only look up based on the N bits available at
each level of the tree, so if your entry is an aligned power-of-64,
everything is nice and neat, and you're a single entry at one level
of the tree.  If you're an arbitrary range, things get more complicated,
and I have to do a little dance to redirect the lookup towards the
canonical entry.

Liam and I are working on a new replacement data structure called the
Maple Tree, but it's not yet ready to replace the radix tree back end.
It looks like it would be perfect for your case; there would be five
entries in it, stored in one 256-byte node:

	NULL
0x8000bfffff
	p1
0x807f7fffff
	NULL
0x10000c00000
	p2
0x1007fffffff
	NULL
0xffff'ffff'ffff'ffff

It would actually turn into a linear scan, because that's just the
fastest way to find something in a list of five elements.  A third
range would take us to a list of seven elements, which still fits
in a single node.  Once we get to more than that, you'd have a
two-level tree, which would work until you have more than ~20 ranges.

We could do better for your case by storing 10x (start, end, p) in each
leaf node, but we're (currently) optimising for VMAs which tend to be
tightly packed, meaning that an implicit 'start' element is a better
choice as it gives us 15x (end, p) pairs.
