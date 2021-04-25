Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8436A413
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 04:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhDYCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 22:08:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3953 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhDYCIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 22:08:24 -0400
Received: from dggeml763-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FSWZL5Vb8z5v3Z;
        Sun, 25 Apr 2021 10:05:14 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggeml763-chm.china.huawei.com (10.1.199.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sun, 25 Apr 2021 10:07:40 +0800
Received: from [10.174.177.7] (10.174.177.7) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Sun, 25 Apr
 2021 10:07:39 +0800
Subject: Re: [PATCH] arm64:align function __arch_clear_user
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <xuwei5@hisilicon.com>,
        <hewenliang4@huawei.com>, <wuxu.wu@huawei.com>
References: <58fecb22-f932-cb6e-d996-ca75fe26a75d@huawei.com>
 <20210414104144.GB8320@arm.com>
 <6829062c-a2d4-57da-4037-269fb7508993@huawei.com>
 <20210423153701.GP18757@arm.com>
From:   Kai Shen <shenkai8@huawei.com>
Message-ID: <b7ed22f7-2c89-c67d-5e06-380964371150@huawei.com>
Date:   Sun, 25 Apr 2021 10:07:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423153701.GP18757@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.7]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/23 23:37, Catalin Marinas wrote:
> On Mon, Apr 19, 2021 at 10:05:16AM +0800, Kai Shen wrote:
>> On 2021/4/14 18:41, Catalin Marinas wrote:
>>> On Wed, Apr 14, 2021 at 05:25:43PM +0800, Kai Shen wrote:
>>>> Performance decreases happen in __arch_clear_user when this
>>>> function is not correctly aligned on HISI-HIP08 arm64 SOC which
>>>> fetches 32 bytes (8 instructions) from icache with a 32-bytes
>>>> aligned end address. As a result, if the hot loop is not 32-bytes
>>>> aligned, it may take more icache fetches which leads to decrease
>>>> in performance.
>>>> Dump of assembler code for function __arch_clear_user:
>>>>          0xffff0000809e3f10 :    nop
>>>>          0xffff0000809e3f14 :    mov x2, x1
>>>>          0xffff0000809e3f18 :    subs x1, x1, #0x8
>>>>          0xffff0000809e3f1c :    b.mi 0xffff0000809e3f30 <__arch_clear_user+3
>>>> -----  0xffff0000809e3f20 :    str    xzr, [x0],#8
>>>> hot    0xffff0000809e3f24 :    nop
>>>> loop   0xffff0000809e3f28 :    subs x1, x1, #0x8
>>>> -----  0xffff0000809e3f2c :    b.pl  0xffff0000809e3f20 <__arch_clear_user+1
>>>> The hot loop above takes one icache fetch as the code is in one
>>>> 32-bytes aligned area and the loop takes one more icache fetch
>>>> when it is not aligned like below.
>>>>          0xffff0000809e4178 :   str    xzr, [x0],#8
>>>>          0xffff0000809e417c :   nop
>>>>          0xffff0000809e4180 :   subs x1, x1, #0x8
>>>>          0xffff0000809e4184 :   b.pl  0xffff0000809e4178 <__arch_clear_user+
>>>> Data collected by perf:
>>>>                            aligned   not aligned
>>>>             instructions   57733790     57739065
>>>>          L1-dcache-store   14938070     13718242
>>>> L1-dcache-store-misses     349280       349869
>>>>          L1-icache-loads   15380895     28500665
>>>> As we can see, L1-icache-loads almost double when the loop is not
>>>> aligned.
>>>> This problem is found in linux 4.19 on HISI-HIP08 arm64 SOC.
>>>> Not sure what the case is on other arm64 SOC, but it should do
>>>> no harm.
>>>> Signed-off-by: Kai Shen <shenkai8@huawei.com>
>>>
>>> Do you have a real world workload that's affected by this function?
>>>
>>> I'm against adding alignments and nops for specific hardware
>>> implementations. What about lots of other loops that the compiler may
>>> generate or that we wrote in asm?
>>
>> The benchmark we used which suffer performance decrease:
>>      https://github.com/redhat-performance/libMicro
>>      pread $OPTS -N "pread_z1k"    -s 1k    -I 300  -f /dev/zero
>>      pread $OPTS -N "pread_z10k"    -s 10k    -I 1000 -f /dev/zero
>>      pread $OPTS -N "pread_z100k"    -s 100k    -I 2000 -f /dev/zero
> 
> Is there any real world use-case that would benefit from this
> optimisation? Reading /dev/zero in a loop hardly counts as a practical
> workload.
> 
Operations like "dd if=/dev/zero of=/dev/sda1" ?
