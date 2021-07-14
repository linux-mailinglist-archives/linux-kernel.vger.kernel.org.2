Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A863C8AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhGNSWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 14:22:50 -0400
Received: from foss.arm.com ([217.140.110.172]:38086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhGNSWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:22:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3219D6E;
        Wed, 14 Jul 2021 11:19:57 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830E83F774;
        Wed, 14 Jul 2021 11:19:55 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Apple M1 DART IOMMU driver
To:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de
References: <20210627143405.77298-1-sven@svenpeter.dev>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
Date:   Wed, 14 Jul 2021 19:19:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627143405.77298-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-27 15:34, Sven Peter wrote:
[...]
> In the long term, I'd like to extend the dma-iommu framework itself to
> support iommu pagesizes with a larger granule than the CPU pagesize if that is
> something you agree with.

BTW this isn't something we can fully support in general. IOMMU API 
users may expect this to work:

iommu_map(domain, iova, page_to_phys(p1), PAGE_SIZE, prot);
iommu_map(domain, iova + PAGE_SIZE, page_to_phys(p2), PAGE_SIZE, prot);

Although they do in principle have visibility of pgsize_bitmap, I still 
doubt anyone is really prepared for CPU-page-aligned mappings to fail.
Even at the DMA API level you could hide *some* of it (at the cost of 
effectively only having 1/4 of the usable address space), but there are 
still cases like where v4l2 has a hard requirement that a page-aligned 
scatterlist can be mapped into a contiguous region of DMA addresses.

> This would be important to later support the thunderbolt DARTs since I would be
> very uncomfortable to have these running in (software or hardware) bypass mode.

Funnily enough that's the one case that would be relatively workable, 
since untrusted devices are currently subject to bounce-buffering of the 
entire DMA request, so it doesn't matter so much how the bounce buffer 
itself is mapped. Even with the possible future optimisation of only 
bouncing the non-page-aligned start and end parts of a buffer I think it 
still works (the physical alignment just has to be considered in terms 
of the IOMMU granule).

Robin.
