Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9475362CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhDQBLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:11:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17349 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQBLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:11:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMZhq67RWz7vFC;
        Sat, 17 Apr 2021 09:08:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Sat, 17 Apr 2021
 09:10:55 +0800
Subject: Re: [PATCH 5/8] iommu: fix a couple of spelling mistakes
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
 <20210326062412.1262-6-thunder.leizhen@huawei.com>
 <e04d117a-4832-7f95-7adf-dbece21aad8c@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b3bd3aed-f02f-2056-1d98-ef164974b0ea@huawei.com>
Date:   Sat, 17 Apr 2021 09:10:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e04d117a-4832-7f95-7adf-dbece21aad8c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/16 23:55, John Garry wrote:
> On 26/03/2021 06:24, Zhen Lei wrote:
>> There are several spelling mistakes, as follows:
>> funcions ==> functions
>> distiguish ==> distinguish
>> detroyed ==> destroyed
>>
>> Signed-off-by: Zhen Lei<thunder.leizhen@huawei.com>
> 
> I think that there should be a /s/appropriatley/appropriately/ in iommu.c

OK, I will fix it in v2.

> 
> Thanks,
> john
> 
> .
> 

