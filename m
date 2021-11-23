Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFD459A24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKWChm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:37:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C30FC061574;
        Mon, 22 Nov 2021 18:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9EVG59efUqSxH7OfvIPVznE1zVfZnhPQVQKL00TpmaY=; b=oNCMe4bh5zWrK+/xRoo23ONOlr
        kbHejiq057MW4w+Iwh6L04zdQvRcKsZHjuopg36CWkI6JLslcrPN8l5SvmpwIo85gmsPishd7UV0g
        TwDdALJI1QYUgU8l8E/wNWYc/zH9xJmicQheokHVa5zrFsLF3j1DQ+TyLZiuYMnl3DICbf6gvoHZ3
        xbe3fM8qI8vdw4c0XrGsuaeU4d3kGDxGVkoPtgfHQeb3mfIAQv3DDNLTZnp3Zgn5DhEMQ7u++OwYu
        VSk7EOegwsocnjreUqW0JJU0FZD4aLE4biXS28YjrwRbDxcxqQJSrKVhxrL9pcJwdlpJhlyGe57h7
        H+FPeYKw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpLdf-000fsw-Bx; Tue, 23 Nov 2021 02:34:31 +0000
Subject: Re: [RFC PATCH 3/3] riscv: Add riscv.fwsz kernel parameter
To:     guoren@kernel.org, anup@brainfault.org, palmer@dabbelt.com,
        atishp@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
References: <20211123015717.542631-1-guoren@kernel.org>
 <20211123015717.542631-4-guoren@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ac5613d9-913e-ff07-5802-21e1771112f9@infradead.org>
Date:   Mon, 22 Nov 2021 18:34:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123015717.542631-4-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 5:57 PM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> chance to users to set the proper size of the firmware and get
> more than 1.5MB of memory.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d4..ee505743c8f4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4964,6 +4964,9 @@
>   			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>   			CPUs.
>   
> +	riscv.fwsz=nn[KMG]
> +			[RISC-V] Determine firmware size to save memory

Is "Determine" like "Set"?  The user is setting (telling the software)
the firmware size?

"Determine" makes it sound to me like the Linux software is somehow
helping to determine the firmware size.

> +
>   	ro		[KNL] Mount root device read-only on boot
>   
>   	rodata=		[KNL]
> 


-- 
~Randy
