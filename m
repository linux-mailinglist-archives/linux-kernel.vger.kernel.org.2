Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5904735D626
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344455AbhDMDud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbhDMDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:50:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:50:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f12so14988485wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCLss6L2rlH6nui9SBILYlvnXvgvjlR5gMc5fRIeGlU=;
        b=h8uHMGP+0siogYx0lsEcrSGhqGjozEZiaoZBsIxchbVkOpuUIaAhHcpY8G9peLdBGR
         C4E4ybkDFRHhDn1HchsyJrogB6Ct1j5hm3rsihquEW2obJuEMqOtmFOOwVJqjZ36Ftii
         YOFq+qQ6RVgTxKwr7CiNmwYj/0i6q+eVM7R0vLUVEA9CeoXX0VfqCwzHkgrkeOjhA37E
         Tt0SegHOZxj7+QZ4unqJfFruG3RlGRGBlheNwz8SUeAKEVW6qveFZ/qM8YyVezD5jM3s
         Ahhyhy8I85kdRyH8sRFHLN6Dv1IW5uA+oZ9YEe9b1B6xHMPJoDTAlA5L7kbvich2mncw
         c/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCLss6L2rlH6nui9SBILYlvnXvgvjlR5gMc5fRIeGlU=;
        b=f5Nn+tRURrZf8HUU/XlE35y/nTS1cjfrb/mpqaOgrF0xfVjoLndkIRlkxiXOtypYoA
         jr1y+spy2QXG6ZNvU1yYefrF+jf9CEDUoXBFXv89xrPXNsFp6FRuPoGDyP/eBklIrtN4
         DRcQrEmd9BA0dXXEUqnb5ax9gvJFW06r9cR/i3IIqhWOTMZFljApeWOn21aUmSlWt1RA
         /FI/Dnkg6ZqU58SlyBeT4IlYDNrzRxHtNXGfOzQ2ILptsKmt8/EPLLkmDV6OuyervOPe
         qXnN60O+GQcKQlPOnNjNlCoCc3Pm4rq7ERUszadL6YKuHYAbxt4fy3QzvVDvZU2V183W
         UQbg==
X-Gm-Message-State: AOAM5326s85fBvOYT1mjJZ3u2uWoyqKLtI2slYKTQ9BNE2Rc3I2DLQ28
        hwbwevfYixLgIPAqfE2shKoTN5ECCoGb/uY5P/wwFQ==
X-Google-Smtp-Source: ABdhPJyuTQXUgefe0/dn4tuy+MtAh10eT9dLIEA1gZIrXQl5WgTFytzsbYihpX1KHFQsBs6cIHHWNMXonoNIbaCn2ww=
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr35673706wrt.390.1618285810112;
 Mon, 12 Apr 2021 20:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210413001110.7209bae6@xhacker> <20210413001159.341a95d6@xhacker>
In-Reply-To: <20210413001159.341a95d6@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 13 Apr 2021 09:19:59 +0530
Message-ID: <CAAhSdy3iiJniE3ubPjSZvtVtT7tf5OW8zNONcEbAvrVmLXAjBA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] riscv: mm: Remove setup_zero_page()
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 9:47 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> The empty_zero_page sits at .bss..page_aligned section, so will be
> cleared to zero during clearing bss, we don't need to clear it again.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/mm/init.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 7f5036fbee8c..dbeaa4144e4d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -57,11 +57,6 @@ static void __init zone_sizes_init(void)
>         free_area_init(max_zone_pfns);
>  }
>
> -static void setup_zero_page(void)
> -{
> -       memset((void *)empty_zero_page, 0, PAGE_SIZE);
> -}
> -
>  #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
>  static inline void print_mlk(char *name, unsigned long b, unsigned long t)
>  {
> @@ -589,7 +584,6 @@ void mark_rodata_ro(void)
>  void __init paging_init(void)
>  {
>         setup_vm_final();
> -       setup_zero_page();
>  }
>
>  void __init misc_mem_init(void)
> --
> 2.31.0
>
>
