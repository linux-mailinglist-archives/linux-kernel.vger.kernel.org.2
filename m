Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093A73A4CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhFLEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLEos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:44:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24674C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:42:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o3so8063117wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkaEs5OoDbQVi5eWL76O0urBiumXEDrqwDT+nb75JPs=;
        b=lesx5X2EuoJQiu/wKMrxbfJEJQAUQ8l3Ut3kqbYeRNdAuzgf884npk+8H6F0NRrNYD
         itOveEVo6B+eROFErPspJrWleFoJDTFeu5z2YMnlIGzatz4IN5Uj/xkKrbtLHDWLgQ+A
         raG6jeLdt+g4eNZUGxGE48SGlSQlr6uwhkfXqM4vbQP1SCoWFyTtnfEAEJ7pXvoaaVYY
         MBAbjl9i0tw659eSxDXl0OfHT7otqxnK1fX5fbqPs1BI7BeB+mTaLZ7Vorz1uL09ikBr
         bAhJN/kCeI/oHxLBQscmWSkwojbgREtmOHhZFw+bhm8BStoRAxFfwrbVVUQhjM0crxUb
         PBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkaEs5OoDbQVi5eWL76O0urBiumXEDrqwDT+nb75JPs=;
        b=uRXAAUyNPPZMh/bbNNaLUs2WHSsb3KkkpoMSVHE9GPb7vUhbxHddBUG94yQBDRslt3
         WO6eBx5x5NORUyskRkEqy0kvgo7J6caLjBovMBau8t/gRZPuuJumn/6SWf6T0jGt+QFn
         ED9QVS38e7ND2ERJ0t4NM8ZoWnxzORMWNkx69BOKYwTYnbEt4EWnNqrDB4MVDSC0mXnL
         TMaoxdp2DkoyPJ5iwPqWPJxHL30IUn3cfJ6Qfhrl8c95kp+Kj+Nb1fpB0QMymJ+2JWF/
         ZMqKBQTWFLzraKTvh2NJjpUpS9l92r+8AJSMBt5Gluvl9YFdUiXbYjmpvN1nF5j0yWF4
         CklQ==
X-Gm-Message-State: AOAM532QE3MTv1CXxnipqzClWO1K9MTsZQxhSqcdsiQmaHqqarerQ3V7
        jsWqqAnzlSNGLL5/eP973W+QWVjQNTj7rKyYrOMpbg==
X-Google-Smtp-Source: ABdhPJz6MgYW8qegCjYiMAcvP1BdzEERmLrzyeX2egYw73NO+adeef4vNNmPs8kyOBbt8qvNYC4CR2cqQzs5nGMsvu4=
X-Received: by 2002:adf:efc3:: with SMTP id i3mr7189395wrp.356.1623472955642;
 Fri, 11 Jun 2021 21:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210612034042.3043112-1-palmer@dabbelt.com>
In-Reply-To: <20210612034042.3043112-1-palmer@dabbelt.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 12 Jun 2021 10:12:24 +0530
Message-ID: <CAAhSdy2oYbSa_c4cqaHcXKiMagOK9NB4F8stBM=cwi6hfAAHBA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Use asm-generic for {in,out}{bwlq}
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 9:25 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> The asm-generic implementation is functionally identical to the RISC-V
> version.
>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Indeed, these are same as asm-generic.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/io.h | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index c025a746a148..69605a474270 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -52,19 +52,6 @@
>  #define __io_pbw()     __asm__ __volatile__ ("fence iow,o" : : : "memory");
>  #define __io_paw()     __asm__ __volatile__ ("fence o,io"  : : : "memory");
>
> -#define inb(c)         ({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> -#define inw(c)         ({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> -#define inl(c)         ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> -
> -#define outb(v,c)      ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> -#define outw(v,c)      ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> -#define outl(v,c)      ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> -
> -#ifdef CONFIG_64BIT
> -#define inq(c)         ({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(__v); __v; })
> -#define outq(v,c)      ({ __io_pbw(); writeq_cpu((v),(void*)(c)); __io_paw(); })
> -#endif
> -
>  /*
>   * Accesses from a single hart to a single I/O address must be ordered.  This
>   * allows us to use the raw read macros, but we still need to fence before and
> --
> 2.32.0.272.g935e593368-goog
>
