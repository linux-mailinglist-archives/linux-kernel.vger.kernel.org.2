Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53403DB714
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhG3KVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:21:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3539 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbhG3KVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:21:08 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbjqL5Syzz6G9Gw;
        Fri, 30 Jul 2021 18:11:42 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 12:21:02 +0200
Received: from [10.47.25.95] (10.47.25.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 30 Jul
 2021 11:21:01 +0100
Subject: Re: [PATCH v2 19/24] iommu: Expose DMA domain strictness via sysfs
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <baolu.lu@linux.intel.com>, <dianders@chromium.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5078e29c-029c-8bab-613f-46c94507c64d@huawei.com>
Date:   Fri, 30 Jul 2021 11:20:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
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
> The sysfs interface for default domain types exists primarily so users
> can choose the performance/security tradeoff relevant to their own
> workload. As such, the choice between the policies for DMA domains fits
> perfectly as an additional point on that scale - downgrading a
> particular device from a strict default to non-strict may be enough to
> let it reach the desired level of performance, while still retaining
> more peace of mind than with a wide-open identity domain. Now that we've
> abstracted non-strict mode as a distinct type of DMA domain, allow it to
> be chosen through the user interface as well.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---

Reviewed-by: John Garry <john.garry@huawei.com>
