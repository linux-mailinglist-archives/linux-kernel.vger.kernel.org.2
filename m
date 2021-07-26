Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CA3D55A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhGZHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:48:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3483 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhGZHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:48:32 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYCX92LzZz6DHYL;
        Mon, 26 Jul 2021 16:19:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 10:29:00 +0200
Received: from [10.47.94.42] (10.47.94.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 26 Jul
 2021 09:28:59 +0100
Subject: Re: [PATCH 13/23] iommu/dma: Remove redundant "!dev" checks
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <baolu.lu@linux.intel.com>, <dianders@chromium.org>
References: <cover.1626888444.git.robin.murphy@arm.com>
 <4395626d7a4ba84ecce4ff8bc6d086795cebf0a6.1626888445.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <94c66d4b-4458-b89f-def4-54b05c17bcaa@huawei.com>
Date:   Mon, 26 Jul 2021 09:28:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <4395626d7a4ba84ecce4ff8bc6d086795cebf0a6.1626888445.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2021 19:20, Robin Murphy wrote:
> iommu_dma_init_domain() is now only called from iommu_setup_dma_ops(),
> which has already assumed dev to be non-NULL.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

FWIW,

Reviewed-by: John Garry <john.garry@huawei.com>
