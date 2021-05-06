Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187F03752C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhEFLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhEFLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:12:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 04:11:10 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id d21so5116716oic.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKN32BSLEk19fqPYRbpp/aBl53jueiL3TeqVBdcVm1A=;
        b=trfJ03cym7SlppeLuStF5gA/an/7BzmlBZPpQgU2YUawWTr19jdN+CKCK9UVoo3CJx
         A3G+1VnSnva69wgLhLkHV/LVnSmKRMs+tPhjjUrxCqEIcTBs08lT4IpPDP6pgppB+m0V
         lDGwQjG5OfKHo1Ux6+55czfwfnTzfMFS1zQWKRwRbZdDuxG2q4SCV0wqttlvfcHhhr0o
         YegUlWSk2uiAYEdTYm9c/y82Oe7X/YsRvK7BoYcg6fp5NGTgagjGIG4IvXjnxRoCbXfA
         zslicAo/d3pgOdP5/bwfIGIiqda/M3zxYnijVFfPoOwEAXznvmmywyNW0j9XO8J51fN1
         FkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKN32BSLEk19fqPYRbpp/aBl53jueiL3TeqVBdcVm1A=;
        b=XZfgXO9Opw6pnrCC2AJtFUfU5yDbrGd/Txoek3+WX5tgucAsbd4BjzTNcj+OBg0hpb
         bpkwRVoZMoiLEtt6dz57olXiKm12TgxBPedfksy+zXrumYVYlzeaOKueHruZHUCG/ehN
         P8ycypQxTrkE5ihFWhKNpw+BYo5Q6xEkb5L360edgbp46l7wGezNHyAaxjRB6ndcMy9e
         TDhLjmXivxm5SXlBScyRIqwz811Zo13oXxkIZyJuPshw/u/V2S+h+TwDL8Rd9g9fCJWu
         8M8Jcq0rBAgLNPX36qoPpQL3ZhURZh+ENiaKDJfsW+3jS2/hDseTe9+08yAtcdt6akUQ
         AViQ==
X-Gm-Message-State: AOAM532oDOIm2TmhiLJ8ualoYtPXHQQpGucS+D1yYWaADyI9bDhJhL9R
        Hv2i7vuqJD2QeIfbYUILu6eV/x8BpdMJGjKfJdC/jQ==
X-Google-Smtp-Source: ABdhPJygPRh1X7Y6yHXsAUbf0hsREbpV+JjVo39JmnI0r3lPDWDE4S7HWnW/8XmWZUKMY8BiBOAI+9KMeqyp+2DzZq0=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr2714132oif.121.1620299469845;
 Thu, 06 May 2021 04:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210506105405.3535023-1-glider@google.com>
In-Reply-To: <20210506105405.3535023-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 May 2021 13:10:58 +0200
Message-ID: <CANpmjNOXJ6B59bxObf5LZwr5b=fAnpf7d=T6=NCAD-Sq7MA23w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] printk: introduce dump_stack_lvl()
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

On Thu, 6 May 2021 at 12:54, Alexander Potapenko <glider@google.com> wrote:
>
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

Reviewed-by: Marco Elver <elver@google.com>


> ---
>
> v2:
>  -- export dump_stack_lvl() (spotted by Marco Elver)
> ---
>  include/linux/printk.h |  1 +
>  lib/dump_stack.c       | 20 +++++++++++++-------
>  2 files changed, 14 insertions(+), 7 deletions(-)
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
> index f5a33b6f773f..586e3f2c6a15 100644
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
> @@ -125,9 +125,15 @@ asmlinkage __visible void dump_stack(void)
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
> +EXPORT_SYMBOL(dump_stack_lvl);
> +
> +asmlinkage __visible void dump_stack(void)
> +{
> +       dump_stack_lvl(KERN_DEFAULT);
> +}
>  EXPORT_SYMBOL(dump_stack);
> --
> 2.31.1.527.g47e6f16901-goog
>
