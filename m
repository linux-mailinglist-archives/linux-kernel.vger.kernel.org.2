Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702DB342968
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCTAWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhCTAWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:22:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFCFE61982;
        Sat, 20 Mar 2021 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616199750;
        bh=yfhC9N4yx6xT3rJ9D4E/XRJxPV8sGJTgzQeYH+mdemI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TI+APkqWcQfgwonCim+iFmS8c7zEVsrTV2NeAO10POk0eFNuHfwTZ3PS6oUiPfrDE
         dR2bOmbF0/WMJw33/HII0nnoGcMewvvTYXsp+8aiSY4T3UuM62Jdwyj2hN+X5TFTJ7
         0FQv0joGMfB56GV8oao8C42zcWOH8+vO3O3dTf9UpM3/bCHi0kiIe6POaRi2Q66nHp
         hq8n0luM/DiBzMDpdUNsctNmuZHsS97tTwI0jL/an8H/fe4rQmhhn2pBxog4NCQnxt
         Izik/bGIY4VCG20TbjzJ5z9y34gH3OzZ7UjcoXn6lDksBIGlRWAyXj//jBbnwRb52t
         8bDOtP4ZxWtEQ==
Date:   Fri, 19 Mar 2021 17:22:28 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
cc:     Christoph Hellwig <hch@lst.de>, xen-devel@lists.xensource.com,
        sstabellini@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
In-Reply-To: <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
Message-ID: <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
References: <20210319040333.183827-1-f.fainelli@gmail.com> <20210319130731.GB2624@lst.de> <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 19, 2021 at 02:07:31PM +0100, Christoph Hellwig wrote:
> > On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
> > >  #ifdef CONFIG_ARM_LPAE
> > > +	if (swiotlb_force == SWIOTLB_FORCE ||
> > > +	    max_pfn > arm_dma_pfn_limit)
> > 
> > Does arm_dma_pfn_limit do the right thing even with the weirdest
> > remapping ranges?  Maybe a commen here would be useful.
> > 
> > > +		swiotlb_init(1);
> > > +	else
> > > +		swiotlb_force = SWIOTLB_NO_FORCE;
> > 
> > Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
> > and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
> > That kind makes more sense than forcing the callers to do it.
> > 
> > While we're at it, I think swiotlb_force should probably be renamed to
> > swiotlb_mode or somethng like that.
> 
> swiotlb_mode sounds good.
> 
> Also it got me thinking - ARM on Xen at some point was a bit strange, so not sure how
> the logic works here, Stefano?

There is nothing strange in regards to swiotlb_force. swiotlb_force is only used
in swiotlb-xen map_page to figure out whether:

- we actually have to use the swiotlb bounce buffer (this is the
  swiotlb_xen == SWIOTLB_FORCE case)
- or we can use the provided page directly for dma if other conditions
  are met (dma_capable, !range_straddles_page_boundary, ...)


I don't think that switching to "swiotlb_mode" would cause any issues.
