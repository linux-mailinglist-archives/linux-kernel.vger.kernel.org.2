Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D853A274D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:43:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3826 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJInC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:43:02 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0y4C24mtzWtkL;
        Thu, 10 Jun 2021 16:36:11 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:41:04 +0800
Subject: Re: [PATCH -next] drm/amdgpu: Use DIV_ROUND_UP_ULL instead of
 DIV_ROUND_UP
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <alexander.deucher@amd.com>, <Xinhui.Pan@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <airlied@redhat.com>,
        <bskeggs@redhat.com>, <matthew.auld@intel.com>,
        <Ramesh.Errabolu@amd.com>, <mchehab+huawei@kernel.org>,
        <Dennis.Li@amd.com>, <funfunctor@folklore1984.net>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20210610082005.86876-1-heying24@huawei.com>
 <5ffe00de-a7b6-3ac4-f61a-5f28b653e7b1@amd.com>
From:   He Ying <heying24@huawei.com>
Message-ID: <ef947327-6114-6c22-6107-bdb9c72f3dfe@huawei.com>
Date:   Thu, 10 Jun 2021 16:41:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5ffe00de-a7b6-3ac4-f61a-5f28b653e7b1@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


在 2021/6/10 16:20, Christian König 写道:
>
>
> Am 10.06.21 um 10:20 schrieb He Ying:
>> When compiling the kernel for MIPS with CONFIG_DRM_AMDGPU = y, errors 
>> are
>> encountered as follows:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.o: In function 
>> `amdgpu_vram_mgr_new':
>> amdgpu_vram_mgr.c:(.text+0x740): undefined reference to `__udivdi3'
>>
>> Making a 64 bit division by a/b (a is uint64_t) is not supported by 
>> default
>> in linux kernel space. Instead, using do_div is OK for this 
>> situation. For
>> this problem, using DIV_ROUND_UP_ULL instead of DIV_ROUND_UP is better.
>
> Already fixed by this patch in drm-next:
>
> commit 691cf8cd7a531dbfcc29d09a23c509a86fd9b24f
> Author: Dave Airlie <airlied@redhat.com>
> Date:   Thu Jun 10 12:59:00 2021 +1000
>
>     drm/amdgpu: use correct rounding macro for 64-bit
>
>     This fixes 32-bit arm build due to lack of 64-bit divides.

OK. Sigh.

Before sending my patch, I searched patches in https://lore.kernel.org/lkml/

but I didn't find this patch. How can I find whether my patch is duplicated

before sending it? Any suggestions?


Thanks.

>
> Regards,
> Christian.
>
>>
>> Fixes: 6a7f76e70fac ("drm/amdgpu: add VRAM manager v2")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: He Ying <heying24@huawei.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 9a6df02477ce..436ec246a7da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -407,7 +407,7 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>   #endif
>>           pages_per_node = max_t(uint32_t, pages_per_node,
>>                          tbo->page_alignment);
>> -        num_nodes = DIV_ROUND_UP(PFN_UP(mem_bytes), pages_per_node);
>> +        num_nodes = DIV_ROUND_UP_ULL(PFN_UP(mem_bytes), 
>> pages_per_node);
>>       }
>>         node = kvmalloc(struct_size(node, mm_nodes, num_nodes),
>
> .
