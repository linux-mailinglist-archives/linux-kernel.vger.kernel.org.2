Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709953D7B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhG0Q7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhG0Q7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:59:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C15C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:59:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e19so23105839ejs.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06umT0zgrhbjqNYxTt/dijb316TtIb66gqZamU5hdxM=;
        b=sHVfj6otChHKWbga7Ddf8n6RnUnQh6ZUFziuMhN2QT+dEW3QkHlt/RrZeeSN5Op6Mq
         Ku96mKjq9jZ5lMY6kkC6JSm5Az9dKZ8wXJG4DJ/LrzFaopoXJOKINiwggTR207bZaFux
         16ow1EAM0hZJKbg8K98iqAzqJrEf2/Gf82mqjvLfuR+7MHBUABKb3V0S3qlXZxsT250s
         8pkd0icXd2OTdYYjjom9xOFyOxWsLeczBGz2c79rNZQzBdmoNa8mO82uNdDuPgA3PSXa
         HckLgl5DFh9CXruGSyqmJPmwLFqhSSlKNHhC6sDU0nxxgTTUrcxaJgTjoabjzlLtiARe
         Bysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06umT0zgrhbjqNYxTt/dijb316TtIb66gqZamU5hdxM=;
        b=enwfbNyJDdFDvOqI9xi0ECNdJ1ufsWNRxHlZZ96ETxilg3ekvRGPsGdQcukf0BwLCx
         oyFqE22w6l7uTqI7Zkem1owJIRhUmFqvwm/bmc5bkL5T/jyEAokIaJG3UVKVIYFOqQrY
         5SBISwQOL3sQoE7+LAaSszGBzD0J9dX9txjitxUP3jM4Pw19l08r6AsHhUDBk7Y+wt3H
         F8BMXjKvcU5gvV+yuc8qqj68LDLyl/ZSrqA4J+/KOflVLxmhZNOs/G4B44fBQTeKymSu
         Xc5cszgVVRvXXhQvg8br64d9MPUzPq7VriXwbL0z1Ddb+qKDWUPewW5pCSkE5Y4JuaVm
         xJQQ==
X-Gm-Message-State: AOAM532nVQWSvuLZ9sDN5eWlx458LqlUi1tpWhpDtapEGdwPgfcjVv7C
        w4TnB1PdA0pbltgV/lwKZpI=
X-Google-Smtp-Source: ABdhPJw7JYoMfM3JbG3lsbgSZPSD+psyW/7Z/4jTtfUzksVTdZbP6LGkTjXblz+aDex0LDH5Cx4VPQ==
X-Received: by 2002:a17:906:4ad9:: with SMTP id u25mr8141470ejt.106.1627405184530;
        Tue, 27 Jul 2021 09:59:44 -0700 (PDT)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id p18sm1465434edu.8.2021.07.27.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:59:44 -0700 (PDT)
Date:   Tue, 27 Jul 2021 18:59:43 +0200
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] tracing/syscalls: Clang cfi enable syscall events
Message-ID: <20210727165943.GA21786@pswork>
References: <20210720221541.16164-1-padmanabha.srinivasaiah@harman.com>
 <CABCJKuecCch5v32GJ8Bt9wEJOWtp2aYanRT7qdrD6BHx5qDRNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuecCch5v32GJ8Bt9wEJOWtp2aYanRT7qdrD6BHx5qDRNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 08:17:45AM -0700, Sami Tolvanen wrote:
> Hi,
> 
> On Tue, Jul 20, 2021 at 3:16 PM <treasure4paddy@gmail.com> wrote:
> >
> > From: Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>
> >
> > With clang cfi syscall symbols are appended with <syscall>.cfi_jt,
> > hence syscall tracer can not find corresponding syscall name.
> > And results in no syscall ftrace events with CFI.
> >
> > To fix this issue, this introduces custom cleanup_syscall_symbol_name()
> > to strip postfix ".cfi_jt" before comparing syscall and symbol name.
> >
> > Signed-off-by: Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>
> > ---
> >  kernel/trace/trace_syscalls.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index 8bfcd3b09422..dbc253fea34d 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -79,6 +79,27 @@ trace_get_syscall_nr(struct task_struct *task, struct pt_regs *regs)
> >  }
> >  #endif /* ARCH_TRACE_IGNORE_COMPAT_SYSCALLS */
> >
> > +#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> > +/*
> > + * For a syscall symbol, clang generated non-canonical local jump tables
> > + * will have entry as <syscall>.cfi_jt and address of this entry
> > + * will be used to replace references to the syscall symbol.
> > + * so we will strip the postfix from appended symbol name.
> > + */
> > +static inline bool cleanup_syscall_symbol_name(char *s)
> > +{
> > +       char *res;
> > +
> > +       res = strrchr(s, '.');
> > +       if (res)
> > +               *res = '\0';
> > +
> > +       return res != NULL;
> > +}
> > +#else
> > +static inline bool cleanup_syscall_symbol_name(char *s) { return false; }
> > +#endif
> > +
> >  static __init struct syscall_metadata *
> >  find_syscall_meta(unsigned long syscall)
> >  {
> > @@ -90,6 +111,7 @@ find_syscall_meta(unsigned long syscall)
> >         start = __start_syscalls_metadata;
> >         stop = __stop_syscalls_metadata;
> >         kallsyms_lookup(syscall, NULL, NULL, NULL, str);
> > +       cleanup_syscall_symbol_name(str);
> 
> Shouldn't this happen in the kallsyms code instead? We already have
> code there to clean up function names, and it seems like we should
> just strip the postfix there before returning the name.
> 
> Sami

Thanks Sami for the input, yes have regenrated patch:
https://lore.kernel.org/lkml/20210727140618.19130-1-treasure4paddy@gmail.com/T/#u

