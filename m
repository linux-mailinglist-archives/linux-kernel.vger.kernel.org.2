Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3765F30B4EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhBBBzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:55:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12092 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBBBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:55:12 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DV7BJ6Yhsz162tS;
        Tue,  2 Feb 2021 09:53:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Feb 2021
 09:54:23 +0800
Subject: Re: [PATCH v5 0/1] perf/smmuv3: Don't reserve the PMCG register
 spaces
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210201132750.1709-1-thunder.leizhen@huawei.com>
 <20210201155021.GD15263@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c4d50b48-aaa2-68e5-dfbe-891884cd1fe7@huawei.com>
Date:   Tue, 2 Feb 2021 09:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210201155021.GD15263@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/1 23:50, Will Deacon wrote:
> On Mon, Feb 01, 2021 at 09:27:49PM +0800, Zhen Lei wrote:
>> v4 --> v5:
>> 1. Give up doing the mapping for the entire SMMU register space.
>> 2. Fix some compile warnings. Sorry. So sorry.
> 
> That's alright, these things happen. However, this came in slightly too
> late for 5.12, so please resend at -rc1 and we'll aim for 5.13.

Okay, thanks for your tolerance.

> 
> Will
> 
> .
> 

