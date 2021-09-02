Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429C63FF20D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346499AbhIBRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhIBRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:06:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9743C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:05:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t19so5775588lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTKwLxJKBb29lTrloLnll/qYjKLGHBwxYT4LSAZlfkw=;
        b=ZP4gtQ+dU1CBjTX+vGsXvPBuqGQi/TppHrDWDvUZ0BzMZa7gXlsJM5iEdJJiwKKK6e
         76mzLH7hK9hzKbxLxJlicUTIsvsWhsPi3lZ7LWgDqGB7vvcBpbI/nElwYdnNGmUoLRBT
         o3802TKxg3Y1OZ3dniRTorfb02Z12jSGHCxcxKvX0kwvuX5wjJX3k7yRoU+Q5hGvpgu+
         PWScLnnckyVRHBGV0vlxnq9qDB0cvu2QCGqCY+2gWpKbcqUVbAO+uu4kFcQSWEMZkYFz
         gIchFtt/vCHSn97H76Y7VTOI4Mrpge2GbeMgCmoARzIf1cx7cUgp6gjLQ25ue/geg1IO
         hIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTKwLxJKBb29lTrloLnll/qYjKLGHBwxYT4LSAZlfkw=;
        b=k6QlPTYzLntqaSgLnwHsrpd/SCjUwDZZ5arEZlpCtubn0X0SXk90zJnyiT775n/xwu
         h/6f2NJjGHAOCobK/xJou686URYhtXpvZBe9uY0TaIt4sMOfIICImnKv5TlX8PDriz+B
         wPNxSsdy0AFln+Pk/V7XlPHk5C+pQD1gxVYJop8DFv6bDOjjZpMe7R7sAHkPue0rQLPs
         2xyIm67Om4an0NGUq/1RSJABr0AjuDqjxgJrTRIOpFzdHVMGrX0CpFooNRrXmJm57oGA
         fOMWFJiEfKEkNQtoEnCZW8p43K5K3YInYlOevFaxq7vsau85ap2Ct5Xi07cKHk09yU8h
         b+Ow==
X-Gm-Message-State: AOAM533SER3rhG5cSTdDq6/5vKJd7Cu6OqSaCWfmcL7k2aFa5ItMQMNU
        4THoQyz49uD+4zTBYQ9uji/8nUiicTl/wBAouvaHQQ==
X-Google-Smtp-Source: ABdhPJyViBSbGZjQ4Wx3ShU9165fwiOcQTisplu661w0y9FZ0DrMM0Hn8qBDF/b/zWaOuVhvEXvcLjrSdL2TEsaURD0=
X-Received: by 2002:a05:6512:15a1:: with SMTP id bp33mr3286376lfb.122.1630602340963;
 Thu, 02 Sep 2021 10:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com> <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com> <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
 <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net>
In-Reply-To: <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Sep 2021 10:05:29 -0700
Message-ID: <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to arch/x86/entry/
To:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 6:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 02, 2021 at 02:05:41PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 02, 2021 at 07:54:25PM +0800, Lai Jiangshan wrote:
> > > For example, stack-protector is instrumenting many noninstr functions now
> > > if the CONFIG is yes.  It is normally Ok and gcc is adding per-function control
> > > on it.
> >
> > IIRC the latest compiler have an attribute for this too, that really
> > should be added to noinstr. Lemme go find.
>
> Something like so... Nick ?
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 49b0ac8b6fd3..6a15c3d8df5c 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -62,6 +62,12 @@
>  #define __no_sanitize_coverage
>  #endif
>
> +#if defined(CONFIG_STACKPROTECTOR)
> +#define __no_stack_protector __attribute__((no_stack_protector))
> +#else
> +#define __no_stack_protector
> +#endif
> +
>  /*
>   * Not all versions of clang implement the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index cb9217fc60af..7ac0a3f11ba9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -128,6 +128,12 @@
>  #define __no_sanitize_coverage
>  #endif
>
> +#if defined(CONFIG_STACKPROTECTOR) && __has_attribute__(__no_stack_protector__)
> +#define __no_stack_protector __attribute__((no_stack_protector))
> +#else
> +#define __no_stack_protector
> +#endif
> +

The above 2 hunks should go in include/linux/compiler_attributes.h,
but yes.  I'd been meaning to send such a patch; it's nice to have
finer grain function-level control over -fno-stack-protector which
significantly hurts ergonomics for things like LTO.  IIRC GCC only
added the attribute recently in the 10.X release, so it might be too
new to rely on quite yet.

>  #if GCC_VERSION >= 50100
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e4ea86fc584d..5ae1c08dba8d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -210,7 +210,8 @@ struct ftrace_likely_data {
>  /* Section for code which can't be instrumented at all */
>  #define noinstr                                                                \
>         noinline notrace __attribute((__section__(".noinstr.text")))    \
> -       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> +       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> +       __no_stack_protector
>
>  #endif /* __KERNEL__ */
>


-- 
Thanks,
~Nick Desaulniers
