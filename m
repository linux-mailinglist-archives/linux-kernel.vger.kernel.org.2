Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7553822F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhEQDCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:02:50 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:60415 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhEQDCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:02:49 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 14H318Vg026659
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:01:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 14H318Vg026659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621220468;
        bh=B35afl+WstfUZPLglkvrBuMk+OqJ2NDiyUbSTYShM+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lWw0jtG04TLEX4i6Ej/TJGMxyjvFqf31qScr7+1ozqMxsI6YXw5PKgI/VOPJSFvyB
         tthJB+FkMa4b3sG1pwGaTHQUIANVJnnWwwfHSd/ir6MmVjF5EGEGid2ihGj7fh6he6
         G3Win9wBG8gsGACEnrSNOwhTzzdKbfNfhrNmB7khPTOE/h7iGA5OlcSFB7JlDXmMYN
         4egwUUFnF9rZp5KipXHz0HCCLy5qFUKNX1SptPWRhlTmrZmic7eCaB+sRJ1Ituguyw
         fK1wF1QVDI5ieLd/H8rN6PHcHeNkvIBThqH7LseLYBJNekbtWcLJJYyRZULhFKZSIN
         905zf4Brmt60w==
X-Nifty-SrcIP: [209.85.215.182]
Received: by mail-pg1-f182.google.com with SMTP id i5so3704776pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 20:01:08 -0700 (PDT)
X-Gm-Message-State: AOAM531EEunzJeuZPMJ/BbkJzWe0BcyZd3B5qiplWktf7lzdR+De4Irj
        WL84q9Pe8fCYYcO4v9UOKryBTPsR3KFbTcX8OhM=
X-Google-Smtp-Source: ABdhPJysFmlhtc+EsE739uaGJyhnuN7/cJS07F6wqUpUnuj9VAMQFYUk1J+UquDLSOs0Hc5g/tOfB8YdhZFy4IshnEY=
X-Received: by 2002:a63:a547:: with SMTP id r7mr58788644pgu.7.1621220467709;
 Sun, 16 May 2021 20:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210421185848.1292167-1-keescook@chromium.org>
 <YIMX164sB0CjPHUW@kernel.org> <202104231158.30BC61C4F@keescook>
In-Reply-To: <202104231158.30BC61C4F@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 17 May 2021 12:00:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAf8d4-GPqAC5FK9fBz6VvO2xN8eEYYGe8u--=+vr=CA@mail.gmail.com>
Message-ID: <CAK7LNAQAf8d4-GPqAC5FK9fBz6VvO2xN8eEYYGe8u--=+vr=CA@mail.gmail.com>
Subject: Re: [PATCH] tools build: Fix quiet cmd indentation
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 4:06 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Apr 23, 2021 at 03:54:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 21, 2021 at 11:58:48AM -0700, Kees Cook escreveu:
> > > The tools quiet cmd output has mismatched indentation (and extra space
> > > character between cmd name and target name) compared to the rest of
> > > kbuild out:
> > >
> > >   HOSTCC  scripts/insert-sys-cert
> > >   LD       /srv/code/tools/objtool/arch/x86/objtool-in.o
> > >   LD       /srv/code/tools/objtool/libsubcmd-in.o
> > >   AR       /srv/code/tools/objtool/libsubcmd.a
> > >   HOSTLD  scripts/genksyms/genksyms
> > >   CC      scripts/mod/empty.o
> > >   HOSTCC  scripts/mod/mk_elfconfig
> > >   CC      scripts/mod/devicetable-offsets.s
> > >   MKELF   scripts/mod/elfconfig.h
> > >   HOSTCC  scripts/mod/modpost.o
> > >   HOSTCC  scripts/mod/file2alias.o
> > >   HOSTCC  scripts/mod/sumversion.o
> > >   LD       /srv/code/tools/objtool/objtool-in.o
> > >   LINK     /srv/code/tools/objtool/objtool
> > >   HOSTLD  scripts/mod/modpost
> > >   CC      kernel/bounds.s
> > >
> > > Adjust to match the rest of kbuild.
> >
> > Is this some recent regression? I never noticed this when build perf,
> > with what I have in perf/urgent:
> > [...]
> > It seems nicely aligned:
> > [...]
> >   GEN      /tmp/build/perf/common-cmds.h
> >   CC       /tmp/build/perf/perf-read-vdso32
> >   CC       /tmp/build/perf/exec-cmd.o
> >   MKDIR    /tmp/build/perf/fd/
>
> This is a "tools only" build. I wasn't clear enough in my commit log
> (sorry, I can fix that if needed): it's mismatched with regard to the
> rest of the kernel's kbuild output. (And since objtool is built out of
> tools/, I see intermixed indentation on parallelized x86 builds.)
>
> And, in fact, you can see it just in our combined email reply
> quotations. The first line is a build target from the main kernel (from
> my email), and the second is a build target from tools/ (from your email,
> with additional email-quote-prefixing added for comparison):
>
> > >   CC      scripts/mod/empty.o
> > >   CC       /tmp/build/perf/exec-cmd.o
> --------------^
>
> (I haven't looked into what's needed to strip $(obj) from the tools/
> target output, but that isn't as jarring for me as the extra space.)
>
> I also nominate myself for "most trivial patch this week" award.
>
> -Kees
>
> --
> Kees Cook

I am not so interested in fixing only the appearance on the surface,
but applied to linux-kbuild. Thanks.


-- 
Best Regards
Masahiro Yamada
