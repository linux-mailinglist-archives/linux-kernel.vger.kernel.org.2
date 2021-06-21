Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9943AE951
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFUMqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:46:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3296 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFUMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:46:10 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7plY3SyGz6H8Bq;
        Mon, 21 Jun 2021 20:30:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 14:43:55 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 13:43:54 +0100
Subject: Re: [PATCH v4 2/7] iommu/amd: Do not use flush-queue when NpCache is
 on
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20210616100500.174507-1-namit@vmware.com>
 <20210616100500.174507-3-namit@vmware.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <91ea2a97-2db6-3e10-9c2e-80f6a4e0f733@huawei.com>
Date:   Mon, 21 Jun 2021 13:37:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210616100500.174507-3-namit@vmware.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 11:04, Nadav Amit wrote:
> -	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
> +	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
> +		if (!amd_iommu_unmap_flush)
> +			pr_warn("IOMMU batching is disabled due to virtualization");

This is missing the '\n', like the Intel driver.

And, JFYI, we are also downgrading that same print to info level (in the 
Intel driver).

Thanks,
John

> +
>   		amd_iommu_np_cache = true;
> +		amd_iommu_unmap_flush = true;

