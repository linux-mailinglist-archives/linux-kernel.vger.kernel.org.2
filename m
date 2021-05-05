Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E023738A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhEEKi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhEEKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:38:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A8C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 03:37:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so1237351otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21OEOBe1K5oTTDMQpZL0edPMTp3mnTLWpfEDMEehxWE=;
        b=N2P3EHi38u7uxsi/pxDK3a4NEO74xNjAmPrr27lMnkbnAuc7PFlBc3Wy4LKAeKWgLZ
         T/OducACAs+uSJSBb8bG1AoipmBNVZ4KbOTAdcooiBpaGpAMXJ1bo8ESFyz2GlXR61pn
         lT15BUF4Fs53cg3JhMXBI1FgydIfPPw+g37E3RVQ437tli1rwR22xe5Ql6e2fKC0iKOu
         QCLdugFw1JPlaulPVmm85nX6RhzBuOL5DTsa+OY0TmUQGjRYKXE52Lu4ueYbE4jo7mWC
         kswH3W3KgiVNOXewDTGd+tGVwEvF7J/qi/OsZQXZri0uFl7xBscCrSVvpYZzu8SnG84M
         pT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21OEOBe1K5oTTDMQpZL0edPMTp3mnTLWpfEDMEehxWE=;
        b=FzsTXJyi3jq2fVuESPcShzRJeo/cuBGBLvFeBOQcPgxzeREkdg738V9sJScVe87PZJ
         hdD4qIulDlTjN7LHbBJ/iGZGOJ6xVepgXP20aN3f743Qrq/it4/d6qg8QVBzhTi1Tg5I
         Yd/WXmlwWWHObB7oXixFZgMXihp8hOoCDC9uiLoP4qBj1cO9iH7zr4omhYMD7nFezJbm
         hy2+4w0DkYepu/PsPmCECe46a5HT0viFXfIXvtZVNXg09BnbsYP5UD8FqBpr5V7AH1tT
         gOUB36h0+kV8VgZkUz3bf/EHSC4lKsIbhtLvZdfH/Q1XMbk1efFNHUEeVso36eFYpaXI
         M2ZA==
X-Gm-Message-State: AOAM531Qe9ZoVGzpzO2IIR+kJxmhP79S3fEa90/3s0vBUiUcD9gdcxrc
        27q70aD1gKfw08P+T9H9OsIxGgjndPsg4EAbclpTYQ==
X-Google-Smtp-Source: ABdhPJxqK6g7FBn8y/9deqo13s8LUGLEcZnzibISWzr3+KDwpNeWRbr5rwr5HCFsQdWytLfdfjaioOHfrroFwHFEU0I=
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr22346686ott.251.1620211049895;
 Wed, 05 May 2021 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210505092218.2422386-1-glider@google.com>
In-Reply-To: <20210505092218.2422386-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 12:37:18 +0200
Message-ID: <CANpmjNPr8HmQieNrKpcBAvnKdUGatTHuN-vjWhO2CfKAmvtoHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] printk: introduce dump_stack_lvl()
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        bo.he@intel.com, yanmin_zhang@linux.intel.com,
        psodagud@quicinc.com, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, he@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 at 11:22, Alexander Potapenko <glider@google.com> wrote:
> dump_stack() is used for many different cases, which may require a log
> level consistent with other kernel messages surrounding the dump_stack()
> call.
> Without that, certain systems that are configured to ignore the default
> level messages will miss stack traces in critical error reports.
>
> This patch introduces dump_stack_lvl() that behaves similarly to
> dump_stack(), but accepts a custom log level.
> The old dump_stack() becomes equal to dump_stack_lvl(KERN_DEFAULT).
>
> A somewhat similar patch has been proposed in 2012:
> https://lore.kernel.org/lkml/1332493269.2359.9.camel@hebo/
> , but wasn't merged.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: he, bo <bo.he@intel.com>
> Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> Cc: Prasad Sodagudi <psodagud@quicinc.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  include/linux/printk.h |  1 +
>  lib/dump_stack.c       | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index fe7eb2351610..abe274305d79 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -206,6 +206,7 @@ void __init setup_log_buf(int early);
>  __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
>  void dump_stack_print_info(const char *log_lvl);
>  void show_regs_print_info(const char *log_lvl);
> +extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>  extern asmlinkage void dump_stack(void) __cold;
>  extern void printk_safe_flush(void);
>  extern void printk_safe_flush_on_panic(void);
> diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> index f5a33b6f773f..3d2c324a4929 100644
> --- a/lib/dump_stack.c
> +++ b/lib/dump_stack.c
> @@ -73,10 +73,10 @@ void show_regs_print_info(const char *log_lvl)
>         dump_stack_print_info(log_lvl);
>  }
>
> -static void __dump_stack(void)
> +static void __dump_stack(const char *log_lvl)
>  {
> -       dump_stack_print_info(KERN_DEFAULT);
> -       show_stack(NULL, NULL, KERN_DEFAULT);
> +       dump_stack_print_info(log_lvl);
> +       show_stack(NULL, NULL, log_lvl);
>  }
>
>  /**
> @@ -87,7 +87,7 @@ static void __dump_stack(void)
>  #ifdef CONFIG_SMP
>  static atomic_t dump_lock = ATOMIC_INIT(-1);
>
> -asmlinkage __visible void dump_stack(void)
> +asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
>  {
>         unsigned long flags;
>         int was_locked;
> @@ -117,7 +117,7 @@ asmlinkage __visible void dump_stack(void)
>                 goto retry;
>         }
>
> -       __dump_stack();
> +       __dump_stack(log_lvl);
>
>         if (!was_locked)
>                 atomic_set(&dump_lock, -1);
> @@ -125,9 +125,14 @@ asmlinkage __visible void dump_stack(void)
>         local_irq_restore(flags);
>  }
>  #else
> -asmlinkage __visible void dump_stack(void)
> +asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
>  {
> -       __dump_stack();
> +       __dump_stack(log_lvl);
>  }
>  #endif

+EXPORT_SYMBOL(dump_stack_lvl);

is missing here?

> +
> +asmlinkage __visible void dump_stack(void)
> +{
> +       dump_stack_lvl(KERN_DEFAULT);
> +}
>  EXPORT_SYMBOL(dump_stack);
> --
> 2.31.1.527.g47e6f16901-goog
>
