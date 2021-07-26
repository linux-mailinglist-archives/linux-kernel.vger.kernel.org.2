Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0A3D54B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhGZHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:11:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3481 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhGZHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:11:23 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYBZW2VHFz6BBDR;
        Mon, 26 Jul 2021 15:36:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:51:50 +0200
Received: from [10.47.94.42] (10.47.94.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 26 Jul
 2021 08:51:50 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>, Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
Date:   Mon, 26 Jul 2021 08:51:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YPqYDY9/VAhfHNfU@T590>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2021 11:21, Ming Lei wrote:
>> Thanks, I was also going to suggest the latter, since it's what
>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>> indicative of where the slowness most likely stems from.
> The improvement from 'iommu.strict=0' is very small:
> 

Have you tried turning off the IOMMU to ensure that this is really just 
an IOMMU problem?

You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing 
cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to 
disabling for kernel drivers).

Thanks,
John
