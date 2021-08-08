Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278603E3A30
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhHHM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 08:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHHM15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 08:27:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340DC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 05:27:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k65so24210065yba.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phMNIVj2qh5Du4B6LD+6E2MJYFQ9Q1V0OB1WzMXLNFU=;
        b=Jjrqo0/3RbtObZC7WL8AdwOuloACp+IvdwQwoWlUJ2BEcbiqhiF52mnRn3vori6fcR
         tLI6wo1l9tXONSW9culbVNy2ImUe5+k68c2YpGKxJ6aABynNsqDz2mSH8bPp/BLC5XU8
         Nz7anivszhrH5HUwc1iB/Oo62hDH22fVKaElg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phMNIVj2qh5Du4B6LD+6E2MJYFQ9Q1V0OB1WzMXLNFU=;
        b=cRN5ov7b6XDVvvUgYcOMShakZvx8QPu1x0z8YkGbqxy58dDgwCCCGzZ8PnMzQYAiKv
         kVhNUbueNs6/Yb9cYmoVR0mImMPNuV22q015mUSa2JrlhwO+HtvgMM7/ZWqppa5n1yB7
         SqEXZG1z1CJnh/i/Koy5h34dp5z4EY9OZUpjO/a3m7tcx7LOj7w9jxQTrG5aMmAf8rE3
         xeKbUSOH68/sNQlmB5lHSGAB3Ox8mpRcJzRrPc1dW7KXwvP1U1hkwFBf/uxu9g3fizDL
         bHo+YYZpC9RTtERLfjJUm2SdUqy/4/lqSig++J7Bs/rtLtVZe4pqP8sw5clLwPAMWvQZ
         EziQ==
X-Gm-Message-State: AOAM531twALzAEdv0nIvylcR7IjYbt3SDp7wZU7LEkHULR3FIDaYc5vU
        cyIju/4eXucw9ZA+PJUiWcL8idvB105AEqgQy0ydbQ==
X-Google-Smtp-Source: ABdhPJw+tMVd0eSGz+SyKmTaXzXcQaC8wPqbpS5lM1+UR5o7T8opjWH2YU9GIg6BOef3NCSdqDuK8Oi2NW7cd2X9emg=
X-Received: by 2002:a25:1f46:: with SMTP id f67mr24752430ybf.421.1628425656723;
 Sun, 08 Aug 2021 05:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210721075937.696811-1-alex@ghiti.fr> <20210721075937.696811-4-alex@ghiti.fr>
In-Reply-To: <20210721075937.696811-4-alex@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 8 Aug 2021 14:27:25 +0200
Message-ID: <CAM4kBBKEU4zKkRJKe27Y0uvt7SN=K6HsyNMdPu7Y+WWyh7QRHg@mail.gmail.com>
Subject: Re: [PATCH -fixes 3/3] riscv: Optimize kernel virtual address
 conversion macro
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:04 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> The current test in kernel_mapping_va_to_pa only applies when
> CONFIG_XIP_KERNEL is set, so use IS_ENABLED to optimize this macro at
> compile-time in standard kernels that do not require this test.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Just in case you need it, here comes

Reviewed-By: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  arch/riscv/include/asm/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index b0ca5058e7ae..10dc063868f6 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -123,7 +123,7 @@ extern phys_addr_t phys_ram_base;
>  #define linear_mapping_va_to_pa(x)     ((unsigned long)(x) - kernel_map.va_pa_offset)
>  #define kernel_mapping_va_to_pa(y) ({                                          \
>         unsigned long _y = y;                                                   \
> -       (_y < kernel_map.virt_addr + XIP_OFFSET) ?                                      \
> +       (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?     \
>                 ((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :            \
>                 ((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);    \
>         })
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
