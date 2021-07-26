Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EB93D5A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhGZM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:28:41 -0400
Received: from foss.arm.com ([217.140.110.172]:51660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhGZM2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:28:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D9811B3;
        Mon, 26 Jul 2021 06:09:07 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C2E3F70D;
        Mon, 26 Jul 2021 06:09:06 -0700 (PDT)
Subject: Re: [PATCH 16/23] iommu/arm-smmu: Prepare for multiple DMA domain
 types
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <04220b3420c2c513490450f37de109182364f235.1626888445.git.robin.murphy@arm.com>
 <YP6ukfewNVjgS/bt@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a0689d30-2214-c92e-8387-8f1d3b22909b@arm.com>
Date:   Mon, 26 Jul 2021 14:09:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YP6ukfewNVjgS/bt@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-26 13:46, Joerg Roedel wrote:
> On Wed, Jul 21, 2021 at 07:20:27PM +0100, Robin Murphy wrote:
>> -	if (type == IOMMU_DOMAIN_DMA && using_legacy_binding)
>> +	if ((type & __IOMMU_DOMAIN_DMA_API) && using_legacy_binding)
> 
> Hmm, I wonder whether it is time to introduce helpers for these checks?
> 
> Something like iommu_domain_is_dma() is more readable.

Ha, I had exactly that at one point, except I think in the order of 
iommu_is_dma_domain() :)

The end result didn't seem to give enough extra clarity to justify the 
header churn for me, but I'm happy to be wrong about that if you prefer.

Cheers,
Robin.
