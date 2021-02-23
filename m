Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB705322E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhBWQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhBWQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:10:08 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0133C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:09:26 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id b3so4721717qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBg1IR5JedpOTOrYO06K6DlJUVlqWpH8omy4Ybzar+8=;
        b=m0zKw9YMqnels88qhtZuB8ptwcMEcFktaV383ohgB6ToB1fno6GsAzPAlkrp3GW54H
         Qw6XrXiQn98GVfR0PlSmeBISxq+3mbZ6iOZvZJmSimBBaCOjm/mu+4jBhPjflxbycyO5
         OK6/c86p5YbIE+7J5XDfYIwczh/hoNDS/3MXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBg1IR5JedpOTOrYO06K6DlJUVlqWpH8omy4Ybzar+8=;
        b=ap/CtDmEXVrTCFJBwCBlg/R1iRBXv2y9oFZwgLiYiBFE2MlqxFPFWEwYSrVPpwnY4O
         mwzyui5lER7zVbcZ04HOLN03qS0TAsQt4TebWdZeb78vGuOnmFeTCvMxw8eFcu3f1dLJ
         c4/eolsReuCTq6OtQmj16EiJbqLAJke44GNGoB3L9eEhHtxsS7w5CTVvjU3ckZxuN5ss
         1NeRpCJ8D5fcRJ8y0D3jtNX7XG6VMb5HyAXVWgMCmxK70ECzRhityBtITkjTbtV/FscE
         SVhXvn+0IRA+Hhgj+8ld4roZ7eUww4VIAfS32EWxzKj6qYoxbO3QHbR22AJhfo1iHfsl
         LgUw==
X-Gm-Message-State: AOAM532xnh0E4HYq2VM6XCbMxiu/1l3NMfJ/p1neEsMLpTlgvoIYwOWS
        Snue5FzHdgKtwCMahROVWiqgB/9pw3VR2A==
X-Google-Smtp-Source: ABdhPJyEW/XLQ9lLLmBFyhynZgxwUl+f0Z362Ck4ixxn2XwLLcHX4XtXQoiLENV3eQhlITV7geWgjA==
X-Received: by 2002:ac8:5e4f:: with SMTP id i15mr24984252qtx.47.1614096565920;
        Tue, 23 Feb 2021 08:09:25 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i16sm640511qkk.104.2021.02.23.08.09.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 08:09:25 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id n195so16967488ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:09:25 -0800 (PST)
X-Received: by 2002:a25:b74d:: with SMTP id e13mr41178295ybm.405.1614096564853;
 Tue, 23 Feb 2021 08:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20210223120045.153208-1-sumit.garg@linaro.org>
In-Reply-To: <20210223120045.153208-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Feb 2021 08:09:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XXRkgC7XzM4Zu9so4=-KgXyXrLSXURj4uoEDPUOuAsoQ@mail.gmail.com>
Message-ID: <CAD=FV=XXRkgC7XzM4Zu9so4=-KgXyXrLSXURj4uoEDPUOuAsoQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Remove redundant function definitions/prototypes
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 23, 2021 at 4:01 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> @@ -103,7 +103,6 @@ extern int kdb_getword(unsigned long *, unsigned long, size_t);
>  extern int kdb_putword(unsigned long, unsigned long, size_t);
>
>  extern int kdbgetularg(const char *, unsigned long *);
> -extern int kdbgetu64arg(const char *, u64 *);

IMO you should leave kdbgetu64arg() the way it was.  It is symmetric
to all of the other similar functions and even if there are no
external users of kdbgetu64arg() now it seems like it makes sense to
keep it matching.


> @@ -209,9 +208,7 @@ extern unsigned long kdb_task_state(const struct task_struct *p,
>                                     unsigned long mask);
>  extern void kdb_ps_suppressed(void);
>  extern void kdb_ps1(const struct task_struct *p);
> -extern void kdb_print_nameval(const char *name, unsigned long val);
>  extern void kdb_send_sig(struct task_struct *p, int sig);
> -extern void kdb_meminfo_proc_show(void);

Getting rid of kdb_print_nameval() / kdb_meminfo_proc_show() makes sense to me.


>  extern char kdb_getchar(void);
>  extern char *kdb_getstr(char *, size_t, const char *);
>  extern void kdb_gdb_state_pass(char *buf);
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index 6226502ce049..b59aad1f0b55 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -665,24 +665,6 @@ unsigned long kdb_task_state(const struct task_struct *p, unsigned long mask)
>         return (mask & kdb_task_state_string(state)) != 0;
>  }
>
> -/*
> - * kdb_print_nameval - Print a name and its value, converting the
> - *     value to a symbol lookup if possible.
> - * Inputs:
> - *     name    field name to print
> - *     val     value of field
> - */
> -void kdb_print_nameval(const char *name, unsigned long val)
> -{
> -       kdb_symtab_t symtab;
> -       kdb_printf("  %-11.11s ", name);
> -       if (kdbnearsym(val, &symtab))
> -               kdb_symbol_print(val, &symtab,
> -                                KDB_SP_VALUE|KDB_SP_SYMSIZE|KDB_SP_NEWLINE);
> -       else
> -               kdb_printf("0x%lx\n", val);
> -}
> -

Getting rid of kdb_print_nameval() makes sense to me.

-Doug
