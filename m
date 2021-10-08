Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B829E426E83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhJHQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:19:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3950 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:19:35 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HQtYS34TPz67LYX;
        Sat,  9 Oct 2021 00:14:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 18:17:36 +0200
Received: from [10.47.80.141] (10.47.80.141) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 17:17:35 +0100
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <robin.murphy@arm.com>, <xieyongji@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
 <20211004113121.GA27373@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b8b51f52-1a8d-46fe-69ca-0acaf8d399f2@huawei.com>
Date:   Fri, 8 Oct 2021 17:20:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004113121.GA27373@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.141]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 12:31, Will Deacon wrote:
> On Fri, Sep 24, 2021 at 06:01:53PM +0800, John Garry wrote:
>> It really is a property of the IOVA rcache code that we need to alloc a
>> power-of-2 size, so relocate the functionality to resize into
>> alloc_iova_fast(), rather than the callsites.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c            | 8 --------
>>   drivers/iommu/iova.c                 | 9 +++++++++
>>   drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
>>   3 files changed, 9 insertions(+), 16 deletions(-)
> Acked-by: Will Deacon<will@kernel.org>

Cheers

 >

Any chance of an ack from the vdpa guys on the change to their code?

Thanks,
John
