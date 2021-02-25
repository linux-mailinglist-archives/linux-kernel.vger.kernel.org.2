Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA33257C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhBYUfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhBYUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:32:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC03C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:31:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id w36so10556698lfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFLJGO3qMErymEV/e2WWT8aq5JYjcCbmXcFkPTYn9ww=;
        b=rX8LiNPofmquP2LsVd5fneVzu1Ka/SP2K7pO1T8fp+uUVJDmRPqKpRDMk9K776aPg2
         EGkgSPP+G+xXLLe0EndPq9JtGVHJXQ5gJ3Zucp4cwHylm6P1+9+TNEhn9vvEXIfv0O1q
         zDUYbXXBL+lZf+WDsPXHrWwGzVsAS9/+Hd8I9NMPDS/C6gI4e+JG9X0RXESmc0smFcbP
         9XUyz9ifIJ5xGS63LdnBUfXgadrQTALziNc3SN7kEFXYiNb4Heee/6MYEjEEu5pjGhhH
         xIWYSSvHwY5gLQdKEl7COxFD0Kvy5CVAbK7niLh/IatamBDy7Z/mUPEASfPWXWAIUnA9
         u9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFLJGO3qMErymEV/e2WWT8aq5JYjcCbmXcFkPTYn9ww=;
        b=Myx/ueQyI4rMiRKTtU8FiDJiapF/AU/+XZPNxTGnCDm3Bss4Ho0N0w9gRVyd52Yg5E
         eDmYvJyuTuaJselezG9m5Aco8ZS+HJVUtMAjw7cvNv7CnBTbV4BpxH9CefVmLOf96/fI
         YrkXVORyBvPB4ixrPWTyleg5CYucaVC9pvnqOovG0t1/I3ArWYqEqbT6SjtnB7Z8edYg
         F7WyrH9PrlrMPO7bDmzDnJHJSjE6IUtTI/20E32zi9RbpFhmB+g0io/wKGsNCl41/DQk
         yOiumSqajH8dhWuenOtTbpuN2imimwkVkkFuXj/RuI4Epuo9mIBA593Ef7Z4DH5PQiF0
         Z1Rw==
X-Gm-Message-State: AOAM531hZIxK0hxCfaovo51l/j9LPfilTzINGd36d4/bxV9XaYRS0Riu
        ZRxL3a261MbKyhYLIohBTijNnIRA+801fiDJzU2vpw==
X-Google-Smtp-Source: ABdhPJxVo8sKwf8hItYHlvU63D/sjoKJuHxv3kjzL+fmrp20Y4F+3RAsIwetVdBBNu72WzlBn/u2G3ojVN5iDfGqaXI=
X-Received: by 2002:ac2:532c:: with SMTP id f12mr3008485lfh.73.1614285104568;
 Thu, 25 Feb 2021 12:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic> <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 12:31:33 -0800
Message-ID: <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Arthur Eubanks <aeubanks@google.com>,
        Chandler Carruth <chandlerc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:20 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 1:42 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Feb 25, 2021 at 01:18:21PM +0100, Arnd Bergmann wrote:
> > > Either way works correctly, I don't care much, but picked the __init
> > > annotation as it seemed more intuitive. If the compiler decides to
> > > make it out-of-line for whatever reason,
> >
> > Well, frankly, I see no good reason for not inlining a function body
> > which is a single call. And gcc does it just fine. And previous clangs
> > did too, so why does clang-13 do it differently?
> >
> > IOW, could it be that you're fixing something that ain't broke?

It's a reasonable question to ask: "why didn't this get inlined?"
which is worthwhile to revisit on occasion.

I'll post a more generic answer than for this specific case since
there's a bit of fallout from the recent changes, and I plan to
explain this in one place then share lore links on all of the other
threads.

Q: What changed?
A: Large changes to LLVM's pass management have finally been enabled
by default in ToT LLVM (what will ship as clang-13). Specifically,
LLVM's "new pass manager" has been made the default after probably at
least 7 years worth of effort. (The previous system is known as the
"legacy pass manager.") https://bugs.llvm.org/show_bug.cgi?id=46649.
With this change, many heuristics related to inlining have changed.
Cost models have changed, thresholds have been adjusted.  I suspect
there's changes in what granularity of IR gets optimized, but I need
to do more research here.

Next on my reading list, for anyone who wants to learn more is:
"Passes in LLVM": https://llvm.org/devmtg/2014-04/PDFs/Talks/Passes.pdf
https://www.youtube.com/watch?v=rY02LT08-J8
"The LLVM Pass Manager, Part 2"
https://www.youtube.com/watch?v=6NDQl544yEg
https://llvm.org/devmtg/2014-10/Slides/Carruth-TheLLVMPassManagerPart2.pdf

Q: But it's just a single function call, what gives?
A: Imagine you have the following:

void baz(void);
void bar(void) { baz(); ... }
void foo(void) { bar(); ... }

So foo() calls bar() calls baz() (and tail calls don't apply).  The
question being asked in this specific case (and a few other threads)
is "why isn't the call to bar() being inlined into foo()?"  Again,
totally fair question to ask.  (In this analogy, bar() is
get_smp_config()/early_get_smp_config(), foo() is their caller(s,
plural potentially)).

The answer lies in the direction that inlining occurs.  If you're
doing "top down" inlining, then when looking at the edge between foo()
and bar(), inlining looks totally reasonable.  Inline substitution is
performed.  Then you get to the edge that existed between bar() and
baz() and decide perhaps that baz() is too big, has too many callers,
etc. and don't inline baz() into foo().

But if you're doing "bottom up" inlining, then you start by analyzing
the edge between baz() and bar(), perhaps you decide to inline baz()
into bar(), but now the size of bar() is just over the threshold to
inline into foo(), or there's too many callers of bar() to inline into
every caller without excessive code bloat, or trips the threshold for
any number of concerns that go into the inlining cost model.  These
cost models are insanely complex (and don't fully generalize), because
you need to distill a great deal many inputs into a single yes/no
signal: "should I inline?"

LLVM's inliner is "bottom up":
https://www.youtube.com/watch?v=FnGCDLhaxKU&start=1650
This is different than GCC with is "top down":
https://www.youtube.com/embed/FnGCDLhaxKU?start=2301&end=2335&autoplay=1
(That video is 6 years old at this point; I have never looked at the
internals of GCC, so I don't personally know whether that is still the
case, FWIW)

Q: Why doesn't LLVM just do what GCC does?
A: The above video should help a little, but this is something not
mandated by the standard.  There are tradeoffs to either, and only
local optima, not general solutions.
(https://www.youtube.com/watch?v=FnGCDLhaxKU&start=1563 is still my
favorite reference that hints at some of the tradeoffs).

Q: But I put the `inline` keyword on the callee?
A: Probably deserves its own post, but the `inline` keyword doesn't
mean what any rational initial impression would suppose. Language in
the standard refers to "inline substitution" and grants a lot of
leeway to implementations in terms of whether it's performed at all.
There are cases where even with "always_inline" fn attr is applied,
and the compiler says "that's nice, but I still cannot perform inline
substitution here, I'm sorry."  Playing with the inlining heuristics
is always difficult, because for each improvement, code that has
"ossified" around how inlining was previously done may experience
unexpected changes in optimizations performed (see also "Q: What
changed?" above).
https://www.youtube.com/watch?v=FnGCDLhaxKU&start=1563

Q: Should I put "always_inline" fn attr everywhere?
A: No! always_inline can still fail in edge cases, leading to inlining
occurring before most optimizations so the same code gets repeatedly
optimized the same way just in different functions (this can really
hurt compile times).  I'm not saying to completely avoid
always_inline, it's good and has useful cases, but it's not a silver
bullet.  There are no silver bullets here.  It's semantics have
changed since its introduction, and I have seen rare uses that make my
skin crawl.

Q: Wouldn't it be nice if we could express a desire to inline from
individual call sites, rather than on the callee for all call sites?
A: Yes; this can be expressed in LLVM IR, but has no analog AFAIK in C or C++.

Q: But what about my specific case?
A: Without the configuration and compiler version provided, I can't
tell you for certain (and if I stopped to look at every case, I
probably wouldn't get any work done myself).  But what I would do if I
wanted to learn more is:
1. Isolate the kernel config that tickles this.  This is pretty
critical for anyone to reproduce kernel issues found via randconfig
builds.
2. Isolate the compiler invocation from the specific build system for
the affected TU. For the kernel, that's `make ... V=1`.
3. Rebuild LLVM in debug mode; using Cmake that's
-DCMAKE_BUILD_TYPE=Debug. This gives you very powerful compiler
introspection features without necessarily needing to attach a
debugger. (I don't think this is needed for every pass, seems like I
can use Release to debug the inliner, below).  It's one of the main
things I really appreciate about LLVM.
4. Ask LLVM to print diagnostics about certain passes when they are
run. Using the the compiler invocation from 2, add `-mllvm
-debug-only=<pass name>`.  Yes, looking up <pass name> requires some
grepping of LLVM source code.  (Lots more general tips:
https://www.youtube.com/watch?v=y4b-sgp6VYA)  For the inliner:

$ cat foo.c
void baz(void);
void bar(void) { baz(); }
void foo(void) { bar(); }
$ clang -mllvm -debug-only=inline foo.c -O2 -S
Inlining calls in: foo
Inlining calls in: foo
    Inlining (cost=0, threshold=337), Call:   call void @bar()
Updated inlining SCC: (foo)

So LLVM is telling us bar() was inlined into foo(); (baz() can't be
because it wasn't defined in this TU).  You can use this to "watch"
the compiler make decisions about inlining.

(full thread: https://lore.kernel.org/lkml/20210225112247.2240389-1-arnd@kernel.org/)
I suspect in this specific case, "Interprocedural Sparse Conditional
Constant Propagation" sees the calls to the same fn with different
constants, propagates those down creating two specialized versions of
the callee (so they are distinct functions now), inlines those into
get_smp_config()/early_get_smp_config(), then there's too many callers
of those in a single TU where inlining would cause excessive code
bloat.

Either way, it's a deep topic and I'm always happy to learn more about
it to help answer questions.  Would make a fun blog post or LWN
article. Now if only this toolchain would stop catching fire so that I
had the time to write such a post...

>
> Maybe Nick can give some more background here. He mentioned
> elsewhere that inlining in clang-13 was completely rewritten and is generally
> better than it was before. I'm not sure whether this particular instance
> is a case where clang could in fact show an advantage in not inlining
> a function, or if this is one case where it got worse and needs to be
> tuned better.
>
> In the end, inlining is a bunch of heuristics that are intended help
> most of the time, but both (old) clang and gcc get it wrong in cases that
> should have been decided the other way. Here we get a new method
> that may go wrong in other ways.
>
>         Arnd



-- 
Thanks,
~Nick Desaulniers
