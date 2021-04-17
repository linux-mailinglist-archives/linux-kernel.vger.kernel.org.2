Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8E362DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhDQE5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhDQE5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:57:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 396886113D;
        Sat, 17 Apr 2021 04:56:43 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] riscv: Disable data start offset in flat binaries
To:     Damien Le Moal <damien.lemoal@wdc.com>, uclinux-dev@uclinux.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210417011009.54569-1-damien.lemoal@wdc.com>
 <20210417011009.54569-3-damien.lemoal@wdc.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <ba8edc33-a171-31c4-a873-ae552cca7690@linux-m68k.org>
Date:   Sat, 17 Apr 2021 14:56:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210417011009.54569-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/4/21 11:10 am, Damien Le Moal wrote:
> uclibc/gcc combined with elf2flt riscv linker file fully resolve the
> PC relative __global_pointer$ value at compile time and do not generate
> a relocation entry to set a correct value of the gp register at runtime.
> As a result, if the flatbin loader offsets the start of the data
> section, the relative position change between the text and data sections
> compared to the compile time positions results in an incorrect gp value
> being used. This causes flatbin executables to crash.
> 
> Avoid this problem by enabling CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
> automatically when CONFIG_RISCV is enabled and CONFIG_MMU is disabled.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Palmer do you want me to take this via my tree with 1/2 in the series,
or are you going to pick it up?

Regards
Greg


> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4515a10c5d22..add528eb9235 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -33,6 +33,7 @@ config RISCV
>   	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>   	select ARCH_WANT_FRAME_POINTERS
>   	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>   	select CLONE_BACKWARDS
>   	select CLINT_TIMER if !MMU
>   	select COMMON_CLK
> 
