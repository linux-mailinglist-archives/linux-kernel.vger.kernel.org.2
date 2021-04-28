Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794E36D56A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhD1KHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:07:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238456AbhD1KHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:07:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557241FB;
        Wed, 28 Apr 2021 03:06:18 -0700 (PDT)
Received: from [10.57.61.101] (unknown [10.57.61.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A06CD3F70D;
        Wed, 28 Apr 2021 03:06:16 -0700 (PDT)
Subject: Re: DMA mapping fill dma_address to 0
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <YIkf4yqt14dGPoyr@Red>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6ce3614e-af79-2a36-de83-6cbb4d9fe9a4@arm.com>
Date:   Wed, 28 Apr 2021 11:06:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIkf4yqt14dGPoyr@Red>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-28 09:42, Corentin Labbe wrote:
> Hello
> 
> I work on the crypto offloader driver of cortina/gemini SL3516 SoC.
> I test it by filling a LUKS2 partition.
> I got a reproductible problem when handling skcipher requests.
> I use dma_map_sg() and when iterating other the result, sg_dma_address(sg) return 0.
> But sg_dma_len(sg) is still correct (4096 in my case).
> 
> Below is a simplified view of my code:
> nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
> (nr_sgs = 1 in my case)
> sg = areq->src;
> if (!sg_dma_address(sg))
> 	FAIL

What is this check supposed to be for in the first place? 0 is a valid 
DMA address, because it's also a valid physical address, and I recall 
RAM at PA 0 on Hikey 960 flushing out some bugs in the past when we 
tried to use 0 for DMA_MAPPING_ERROR. All the Gemini DTs appear to show 
RAM starting at PA 0 too, so I'd have to guess that it's simply the case 
that your DMA buffer happened to end up using that particular page.

Robin.

> I have digged to find what do dma_map_sg() and I have added some debug.
> sg_page(sg) return c7efb000 for example so sg_page() works.
> But it seems the problem is that page_to_phys(sg_page(sg)) return 0.
> 
> This problem does not appear immediatly, luksOpen and subsequent fsck always work.
> But it appears fast after, when mouting or rsync files in it.
> 
> I have added CONFIG_DEBUG_SG, CONFIG_DMA_API_DEBUG, CONFIG_DMA_API_DEBUG_SG but they didnt bringed any more hints.
> Only "DMA-API: cacheline tracking ENOMEM, dma-debug disabled" appears but always with some "time" between my problem and its display.
> So I am not sure it is related.
> 
> Regards
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
