Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A289D3FE727
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhIBBdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:33:10 -0400
Received: from rosenzweig.io ([138.197.143.207]:45354 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232888AbhIBBdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:33:08 -0400
Date:   Wed, 1 Sep 2021 17:10:09 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] iommu/dma: Disable get_sgtable for granule >
 PAGE_SIZE
Message-ID: <YS/sMckPUJRMYwYq@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev>
 <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My biggest issue is that I do not understand how this function is supposed
> to be used correctly. It would work fine as-is if it only ever gets passed buffers
> allocated by the coherent API but there's not way to check or guarantee that.
> There may also be callers making assumptions that no longer hold when
> iovad->granule > PAGE_SIZE.
> 
> Regarding your case: I'm not convinced the function is meant to be used there.
> If I understand it correctly, your code first allocates memory with dma_alloc_coherent
> (which possibly creates a sgt internally and then maps it with iommu_map_sg),
> then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
> another iommu domain with dma_map_sg while assuming that the result will be contiguous
> in IOVA space. It'll work out because dma_alloc_coherent is the very thing
> meant to allocate pages that can be mapped into kernel and device VA space
> as a single contiguous block and because both of your IOMMUs are different
> instances of the same HW block. Anything allocated by dma_alloc_coherent for the
> first IOMMU will have the right shape that will allow it to be mapped as
> a single contiguous block for the second IOMMU.
> 
> What could be done in your case is to instead use the IOMMU API,
> allocate the pages yourself (while ensuring the sgt your create is made up
> of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
> and then just use iommu_map_sg for both domains which actually comes with the
> guarantee that the result will be a single contiguous block in IOVA space and
> doesn't required the sgt roundtrip.

In principle I agree. I am getting the sense this function can't be used
correctly in general, and yet is the function that's meant to be used.
If my interpretation of prior LKML discussion holds, the problems are
far deeper than my code or indeed page size problems...

If the right way to handle this is with the IOMMU and IOVA APIs, I really wish
that dance were wrapped up in a safe helper function instead of open
coding it in every driver that does cross device sharing.

We might even call that helper... hmm... dma_map_sg.... *ducks*

For context for people-other-than-Sven, the code in question from my
tree appears below the break.

---------------------------------------------------------------------------------

/*
 * Allocate an IOVA contiguous buffer mapped to the DCP. The buffer need not be
 * physically contigiuous, however we should save the sgtable in case the
 * buffer needs to be later mapped for PIODMA.
 */
static bool dcpep_cb_allocate_buffer(struct apple_dcp *dcp, void *out, void *in)
{
        struct dcp_allocate_buffer_resp *resp = out;
        struct dcp_allocate_buffer_req *req = in;
        void *buf;

        resp->dva_size = ALIGN(req->size, 4096);
        resp->mem_desc_id = ++dcp->nr_mappings;

        if (resp->mem_desc_id >= ARRAY_SIZE(dcp->mappings)) {
                dev_warn(dcp->dev, "DCP overflowed mapping table, ignoring");
                return true;
        }

        buf = dma_alloc_coherent(dcp->dev, resp->dva_size, &resp->dva,
                                 GFP_KERNEL);

        dma_get_sgtable(dcp->dev, &dcp->mappings[resp->mem_desc_id], buf,
                        resp->dva, resp->dva_size);

        WARN_ON(resp->mem_desc_id == 0);
        return true;
}

/*
 * Callback to map a buffer allocated with allocate_buf for PIODMA usage.
 * PIODMA is separate from the main DCP and uses own IOVA space on a dedicated
 * stream of the display DART, rather than the expected DCP DART.
 *
 * XXX: This relies on dma_get_sgtable in concert with dma_map_sgtable, which
 * is a "fundamentally unsafe" operation according to the docs. And yet
 * everyone does it...
 */
static bool dcpep_cb_map_piodma(struct apple_dcp *dcp, void *out, void *in)
{
        struct dcp_map_buf_resp *resp = out;
        struct dcp_map_buf_req *req = in;
        struct sg_table *map;

        if (req->buffer >= ARRAY_SIZE(dcp->mappings))
                goto reject;

        map = &dcp->mappings[req->buffer];

        if (!map->sgl)
                goto reject;

        /* XNU leaks a kernel VA here, breaking kASLR. Don't do that. */
        resp->vaddr = 0;

        /* Use PIODMA device instead of DCP to map against the right IOMMU. */
        resp->ret = dma_map_sgtable(dcp->piodma, map, DMA_BIDIRECTIONAL, 0);

        if (resp->ret)
                dev_warn(dcp->dev, "failed to map for piodma %d\n", resp->ret);
        else
                resp->dva = sg_dma_address(map->sgl);

        resp->ret = 0;
        return true;

reject:
        dev_warn(dcp->dev, "denying map of invalid buffer %llx for pidoma\n",
                 req->buffer);
        resp->ret = EINVAL;
        return true;
}
