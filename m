Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFB359A96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhDIJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233586AbhDIJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:57:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6489D6120E;
        Fri,  9 Apr 2021 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617962254;
        bh=nGCNx1wY4X/AXQUPoF05TRjpfj09hr2BRM5BkudgZQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PMb5Ns3zOCbadneDa8RK3rIYpibA0D7d99feuB27/EgfaobmD+3hzMBpA8ajFNzW8
         2GKai/JieYDo4icVU6kBcjY6Bwoo36bNadgRTHg8HsVni0b6lZOSLQ73rQunSANke+
         gSc441POwPUJicO7vs2mearbnmy2kRrRyQ3PlShzzRAUfyVIuAYtWoRc3m+3Pq4CzT
         g/Y+Wpi/Yx+xhEecHWm4Hc7x8HFJfm5aKYn3hlt+WTO8OZciODhmYSeN0N00Zyj0xW
         epydMULzVRpX5dkKOyqZuMhBqxTGXLDNlDWV0UTd35dr8jWWu0AnazEscWsLeGyet2
         AGaSGefWczJFw==
Received: by mail-oo1-f54.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so1211637ook.2;
        Fri, 09 Apr 2021 02:57:34 -0700 (PDT)
X-Gm-Message-State: AOAM530Y02238f6WnJYL3CZi34l7AQIhgJ4NwVP7J0Ijw+MLXvegFvSB
        TpZy7ivFCWCwg8NngUeUxIKtduzDdSQ5Y/5D0qE=
X-Google-Smtp-Source: ABdhPJx5NOYyUVTSUfPjSJip/NUv6T0/6Fxp6M7iZAOw14f+IkuUIMfguVLHlXhVYEW6ZQyh2e2y4ZJqbXjEHb6OxOI=
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr11240455oop.13.1617962253691;
 Fri, 09 Apr 2021 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Apr 2021 11:57:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
Message-ID: <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
Subject: Re: static_branch/jump_label vs branch merging
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 at 18:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi!
>
> Given code like:
>
> DEFINE_STATIC_KEY_FALSE(sched_schedstats);
>
> #define   schedstat_enabled()           static_branch_unlikely(&sched_schedstats)
> #define   schedstat_set(var, val)       do { if (schedstat_enabled()) { var = (val); } } while (0)
> #define __schedstat_set(var, val)       do { var = (val); } while (0)
>
> void foo(void)
> {
>         struct task_struct *p = current;
>
>         schedstat_set(p->se.statistics.wait_start,  0);
>         schedstat_set(p->se.statistics.sleep_start, 0);
>         schedstat_set(p->se.statistics.block_start, 0);
> }
>
> Where the static_branch_unlikely() ends up being:
>
> static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
> {
>         asm_volatile_goto("1:"
>                 ".byte " __stringify(BYTES_NOP5) "\n\t"
>                 ".pushsection __jump_table,  \"aw\" \n\t"
>                 _ASM_ALIGN "\n\t"
>                 ".long 1b - ., %l[l_yes] - . \n\t"
>                 _ASM_PTR "%c0 + %c1 - .\n\t"
>                 ".popsection \n\t"
>                 : :  "i" (key), "i" (branch) : : l_yes);
>
>         return false;
> l_yes:
>         return true;
> }
>
> The compiler gives us code like:
>
> 000000000000a290 <foo>:
>     a290:       65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     a295: R_X86_64_32S      current_task
>     a299:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>     a29e:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>     a2a3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>     a2a8:       c3                      retq
>     a2a9:       48 c7 80 28 01 00 00 00 00 00 00        movq   $0x0,0x128(%rax)
>     a2b4:       eb e8                   jmp    a29e <foo+0xe>
>     a2b6:       48 c7 80 58 01 00 00 00 00 00 00        movq   $0x0,0x158(%rax)
>     a2c1:       eb e0                   jmp    a2a3 <foo+0x13>
>     a2c3:       48 c7 80 70 01 00 00 00 00 00 00        movq   $0x0,0x170(%rax)
>     a2ce:       c3                      retq
>
>
> Now, in this case I can easily rewrite foo like:
>
> void foo2(void)
> {
>         struct task_struct *p = current;
>
>         if (schedstat_enabled()) {
>                 __schedstat_set(p->se.statistics.wait_start,  0);
>                 __schedstat_set(p->se.statistics.sleep_start, 0);
>                 __schedstat_set(p->se.statistics.block_start, 0);
>         }
> }
>
> Which gives the far more reasonable:
>
> 000000000000a2d0 <foo2>:
>     a2d0:       65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     a2d5: R_X86_64_32S      current_task
>     a2d9:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>     a2de:       c3                      retq
>     a2df:       48 c7 80 28 01 00 00 00 00 00 00        movq   $0x0,0x128(%rax)
>     a2ea:       48 c7 80 58 01 00 00 00 00 00 00        movq   $0x0,0x158(%rax)
>     a2f5:       48 c7 80 70 01 00 00 00 00 00 00        movq   $0x0,0x170(%rax)
>     a300:       c3                      retq
>
> But I've found a few sites where this isn't so trivial.
>
> Is there *any* way in which we can have the compiler recognise that the
> asm_goto only depends on its arguments and have it merge the branches
> itself?
>
> I do realize that asm-goto being volatile this is a fairly huge ask, but
> I figured I should at least raise the issue, if only to raise awareness.
>

Wouldn't that require the compiler to interpret the contents of the asm() block?
