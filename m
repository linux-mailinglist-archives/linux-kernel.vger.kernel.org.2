Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC51740C78B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhIOOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhIOOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:37:27 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E963C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=H2SjBs0kBa3Umj4ph9RU8nWpMuNZomN4Wg
        +b/+m9/Js=; b=xP6BnDCDyXcNheP7K988Vr+umNnd2OPw7/0/blm/2nrzS2qd2E
        fdmDh2plhhUHFuGSHY9grC5bBSNRf9VmXNn/JxuTmifmcO+33z768DV3q6hHsEJB
        RqNeWe+0+WBoOiuCONLotc5RbUrplt1cNYS9Jx4eZawUm1zaBFrS9EkhU=
Received: from xhacker (unknown [101.86.20.138])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDnIqrTBEJhLtIBAA--.1028S2;
        Wed, 15 Sep 2021 22:36:03 +0800 (CST)
Date:   Wed, 15 Sep 2021 22:29:37 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: Re: [RFC PATCH v8 20/21] riscv: Optimize task switch codes of
 vector
Message-ID: <20210915222937.49066323@xhacker>
In-Reply-To: <3b2d4ff556d310ed73a6910b89566a195fc28861.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
        <3b2d4ff556d310ed73a6910b89566a195fc28861.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDnIqrTBEJhLtIBAA--.1028S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1UGw13tFyUXw1xWw4rKrg_yoW8Ww1rpr
        Z0kF98tFW8WrZ3WaySvF15Zry5G3yDWw47KF1qkw1UWr42grn5C3ZYvryDuFs0qryFkayr
        Xa4v9r1vga1DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        W3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85GYPUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Sep 2021 01:45:32 +0800
Greentime Hu <greentime.hu@sifive.com> wrote:

> This patch replacees 2 instructions with 1 instruction to do the same thing
> . rs1=x0 with rd != x0 is a special form of the instruction that sets vl to
> MAXVL.

Similarly, the vector.S is newly introduced in this patch set, so could
this optimization be folded into the __vstate_save and __vstate_restore
introduction patch? Or it's better to keep this optimizaion in commit log?

> 
> Suggested-by: Andrew Waterman <andrew@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/vector.S | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
> index 4f0c5a166e4e..f7223c81b11a 100644
> --- a/arch/riscv/kernel/vector.S
> +++ b/arch/riscv/kernel/vector.S
> @@ -27,8 +27,7 @@
>  #define x_vl     t2
>  #define x_vcsr   t3
>  #define incr     t4
> -#define m_one    t5
> -#define status   t6
> +#define status   t5
>  
>  ENTRY(__vstate_save)
>  	li      status, SR_VS
> @@ -38,8 +37,7 @@ ENTRY(__vstate_save)
>  	csrr    x_vtype, CSR_VTYPE
>  	csrr    x_vl, CSR_VL
>  	csrr    x_vcsr, CSR_VCSR
> -	li      m_one, -1
> -	vsetvli incr, m_one, e8, m8
> +	vsetvli incr, x0, e8, m8
>  	vse8.v   v0, (datap)
>  	add     datap, datap, incr
>  	vse8.v   v8, (datap)
> @@ -61,8 +59,7 @@ ENTRY(__vstate_restore)
>  	li      status, SR_VS
>  	csrs    CSR_STATUS, status
>  
> -	li      m_one, -1
> -	vsetvli incr, m_one, e8, m8
> +	vsetvli incr, x0, e8, m8
>  	vle8.v   v0, (datap)
>  	add     datap, datap, incr
>  	vle8.v   v8, (datap)


