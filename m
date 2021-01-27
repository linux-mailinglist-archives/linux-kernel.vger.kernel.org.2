Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18CD30571C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhA0Jjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:39:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11517 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhA0Jgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:36:46 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DQdjl4GX9zjDTQ;
        Wed, 27 Jan 2021 17:34:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 27 Jan 2021
 17:36:01 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify
 code
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210122131448.1167-1-thunder.leizhen@huawei.com>
 <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
 <20210127092352.GA31790@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <266dcbb7-56fb-6b29-6e50-d49fbee5a966@huawei.com>
Date:   Wed, 27 Jan 2021 17:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210127092352.GA31790@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/27 17:23, Will Deacon wrote:
> On Wed, Jan 27, 2021 at 10:05:50AM +0800, Leizhen (ThunderTown) wrote:
>> I've sent another set of patches. https://lkml.org/lkml/2021/1/26/1065
>> If those patches are acceptable, then this one should be ignored.
> 
> I've already queued this one, so if you want me to drop it then you need to
> send me a revert.

Thanks. Since it's queued, keep it. I'll update the new patch set.

> 
> Will
> 
> .
> 

