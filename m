Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B253390082
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhEYMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:04:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42649 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhEYMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:04:14 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 14PC2V55002350
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 21:02:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 14PC2V55002350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621944151;
        bh=tvWj8zc1KaZx8oneFEp/D8SkmcxSTtuo3lyEiiqE9JE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zyx9nOCPE7dO2bwtRfTp5gQSVF8gOl8vN32FmyO1z9Toi9mizoyFOQ/WvJxu+5+NI
         mbHw5MVBOEWSgDdtLURzaWgZiAuN8trmS4lxcSxaTAIfHu4x6BHA0czk9vw/FFtW1a
         begG705RYJOlcm/DtoRmiXVvqgDwgtJ0bmAhGP9Qkzzo88bEWjLhuPUDM5C//FaC+I
         9AYJ6W0f3oWtdP5KT/pMp9cVgrIlL6SBhv5sqAXLNKWo0MgYplQW93NZO0lXR8kcHG
         d/fv1p2ucz6Jh+L1/dlSysuj9ArXJx5IAeaxM407MiteLlcVypWZnAzjiwh/Nx753T
         JNOU3ZF1Puxcg==
X-Nifty-SrcIP: [209.85.215.180]
Received: by mail-pg1-f180.google.com with SMTP id 29so11451836pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:02:31 -0700 (PDT)
X-Gm-Message-State: AOAM5321H4dMGB3JzVT8ZzSJMuGc/j2owzlfOPExDGR+fucN5zHaKZwA
        fX1lKGhBUTDklRLc87ZWyAodsxtavdTR/QlEzFM=
X-Google-Smtp-Source: ABdhPJwvJP3lvt31ep8fsoSOxeZtv9Y0qDbFQ3oudffI76qICC9WZp20ooMH2LlR1JddU3KSfrJxUQcYKyWGk0El5ys=
X-Received: by 2002:a05:6a00:158d:b029:2e0:6ae2:17b1 with SMTP id
 u13-20020a056a00158db02902e06ae217b1mr28842988pfk.76.1621944150806; Tue, 25
 May 2021 05:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210524181707.132844-1-brgerst@gmail.com> <20210524181707.132844-4-brgerst@gmail.com>
In-Reply-To: <20210524181707.132844-4-brgerst@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 May 2021 21:01:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJAry3dDgg9wHK_Y-eNHNs2Y4iVs89g42c1NKLgVKb4A@mail.gmail.com>
Message-ID: <CAK7LNASJAry3dDgg9wHK_Y-eNHNs2Y4iVs89g42c1NKLgVKb4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/syscalls: Don't sdjust CFLAGS for syscall tables
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 3:17 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> The syscall_*.c files only contain data (the syscall tables).  There
> is no need to adjust CFLAGS for tracing and stack protector since they
> contain no code.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

>  arch/x86/entry/Makefile | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
> index 94d2843ce80c..7fec5dcf6438 100644
> --- a/arch/x86/entry/Makefile
> +++ b/arch/x86/entry/Makefile
> @@ -8,14 +8,8 @@ UBSAN_SANITIZE := n
>  KCOV_INSTRUMENT := n
>
>  CFLAGS_REMOVE_common.o         = $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_syscall_64.o     = $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_syscall_32.o     = $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_syscall_x32.o    = $(CC_FLAGS_FTRACE)
>
>  CFLAGS_common.o                        += -fno-stack-protector
> -CFLAGS_syscall_64.o            += -fno-stack-protector
> -CFLAGS_syscall_32.o            += -fno-stack-protector
> -CFLAGS_syscall_x32.o           += -fno-stack-protector
>
>  obj-y                          := entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
>  obj-y                          += common.o
> --
> 2.31.1
>


-- 
Best Regards
Masahiro Yamada
