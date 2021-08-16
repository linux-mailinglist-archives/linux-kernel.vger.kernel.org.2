Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2570C3ED9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhHPPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:31:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14211 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:31:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GpJ4v4cC4z1CWsC;
        Mon, 16 Aug 2021 23:30:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 23:30:29 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 23:30:28 +0800
Subject: Re: [PATCH 1/1] riscv: select CONFIG_ARCH_KEEP_MEMBLOCK
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210816144728.1425121-1-heinrich.schuchardt@canonical.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <bef20bf2-538d-1319-ba22-6774efa10ebc@huawei.com>
Date:   Mon, 16 Aug 2021 23:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210816144728.1425121-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/16 22:47, Heinrich Schuchardt wrote:
> For analyzing memory blocks we can either use the memblock=debug command
> line argument which creates massive output or a debug file system.
>
> Select CONFIG_ARCH_KEEP_MEMBLOCK to provide a debugfs at
> /sys/kernel/debug/memblock to analyze memory blocks. The
> same is already done for arm, arm64, mips, powerpc.
>
> The actual provisioning of the file system depends on CONFIG_DEBUG_FS.

Hi，for riscv, it don't use memblock(eg, no provide pfn_valid to use 
memblock),

we could call memblock_discard() to discard memblock private memory to save

some memory, right?  So I think we don't need this config for now.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4f7b70ae7c31..a6e57614c3fd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -31,6 +31,7 @@ config RISCV
>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> +	select ARCH_KEEP_MEMBLOCK
>   	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>   	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>   	select ARCH_SUPPORTS_HUGETLBFS if MMU
