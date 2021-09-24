Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540A4417D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbhIXVvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhIXVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:51:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08753C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:50:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s20so14499416ioa.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTEnaTsjZV/Myt/S7bXbh7jnmxht9cJklJxA24XO/+s=;
        b=FFKPuUGCIRUXYPy2O/4lSvx0BoSKh+LtG779CDrIiBYjwr8rF8GhiDlDJz9k3PQcRg
         R+AyzSSolA98kI/R4a6J5pWx8MMk6eSIyR27Ye3se14WayDENm90zqMom1CzdDfzu5YR
         w9HDf/Tu2tRebCcy2NIkgAQ3rOk0KgOvZKP5eX9NTF/AJTz9iZ4Rag4jqujI+UAmWFlI
         WBSzQkcHWFZ1EO5N3nObdE27+oc+EBuJSxKd4EuD6FIUrx5UGWa/X1xX+1i1nsmw+kjc
         oRTfFdHOZaHOo3x1iuH2Sjr2yfMOimeb7SuTXFuT+MJZ1re/gFtkU9uVtI0Ut7lJp3IJ
         Qi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTEnaTsjZV/Myt/S7bXbh7jnmxht9cJklJxA24XO/+s=;
        b=w6UZ4Gq285XfVnoCH9VqBaH9Xu33pf6aNSxdnXRwreg6oPJxZosT6dR76QMxDv0cbA
         pWOoiDLixrxZFswq7KJcXRdckQ8ZoX4glAZZMqEujsgSxU8RZaOJMPUC0nErVaqSTchO
         Nfi073KFfkq3RIzP6491VYnRRwBjGoLY54PrzG217fLwtBYlW3styJVEMCwFfK8NTHO2
         p7kOXkafEOv9ZWCZgYEObU8Bb8AMEc7wkyXLAFHe0w7UB30sLlY7xsutM9xWlfAhybAB
         mFk8cOyYimGD851n7twnkIX7DsY7liupFXb4MswZ/d28UWJa3cFmoyhs35XKwnApdf26
         3H8A==
X-Gm-Message-State: AOAM530xQgp+vJEDzApDySM/lHYgSaNr+vYGVUwM3Gmemd1BpkNc/C9X
        WJlQ576EHvp1A0ksqGt9Raxw1WgbAZX3j9Zs28YvfQ==
X-Google-Smtp-Source: ABdhPJy4kAOEH4FEVEUy+BLtXH/CLtJ1HcKMhQdR1DBXXSKsn35lC+jL5Ai904lGLOrYQoXMiMDJr8WH+F8AHnXhxwA=
X-Received: by 2002:a6b:5a0c:: with SMTP id o12mr10993276iob.140.1632520216332;
 Fri, 24 Sep 2021 14:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210922061809.736124-1-pcc@google.com> <87k0j8zo35.fsf@disp2133>
 <202109220755.B0CFED9F5@keescook> <CAG48ez1wQZ2Jte_JRS92Njw89abpU5kGCk8KPyEdC93XX33NRA@mail.gmail.com>
In-Reply-To: <CAG48ez1wQZ2Jte_JRS92Njw89abpU5kGCk8KPyEdC93XX33NRA@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 24 Sep 2021 14:50:04 -0700
Message-ID: <CAMn1gO5_L-+Gjm2GGGPAa8JhZj+Xf-zZ4MDzHjb7xtANFG8c5A@mail.gmail.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 8:59 AM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Sep 22, 2021 at 5:30 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Sep 22, 2021 at 09:23:10AM -0500, Eric W. Biederman wrote:
> > > Peter Collingbourne <pcc@google.com> writes:
> > >
> > > > This patch introduces a kernel feature known as uaccess logging.
> > > > With uaccess logging, the userspace program passes the address and size
> > > > of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> > > > is a request for the kernel to log any uaccesses made during the next
> > > > syscall to the uaccess buffer. When the next syscall returns, the address
> > > > one past the end of the logged uaccess buffer entries is written to the
> > > > location specified by the third argument to the prctl(). In this way,
> > > > the userspace program may enumerate the uaccesses logged to the access
> > > > buffer to determine which accesses occurred.
> > > > [...]
> > > > 3) Kernel fuzzing. We may use the list of reported kernel accesses to
> > > >    guide a kernel fuzzing tool such as syzkaller (so that it knows which
> > > >    parts of user memory to fuzz), as an alternative to providing the tool
> > > >    with a list of syscalls and their uaccesses (which again thanks to
> > > >    (2) may not be accurate).
> > >
> > > How is logging the kernel's activity like this not a significant
> > > information leak?  How is this safe for unprivileged users?
> >
> > This does result in userspace being able to "watch" the kernel progress
> > through a syscall. I'd say it's less dangerous than userfaultfd, but
> > still worrisome. (And userfaultfd is normally disabled[1] for unprivileged
> > users trying to interpose the kernel accessing user memory.)
> >
> > Regardless, this is a pretty useful tool for this kind of fuzzing.
> > Perhaps the timing exposure could be mitigated by having the kernel
> > collect the record in a separate kernel-allocated buffer and flush the
> > results to userspace at syscall exit? (This would solve the
> > copy_to_user() recursion issue too.)

Seems reasonable. I suppose that in terms of timing information we're
already (unavoidably) exposing how long the syscall took overall, and
we probably shouldn't deliberately expose more than that.

That being said, I'm wondering if that has security implications on
its own if it's then possible for userspace to manipulate the kernel
into allocating a large buffer (either at prctl() time or as a result
of getting the kernel to do a large number of uaccesses). Perhaps it
can be mitigated by limiting the size of the uaccess buffer provided
at prctl() time.

> Other than what Kees has already said, the only security concern I
> have with that patch should be trivial to fix: If the ->uaccess_buffer
> machinery writes to current's memory, it must be reset during
> execve(), before switching to the new mm, to prevent the old task from
> causing the kernel to scribble into the new mm.

Yes, that's a good point. I'll fix that in the next version.

> One aspect that might benefit from some clarification on intended
> behavior is: what should happen if there are BPF tracing programs
> running (possibly as part of some kind of system-wide profiling or
> such) that poke around in userspace memory with BPF's uaccess helpers
> (especially "bpf_copy_from_user")?

I think we should probably be ignoring those accesses, since we cannot
know a priori whether the accesses are directly associated with the
syscall or not, and this is after all a best-effort mechanism.

> > I'm pondering what else might be getting exposed by creating this level
> > of probing... kernel addresses would already be getting rejected, so
> > they wouldn't show up in the buffer. Hmm. Jann, any thoughts here?
> >
> >
> > Some other thoughts:
> >
> >
> > Instead of reimplementing copy_*_user() with a new wrapper that
> > bypasses some checks and adds others and has to stay in sync, etc,
> > how about just adding a "recursion" flag? Something like:
> >
> >     copy_from_user(...)
> >         instrument_copy_from_user(...)
> >             uaccess_buffer_log_read(...)
> >                 if (current->uaccess_buffer.writing)
> >                     return;
> >                 uaccess_buffer_log(...)
> >                     current->uaccess_buffer.writing = true;
> >                     copy_to_user(...)
> >                     current->uaccess_buffer.writing = false;
> >
> >
> > How about using this via seccomp instead of a per-syscall prctl? This
> > would mean you would have very specific control over which syscalls
> > should get the uaccess tracing, and wouldn't need to deal with
> > the signal mask (I think). I would imagine something similar to
> > SECCOMP_FILTER_FLAG_LOG, maybe SECCOMP_FILTER_FLAG_UACCESS_TRACE, and
> > add a new top-level seccomp command, (like SECCOMP_GET_NOTIF_SIZES)
> > maybe named SECCOMP_SET_UACCESS_TRACE_BUFFER.
> >
> > This would likely only make sense for SECCOMP_RET_TRACE or _TRAP if the
> > program wants to collect the results after every syscall. And maybe this
> > won't make any sense across exec (losing the mm that was used during
> > SECCOMP_SET_UACCESS_TRACE_BUFFER). Hmmm.
>
> And then I guess your plan would be that userspace would be expected
> to use the userspace instruction pointer
> (seccomp_data::instruction_pointer) to indicate instructions that
> should be traced?
>
> Or instead of seccomp, you could do it kinda like
> https://www.kernel.org/doc/html/latest/admin-guide/syscall-user-dispatch.html
> , with a prctl that specifies a specific instruction pointer?

Given a choice between these two options, I would prefer the prctl()
because userspace programs may already be using seccomp filters and
sanitizers shouldn't interfere with it.

However, in either the seccomp filter or prctl() case, you still have
the problem of deciding where to log to. Keep in mind that you would
need to prevent intervening async signals (that occur between when the
syscall happens and when we read the log) from triggering additional
syscalls that may overwrite the log (as a result of using the same
syscall wrapper). This implies that the log location would need to be
per-syscall, so the location would need to be on the stack (or
equivalent, like a heap-allocated buffer with lifetime tied to that of
the syscall wrapper function). So then, how do you notify the kernel
of that location? One possibility is arch-specific augmentation of the
syscall calling convention, as I mentioned in the initial message. But
then if you're doing that, you might as well dispense with the seccomp
filter or prctl() entirely and have the request for a log be
communicated purely via the calling convention.

It seems like any approach which avoids the multiple syscalls is going
to be arch-specific to some degree. So I think I would prefer to start
with a "slow but simple" API, and let architectures provide their own
arch-specific mechanisms if they wish to optimize it.

Peter
