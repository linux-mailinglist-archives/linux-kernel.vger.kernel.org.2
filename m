Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEC326AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 02:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhB0BEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 20:04:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12585 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0BEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 20:04:37 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DnSsV6l6bzMd8F;
        Sat, 27 Feb 2021 09:01:50 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 09:03:54 +0800
Subject: Re: [PATCH] RISC-V: Make NUMA depend on SMP
To:     Palmer Dabbelt <palmer@dabbelt.com>, <akpm@linux-foundation.org>,
        <atishp@atishpatra.org>
CC:     <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmerdabbelt@google.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <kernel-team@android.com>
References: <20210226202550.512012-1-palmer@dabbelt.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <e76cf929-ba52-6d53-9ac8-ef403f9b1f4f@huawei.com>
Date:   Sat, 27 Feb 2021 09:03:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210226202550.512012-1-palmer@dabbelt.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/27 4:25, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> In theory these are orthogonal, but in practice all NUMA systems are
> SMP.  NUMA && !SMP doesn't build, everyone else is coupling them, and I
> don't really see any value in supporting that configuration.
>
> Fixes: 4f0e8eef772e ("riscv: Add numa support for riscv64 platform")
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Atish Patra <atishp@atishpatra.org>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Reported-and-Tested-by:  Kefeng Wang <wangkefeng.wang@huawei.com>


> ---
> This is on fixes.
> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a998babc1237..85d626b8ce5e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -314,6 +314,7 @@ endchoice
>   # Common NUMA Features
>   config NUMA
>   	bool "NUMA Memory Allocation and Scheduler Support"
> +	depends on SMP
>   	select GENERIC_ARCH_NUMA
>   	select OF_NUMA
>   	select ARCH_SUPPORTS_NUMA_BALANCING
