Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF73A5129
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 00:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhFLWvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 18:51:22 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:45710 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhFLWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 18:51:19 -0400
Received: by mail-ej1-f46.google.com with SMTP id k7so10024694ejv.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 15:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGHIR4/0sog9+QR1vgYyGt5rSfZQ7hXnNFmBCZsNQSk=;
        b=lC+cdrowzchkcKAaUtHdUnGc8rpJhhCfEju3TA2/o8CiBKiosvPMgP7QSG9rGrthF/
         P4iryOOKpvsyUr9nhZBqZ9D+MUsnU9NDUoTe6q6zdZXxIwv+V4JHcEL3g0h5zefAnYU9
         uYkSgVlKtdJKXQGQ9l87vB3tQ8+8f+kgXVfX0ai1cCuqMMPnBlH3afaR9oELkVHB6Cqi
         q+rQTncUITPSytCVm03VlE8vlSuYkexxAoq/c9uB6VB9hcdT6+DSFm16yTbgRiFjjgpt
         x0ZBpG90T+cZIoOzntShCWYcInf26H4HbWVJDVr+NuP53d7hggxvDIZkvzsAwcPn/e7N
         w/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGHIR4/0sog9+QR1vgYyGt5rSfZQ7hXnNFmBCZsNQSk=;
        b=ZWqC7K8mXKs8ZI0q4Tcs/C8b4evD9+CxzNoLTuhpAtOd0FosOnqV9+Jb3wR8Fo1yZ0
         9/f03gBU/bEr5vru/SJhbbiY2IfaJM8oQyvF8CqgphvZyhKLT9Meq6o3FxobgsfkuTov
         0zHbAowu4mSNViXf90PH8Qk4DlrpUml579hUlAwcbtZjkd1HQ5hm21VfYls8jNV7zA3v
         W7/RM4jw724Gq9RyL2Cww+DhyrqpxDTQk5bDb8jY0fgrqxyUJrYWi/PyUKVJ0agJfCsz
         SntKaYmn2+fVjTIa9cvng26dH8jEGfDw/Y1Q+zJQxtEFPvMphOl7cGzzIrfhjs3cbdHF
         J78A==
X-Gm-Message-State: AOAM5307KpRrkn46rfDoU20SecocNev3W88FnqLAVkjpopRnKlBPMSi3
        VcrY7rNdIz0Gx4cGxgOOLElJDTi8/bU09mZMBqrj
X-Google-Smtp-Source: ABdhPJzRAcgO7wzp2G7V21pmftTy6/ICxCnXT86ZVVRZzFnksPSe2C772+v9xZAtsTx/BWDBcpYFkhMyzJ5BmZGcHno=
X-Received: by 2002:a17:906:7052:: with SMTP id r18mr9007489ejj.449.1623538087519;
 Sat, 12 Jun 2021 15:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210407211704.367039-1-morbo@google.com>
 <YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net> <CAGG=3QXjD1DQjACu=CQQSP=whue-14Pw8FcNcXrJZfLC_E+y9w@mail.gmail.com>
 <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net> <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
 <20210612202505.GG68208@worktop.programming.kicks-ass.net> <CAGG=3QUZ9tXGNLhbOr+AFDTJABDujZuaG1mYaLKdTcJZguEDWw@mail.gmail.com>
In-Reply-To: <CAGG=3QUZ9tXGNLhbOr+AFDTJABDujZuaG1mYaLKdTcJZguEDWw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 12 Jun 2021 15:47:56 -0700
Message-ID: <CAGG=3QUFRM85bpyjdokO93=Nem_w7-784-_qihP1P_CJMOsdqg@mail.gmail.com>
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

On Sat, Jun 12, 2021 at 1:56 PM Bill Wendling <morbo@google.com> wrote:
> On Sat, Jun 12, 2021 at 1:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Jun 12, 2021 at 12:10:03PM -0700, Bill Wendling wrote:
> > Yes it is, but is that sufficient in this case? It very much isn't for
> > KASAN, UBSAN, and a whole host of other instrumentation crud. They all
> > needed their own 'bugger-off' attributes.
> >
> Now, for the "nointr" issue. I'll see if we need an additional change for that.
>
The GCOV implementation disables profiling in those directories where
instrumentation would fail. We do the same. Both clang and gcc seem to
treat the no_instrument_function attribute similarly.

-bw
