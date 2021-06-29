Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F483B79B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhF2VI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhF2VIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:08:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C396BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:05:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a18so752034lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=at0ZjCEHdnjAbauppHO6g8ow1KqhQCXYe0Z+hJPVLYA=;
        b=AZ/qR6zwYLsWzcqtsPkz97l2LxlMlRiYeyeHths2LQs4XpqgJKhvlGo5NmHKYeMSyh
         p/TLMuZb7L3ptpeUeWhly//DSTtHdYoGyCKRB/4DChOs8FjYg2FrVE9ULy8fPv9WOmq8
         fhlPI6M+h5fsD0DGhuOuealtNn9WKWY1l06OmfO1MMNp+BD3I3jQ6YNshOaU4GNfJxtS
         2LF/uik/PnDPv1yTp5gmBun1yHVDhsAoZzxcUQMA1inVgVRqjLAbTeDXUdbR9o1qAx+n
         NV21rwFkLBwMbLgfv/wC4b02ljLpXQnLkddBaPGIWf6xvNTwCskS5uw3loLvzFjY0xP+
         6YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=at0ZjCEHdnjAbauppHO6g8ow1KqhQCXYe0Z+hJPVLYA=;
        b=BuuWBu2MAWVwtYTY1D+yc8IMoUqjrBxDyjZdKemVOU3ukL7jBVnNOpEuDbAHeCLnEi
         u4SmHeS5YiVgk3WmPka/c6hl1FRs314qbQBdtlj7rCSCmDk40GPjm17UdLwT+nUhZVzJ
         aO+el8E6H82pPUQnVPWH6v5B+LbOHjosfC20xtrz+swgPixkGBHDvRfEYYrxpXHrRcyK
         oqa5pAFgPucX5fMAXg0mKMAPZopqsfL3QP3fkCbuBAvH4ftZSTah36y2xkrRsXJZ301O
         t1tt73VR+yznEmY9mcgBdnTVhtNzKBLdfEZLKBkTTm/w5TbDcTJbYpngEYUIW+1BWnpA
         xvYw==
X-Gm-Message-State: AOAM5331JqqHvCplRIUKv03i5WF+s6GxnKsYpQJtg4Cwuu57IVgx8/W2
        Moih2Ntk9YVyu5h4J4XASzKoINtpgzXdzG/jRZLDyA==
X-Google-Smtp-Source: ABdhPJyaqWBv+mHfIg72by8ziWDMj9w+UGooEB4CHNjmJo68dboCxiw8mPPalM1oKZD3TefdariUBuRewLrZHdVebfc=
X-Received: by 2002:a05:6512:3e24:: with SMTP id i36mr23461870lfv.368.1625000751708;
 Tue, 29 Jun 2021 14:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <20210629131400.GA24514@C02TD0UTHF1T.local>
In-Reply-To: <20210629131400.GA24514@C02TD0UTHF1T.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Jun 2021 14:05:40 -0700
Message-ID: <CAKwvOd=BRD8Yrq6QvLiZq-_GL-JdDPvx6ghO4ROCo+AtisTJvw@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 6:14 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Kees,
>
> I thought the PGO stuff was on hold given Peter had open concerns, e.g.
>
> https://lore.kernel.org/r/20210614154639.GB68749@worktop.programming.kicks-ass.net
>
> ... and there didn't seem to be a strong conclusion to the contrary.

Hi Mark,
If I could rephrase Peter's concerns in my own words to see if I
understood the intent correctly, I'd summarize the concerns as:
1. How does instrumentation act in regards to noinstr?

https://lore.kernel.org/linux-doc/20210614153545.GA68749@worktop.programming.kicks-ass.net/
https://lore.kernel.org/lkml/YMcssV%2Fn5IBGv4f0@hirez.programming.kicks-ass.net/

2. How much of this code can be reused with GCC?

https://lore.kernel.org/linux-doc/20210614154639.GB68749@worktop.programming.kicks-ass.net/

3. Can we avoid proliferation of compiler specific code in the kernel?

https://lore.kernel.org/linux-doc/YMca2aa+t+3VrpN9@hirez.programming.kicks-ass.net/

---

Regarding point 1, I believe that was addressed by this series, which
Peter Ack'ed, and is based on work I did in LLVM based on Peter's
feedback, while collaborating with GCC developers on the semantics in
regards to inlining.  I notice you weren't explicitly cc'ed on that
thread, that's my fault and I apologize.  It wasn't intentional; once
a cc list as recommended by get_maintainer.pl gets too long, I start
to forget who was on previous threads and might be interested in
updates.

https://lore.kernel.org/lkml/YNGQV09E9xAvvppO@hirez.programming.kicks-ass.net/
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80223

---

Regarding point 2, I believe I addressed that in my response.  Similar
to GCOV, we need the runtime hooks which are compiler specific in
order to capture the profiling data. Exporting such data to userspace
via sysfs can be easily shared though, as is done currently for GCOV.

https://lore.kernel.org/linux-doc/CAKwvOd=aAo72j-iE2PNE5Os8BPc0y-Zs7ZoMzd21ck+QNeboBA@mail.gmail.com/

---

Regarding point 3, I agree. There's currently 2 big places in the
kernel where we have very compiler specific code, IMO:
1. frame pointer based unwinding on 32b ARM (especially but not
limited to THUMB).
2. GCOV
This series does ask to add a third.

At the same time, there are differences between compilers that are
unlikely to converge without great need.  Compiler IR is generally not
interchangeable between compilers; the compiler runtimes (ie. symbols
typically provided by libgcc_s or compiler-rt) are (generally) tightly
coupled to their respective compilers.  Since PGO relies on the
respective compiler runtimes, we wind up with compiler specific
runtime support for this feature.  For a semi-freestanding environment
like the Linux kernel, that means duplicating the ABI for these
compiler runtime libraries, with additional code for kernel specific
synchronization, memory management, and data retrieval (sysfs).

Further, asking compiler vendors to break their existing ABIs with
their compiler runtimes to support a shared interface for profiling
data is also a hard sell. That's a major issue regarding frame pointer
based unwinding on 32b ARM as well; existing unwinders must change to
support the latest spec, yet not all code will be recompiled to match
it as the same time the unwinder support is added or updated.  Unless
the compiler runtime was statically linked, then upgrading that shared
object might break binaries when they are run next.  I'm not saying
it's impossible, but is it worth it? Do the compiler vendors agree?
-- 
Thanks,
~Nick Desaulniers
