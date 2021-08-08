Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1FE3E3B9F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhHHQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:37:53 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B14CC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=wGp9oslcYn/4MPbEEh0iFKyJg/ieb0O1ie
        OAiKIaJ8o=; b=uBY1PLvyiJOE6fi1IN0UXQ7jXSbwP/K2ndIOgF1zG8A7L0bkRT
        +Tcaqhh5EH8CCW7B28zlDhvnF0grM/pi6FP8negVZhf8W6563sLCIqtbDIhjpYDJ
        lKp9USkrEtCxtG9MoW0t5btxTMnJqFBgk5lqrv6L+le7KzplMqlxVjaqg=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygD3xjgkCBBhk60MAA--.4994S2;
        Mon, 09 Aug 2021 00:36:54 +0800 (CST)
Date:   Mon, 9 Aug 2021 00:30:44 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add ARCH_DMA_MINALIGN support
Message-ID: <20210809003044.6692ddce@xhacker>
In-Reply-To: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
References: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygD3xjgkCBBhk60MAA--.4994S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw13Xr4kCw1fXw1xJF1rXrb_yoWfXwb_C3
        yxG397Wr1xXF4xAFsrJas3Jr4Y93yvvFykXr4Yyw13G3WDuw15C39Ykr17Jr4FkayYyFs7
        Ca4rt34kCryYvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU86OJ5UUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Aug 2021 22:55:37 +0800
Xianting Tian <xianting.tian@linux.alibaba.com> wrote:

> Introduce ARCH_DMA_MINALIGN to riscv arch.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/cache.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> index 9b58b1045..2945bbe2b 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -11,6 +11,8 @@
>  
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>  
> +#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES

It's not a good idea to blindly set this for all riscv. For "coherent"
platforms, this is not necessary and will waste memory.


> +
>  /*
>   * RISC-V requires the stack pointer to be 16-byte aligned, so ensure that
>   * the flat loader aligns it accordingly.


