Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5C362CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhDQBMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:12:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17350 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:12:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMZjQ2G6gz7vDT;
        Sat, 17 Apr 2021 09:09:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Sat, 17 Apr 2021
 09:11:30 +0800
Subject: Re: [PATCH 0/8] iommu: fix a couple of spelling mistakes detected by
 codespell tool
To:     Joerg Roedel <joro@8bytes.org>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
 <YHmsQtm4o5f7fAru@8bytes.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2025c88d-0711-22c8-3e1c-2d8c9f053fbf@huawei.com>
Date:   Sat, 17 Apr 2021 09:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YHmsQtm4o5f7fAru@8bytes.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/16 23:24, Joerg Roedel wrote:
> On Fri, Mar 26, 2021 at 02:24:04PM +0800, Zhen Lei wrote:
>> This detection and correction covers the entire driver/iommu directory.
>>
>> Zhen Lei (8):
>>   iommu/pamu: fix a couple of spelling mistakes
>>   iommu/omap: Fix spelling mistake "alignement" -> "alignment"
>>   iommu/mediatek: Fix spelling mistake "phyiscal" -> "physical"
>>   iommu/sun50i: Fix spelling mistake "consits" -> "consists"
>>   iommu: fix a couple of spelling mistakes
>>   iommu/amd: fix a couple of spelling mistakes
>>   iommu/arm-smmu: Fix spelling mistake "initally" -> "initially"
>>   iommu/vt-d: fix a couple of spelling mistakes
> 
> This patch-set doesn't apply. Please re-send it as a single patch when
> v5.13-rc1 is released.

OK

> 
> Thanks,
> 
> 	Joerg
> 
> .
> 

