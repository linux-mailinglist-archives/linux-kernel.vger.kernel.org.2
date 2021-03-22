Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70522343ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCVHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:46:48 -0400
Received: from verein.lst.de ([213.95.11.211]:53905 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCVHqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:46:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFD0767373; Mon, 22 Mar 2021 08:46:27 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:46:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Message-ID: <20210322074627.GA4252@lst.de>
References: <20210319040055.183433-1-f.fainelli@gmail.com> <20210321033740.312500-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321033740.312500-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 08:37:40PM -0700, Florian Fainelli wrote:
> -	if (!strcmp(str, "force")) {
> +	if (!strcmp(str, "force"))
>  		swiotlb_force = SWIOTLB_FORCE;
> -	} else if (!strcmp(str, "noforce")) {
> +	else if (!strcmp(str, "noforce"))
>  		swiotlb_force = SWIOTLB_NO_FORCE;
> -		default_nslabs = 1;
> -	}
>  
>  	return 0;
>  }
> @@ -211,6 +209,9 @@ swiotlb_init(int verbose)
>  	size_t bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
>  	void *tlb;
>  
> +	if (swiotlb_force == SWIOTLB_NO_FORCE)
> +		return;

We'll also need this in the other callers of swiotlb_init_with_tbl
and swiotlb_late_init_with_tbl.

I actually had a plan to mostly kill them, but that can better
way until more support for multiple io_tlb structures is merged.
