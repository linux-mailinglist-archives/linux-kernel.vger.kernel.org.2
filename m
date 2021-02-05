Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC459310617
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhBEHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:54:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12426 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhBEHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:54:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DX71J0vR6zjGhX;
        Fri,  5 Feb 2021 15:52:20 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 15:53:21 +0800
Subject: Re: [PATCH -next] RISCV: Add some depends for NUMA
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        <linux-riscv@lists.infradead.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>
References: <mhng-3a9465c0-42bb-42de-ad66-855dc2e3c56f@palmerdabbelt-glaptop>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <ed095f07-8c91-903b-2859-203ca9b429fa@huawei.com>
Date:   Fri, 5 Feb 2021 15:53:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-3a9465c0-42bb-42de-ad66-855dc2e3c56f@palmerdabbelt-glaptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/5 14:58, Palmer Dabbelt wrote:
> On Wed, 03 Feb 2021 06:23:43 PST (-0800), wangkefeng.wang@huawei.com 
> wrote:
>> The numa feature is useless for riscv32 platform(MAXPHYSMEM_1GB if 
>> 32bit),
>
> I'm not convinced of that.  There's no reason NUMA shouldn't work on 
> 32-bit, it
> doesn't depend on having a large amount of memory just having non-uniform
> memory.  I could buy the argument that build a 32-bit NUMA system 
> would be
> wacky, but IIUC it works now and I don't see any reason to throw that 
> away.

I think the RV32 won't benefit from NUMA, there's no too much memory 
support on RV32,

and it may increase the Image size,  so I decided to drop support for RV32.

>
>> and it should depends on SMP feature, this also fix the build error,
>
> I can buy that CONFIG_NUMA doesn't really make sense without 
> CONFIG_SMP, as
> there's not a whole lot to do, but I also don't see any reason from 
> disallowing
> users from picking it.  arm64 allows !SMP && NUMA, and I don't see any 
> reason
> it wouldn't work just as well for us.

ARM64 won' support !SMP after following patch, and for most 
architecture,  the NUMA feature

depends or select SMP feature.


commit 4b3dc9679cf779339d9049800803dfc3c83433d1
Author: Will Deacon <will@kernel.org>
Date:   Fri May 29 18:28:44 2015 +0100

     arm64: force CONFIG_SMP=y and remove redundant #ifdefs



>
>>   riscv64-buildroot-linux-gnu-ld: mm/page_alloc.o: in function `.L0 ':
>>   page_alloc.c:(.text+0x4808): undefined reference to 
>> `node_reclaim_distance'
>
> The only instance of node_reclaim_distance I see in mm/page_alloc.c is 
> already
> guarded with CONFIG_NUMA, but the definition of node_reclaim_distance 
> isn't.
> I'll send out some patches to add the guard which might make sorting 
> this out
> earlier, but I don't see it fixing any failures.
>
>
>
