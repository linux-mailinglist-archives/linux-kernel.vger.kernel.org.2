Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6484B30FAFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhBDSMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhBDSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:12:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF5C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:11:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a16so2184524plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtK9mH1gkT4tly0aUjleqbTCqo0H1GWRGkm+wgQLcKQ=;
        b=VzWx0dK0F/0P0JbZEaZ7yNuVnXXvvlUt6ZWlIUVzcsmzxQwK0QWShtSdZaJu0SAXdC
         qWQJBu7pYT8MOSGQqxyJ2S6cqveiHyEIfFl0YqmvohE0/IRuuafPGXHtRtswtVSP24As
         v3KylExv9pXuIP1YcK9XeVzoFn9ILZl2JMUb1viSplB3gBRf1sWfjAui3Sn7yGqI5Zso
         NAYvod40+nciWJ+9lcotHZQPdlsyqrzFAcHZU3gRiYrku1qg/3wAxpvtREXsNv4d/Iee
         Sb0MApJzgAMp9CUhnXOhsBd1OgJMoJgOExqhaoHmv4kh30yQHQ2snSw0+3Aq+2R16SYE
         icKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtK9mH1gkT4tly0aUjleqbTCqo0H1GWRGkm+wgQLcKQ=;
        b=G4yU5yFNbe21RyOLHhugGxnD0Y2csqMAxtXspcojCbZQ2xv/FtpimGFrAYP2/bdkBg
         OiAvpRjQ5GeM1bvI+IkXiimUr2+QkMIGOdPgDx44/DOXwaX4de1cIV5Tg+1/1G02KqNo
         6lVy54vJWNBk740AW5VnbKxK4vCHxKgZlxuHNsTOlnzCICH5BElSeAZwxpgspYBDqowV
         xq0umGyWGHVPxsYMGjavHVudlcSYvZSf+Pqtbh2jsaxTr2ROFjumbzZVa7TCHYHZ6FmK
         4dU2QkmI5dsQOVLdUit1CCYQBUXLDeji+8xGbsOozEY9GeLz7VKmKzY1dONafiiuprkx
         C7uQ==
X-Gm-Message-State: AOAM532CeRTbv6FiXrJHavJGl8Hx9b0WLfXI0/uN22lzDbTqmzTdTudO
        E9KS96lcD/PlM9ee+UZ+JnMfGjBXTb7XbRPPE0xzjw==
X-Google-Smtp-Source: ABdhPJwM9n11EzR6QjrdGwIT7tXe7o6IvZV4XBcsjcTX9FIJNuwD9dfLJji0WYIC63nh1Z206CveXNSVwbNVcyALRBI=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr190576pjn.25.1612462294295;
 Thu, 04 Feb 2021 10:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20210204162416.3030114-1-arnd@kernel.org>
In-Reply-To: <20210204162416.3030114-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Feb 2021 10:11:23 -0800
Message-ID: <CAKwvOd=1Cs75KdVU5Fa9W+wYmjo=5fFNBb6m6PnHUp=eoM-H5g@mail.gmail.com>
Subject: Re: [PATCH] ARM: s3c: fix fiq for clang IAS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 8:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building with the clang integrated assembler produces a couple of
> errors for the s3c24xx fiq support:
>
> arch/arm/mach-s3c/irq-s3c24xx-fiq.S:52:2: error: instruction 'subne' can not set flags, but 's' suffix specified
>  subnes pc, lr, #4 @@ return, still have work to do
>  ^
> arch/arm/mach-s3c/irq-s3c24xx-fiq.S:64:1: error: invalid symbol redefinition
> s3c24xx_spi_fiq_txrx:
> ^
> arch/arm/mach-s3c/irq-s3c24xx-fiq.S:79:2: error: instruction 'subne' can not set flags, but 's' suffix specified
>  subnes pc, lr, #4 @@ return, still have work to do
>  ^
> arch/arm/mach-s3c/irq-s3c24xx-fiq.S:104:2: error: instruction 'subne' can not set flags, but 's' suffix specified
>  subnes pc, lr, #4 @@ return, still have work to do
>
> There are apparently two problems: one with extraneous or duplicate
> labels, and one with old-style opcode mnemonics. Stefan Agner has
> previously fixed other problems like this, but missed this particular
> file.

Thanks for the patch.  Pre-UAL syntax

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: bec0806cfec6 ("spi_s3c24xx: add FIQ pseudo-DMA support")
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c/irq-s3c24xx-fiq.S | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-s3c/irq-s3c24xx-fiq.S b/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
> index b54cbd012241..5d238d9a798e 100644
> --- a/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
> +++ b/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
> @@ -35,7 +35,6 @@
>         @ and an offset to the irq acknowledgment word
>
>  ENTRY(s3c24xx_spi_fiq_rx)
> -s3c24xx_spi_fix_rx:
>         .word   fiq_rx_end - fiq_rx_start
>         .word   fiq_rx_irq_ack - fiq_rx_start
>  fiq_rx_start:
> @@ -49,7 +48,7 @@ fiq_rx_start:
>         strb    fiq_rtmp, [ fiq_rspi, # S3C2410_SPTDAT ]
>
>         subs    fiq_rcount, fiq_rcount, #1
> -       subnes  pc, lr, #4              @@ return, still have work to do
> +       subsne  pc, lr, #4              @@ return, still have work to do
>
>         @@ set IRQ controller so that next op will trigger IRQ
>         mov     fiq_rtmp, #0
> @@ -61,7 +60,6 @@ fiq_rx_irq_ack:
>  fiq_rx_end:
>
>  ENTRY(s3c24xx_spi_fiq_txrx)
> -s3c24xx_spi_fiq_txrx:
>         .word   fiq_txrx_end - fiq_txrx_start
>         .word   fiq_txrx_irq_ack - fiq_txrx_start
>  fiq_txrx_start:
> @@ -76,7 +74,7 @@ fiq_txrx_start:
>         strb    fiq_rtmp, [ fiq_rspi, # S3C2410_SPTDAT ]
>
>         subs    fiq_rcount, fiq_rcount, #1
> -       subnes  pc, lr, #4              @@ return, still have work to do
> +       subsne  pc, lr, #4              @@ return, still have work to do
>
>         mov     fiq_rtmp, #0
>         str     fiq_rtmp, [ fiq_rirq, # S3C2410_INTMOD  - S3C24XX_VA_IRQ ]
> @@ -88,7 +86,6 @@ fiq_txrx_irq_ack:
>  fiq_txrx_end:
>
>  ENTRY(s3c24xx_spi_fiq_tx)
> -s3c24xx_spi_fix_tx:
>         .word   fiq_tx_end - fiq_tx_start
>         .word   fiq_tx_irq_ack - fiq_tx_start
>  fiq_tx_start:
> @@ -101,7 +98,7 @@ fiq_tx_start:
>         strb    fiq_rtmp, [ fiq_rspi, # S3C2410_SPTDAT ]
>
>         subs    fiq_rcount, fiq_rcount, #1
> -       subnes  pc, lr, #4              @@ return, still have work to do
> +       subsne  pc, lr, #4              @@ return, still have work to do
>
>         mov     fiq_rtmp, #0
>         str     fiq_rtmp, [ fiq_rirq, # S3C2410_INTMOD  - S3C24XX_VA_IRQ ]
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
