Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F523DB5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhG3JV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:21:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3536 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhG3JVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:21:23 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbhVP6GVdz6G9mB;
        Fri, 30 Jul 2021 17:11:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 11:21:17 +0200
Received: from [10.47.25.95] (10.47.25.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 30 Jul
 2021 10:21:16 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 21/24] iommu/dma: Factor out flush queue init
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <baolu.lu@linux.intel.com>, <dianders@chromium.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <afdded2f32737757f2af3ee08e123798fa024cce.1627468310.git.robin.murphy@arm.com>
Message-ID: <da69ed21-5161-3354-5f8b-f39b31f714c0@huawei.com>
Date:   Fri, 30 Jul 2021 10:20:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <afdded2f32737757f2af3ee08e123798fa024cce.1627468310.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.95]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 16:58, Robin Murphy wrote:
> Factor out flush queue setup from the initial domain init so that we
> can potentially trigger it from sysfs later on in a domain's lifetime.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>

