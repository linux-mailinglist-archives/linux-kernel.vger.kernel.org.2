Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE13A59F5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhFMSKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 14:10:42 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:45622 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhFMSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 14:10:40 -0400
Received: by mail-ej1-f54.google.com with SMTP id k7so12641684ejv.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDsNnaB5ppj4g5MtFY0m5Kbx3wK4L7HQC7af0yYbm7Q=;
        b=TM9DZ6gSH7CwAVJC0+D0OIC5LCLgVzSXL3kIybCqHfM62NH7+HUlM8BHmPjTYen7QA
         6PZTPAf97gTVU/Ewynu3DCMbRiEFFgk0QLEqT3HoWUR5EapfuXetZOvJJHj66pHFpO2/
         GI3DVGYz6w3AUF06FKeDvFThQf71sweoJQ07ojJbb2N29KJzR9EOlK+09Hj02MEvU5EJ
         4WKM2Kkf9BWODFpihsegzuyQxHZnweedlYD7zbL1XuPzV+/m6EERQaB69gurEZ5YpYy8
         C8khzBmvDbIXPC+HaqP1dNjLY/W5Ppe3CwgWXxclcmy43fFY3nOpt+F2vZCxOd1Dxo/R
         /HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDsNnaB5ppj4g5MtFY0m5Kbx3wK4L7HQC7af0yYbm7Q=;
        b=qQ6V9mofPVJDt7zEZCDNSMMCLN31BBnz1KBuVVIyVwSmRz3LoPBmmqB43FWxMaV+/1
         l90yh8LJwty+uruvlZ5mQGwNvQWZNLjI2E+WHzYrpy3REoIHj6qlWPqB5brcKo/JOJ2A
         mtXG9eb0QnRLTiRdwU+y9xHQKpd+G8jfBnumIpFpWP19OO9mATsHFF9Gccu2TiS2CiD+
         XarXhF2xARgDe/HB2OwWK4UIL9FBWeRnY+00Kjfvxr+RsFKRtCG84sAMcjc0N8GUo55q
         OqR1bPaV4LS/y1H3vhIouP2fvJuL+RXJ8N+pm2N2kE53Vvi5VunyR1ICDMZ7ZAsvy0g6
         I+8A==
X-Gm-Message-State: AOAM533kU/Rc+hi3F+bldgsVnWaWDr9GoPU02K/krruVb87O91PD7Kg/
        2vlaPmqRAsGcHDaWnS34NHQeDkLXEKtwUHCI4dLJyr6iGunV
X-Google-Smtp-Source: ABdhPJw/qSH3tHFNLGhO6GQYyeUxfFg+hUhkSrkizMSt3oBgvCASIk/F6h3Mrnpy58OUlVunK56cx50hHTOQ/2wYiig=
X-Received: by 2002:a17:907:2d88:: with SMTP id gt8mr2394107ejc.449.1623607658177;
 Sun, 13 Jun 2021 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210407211704.367039-1-morbo@google.com>
 <YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net> <CAGG=3QXjD1DQjACu=CQQSP=whue-14Pw8FcNcXrJZfLC_E+y9w@mail.gmail.com>
 <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net> <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
 <20210612202505.GG68208@worktop.programming.kicks-ass.net>
 <CAGG=3QUZ9tXGNLhbOr+AFDTJABDujZuaG1mYaLKdTcJZguEDWw@mail.gmail.com> <CAGG=3QUFRM85bpyjdokO93=Nem_w7-784-_qihP1P_CJMOsdqg@mail.gmail.com>
In-Reply-To: <CAGG=3QUFRM85bpyjdokO93=Nem_w7-784-_qihP1P_CJMOsdqg@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Sun, 13 Jun 2021 11:07:26 -0700
Message-ID: <CAGG=3QUrhVi37sYtybTUAZMpCDjB_pw+1OdkbZKvL6+UQrbMbQ@mail.gmail.com>
Subject: Re: [PATCH v9] pgo: add clang's Profile Guided Optimization infrastructure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 3:47 PM Bill Wendling <morbo@google.com> wrote:
>
> On Sat, Jun 12, 2021 at 1:56 PM Bill Wendling <morbo@google.com> wrote:
> > On Sat, Jun 12, 2021 at 1:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Sat, Jun 12, 2021 at 12:10:03PM -0700, Bill Wendling wrote:
> > > Yes it is, but is that sufficient in this case? It very much isn't for
> > > KASAN, UBSAN, and a whole host of other instrumentation crud. They all
> > > needed their own 'bugger-off' attributes.
> > >
> > Now, for the "nointr" issue. I'll see if we need an additional change for that.
> >
> The GCOV implementation disables profiling in those directories where
> instrumentation would fail. We do the same. Both clang and gcc seem to
> treat the no_instrument_function attribute similarly.
>
An example:

$ cat n.c
int g(int);

int __attribute__((__no_instrument_function__))
__attribute__((no_instrument_function))
no_instr(int a) {
  int sum = 0;
  for (int i = 0; i < a; i++)
    sum += g(i);
  return sum;
}

int instr(int a) {
  int sum = 0;
  for (int i = 0; i < a; i++)
    sum += g(i);
  return sum;
}

$ gcc -S -o - n.c -fprofile-arcs -ftest-coverage -O2
        .globl  no_instr
        .type   no_instr, @function
no_instr:
.LFB0:
 ...
        addq    $1, __gcov0.no_instr(%rip)
        pushq   %rbp
 ...
.L3:
 ...
        addq    $1, 8+__gcov0.no_instr(%rip)
 ...
        addq    $1, 16+__gcov0.no_instr(%rip)
 ...
        addq    $1, 16+__gcov0.no_instr(%rip)
 ...
        ret
        .globl  instr
        .type   instr, @function
instr:
.LFB1:
 ...
        addq    $1, __gcov0.instr(%rip)
 ...
        addq    $1, 8+__gcov0.instr(%rip)
 ...
        addq    $1, 16+__gcov0.instr(%rip)
 ...
        addq    $1, 16+__gcov0.instr(%rip)
 ...
        ret

$ clang -S -o - n.c -fprofile-generate -O2
        .globl  no_instr                        # -- Begin function no_instr
        .p2align        4, 0x90
        .type   no_instr,@function
no_instr:                               # @no_instr
 ...
        addq    $1, .L__profc_no_instr+8(%rip)
 ...
        movq    .L__profc_no_instr(%rip), %rax
 ...
        movq    %rax, .L__profc_no_instr(%rip)
 ...
        retq
        .globl  instr                           # -- Begin function instr
        .p2align        4, 0x90
        .type   instr,@function
instr:                                  # @instr
 ...
        addq    $1, .L__profc_instr+8(%rip)
 ...
        movq    .L__profc_instr(%rip), %rax
 ...
        movq    %rax, .L__profc_instr(%rip)
 ...
        retq
.Lfunc_end1:
