Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8134403C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350054AbhIHPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhIHPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:12:14 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81A6BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=0C3YBGnfpbG9UOTagLlfTYYKY8tokMJAvI
        Ql9p4G3lI=; b=gT8DVp8CbcFATMUBS9fwOB0WS36+q/qdnpW8Hy5wjuZJZ/lTuM
        TPNZ/tUrqqulOn9moSy17+wIG+I5hJKVxIoeEqI9KMf9UWu6OMtZ/p/dGH7b91lr
        9DFaPbVSbmqGqCNXsGByk514vPeG7aHtAJEMBdsBixqxj7rRL5H8Q5jLs=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAnL0t+0jhh3cACAA--.2155S2;
        Wed, 08 Sep 2021 23:10:54 +0800 (CST)
Date:   Wed, 8 Sep 2021 23:04:27 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210908230427.3a92fb87@xhacker>
In-Reply-To: <20210718001423.6b8e1d23@xhacker>
References: <20210718001423.6b8e1d23@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAnL0t+0jhh3cACAA--.2155S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW8Zr1UXF15ur17XrWxCrg_yoW8JrWfpr
        45CF1Fgr45JFyrWF1fKFy7u34xWa1fG393Kr95t3W5Xry3urZ5urn3Kr13W34UCrs5Wryf
        JFyfC34UAayYyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Sun, 18 Jul 2021 00:14:23 +0800
Jisheng Zhang wrote:

> From: Jisheng Zhang <jszhang@kernel.org>
> 
> riscv doesn't implement architecture-optimized bitsearching functions
> such as find_first_{zero}_bit() etc.
> 
> When GENERIC_FIND_FIRST_BIT=n, find_first_bit() is implemented with
> find_next_bit() which is less efficient. Enable GENERIC_FIND_FIRST_BIT
> for riscv to get more optimized find_first_bit() implementation, an
> initial test(lib/find_bit_benchmark) shows find_first_bit() performance
> is improved by nearly 32%.

It seems this patch is missed. Is it possible to pick it up for 2nd 5.15-rc1 PR?

Thanks

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8fcceb8eda07..7ebc54c5c245 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -47,6 +47,7 @@ config RISCV
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_EARLY_IOREMAP
> +	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>  	select GENERIC_IOREMAP
>  	select GENERIC_IRQ_MULTI_HANDLER


