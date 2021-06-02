Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0E398E17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFBPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:16:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7076 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhFBPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:16:39 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FwCDl5T2yzYptM;
        Wed,  2 Jun 2021 23:12:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 23:14:52 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 23:14:51 +0800
Subject: Re: [PATCH] Revert "arm: mm: qsd8x50: Fix incorrect permission
 faults"
To:     Russell King <linux@armlinux.org.uk>
CC:     Nathan Chancellor <nathan@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210528074444.17291-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <248320ed-494b-937d-734c-c97e0c32038a@huawei.com>
Date:   Wed, 2 Jun 2021 23:14:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210528074444.17291-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, any comment about this patch, thanks.

On 2021/5/28 15:44, Kefeng Wang wrote:
> This reverts commit e220ba60223a9d63e70217e5b112160df8c21cea.
>
> The VERIFY_PERMISSION_FAULT is introduced since 2009 but no
> one use it, just revert it and clean unused comment.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm/mm/Kconfig     |  2 --
>   arch/arm/mm/abort-ev7.S | 26 --------------------------
>   2 files changed, 28 deletions(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 35f43d0aa056..8355c3895894 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -601,8 +601,6 @@ config CPU_TLB_V6
>   config CPU_TLB_V7
>   	bool
>   
> -config VERIFY_PERMISSION_FAULT
> -	bool
>   endif
>   
>   config CPU_HAS_ASID
> diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
> index f7cc5d68444b..f81bceacc660 100644
> --- a/arch/arm/mm/abort-ev7.S
> +++ b/arch/arm/mm/abort-ev7.S
> @@ -17,31 +17,5 @@ ENTRY(v7_early_abort)
>   	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
>   	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
>   	uaccess_disable ip			@ disable userspace access
> -
> -	/*
> -	 * V6 code adjusts the returned DFSR.
> -	 * New designs should not need to patch up faults.
> -	 */
> -
> -#if defined(CONFIG_VERIFY_PERMISSION_FAULT)
> -	/*
> -	 * Detect erroneous permission failures and fix
> -	 */
> -	ldr	r3, =0x40d			@ On permission fault
> -	and	r3, r1, r3
> -	cmp	r3, #0x0d
> -	bne	do_DataAbort
> -
> -	mcr	p15, 0, r0, c7, c8, 0   	@ Retranslate FAR
> -	isb
> -	mrc	p15, 0, ip, c7, c4, 0   	@ Read the PAR
> -	and	r3, ip, #0x7b   		@ On translation fault
> -	cmp	r3, #0x0b
> -	bne	do_DataAbort
> -	bic	r1, r1, #0xf			@ Fix up FSR FS[5:0]
> -	and	ip, ip, #0x7e
> -	orr	r1, r1, ip, LSR #1
> -#endif
> -
>   	b	do_DataAbort
>   ENDPROC(v7_early_abort)
