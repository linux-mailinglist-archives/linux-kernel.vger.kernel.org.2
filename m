Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075A43B081C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFVPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhFVPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:01:59 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2103BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=aR8G01IJ+UceVFDgRJW6BYPthEX2HmXBea
        Q0eDZtDvc=; b=rN9/qI/+KZUTwcPnMglDwR/DmH325OzAcRRpUGkBv94ONCmds6
        6g2xr9YsPWvYuurbncwEpXiKTKACK+TnKPMBNCA0Ok2hGSDkI6FR0a9222czloFq
        l3LGBjEqQPdQ9N2gdyCsZ5AKE+woSn8YaXAJ6arwFC3vIiszvc3M+frqY=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHjoql+tFgLsMbAQ--.20215S2;
        Tue, 22 Jun 2021 22:58:45 +0800 (CST)
Date:   Tue, 22 Jun 2021 22:53:04 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] riscv: Introduce set_kernel_memory helper
Message-ID: <20210622225304.53d94c0b@xhacker>
In-Reply-To: <20210622082134.2404162-2-alex@ghiti.fr>
References: <20210622082134.2404162-1-alex@ghiti.fr>
        <20210622082134.2404162-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCHjoql+tFgLsMbAQ--.20215S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw17uFy3ZrWDXry3Zw4DXFb_yoW5XFy5pF
        48Jw4DCrWagF9rGFWI9ryq9w1xJwn5Gw1jyrW3A34DuF47XrWUCw15tw1DJr1kGFyqgF4q
        kay5C34Duanxt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
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
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8489tUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, 22 Jun 2021 10:21:33 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> This helper should be used for setting permissions to the kernel
> mapping as it takes pointers as arguments and then avoids explicit cast
> to unsigned long needed for the set_memory_* API.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/set_memory.h |  8 ++++++++
>  arch/riscv/mm/pageattr.c            | 11 +++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 9d4d455726d4..4f9fc54d1806 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -16,6 +16,8 @@ int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  int set_memory_rw_nx(unsigned long addr, int numpages);
> +int set_kernel_memory(char *start, char *end,
> +		      int (*set_memory)(unsigned long start, int num_pages));
>  void protect_kernel_text_data(void);
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> @@ -24,6 +26,12 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  static inline void protect_kernel_text_data(void) {}
>  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
> +static inline int set_kernel_memory(char *start, char *end,
> +				    int (*set_memory)(unsigned long start,
> +						      int num_pages))
> +{
> +	return 0;
> +}
>  #endif
>  
>  #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 5e49e4b4a4cc..11d0b0f4c65d 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -156,6 +156,17 @@ int set_memory_nx(unsigned long addr, int numpages)
>  	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
>  }
>  
> +__always_inline int set_kernel_memory(char *startp, char *endp,

If __always_inline, can it be moved to set_memory.h?

Thanks

> +				      int (*set_memory)(unsigned long start,
> +							int num_pages))
> +{
> +	unsigned long start = (unsigned long)startp;
> +	unsigned long end = (unsigned long)endp;
> +	int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
> +
> +	return set_memory(start, num_pages);
> +}
> +
>  int set_direct_map_invalid_noflush(struct page *page)
>  {
>  	int ret;


