Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60955441694
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKAJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:26:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4043 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhKAJX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:23:57 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HjS8p4P2Kz67PwL;
        Mon,  1 Nov 2021 17:16:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 10:21:22 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 09:21:21 +0000
Subject: Re: [PATCH] iommu/dma: fix incorrect error return on iommu deferred
 attach
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Will Deacon <will@kernel.org>,
        Marshall Midden <marshallmidden@gmail.com>
References: <20211027174757.119755-1-logang@deltatee.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0ad0367d-1242-1c41-ad7c-6c4cc4f70983@huawei.com>
Date:   Mon, 1 Nov 2021 09:21:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211027174757.119755-1-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 18:47, Logan Gunthorpe wrote:
> scsi_dma_map() was reporting a failure during boot on an AMD machine
> with the IOMMU enabled.
> 
>    scsi_dma_map failed: request for 36 bytes!
> 
> The issue was tracked down to a mistake in logic: should not return
> an error if iommu_deferred_attach() returns zero.
> 
> Reported-by: Marshall Midden<marshallmidden@gmail.com>
> Fixes: dabb16f67215 ("iommu/dma: return error code from iommu_dma_map_sg()")
> Link:https://lore.kernel.org/all/CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>

Seems reasonable, FWIW:
Reviewed-by: John Garry <john.garry@huawei.com>
