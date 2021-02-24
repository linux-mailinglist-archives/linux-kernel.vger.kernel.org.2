Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61713236E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 06:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhBXFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 00:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhBXFdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 00:33:02 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:32:22 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a17so1026360ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wv8CKIyAToDWF6+F0p3d49urVW/e2Wi+1E9Kv9qlvpI=;
        b=bZKVDobwwmd1LqH+T19P38gN0jKOEphMqIOGnSTonZ2PsunaN+6CgzSrFJDfiMAo1U
         3hcTn27KrGeHS6tlRSAQ1usryJnnQE1XHY5dSrGsYbTNe4//n9SjmXMDzjURG6tz8bx8
         vsnHip1e1V3E3GnvSMEcW1TPnObOF/r5z3Dvnn6Gj406jMBn35f9OFFt0vtxsosfr1wk
         isHuxWFkp2Xl+rM9cGRVuC/syKc1HCCfyduEiw7CxU7rJMjpeaPKF8tWgS9otctfGgGC
         qs0r8WfKrCMASYwFUS21v2fT5/BHAk2m6aNXludFLuf3go9kx8NwqZLKnl6HzefhzPjg
         rm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wv8CKIyAToDWF6+F0p3d49urVW/e2Wi+1E9Kv9qlvpI=;
        b=EfFdG9QMqxFP+DokNGRuipu3Liw/qh0Ysl5xOnDm6XUfBu5uzAP8rnL8LcnCOHsNTp
         SDpx7iPOb1iTOTpb0rKW1LoR28quRo7lDZXGLckDcGAtRQhE1KE8dvfBjNmCUjUsptXz
         VlUJCsT+HjAelOHTNvtrrNz/NBWguIHk2CbTRZvQ5DLL5ZuJf3xD9Ab5jgq6zZA2rLmY
         C2C71OXmQmGsT8qx7fmcmeX5tMMahodumdrxkl18UuJcH6Et6m3e+28eX863fus82lvH
         FZcdZuuYZWcOkB4DdE4lCXnbTCPXIRHp2c7ehsqBDjs2NiRik+Aa5IssALwjqeSLGblu
         smkQ==
X-Gm-Message-State: AOAM532v5yxwI3FENXftKp+EJtnQDcHUSF+cStt/t2zA0dpD5AtTTDDh
        6IwL8n7RCXiNPsANXyF4R3u5dl4kj40j3ClppEPelQ==
X-Google-Smtp-Source: ABdhPJz9KV36JqaHj/GoB106Kuqalqwntbhpkn8gE3LdvAnOFTzqlx5yXKunW0lep6L/9iQUAs2nM3PIwWbv5paAWV4=
X-Received: by 2002:a2e:557:: with SMTP id 84mr864428ljf.480.1614144740535;
 Tue, 23 Feb 2021 21:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20210223120045.153208-1-sumit.garg@linaro.org> <CAD=FV=XXRkgC7XzM4Zu9so4=-KgXyXrLSXURj4uoEDPUOuAsoQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XXRkgC7XzM4Zu9so4=-KgXyXrLSXURj4uoEDPUOuAsoQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 Feb 2021 11:02:09 +0530
Message-ID: <CAFA6WYNhdMXVaDJf90_kx7Pzmbozwcq3DjSwm0isXw3pTcVhzA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Remove redundant function definitions/prototypes
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 at 21:39, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Feb 23, 2021 at 4:01 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > @@ -103,7 +103,6 @@ extern int kdb_getword(unsigned long *, unsigned long, size_t);
> >  extern int kdb_putword(unsigned long, unsigned long, size_t);
> >
> >  extern int kdbgetularg(const char *, unsigned long *);
> > -extern int kdbgetu64arg(const char *, u64 *);
>
> IMO you should leave kdbgetu64arg() the way it was.  It is symmetric
> to all of the other similar functions and even if there are no
> external users of kdbgetu64arg() now it seems like it makes sense to
> keep it matching.
>

Okay, will keep kdbgetu64arg() the way it was.

-Sumit

>
> > @@ -209,9 +208,7 @@ extern unsigned long kdb_task_state(const struct task_struct *p,
> >                                     unsigned long mask);
> >  extern void kdb_ps_suppressed(void);
> >  extern void kdb_ps1(const struct task_struct *p);
> > -extern void kdb_print_nameval(const char *name, unsigned long val);
> >  extern void kdb_send_sig(struct task_struct *p, int sig);
> > -extern void kdb_meminfo_proc_show(void);
>
> Getting rid of kdb_print_nameval() / kdb_meminfo_proc_show() makes sense to me.
>
>
> >  extern char kdb_getchar(void);
> >  extern char *kdb_getstr(char *, size_t, const char *);
> >  extern void kdb_gdb_state_pass(char *buf);
> > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > index 6226502ce049..b59aad1f0b55 100644
> > --- a/kernel/debug/kdb/kdb_support.c
> > +++ b/kernel/debug/kdb/kdb_support.c
> > @@ -665,24 +665,6 @@ unsigned long kdb_task_state(const struct task_struct *p, unsigned long mask)
> >         return (mask & kdb_task_state_string(state)) != 0;
> >  }
> >
> > -/*
> > - * kdb_print_nameval - Print a name and its value, converting the
> > - *     value to a symbol lookup if possible.
> > - * Inputs:
> > - *     name    field name to print
> > - *     val     value of field
> > - */
> > -void kdb_print_nameval(const char *name, unsigned long val)
> > -{
> > -       kdb_symtab_t symtab;
> > -       kdb_printf("  %-11.11s ", name);
> > -       if (kdbnearsym(val, &symtab))
> > -               kdb_symbol_print(val, &symtab,
> > -                                KDB_SP_VALUE|KDB_SP_SYMSIZE|KDB_SP_NEWLINE);
> > -       else
> > -               kdb_printf("0x%lx\n", val);
> > -}
> > -
>
> Getting rid of kdb_print_nameval() makes sense to me.
>
> -Doug
