Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A763C409EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbhIMUz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240598AbhIMUzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:55:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9E060F38;
        Mon, 13 Sep 2021 20:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631566476;
        bh=7L/OWAO6BBlfagMy79zsuNYBLLG3xgrbcgKW6Hv1xI8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rTmhVuZEryO4b6nAFbM2j0Y+fpPjuBAnsuBWQSLTJy2HvZCp5g0gtsbc6rr9nZGZY
         NB5yCW14K1MhARAk9GBo2g28JnVcWLUbcWNNzN8GU8uGW9xpbTx7zlZSjIq+BTF4K4
         Swl147x3L5jeFXmm36e/MdXHlz1bjDPTABEXeCGbua/uldJAXcT6yWYjimvafyZBVJ
         KclzL6D66SpyEmbj21obt9chK504MofCESbbiBVGZMuzEX6fdBI6glfBxi5y5j6FG+
         GQ1hbdJuB7SiH3q7EndmHdZjacQ+Psv5SNM7EA6uNqm4JhxxoOhqXHSNYzdUEorQ6h
         LOK4KNDJ/74kA==
Date:   Mon, 13 Sep 2021 13:54:35 -0700 (PDT)
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
In-Reply-To: <543b446b-0143-ad32-99ed-d7a6f79381e8@suse.com>
Message-ID: <alpine.DEB.2.21.2109131350150.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <004feaef-f3bb-e4bb-fb10-f205a9f69f28@suse.com> <YThiyxG0d2tmCtb+@infradead.org> <alpine.DEB.2.21.2109101636470.10523@sstabellini-ThinkPad-T480s> <543b446b-0143-ad32-99ed-d7a6f79381e8@suse.com>
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
> Hmm, you say "translate", which isn't my understanding of swiotlb's
> purpose. As per my understanding swiotlb instead double buffers data
> such that is becomes accessible, or suitably arranges underlying
> machine addresses. The latter part is clearly a PV-only thing, unused
> by Arm as can be seen by there not being any use of XENMEM_exchange.
> So it must be the former part that you're talking about, but that's
> also the purpose of the non-Xen swiotlb code. If only for my own
> education and understanding, could you point me at the difference
> between swiotlb-xen and generic swiotlb which addresses this specific
> aspect of Arm behavior?

If you look at xen_swiotlb_map_page, you'll see the call to
xen_phys_to_dma which eventually calls arch/arm/xen/p2m.c:__pfn_to_mfn.
If everything goes well and we only need to do translation we'll "goto
done". Otherwise, we'll fall back on a swiotlb buffer with
swiotlb_tbl_map_single, the result of which also needs to be translated,
see the second call to xen_phys_to_dma.
