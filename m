Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C13B478E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFYQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:50:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3306 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:50:11 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBMyt5Wztz6L4vj;
        Sat, 26 Jun 2021 00:34:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:47:47 +0200
Received: from [10.47.26.115] (10.47.26.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 25 Jun
 2021 17:47:47 +0100
Subject: Re: [PATCH v14 0/6] iommu: Enhance IOMMU default DMA mode build
 options
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1b75de8f-a2e3-6297-0f56-b2f1548495b0@huawei.com>
Date:   Fri, 25 Jun 2021 17:41:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.115]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 12:34, John Garry wrote:
> This is a reboot of Zhen Lei's series from a couple of years ago, which
> never made it across the line.
> 
> I still think that it has some value, so taking up the mantle.
> 
> Motivation:
> Allow lazy mode be default mode for DMA domains for all ARCHs, and not
> only those who hardcode it (to be lazy). For ARM64, currently we must use
> a kernel command line parameter to use lazy mode, which is less than
> ideal.
> 
> I have now included the print for strict/lazy mode, which I originally
> sent in:
> https://lore.kernel.org/linux-iommu/72eb3de9-1d1c-ae46-c5a9-95f26525d435@huawei.com/
> 
> There was some concern there about drivers and their custom prints
> conflicting with the print in that patch, but I think that it
> should be ok.
> 
> Based on next-20210611 + "iommu: Update "iommu.strict" documentation"

Hi Joerg, Will,

We think that this series is ready to go.

There would be a build conflict with the following:
https://lore.kernel.org/linux-iommu/20210616100500.174507-1-namit@vmware.com/

So please let us know where you stand on it, so that could be resolved.

Robin and Baolu have kindly reviewed all the patches, apart from the AMD 
one.

Thanks,
John
