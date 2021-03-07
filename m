Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1D33001D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhCGK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhCGKZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:25:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9C165161
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615112734;
        bh=5argcPxIQ145L+A9+bYHb1SXgS8fgArICXY045nS7+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NRQzOJXMDza1bEKhuY3iC98my8yPJcwG1iD7wEXrJGzR1DidHZRTev0La0ienOy6B
         g+dNciyDv4XFnZiJOJyQtaRq8d6yjZb9BM0txrY1HnQBgGX6hzew1MbW0RDDWWE86G
         gzF/EWgGVHZzFh7jrO3BBY77bm+7IRZuQ7KNJ0dV7nG7UvZin4TggXWM6klFU0TQnI
         /7iaqLg0hCNQLC1UZp8n6DedEFDwAu++v46LGuQQKldHRiXPGkYeL+yKibKr9FknKQ
         BqNb4ZX4GrI/P1fs1/DJZGZXQKpfgLWqHFawFISHpf3ggQleP+vVuOgMI782hZ4ad/
         j4w4vAJYuKIHw==
Received: by mail-ot1-f45.google.com with SMTP id j22so506123otp.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 02:25:34 -0800 (PST)
X-Gm-Message-State: AOAM532KTxMNzhLyDzo6NMcQflOHNuux/cIhfytng0ka30j9d5f6ZPkC
        0SVOeI7P/HEy9SIrJr1NvEoNEci9SbxUJdIgJjM=
X-Google-Smtp-Source: ABdhPJwGHt2AIg8h4ogt+UzuGvMzmeLzjoDNtPF/3XtiaKmHPPlsJ0bDC5mtDjHRfTGE2tLnGjfoLEH9FYCY3W33YsA=
X-Received: by 2002:a9d:503:: with SMTP id 3mr5936406otw.77.1615112734063;
 Sun, 07 Mar 2021 02:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20210303170932.1838634-1-jthierry@redhat.com> <20210303170932.1838634-14-jthierry@redhat.com>
In-Reply-To: <20210303170932.1838634-14-jthierry@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 7 Mar 2021 11:25:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEt36b6oPAz8wtpig+WBNCGaWhWcKQiAAfOBC2a5O0iVA@mail.gmail.com>
Message-ID: <CAMj1kXEt36b6oPAz8wtpig+WBNCGaWhWcKQiAAfOBC2a5O0iVA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/13] objtool: arm64: Enable stack validation for arm64
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ycote@redhat.com,
        Raphael Gault <raphael.gault@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 at 18:10, Julien Thierry <jthierry@redhat.com> wrote:
>
> From: Raphael Gault <raphael.gault@arm.com>
>
> Add build option to run stack validation at compile time.
>
> When requiring stack validation, jump tables are disabled as it
> simplifies objtool analysis (without having to introduce unreliable
> artifacs). In local testing, this does not appear to significaly
> affect final binary size nor system performance.
>
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  arch/arm64/Kconfig  | 1 +
>  arch/arm64/Makefile | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1f212b47a48a..928323c03318 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -187,6 +187,7 @@ config ARM64
>         select MMU_GATHER_RCU_TABLE_FREE
>         select HAVE_RSEQ
>         select HAVE_STACKPROTECTOR
> +       select HAVE_STACK_VALIDATION
>         select HAVE_SYSCALL_TRACEPOINTS
>         select HAVE_KPROBES
>         select HAVE_KRETPROBES
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 5b84aec31ed3..b819fb2e8eda 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -136,6 +136,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
>    CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>  endif
>
> +ifeq ($(CONFIG_STACK_VALIDATION),y)
> +KBUILD_CFLAGS  += -fno-jump-tables
> +endif
> +

This is a bit misleading: the Kconfig option in question is selected
automatically in all cases, so jump tables are always disabled.

However, I think disabling jump tables make sense anyway, at least
when building the relocatable kernel for KASLR: we currently don't use
-fpic/fpie in that case when building the vmlinux objects (because we
don't want/need GOT tables), and so jump tables are emitted using
absolute addresses, which induce some space overhead in the image. (24
bytes of RELA data per absolute address)

... unless I am missing something, and jump tables can/will be emitted
as relative, even when not compiling in PIC mode?





>  # Default value
>  head-y         := arch/arm64/kernel/head.o
>
> --
> 2.25.4
>
