Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41843C66A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbhJ0J17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:27:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4033 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJ0J15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:27:57 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HfNTf60vGz6H6sb;
        Wed, 27 Oct 2021 17:20:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 11:25:29 +0200
Received: from [10.47.27.251] (10.47.27.251) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 10:25:28 +0100
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     Jason Wang <jasowang@redhat.com>, mst <mst@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
 <CACGkMEt8FcoJ4zMXFZzmrFjm=ynWfr5yLfvSHCckawpa3FvhkA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c0d35d67-e6b0-3165-0968-30eb9998d242@huawei.com>
Date:   Wed, 27 Oct 2021 10:25:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CACGkMEt8FcoJ4zMXFZzmrFjm=ynWfr5yLfvSHCckawpa3FvhkA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.251]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 03:06, Jason Wang wrote:
> On Fri, Sep 24, 2021 at 6:07 PM John Garry<john.garry@huawei.com>  wrote:
>> It really is a property of the IOVA rcache code that we need to alloc a
>> power-of-2 size, so relocate the functionality to resize into
>> alloc_iova_fast(), rather than the callsites.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
> Acked-by: Jason Wang<jasowang@redhat.com>

Thanks
> 

Hi Joerg,

Can you pick up this patch only for 5.16? It has a good few tags, and 
I'm waiting for feedback/update from Robin on the rest of the series.

Cheers,
John
