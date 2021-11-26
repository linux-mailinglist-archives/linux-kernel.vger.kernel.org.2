Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6335A45ED56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377224AbhKZMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:07:50 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15873 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377262AbhKZMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:05:48 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J0tdn2d1sz90SV;
        Fri, 26 Nov 2021 20:02:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 20:02:33 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 20:02:33 +0800
Message-ID: <2ec0f613-1fad-f64a-4dd5-ba2a7a93dad3@huawei.com>
Date:   Fri, 26 Nov 2021 20:02:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: Enable KCSAN
Content-Language: en-US
To:     Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211126080008.77202-1-wangkefeng.wang@huawei.com>
 <YaC5dbsw/uDYOVEv@elver.google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YaC5dbsw/uDYOVEv@elver.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/26 18:39, Marco Elver wrote:
> On Fri, Nov 26, 2021 at 04:00PM +0800, Kefeng Wang wrote:
>> This patch enables KCSAN for arm64, with updates to build rules
>> to not use KCSAN for several incompatible compilation units.
>>
>> Tested selftest and kcsan_test, and all passed.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Nice! Although I think Mark (Cc'd) also had been working on this and
> probably knows what, if anything, is still missing.
>
> For one, have you tested gcc 11? To make it work with gcc 11, my
> preferred solution is that you simply squash this:
I only have gcc10,  will try gcc 11.
>
> ---
>
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> index c2bb07f5bcc7..d7d0b51b79f5 100644
> --- a/kernel/kcsan/Makefile
> +++ b/kernel/kcsan/Makefile
> @@ -8,6 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
>   CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
>   
>   CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
> +		 $(call cc-option,-mno-outline-atomics) \
>   	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
>   
>   obj-y := core.o debugfs.o report.o
>
> ---
>
> [ I have changes to kernel/kcsan/Makefile that I expect to land in -next
>    soon'ish, the above is small enough that git can auto-merge. ]
>
> gcc somehow made outline-atomics the default (unlike clang), which will
> cause linker errors for kernel/kcsan/core.o. While the support for
> builtin atomics shouldn't be required on arm64, I want it to be
> (compile-)testable on all architectures. Although there's an exception
> that certain compiler instrumentation actually require working builtin
> atomics support, specifically GCOV_KERNEL.
Thanks for your infos, I will try to test it.
> Thanks,
> -- Marco
>
>
