Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185A844D4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhKKKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhKKKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:15:15 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934C1C06127A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 02:12:26 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t19so10767830oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 02:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2JqhGMyfJOncOO31VPKGQJKmpqXdotolWXJ0Sscp8s=;
        b=CkvxSK1EjyO2pbzkq70likXbwf1/G65ullJU9N53M5lbs4WkwpWvQGJ+xxcsj3R4uD
         vcqB3rJiaK92xh67IbFVu3lAHIG/znWaTUQunSIypYeP4CnnjeTNGIm+mf+o07hHuzxl
         uGRxyXOIOSGr3YpDTGHVku9ehCQPRKdT4tIjm0CwEBIHtMVhOjrry3RqCIKnpqVak7aE
         eT5E5GPsB+qwjtDL4GJrrCHtn/xG1iVwritcMgG8snngv+U9QVZApUx9jhk85/z97JqK
         c2iyK+Ej5z+UF/7SIqqzQxvu4fH5Ror0RgY3cEcQrowltSXdyTVkGunN2QHGRAJExYJh
         ldjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2JqhGMyfJOncOO31VPKGQJKmpqXdotolWXJ0Sscp8s=;
        b=dpwBbNUL5XPUwJ+3MkpEG46nltQ4EReRehBy4vhEe/4Jz8jiZ1e7fjonkSz1kl8j5a
         H57tdD9tAix3JuT3dLd+UcvA35nJRYomyNP9mVuXIWtWfeV7SLTmTNASXK+3KmqPXWyJ
         XZFgrMrJ/rP7ecf3Uclorcfi4vGqU68JP2hml/WcjM9pddFfZj6AhnWtv4MgJK3ENUKE
         JdEDk/BSN8/JG6PUnRaQiek6o8in7a3oSUMIlKZOsQ5HcDOMAFbS425dmmchqm9JCMaO
         5Vy9cBMjnbIsbC4eOYzng61ENIgQMOzItlIGCM6KhlNGrH8GAOsN4WM1hraPcX9yBQdX
         H37Q==
X-Gm-Message-State: AOAM530Hdk8YX6QWBZyNXWcECcc/vuGq6Zut51zvizKA69cDZwWEitTi
        osDt4joULKkeVLOKEaWN/7c/TU8g3GpiF0w4WSiOVQ==
X-Google-Smtp-Source: ABdhPJz7epDTv5uCxOQ8Cm3nb9HVHDMTO19qLrlz3UwOWboYoIDGzDq9VXXEzngFTMgtlnhp8icDZqg8O4nzWcv7HOo=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr5116357oil.65.1636625545648;
 Thu, 11 Nov 2021 02:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com> <20211005105905.1994700-24-elver@google.com>
 <YVxjH2AtjvB8BDMD@hirez.programming.kicks-ass.net> <YVxrn2658Xdf0Asf@elver.google.com>
In-Reply-To: <YVxrn2658Xdf0Asf@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 11 Nov 2021 11:11:00 +0100
Message-ID: <CANpmjNPk9i9Ap6LRuS32dRRCOrs4YwDP-EhfX-niCXu7zH2JOg@mail.gmail.com>
Subject: Re: [PATCH -rcu/kcsan 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 at 17:13, Marco Elver <elver@google.com> wrote:
> On Tue, Oct 05, 2021 at 04:37PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 05, 2021 at 12:59:05PM +0200, Marco Elver wrote:
> > > Teach objtool to turn instrumentation required for memory barrier
> > > modeling into nops in noinstr text.
> > >
> > > The __tsan_func_entry/exit calls are still emitted by compilers even
> > > with the __no_sanitize_thread attribute. The memory barrier
> > > instrumentation will be inserted explicitly (without compiler help), and
> > > thus needs to also explicitly be removed.
> >
> > How is arm64 and others using kernel/entry + noinstr going to fix this?
> >
> > ISTR they fully rely on the compilers not emitting instrumentation,
> > since they don't have objtool to fix up stray issues like this.
>
> So this is where I'd like to hear if the approach of:
>
>  | #if !defined(CONFIG_ARCH_WANTS_NO_INSTR) || defined(CONFIG_STACK_VALIDATION)
>  | ...
>  | #else
>  | #define kcsan_noinstr noinstr
>  | static __always_inline bool within_noinstr(unsigned long ip)
>  | {
>  |      return (unsigned long)__noinstr_text_start <= ip &&
>  |             ip < (unsigned long)__noinstr_text_end;
>  | }
>  | #endif
>
> and then (using the !STACK_VALIDATION definitions)
>
>  | kcsan_noinstr void instrumentation_may_appear_in_noinstr(void)
>  | {
>  |      if (within_noinstr(_RET_IP_))
>  |              return;
>
> works for the non-x86 arches that select ARCH_WANTS_NO_INSTR.
>
> If it doesn't I can easily just remove kcsan_noinstr/within_noinstr, and
> add a "depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION" to the
> KCSAN_WEAK_MEMORY option.
>
> Looking at a previous discussion [1], however, I was under the
> impression that this would work.
>
> [1] https://lkml.kernel.org/r/CANpmjNMAZiW-Er=2QDgGP+_3hg1LOvPYcbfGSPMv=aR6MVTB-g@mail.gmail.com

I'll send v2 of this series after 5.16-rc1. So far I think we haven't
been able to say the above doesn't work, which means I'll assume it
works on non-x86 architectures with ARCH_WANTS_NO_INSTR until we get
evidence of the opposite.
