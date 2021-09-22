Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98584414DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhIVQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhIVQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:03:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:01:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g41so13611383lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpX24QoOsIKPkOvUjxkGK/Mz77DaA/pI1GzEr5lGPpY=;
        b=N7xosZj3jz49Pe7XO4QdW63nlKTtjawIBDzQYF1ltZCTEN6Ncnwd9J59tE9HgXNkJn
         S8P+9Mgn+MxmqoSpXSrtd6+wvqsj7UiO+TqevHkTyRIfUYOPO/S6DFASeQj2iabD65Fu
         FgH5k9qCz7VeS2zFiBCaG4nReukENDW8nyOG6M1JWgSNwccNYG9XI6WMmvjYmLCboGaa
         ek2Xk59jmeGhaECKOjIb9zPveBYFcnedADHY4cwvfRDJnNj83lrp28i3O0PqAys44Y2q
         +0z6KRgC02Eb/zgpcPw3JB7hgTFa5OczZsw6AenwcN0SnGXH8iDsFTRYayLygfaXgYtb
         tBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpX24QoOsIKPkOvUjxkGK/Mz77DaA/pI1GzEr5lGPpY=;
        b=Hh9iAS5qxG0LB698Xx34Hk0rLta70Bs/mRoAtcQvG0og3FtvqZThfEePyxqgGLJnNd
         f7BmBApNg/jiG5GU1rcZCIbL6QzPo3hp/Ul651uT5UY+1wW1zhhfV3y6Acv6qandDTAw
         PwBVyRjHDTZq5BqqfvWYTnrDQ+WD8QqEIPvzWOOHcGos2O5UnW85uKhClNKsf9WeHPGb
         w5N4wt+ZfRhUTkrkrK6RbtjaoS86cdbB9DusGNttYE9XC8jLEYrdZaFQ0l3t3iuMlgOs
         Tsr8N5fhHmnJpGb2+AiIX2Y6LLU56/hsDNN+9DzuEKCsVEzviiV21FBAZM5yJr4UlgZm
         EWyQ==
X-Gm-Message-State: AOAM530DdGxnF0Jl9V1c2WvYWdD/6FsPJGBQEC0rOURDgj3lKC6odu+T
        ggH99SxrplDCpn/zDCzj/iZRNMopAEaapVsaxCYepA==
X-Google-Smtp-Source: ABdhPJyvMabYfEgFWlQFgf3b5FPc+RET2g/hAYpQAzkxXVFerlggFY1MDY9wesds/bIvErl0VAsRg7VOriEbVmQTTzc=
X-Received: by 2002:a05:6512:10ca:: with SMTP id k10mr308176lfg.315.1632326386519;
 Wed, 22 Sep 2021 08:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210922061809.736124-1-pcc@google.com> <87k0j8zo35.fsf@disp2133> <202109220755.B0CFED9F5@keescook>
In-Reply-To: <202109220755.B0CFED9F5@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 22 Sep 2021 17:59:19 +0200
Message-ID: <CAG48ez1wQZ2Jte_JRS92Njw89abpU5kGCk8KPyEdC93XX33NRA@mail.gmail.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 5:30 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 22, 2021 at 09:23:10AM -0500, Eric W. Biederman wrote:
> > Peter Collingbourne <pcc@google.com> writes:
> >
> > > This patch introduces a kernel feature known as uaccess logging.
> > > With uaccess logging, the userspace program passes the address and size
> > > of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> > > is a request for the kernel to log any uaccesses made during the next
> > > syscall to the uaccess buffer. When the next syscall returns, the address
> > > one past the end of the logged uaccess buffer entries is written to the
> > > location specified by the third argument to the prctl(). In this way,
> > > the userspace program may enumerate the uaccesses logged to the access
> > > buffer to determine which accesses occurred.
> > > [...]
> > > 3) Kernel fuzzing. We may use the list of reported kernel accesses to
> > >    guide a kernel fuzzing tool such as syzkaller (so that it knows which
> > >    parts of user memory to fuzz), as an alternative to providing the tool
> > >    with a list of syscalls and their uaccesses (which again thanks to
> > >    (2) may not be accurate).
> >
> > How is logging the kernel's activity like this not a significant
> > information leak?  How is this safe for unprivileged users?
>
> This does result in userspace being able to "watch" the kernel progress
> through a syscall. I'd say it's less dangerous than userfaultfd, but
> still worrisome. (And userfaultfd is normally disabled[1] for unprivileged
> users trying to interpose the kernel accessing user memory.)
>
> Regardless, this is a pretty useful tool for this kind of fuzzing.
> Perhaps the timing exposure could be mitigated by having the kernel
> collect the record in a separate kernel-allocated buffer and flush the
> results to userspace at syscall exit? (This would solve the
> copy_to_user() recursion issue too.)

Other than what Kees has already said, the only security concern I
have with that patch should be trivial to fix: If the ->uaccess_buffer
machinery writes to current's memory, it must be reset during
execve(), before switching to the new mm, to prevent the old task from
causing the kernel to scribble into the new mm.

One aspect that might benefit from some clarification on intended
behavior is: what should happen if there are BPF tracing programs
running (possibly as part of some kind of system-wide profiling or
such) that poke around in userspace memory with BPF's uaccess helpers
(especially "bpf_copy_from_user")?

> I'm pondering what else might be getting exposed by creating this level
> of probing... kernel addresses would already be getting rejected, so
> they wouldn't show up in the buffer. Hmm. Jann, any thoughts here?
>
>
> Some other thoughts:
>
>
> Instead of reimplementing copy_*_user() with a new wrapper that
> bypasses some checks and adds others and has to stay in sync, etc,
> how about just adding a "recursion" flag? Something like:
>
>     copy_from_user(...)
>         instrument_copy_from_user(...)
>             uaccess_buffer_log_read(...)
>                 if (current->uaccess_buffer.writing)
>                     return;
>                 uaccess_buffer_log(...)
>                     current->uaccess_buffer.writing = true;
>                     copy_to_user(...)
>                     current->uaccess_buffer.writing = false;
>
>
> How about using this via seccomp instead of a per-syscall prctl? This
> would mean you would have very specific control over which syscalls
> should get the uaccess tracing, and wouldn't need to deal with
> the signal mask (I think). I would imagine something similar to
> SECCOMP_FILTER_FLAG_LOG, maybe SECCOMP_FILTER_FLAG_UACCESS_TRACE, and
> add a new top-level seccomp command, (like SECCOMP_GET_NOTIF_SIZES)
> maybe named SECCOMP_SET_UACCESS_TRACE_BUFFER.
>
> This would likely only make sense for SECCOMP_RET_TRACE or _TRAP if the
> program wants to collect the results after every syscall. And maybe this
> won't make any sense across exec (losing the mm that was used during
> SECCOMP_SET_UACCESS_TRACE_BUFFER). Hmmm.

And then I guess your plan would be that userspace would be expected
to use the userspace instruction pointer
(seccomp_data::instruction_pointer) to indicate instructions that
should be traced?

Or instead of seccomp, you could do it kinda like
https://www.kernel.org/doc/html/latest/admin-guide/syscall-user-dispatch.html
, with a prctl that specifies a specific instruction pointer?
