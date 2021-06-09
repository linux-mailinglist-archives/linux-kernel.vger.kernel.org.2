Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CB93A1A17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhFIPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235930AbhFIPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:49:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35F896139A;
        Wed,  9 Jun 2021 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623253663;
        bh=y2iT1KaKtWXjVA9Qr2dgdN0hQdcFSVwVBcGncn6FSMg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U6ryXcI15yXTe1pRr2qJ5YvmkBxCRmgsA6aMDlR3YY8GuNly4LxwheFv4Kwex5oX2
         ucLMX48VrEgNSSPYWpAfzS3ZDEYgi8FGbMriwiDf/tyhaClrOdr0B2JS1kcE1qMNJ8
         cjkuYiHbc6xR0oBEWTWOh20x5EjXY4OnQrZWEjTBs6hkQA5l7sSC2VeQv/6uFzMf4S
         slVcdkeiYM1KgazjJA/XiV3SBcXSmuJCDZ/3NtPEUhY/dtsOCFaWq5l/EAfZsd3yg7
         Aax694BSaKSXxdhonzuoKTgfK47+7lu/XX+gM2n0FQHC9Z/HwsDQhGEFVL6VhSWnUh
         udz1keWTyzQQQ==
Received: by mail-lf1-f53.google.com with SMTP id f30so38797352lfj.1;
        Wed, 09 Jun 2021 08:47:43 -0700 (PDT)
X-Gm-Message-State: AOAM531910dhXZDHaEhjSKB5I33W2QjtrzlfZnWGLgk9rFScimCkcf3u
        io/7gNIwIFdGdRvXxJnJBfj3ji2L5mW3ZGjyqQc=
X-Google-Smtp-Source: ABdhPJwpZc1pXubxiYhUED9hZrt4IMeD1eY08EFNm6wFm/ojJscVpxBCM8rUdseYGSPswFlfe255346Px3BL8x22ZQk=
X-Received: by 2002:ac2:57c1:: with SMTP id k1mr110048lfo.231.1623253661486;
 Wed, 09 Jun 2021 08:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
 <20210609105019.3626677-5-punitagrawal@gmail.com> <CAJF2gTS_tmOYFNaLYQmJvbwZwksMctPPbE6GAGgUYTwvLLwE=w@mail.gmail.com>
 <20210609232959.3b94659c00ad66a602653bde@kernel.org>
In-Reply-To: <20210609232959.3b94659c00ad66a602653bde@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Jun 2021 23:47:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSFaexHqbZfHp2tMh-VbmRu+9sJPrWtKv14t6Vassv5A@mail.gmail.com>
Message-ID: <CAJF2gTTSFaexHqbZfHp2tMh-VbmRu+9sJPrWtKv14t6Vassv5A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 10:30 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Guo,
>
> On Wed, 9 Jun 2021 20:33:18 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > csky using -mcount not -fpatchable-function-entry, so
> >                 /* Given address is not on the instruction boundary */
> >                 if ((unsigned long)p->addr != ftrace_addr)
> >                         return -EILSEQ;
> > all right?
>
> Even if -mcount is used, that check is still needed since the
> ftrace hooked address will be the ftrace_addr. If user tries to
> probe the second instruction in mcount code, kprobes needs to stop it.
Make sense. It guarantees p->addr is the first instruction of function
-mcount call site.

Thx

Acked-by: Guo Ren <guoren@kernel.org>

>
> Thank you,
>
> >
> > On Wed, Jun 9, 2021 at 6:51 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
> > >
> > > The csky specific arch_check_ftrace_location() shadows a weak
> > > implementation of the function in core code that offers the same
> > > functionality but with additional error checking.
> > >
> > > Drop the architecture specific function as a step towards further
> > > cleanup in core code.
> > >
> > > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > > Cc: Guo Ren <guoren@linux.alibaba.com>
> > > ---
> > >  arch/csky/kernel/probes/ftrace.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> > > index ef2bb9bd9605..b388228abbf2 100644
> > > --- a/arch/csky/kernel/probes/ftrace.c
> > > +++ b/arch/csky/kernel/probes/ftrace.c
> > > @@ -2,13 +2,6 @@
> > >
> > >  #include <linux/kprobes.h>
> > >
> > > -int arch_check_ftrace_location(struct kprobe *p)
> > > -{
> > > -       if (ftrace_location((unsigned long)p->addr))
> > > -               p->flags |= KPROBE_FLAG_FTRACE;
> > > -       return 0;
> > > -}
> > > -
> > >  /* Ftrace callback handler for kprobes -- called under preepmt disabled */
> > >  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > >                            struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > --
> > > 2.30.2
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
