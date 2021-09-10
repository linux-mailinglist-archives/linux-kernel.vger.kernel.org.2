Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7078D40740D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhIJXuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234787AbhIJXt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C6A561209;
        Fri, 10 Sep 2021 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631317725;
        bh=CT+zN2hvsAGlq3FXd8oqicFmjUPdT7vc0738cJVqDhc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NBh9bj15FRDBR+BDeOLotaclfeKGuxxEoc4JgAJKKHSox00tTCMgZLOGby7uUyLYQ
         pUtT8PJgxMce1q0BfXQGk+qIw445gAvZ6NLhM4y8jA3YmI46zR+zNzroZXVu/pZbaM
         pTbn7Eto3WbEs5hwCEQxgUa7pk5OieVIazdXrixmWnVA0ZXVHOPpeLJa2vQT1Ei7aF
         /ufGH9sxsebTeWF+phKh0lNfjV8oBhSvhX22Iap+CYZELu0dBswL/q/Q1LCFKtPJe6
         t2CcUFqSt5aknM/ek0YF2QSjZKjYczxCuqCMGiGxDka+iZ6w5jVDpn2rd6xDDUxgLZ
         AD+jGYwhQZKlw==
Date:   Fri, 10 Sep 2021 16:48:44 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 12/12] swiotlb-xen: this is PV-only on x86
In-Reply-To: <YThiyxG0d2tmCtb+@infradead.org>
Message-ID: <alpine.DEB.2.21.2109101636470.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <004feaef-f3bb-e4bb-fb10-f205a9f69f28@suse.com> <YThiyxG0d2tmCtb+@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021, Christoph Hellwig wrote:
> On Tue, Sep 07, 2021 at 02:13:21PM +0200, Jan Beulich wrote:
> > The code is unreachable for HVM or PVH, and it also makes little sense
> > in auto-translated environments. On Arm, with
> > xen_{create,destroy}_contiguous_region() both being stubs, I have a hard
> > time seeing what good the Xen specific variant does - the generic one
> > ought to be fine for all purposes there. Still Arm code explicitly
> > references symbols here, so the code will continue to be included there.
> 
> Can the Xen/arm folks look into that?  Getting ARM out of using
> swiotlb-xen would be a huge step forward cleaning up some DMA APIs.

On ARM swiotlb-xen is used for a different purpose compared to x86.

Many ARM SoCs still don't have an IOMMU covering all DMA-mastering
devices (e.g. Raspberry Pi 4). As a consequence we map Dom0 1:1 (guest
physical == physical address).

Now if it was just for Dom0, thanks to the 1:1 mapping, we wouldn't need
swiotlb-xen. But when we start using PV drivers to share the network or
disk between Dom0 and DomU we are going to get DomU pages mapped in
Dom0, we call them "foreign pages".  They are not mapped 1:1. It can
happen that one of these foreign pages are used for DMA operations
(e.g. related to the NIC). swiotlb-xen is used to detect these
situations and translate the guest physical address to physical address
of foreign pages appropriately.

If an IOMMU is available and the DMA-mastering device is behind it, then
swiotlb-xen is not necessary. FYI there is community interest in
selectively disabling swiotlb-xen for devices that are behind an IOMMU.


> > Instead of making PCI_XEN's "select" conditional, simply drop it -
> > SWIOTLB_XEN will be available unconditionally in the PV case anyway, and
> > is - as explained above - dead code in non-PV environments.
> > 
> > This in turn allows dropping the stubs for
> > xen_{create,destroy}_contiguous_region(), the former of which was broken
> > anyway - it failed to set the DMA handle output.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
