Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747EF36BC32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhDZXlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhDZXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:41:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:40:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 35-20020a9d05260000b029029c82502d7bso22340848otw.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=NEHpIT7JtAotWEAmzkKwy8vPNiQepRQjD2rlrKixEck=;
        b=htJSDBHTfHv3U5av1DteYHnJDJNDUhM/OShaHprDGj0u3+edde0fgzoJhi6v3ZJUGN
         d+d3OgU+6iGVw2wYgjMT5NUuCjcZX/NJ88+hsZCeceFr7SFBzBEAkJwIwfKakOnWZOCt
         uNgsIqt7BRdvEgF27FFZI9YIr6XzlerGlJj/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=NEHpIT7JtAotWEAmzkKwy8vPNiQepRQjD2rlrKixEck=;
        b=G0GYcoQ5STh1s5wxgl3gpjel/jVulKDUwE/NdqQ6MF9ciDptmKqa2DUjjn40S3XgoV
         bQtlay2MmYzYcbYLLqeXzCvnAavyKxnj8r6DJHEN3q92TNIDeIaSrnllnykY7gEYuNCx
         Gni+IeUnEiU8bQGS/ksNKMgWysmLORH58M5HRXA+/anZ7dusUTogHErQfDghNxN051Xy
         ocmsRQzQNjH90DE52dsAXus8wGqEaa1Z85K9HQb+2bbc7L5nz1Geh5/q+dEgVvESmqfg
         t64sg43a/XxtDfw6lfYt17xKnx7a/p68C7CY8+0g8APLwUbSmYUfW3tSqgAHhqmAk0/X
         14jQ==
X-Gm-Message-State: AOAM530fPddpURbC8HLj4xZQHPHQNF6XBk5Nm6Jgill9JRV18wXsVP3T
        yaU4leowsf+oY2BxuSUtBRL2e0ZvY9I0auY3QgJNSQ==
X-Google-Smtp-Source: ABdhPJx87OTgMCGlnQEjvHG1bfaHrJ5Zbfuwn/xKmtbZFK2gWuancnL+IUbBA2+8/DPh25YEDdXNrFzZqEeWtunjfGI=
X-Received: by 2002:a05:6830:1f02:: with SMTP id u2mr16559621otg.308.1619480457466;
 Mon, 26 Apr 2021 16:40:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Apr 2021 16:40:56 -0700
MIME-Version: 1.0
In-Reply-To: <YIaePJGgD+FEQAUF@alley>
References: <20210420215003.3510247-1-swboyd@chromium.org> <20210420215003.3510247-5-swboyd@chromium.org>
 <YIaePJGgD+FEQAUF@alley>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Apr 2021 16:40:56 -0700
Message-ID: <CAE-0n53bcJBe9h90_YkZbwREFPCoJKcEsAwZY5AkQh-SNBZXLw@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] dump_stack: Add vmlinux build ID to stack traces
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-26 04:04:28)
> On Tue 2021-04-20 14:49:54, Stephen Boyd wrote:
> > Add the running kernel's build ID[1] to the stacktrace information
> > header.  This makes it simpler for developers to locate the vmlinux with
> > full debuginfo for a particular kernel stacktrace. Combined with
> > scripts/decode_stracktrace.sh, a developer can download the correct
> > vmlinux from a debuginfod[2] server and find the exact file and line
> > number for the functions plus offsets in a stacktrace.
> >
> > diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> > index f375900cf9ed..3b7a0ff4642f 100644
> > --- a/include/linux/buildid.h
> > +++ b/include/linux/buildid.h
> > @@ -10,7 +10,11 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> >                  __u32 *size);
> >  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
> >
> > +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
>
> Why is this enabled for CONFIG_CRASH_CORE, please?
>
> Is some crash_core code going to printk it id even when
> CONFIG_STACKTRACE_BUILD_ID is disabled?
>
> Anyway, this condition should be added in the patch when a code is
> really going to depend on it. Or the intention should be explained
> in the commit message at least.

Sure I'll move the latter condition to the crash patch at the end.

>
>
> >  extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
> >  void init_vmlinux_build_id(void);
> > +#else
> > +static inline void init_vmlinux_build_id(void) { }
> > +#endif
>
> Otherwise, the patch looks good to me.
>

Thanks.
