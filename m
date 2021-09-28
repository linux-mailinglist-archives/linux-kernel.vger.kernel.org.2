Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B941AFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhI1NRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbhI1NRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:17:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123CC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:16:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so2781584pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SQUYxjDv8R+Qi1Gg/UMc76goHZCTJGQFEBZ8qsddbj4=;
        b=DYNEZUd+mGyPYR4THMYTEjHKsnNoWQo7uS4c6ceIxnNshkuyxQZGM4zEchF+Q8HPPp
         YreRepmi7YOL4FEDPiwJvA9pzoYJGLf8QT48wkd2muHVf6sFJ3um4X2++kWpTMx/UmMK
         OMLjQHW3Oy0z726eRgvi6dTR9rpx5302Cw4Qra0y4XIepoteh5PcUycEg9HWhIcwg8PH
         g5baJNsUSvXHgMHlsfXwIQWwznA1YZHDF6BO8AVb9rqBJKnX7nHhpmnqM+y7ZeA/ZnSn
         KEDlrnGMrOdaSRh0q/5oiRAUG7gcUu2ylQic1FYzXMH0F3nAmwPadsSeU7qGKWT8idFn
         OKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SQUYxjDv8R+Qi1Gg/UMc76goHZCTJGQFEBZ8qsddbj4=;
        b=LOmAV210BcgV5WJjBr5UmBC7W5RlFNPeE5GP7nJktpQc1XHrVcgBdzZzjNezwtKpBs
         iq8f+M4CvnNFvS58oj1ts2hiA9JZUzndzeCJkwI72nPJ++tqshXDFD814qKwsztAK86m
         Vl8D9RhSGQQFds8FqLjC1eLRLMbadBC855ZSkAkF8jAZzEGmW9qbswKRgSUmjEGUo5F2
         36SUbEm2JefSMNUr1rpk5CgGiUYmXeuy8uT4dtqMpGO5RXZyd5M+Poi5m0d8LJMW8MpP
         42pYvKcdfVbkxojZSdb17P0AIvQ4rOjNSRoj/eJKaig1AmhgGep8OIdg6nz8mFuDevEb
         tHpw==
X-Gm-Message-State: AOAM533ASsO9bzUZJmx/WhVlKoCBGLcSvABBWRf8+UJz4imc5++XtVOY
        SBay1B2dn+IakXoTb+dCSsQBzya0ZFbSUMbKuFo=
X-Google-Smtp-Source: ABdhPJx/mZsctE2tHvQECw7udBIzXRCC3KJ8CVSbgZbONe+7hDW7IO2MX/qvS792MRTCf+1pJcxghmkWwah/fmYRFr8=
X-Received: by 2002:a17:90b:3ec1:: with SMTP id rm1mr5631691pjb.179.1632834960929;
 Tue, 28 Sep 2021 06:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210928052657.20909-1-rdunlap@infradead.org>
In-Reply-To: <20210928052657.20909-1-rdunlap@infradead.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 28 Sep 2021 21:15:25 +0800
Message-ID: <CAEbi=3cT_ifvDmn3WKHfuy=VyG8Y79X+HS9hNNuvNwTn_Ned_Q@mail.gmail.com>
Subject: Re: [PATCH] NDS32: export __trace_hardirqs_on/_offf for entry/exit
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alan Kao <alankao@andestech.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>, kclin@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add exports for __trace_hardirqs_on/_off and use them in
> kernel/ex-entry.S and kernel/ex-exit.S to fix build/linker errors.
>
> nds32le-linux-ld: arch/nds32/kernel/ex-entry.o: in function `fucop_ctl_do=
ne':
> (.text+0x12a): undefined reference to `__trace_hardirqs_off'
> (.text+0x12a): relocation truncated to fit: R_NDS32_25_PCREL_RELA against=
 undefined symbol `__trace_hardirqs_off'
> nds32le-linux-ld: arch/nds32/kernel/ex-exit.o: in function `no_work_pendi=
ng':
> (.text+0xea): undefined reference to `__trace_hardirqs_off'
> nds32le-linux-ld: (.text+0xee): undefined reference to `__trace_hardirqs_=
off'
> nds32le-linux-ld: (.text+0xf2): undefined reference to `__trace_hardirqs_=
on'
> nds32le-linux-ld: (.text+0xf6): undefined reference to `__trace_hardirqs_=
on'
>
> Fixes: 0cde56e0280d ("nds32: Fix a kernel panic issue because of wrong fr=
ame pointer access.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> ---
>  arch/nds32/include/asm/ftrace.h |    3 +++
>  arch/nds32/kernel/ex-entry.S    |    1 +
>  arch/nds32/kernel/ex-exit.S     |    2 +-
>  arch/nds32/kernel/ftrace.c      |    3 +++
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> --- linux-next-20210917.orig/arch/nds32/kernel/ftrace.c
> +++ linux-next-20210917/arch/nds32/kernel/ftrace.c
> @@ -276,8 +276,11 @@ noinline void __trace_hardirqs_off(void)
>  {
>         trace_hardirqs_off();
>  }
> +EXPORT_SYMBOL(__trace_hardirqs_off);
> +
>  noinline void __trace_hardirqs_on(void)
>  {
>         trace_hardirqs_on();
>  }
> +EXPORT_SYMBOL(__trace_hardirqs_on);
>  #endif /* CONFIG_TRACE_IRQFLAGS */
> --- linux-next-20210917.orig/arch/nds32/include/asm/ftrace.h
> +++ linux-next-20210917/arch/nds32/include/asm/ftrace.h
> @@ -15,6 +15,9 @@
>
>  extern void _mcount(unsigned long parent_ip);
>
> +extern void __trace_hardirqs_off(void);
> +extern void __trace_hardirqs_on(void);
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>
>  #define FTRACE_ADDR ((unsigned long)_ftrace_caller)
> --- linux-next-20210917.orig/arch/nds32/kernel/ex-entry.S
> +++ linux-next-20210917/arch/nds32/kernel/ex-entry.S
> @@ -8,6 +8,7 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/page.h>
>  #include <asm/fpu.h>
> +#include <asm/ftrace.h>
>
>  #ifdef CONFIG_HWZOL
>         .macro push_zol
> --- linux-next-20210917.orig/arch/nds32/kernel/ex-exit.S
> +++ linux-next-20210917/arch/nds32/kernel/ex-exit.S
> @@ -9,7 +9,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/current.h>
>  #include <asm/fpu.h>
> -
> +#include <asm/ftrace.h>
>
>
>  #ifdef CONFIG_HWZOL

loop in Alan and KC.
