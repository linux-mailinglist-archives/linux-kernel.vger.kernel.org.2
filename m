Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2312341DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:08:05 -0400
Received: from verein.lst.de ([213.95.11.211]:46113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhCSNHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:07:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE0B568BFE; Fri, 19 Mar 2021 14:07:31 +0100 (CET)
Date:   Fri, 19 Mar 2021 14:07:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20210319130731.GB2624@lst.de>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319040333.183827-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
>  #ifdef CONFIG_ARM_LPAE
> +	if (swiotlb_force == SWIOTLB_FORCE ||
> +	    max_pfn > arm_dma_pfn_limit)

Does arm_dma_pfn_limit do the right thing even with the weirdest
remapping ranges?  Maybe a commen here would be useful.

> +		swiotlb_init(1);
> +	else
> +		swiotlb_force = SWIOTLB_NO_FORCE;

Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
That kind makes more sense than forcing the callers to do it.

While we're at it, I think swiotlb_force should probably be renamed to
swiotlb_mode or somethng like that.
