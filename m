Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2EA3B4499
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhFYNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhFYNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:37:40 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71584C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=fNsdP1h8nt16cy9XNDlUuz7NRuDExXgQbd
        +Sq1hHnEI=; b=GLvTYLIzNRT77vXZvtdLVEd6b2L0EypGi9LCUXX/fgmSf4gQuc
        zUhoTS7DVNBArsFJjeQKIoqC/Mg/D9lCyqpkTwc93G+jIQ85+dLNUBlX3kZIb/Um
        sjaWqx9e99ZvISScOD7P2WC7fVKgU6egxLqfQQ8l4GS5fEpBXVtBWoUWg=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3PMB529VgZw00AQ--.11612S2;
        Fri, 25 Jun 2021 21:34:49 +0800 (CST)
Date:   Fri, 25 Jun 2021 21:29:02 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] riscv: Introduce set_kernel_memory helper
Message-ID: <20210625212903.4a2ff309@xhacker>
In-Reply-To: <20210624120041.2786419-2-alex@ghiti.fr>
References: <20210624120041.2786419-1-alex@ghiti.fr>
        <20210624120041.2786419-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygA3PMB529VgZw00AQ--.11612S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyDZF1fAw4DAw1fGFyUWrg_yoW8uw47pF
        48Jw4DCFWagF9rGFWI9r98ua4fJwn5G342yryak3s5uF47Xr4UZw15tw1DJr1kCFyv9F42
        kay7C34Duws8t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fwIDUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 14:00:40 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> This helper should be used for setting permissions to the kernel
> mapping as it takes pointers as arguments and then avoids explicit cast
> to unsigned long needed for the set_memory_* API.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  arch/riscv/include/asm/set_memory.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 9d4d455726d4..96e317dcab13 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -17,6 +17,16 @@ int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  int set_memory_rw_nx(unsigned long addr, int numpages);
>  void protect_kernel_text_data(void);
> +static __always_inline int set_kernel_memory(char *startp, char *endp,
> +					     int (*set_memory)(unsigned long start,
> +							       int num_pages))
> +{
> +	unsigned long start = (unsigned long)startp;
> +	unsigned long end = (unsigned long)endp;
> +	int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
> +
> +	return set_memory(start, num_pages);
> +}
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> @@ -24,6 +34,12 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  static inline void protect_kernel_text_data(void) {}
>  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
> +static inline int set_kernel_memory(char *startp, char *endp,
> +				    int (*set_memory)(unsigned long start,
> +						      int num_pages))
> +{
> +	return 0;
> +}
>  #endif
>  
>  #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)


