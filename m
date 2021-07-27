Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D33D7CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhG0Rzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhG0Rzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:55:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:55:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so23143841lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VbJOr8r6+EQm5drNSCNTr2Un9oLoU3QNaM6UXCSAXY=;
        b=Q88+W4TPhALv2EnSzUJjE3G5Pp+HO1jOVYRzEbEKS85Cz286dMwg93wz05W1J5UIiY
         YmYTttpvOcu/DCoTTAKO05a8f4NMrYqthqm0UuMVn8gwrstzKch8fJ6BSPwn9owADL9K
         rLwdg3whbvqMJ0VJLqiNkVKpr8DpZenYe3qWv6UE/BEjN02lFAQxjA2iwEhGP9UgTy6t
         OdGXPuvaCl5IgCfm9xj8fN1XzGD1/wfBwTZ3uZgqUwDhU8xg8+lAtksW5HNn21CBCojE
         RSQx8W6/fIEPEYCpO7Nw0Fjw0OOkstInly5Ja2f6DwfA/aY6ZSBjLbXq3sSf9TMzZq3D
         ILUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VbJOr8r6+EQm5drNSCNTr2Un9oLoU3QNaM6UXCSAXY=;
        b=uBXHKXtt31oRDccdzHe7h5fNINKM04X2/67Wd0KZL7LrJKtjwvVLgayA96psjM9IN1
         0PAFdx3uZsnPYOS7MaxRXZ8LLTckwEb4u1X7ZxwG7JxZOyW9jp8lACifKUvvlhrQcCpS
         2hcw4OOPvKglBIax/e2JCvdqJWMWHzjJDi4z9ro0CA2E6RGyLQmNK1WjE3bRZlJpERpF
         9Q/DtCE+0VI2vjVMXCgP1guEdEVTvGLLC03XiP5I2TVD1cgc/KmRgKRJi4DHbM47386p
         RaPzP39BN2E2tQLbsgm0jn/VyY/6j2c7roR05Cdj55TJlF9aqPnNn04pHwSb6z+2JZDH
         dELg==
X-Gm-Message-State: AOAM531X25pOLeBnty7EGV+9Pc7NoHd7IUbm9YUHMjom4NhyStKnhNV6
        n1PyZ7LMwYZqtbH9asi0ZW5UC57u1oOCYhImx0leqQ==
X-Google-Smtp-Source: ABdhPJw7Kvy1I8XM015PtKO5aI5LPLAX6DHWav5pbIxK4FytT12zgoEOZtRninu8Yhht40enV+rPk/HO2BRICkBlOTM=
X-Received: by 2002:a05:6512:32aa:: with SMTP id q10mr16877203lfe.368.1627408537141;
 Tue, 27 Jul 2021 10:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210727141119.19812-1-pavo.banicevic@sartura.hr> <20210727141119.19812-3-pavo.banicevic@sartura.hr>
In-Reply-To: <20210727141119.19812-3-pavo.banicevic@sartura.hr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 10:55:26 -0700
Message-ID: <CAKwvOdmgSxx-7o6GKd0aLESQvGssteq_GkNFW11a4fatgVeZpA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: include: asm: unified: mask .syntax unified for clang
To:     Pavo Banicevic <pavo.banicevic@sartura.hr>
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
> The samples/bpf reuses linux headers, with clang -emit-llvm,
> so this w/a is only for samples/bpf (samples/bpf/Makefile CLANG-bpf).
>
> It allows to build samples/bpf for arm on target board.
> In another way clang -emit-llvm generates errors like:
>
> <inline asm>:1:1: error: unknown directive
> .syntax unified
>
> I have verified it on clang 5, 6, 7, 8, 9, 10
> as on native platform as for cross-compiling. This decision is
> arguable, but it doesn't have impact on samples/bpf so it's easier
> just ignore it for clang, at least for now...

Did you test ARCH=arm kernel builds with Clang with this series applied?

>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  arch/arm/include/asm/unified.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
> index 1e2c3eb04353..8718f313e7c4 100644
> --- a/arch/arm/include/asm/unified.h
> +++ b/arch/arm/include/asm/unified.h
> @@ -11,7 +11,9 @@
>  #if defined(__ASSEMBLY__)
>         .syntax unified
>  #else
> -__asm__(".syntax unified");
> +
> +#ifndef __clang__
> +       __asm__(".syntax unified");
>  #endif
>
>  #ifdef CONFIG_CPU_V7M
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
