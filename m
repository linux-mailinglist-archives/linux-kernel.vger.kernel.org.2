Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805E23473D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhCXInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:43:17 -0400
Received: from verein.lst.de ([213.95.11.211]:36021 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhCXImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:42:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C8A8B68B05; Wed, 24 Mar 2021 09:42:50 +0100 (CET)
Date:   Wed, 24 Mar 2021 09:42:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Message-ID: <20210324084250.GA4474@lst.de>
References: <20210321033740.312500-1-f.fainelli@gmail.com> <20210323015350.399493-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323015350.399493-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:53:49PM -0700, Florian Fainelli wrote:
> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
> default_nslabs to occur since we are not going to use those slabs. If a
> platform was somehow setting swiotlb_no_force and a later call to
> swiotlb_init() was to be made we would still be proceeding with
> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
> was set on the kernel command line we would have only allocated 2KB.
> 
> This would be inconsistent and the point of initializing default_nslabs
> to 1, was intended to allocate the minimum amount of memory possible, so
> simply remove that minimal allocation period.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
