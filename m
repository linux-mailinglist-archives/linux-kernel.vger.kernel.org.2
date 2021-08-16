Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D33ED072
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhHPImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:42:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17025 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbhHPImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:42:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gp6xT5ftgzb2St;
        Mon, 16 Aug 2021 16:38:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 16:41:48 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 16:41:48 +0800
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To:     Will Deacon <will@kernel.org>
CC:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
 <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
 <52204403-f69a-d2b9-9365-7553e87d1298@huawei.com>
 <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
 <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
 <20210816082126.GA11011@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <60343dae-5e67-f7e1-478f-f3aab32dd8c2@huawei.com>
Date:   Mon, 16 Aug 2021 16:41:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210816082126.GA11011@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/16 16:21, Will Deacon wrote:
> On Mon, Aug 16, 2021 at 03:47:58PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/8/16 15:24, John Garry wrote:
>>>> In addition, I find that function arm_smmu_cmdq_build_cmd() can also be optimized
>>>> slightly, three useless instructions can be reduced.
>>>
>>> I think that you could optimise further by pre-building commonly used commands.
>>>
>>> For example, CMD_SYNC without MSI polling is always the same. And then only different in 1 field for MSI polling.
>>>
>>> But you need to check if the performance gain is worth the change.
>>
>> Good advice. I can give it a try.
> 
> Please send it as a new patch on top. I've queued the old one and sent
> it to Joerg. Since this is just further cleanup, it can be done separately.

OK, I'll post a separate patch later.

> 
> Will
> .
> 
