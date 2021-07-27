Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECD3D7C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhG0Rxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0Rxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:53:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:53:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y34so23133305lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Awr/4hVZSQpR09EKl8Cxh+0W9sPXqPB7mEdVNsZFybE=;
        b=V2PLR/CAJgIlsjKRoDW/LGwfrR93pYMWyDC98nZxzvVcnvPhmyIvZh1T0TZHwr9S6y
         A3/vJNoA/t86Rs+UHOC8QW2Nm6cZlqn2v94Hy840MI10ZTYaDTAsOitPtTlt7OvNH7Gj
         Ch67d9S9LaWY1UVfcAZZOr+USn7gpKICbuApTOylauPXABmOcyuIyaSSu5BSDBDp8GKA
         +BQxuxVlcslOlOLYeWCmn3eBO9kv8kLUDt0HcKDXyLtqUs3p4wT5lHY6VltGfTJ6E/hV
         OTmY690ZkbGm/fuzHcIKm0PVs4+oM12SYG0hj7frRKkcxkDvhLcBmWp32Drs/d5rPJAu
         mM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Awr/4hVZSQpR09EKl8Cxh+0W9sPXqPB7mEdVNsZFybE=;
        b=YRHDmek0mQ3QA0+kbcCVZnt6pdLTD/oTGbuJUf9RSskOaihi1U7kUU0CX6V4VDTIyR
         qWgr+MoCBa2VYE9fktqE98ye6WFoyGLF3ey/bKC9RZezgB5S6v5g5qK46R6kxMEzfEGx
         ZwL0xYPZPDx4co1D9X9Ui6dozIYtoS6MEO/G+LyRjpuwoDgSeR7eMMIU/w8J8kMTOYCP
         7nJaiK9GevHeSXeOjdlUyCKmsm3fO7Lvg7iEnS9cCOUu04MzxyJ/CXhrjYfeqABnsWX4
         d5u51ywU2YzsxSEhPJSMS1CcC0ZV93wz2oVhM9v4hmcNbwkUAB5rOLqMwTGhULiE+4Od
         mUaA==
X-Gm-Message-State: AOAM530BLbJpgxMXtYtSHuVR/IiSjODSIkweXLYwJWUbtQRzgATUiSnN
        6o9ZHkov4JfxSI6110DWHHSDtHcd1nNwrBbOYm6+qA==
X-Google-Smtp-Source: ABdhPJwsKtkZlbLKRRIc3I9bBKaRdlnCjCuAl8pBTaskMvPD41oUBGFLU4JVYkcXZkNxaK/jVEFVabGCTM4iNLrSEB4=
X-Received: by 2002:ac2:596a:: with SMTP id h10mr10205722lfp.374.1627408411608;
 Tue, 27 Jul 2021 10:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210727141119.19812-1-pavo.banicevic@sartura.hr> <20210727141119.19812-2-pavo.banicevic@sartura.hr>
In-Reply-To: <20210727141119.19812-2-pavo.banicevic@sartura.hr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 10:53:20 -0700
Message-ID: <CAKwvOdkwwXV9rN6bzRs_+hbq5thHNSbEtqwOZ7340a79=NqjSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: include: asm: swab: mask rev16 instruction for clang
To:     Pavo Banicevic <pavo.banicevic@sartura.hr>,
        Arnd Bergmann <arnd@linaro.org>
Cc:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, nathan@kernel.org,
        ivan.khoronzhuk@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        matt.redfearn@mips.com, mingo@kernel.org, dvlasenk@redhat.com,
        juraj.vijtiuk@sartura.hr, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, jakov.petrina@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 7:12 AM Pavo Banicevic
<pavo.banicevic@sartura.hr> wrote:
>
> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>
> The samples/bpf with clang -emit-llvm reuses linux headers to build
> bpf samples, and this w/a only for samples (samples/bpf/Makefile
> CLANG-bpf).
>
> It allows to build samples/bpf for arm bpf using clang.
> In another way clang -emit-llvm generates errors like:
>
> CLANG-bpf  samples/bpf/tc_l2_redirect_kern.o
> <inline asm>:1:2: error: invalid register/token name
> rev16 r3, r0
>
> This decision is arguable, probably there is another way, but
> it doesn't have impact on samples/bpf, so it's easier just ignore
> it for clang, at least for now.

NACK

The way to fix these is to sort out the header includes, not turning
off arbitrary things that are used by the actual kernel build for 32b
ARM.

>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  arch/arm/include/asm/swab.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
> index c6051823048b..a9fd9cd33d5e 100644
> --- a/arch/arm/include/asm/swab.h
> +++ b/arch/arm/include/asm/swab.h
> @@ -25,8 +25,11 @@ static inline __attribute_const__ __u32 __arch_swahb32(__u32 x)
>         __asm__ ("rev16 %0, %1" : "=r" (x) : "r" (x));
>         return x;
>  }
> +
> +#ifndef __clang__
>  #define __arch_swahb32 __arch_swahb32
>  #define __arch_swab16(x) ((__u16)__arch_swahb32(x))
> +#endif
>
>  static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  {
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
