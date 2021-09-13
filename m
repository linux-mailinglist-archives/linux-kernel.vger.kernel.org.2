Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148DE409E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbhIMUuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242743AbhIMUuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:50:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6463A610FE;
        Mon, 13 Sep 2021 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631566145;
        bh=hUiqmRGtEXepWEODLRwwvcp5j41ZXDQIlBCemxiVKNw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DHwsMX7ikvWdd/BI8zDeHuw+7Tapq9FDRv/8U/Wc5GJhsdDEr0PZBkADcNC3Cw4/l
         XVIYVS3fpf4IB/pEf/TBDYctfkgqE5TknKGwK5w28r1T0PfvZgGxfh5u4emxheYskE
         tfJGnP6f/saAr4DBa9u2FuM//73eD3+3Ma38STWt9N64jckrDfpLuZsst7TasKtIXx
         vFlplwL562zn3HK9rwxFYC1y4bQe7btGfdnMb5FDi/TilVePV2YX60eoSVjbN+C9Oj
         eGh0ylJCU9jw2iP9ocX1Qp0BMnuv15otYWsJrZYReV/tsLjmDecY0Nc2ev8c2d0QaN
         wqK6HMy1fcSRg==
Date:   Mon, 13 Sep 2021 13:49:04 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/12] swiotlb-xen: this is PV-only on x86
In-Reply-To: <ea90d3d7-22c7-604f-d0c8-f83c2a58554d@suse.com>
Message-ID: <alpine.DEB.2.21.2109131331570.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <004feaef-f3bb-e4bb-fb10-f205a9f69f28@suse.com> <YThiyxG0d2tmCtb+@infradead.org> <alpine.DEB.2.21.2109101636470.10523@sstabellini-ThinkPad-T480s> <ea90d3d7-22c7-604f-d0c8-f83c2a58554d@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021, Jan Beulich wrote:
> On 11.09.2021 01:48, Stefano Stabellini wrote:
> > On Wed, 8 Sep 2021, Christoph Hellwig wrote:
> >> On Tue, Sep 07, 2021 at 02:13:21PM +0200, Jan Beulich wrote:
> >>> The code is unreachable for HVM or PVH, and it also makes little sense
> >>> in auto-translated environments. On Arm, with
> >>> xen_{create,destroy}_contiguous_region() both being stubs, I have a hard
> >>> time seeing what good the Xen specific variant does - the generic one
> >>> ought to be fine for all purposes there. Still Arm code explicitly
> >>> references symbols here, so the code will continue to be included there.
> >>
> >> Can the Xen/arm folks look into that?  Getting ARM out of using
> >> swiotlb-xen would be a huge step forward cleaning up some DMA APIs.
> > 
> > On ARM swiotlb-xen is used for a different purpose compared to x86.
> > 
> > Many ARM SoCs still don't have an IOMMU covering all DMA-mastering
> > devices (e.g. Raspberry Pi 4). As a consequence we map Dom0 1:1 (guest
> > physical == physical address).
> > 
> > Now if it was just for Dom0, thanks to the 1:1 mapping, we wouldn't need
> > swiotlb-xen. But when we start using PV drivers to share the network or
> > disk between Dom0 and DomU we are going to get DomU pages mapped in
> > Dom0, we call them "foreign pages".  They are not mapped 1:1. It can
> > happen that one of these foreign pages are used for DMA operations
> > (e.g. related to the NIC). swiotlb-xen is used to detect these
> > situations and translate the guest physical address to physical address
> > of foreign pages appropriately.
> 
> Thinking about this some more - if Dom0 is 1:1 mapped, why don't you
> map foreign pages 1:1 as well then?

That's because the foreign page, from Linux POV, would appear out of
thin air. It would just show up in a region not considered memory just
few moments before, so there would be no memblock, no struct page,
nothing. At least in the past that caused serious issues to the kernel.

This is the reason why the kernel is using ballooned-out pages to map
foreign pages even on x86:

drivers/block/xen-blkback/blkback.c:xen_blkbk_map -> gnttab_page_cache_get
drivers/xen/grant-table.c:gnttab_page_cache_get
drivers/xen/grant-table.c:gnttab_alloc_pages
drivers/xen/unpopulated-alloc.c:xen_alloc_unpopulated_pages
drivers/xen/balloon.c:alloc_xenballooned_pages
