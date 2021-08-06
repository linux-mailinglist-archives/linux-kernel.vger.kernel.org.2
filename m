Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50FD3E2703
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbhHFJQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:16:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3603 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbhHFJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:16:24 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gh0Fd6jBTz6BCSP;
        Fri,  6 Aug 2021 17:15:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 11:16:07 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 6 Aug 2021
 10:16:06 +0100
Subject: Re: [PATCH v3 23/25] iommu: Merge strictness and domain type configs
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <baolu.lu@linux.intel.com>, <dianders@chromium.org>,
        <rajatja@google.com>, <chenxiang66@hisilicon.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <18f2757675b1a4d74d052b2b211e512ebf6e465e.1628094601.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3f383bf0-621a-9e3d-3c49-3e50c498b9f8@huawei.com>
Date:   Fri, 6 Aug 2021 10:15:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <18f2757675b1a4d74d052b2b211e512ebf6e465e.1628094601.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2021 18:15, Robin Murphy wrote:
> To parallel the sysfs behaviour, merge the new build-time option
> for DMA domain strictness into the default domain type choice.
> 
> Suggested-by: Joerg Roedel<joro@8bytes.org>
> Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>
