Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D9459B81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhKWFV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhKWFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:21:14 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E712C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:18:06 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h23so20464283ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn3jFra4szqkLVg7Z0tfs5h8tb/RnJeZ4YQ9W3+nAww=;
        b=dxSk9qdBO6rFImSzeqC5aLbH33bzaoRhs8BW8aRbXz6y8yGOnsqTDkjRM7EzVoQdMi
         mfRXU7KDumUGPIyh8hov+rTU8eh/oAMS2DTbZerIn1wCX8tS1x+k9nAM0Z6f9j6rIEPF
         h2780jeaNXVQagfob2LozyEgv8cGVdfCd8dj3VdlWNHUWS/asHc9dbS/v0ihGYFhNBi0
         bs4bmhTxgl/FXvT05FUz5oZ7c6oq98mF68RDNDBTNDKtwmmW7aAnOeh0JVTqCwi9UiWn
         eRIjIZjOlfFiBDC4fK66iZD4/+AFYCLJq7s2B+EX+1Z7kpWnOWOztoXI/EbTrL2RPLGt
         kTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn3jFra4szqkLVg7Z0tfs5h8tb/RnJeZ4YQ9W3+nAww=;
        b=Gop52I8kbyvRo6Nx2bn0SnOZKw3DPez8JQA96zQ+b+rvmnScupS2pPHd9t+CH3VDsy
         P9LK/YjlEH3BI/IWLGR1IX34Tp68xA+ihYvvuWRDiMzvcTbt04GOdBrtawzkGT/zm0tl
         XrD3ZY/XGizzS9DZADDsxDuSND7DvuuJATt6Ig9w46IqX9/pXQX/wq7SZ6p7KPj9O9Z/
         MLl7R1C05WQ0hfNnFcvcr/n1rIOGgL12ou/yPM1Qb7aNZQWt8lLSPaofmoNQM/j3m4gn
         EQw2qv8tC3PBHRKUP/uzDS/IxFEtpdY5wVSKn1KBflDmlX9+QkHZ7uy12oa+GpnuRwp3
         H/wg==
X-Gm-Message-State: AOAM531YGyY4XflI1aoOkeq91ofxrMWmQ3KSbf0tIQWlenKVbOf740Dq
        WiarGSm0JDcK5n2EjSX6QltykEMGrA0s0V6XnyB2xw==
X-Google-Smtp-Source: ABdhPJwtzSnHyO2YHc8y8g0l3gWdd8PL3it8tncw2xNu508x573uLWjCOh8pCusxOcnyOCFM9++ZsGBuUjOo1xe+IDk=
X-Received: by 2002:a05:6e02:1bc3:: with SMTP id x3mr2644270ilv.39.1637644685327;
 Mon, 22 Nov 2021 21:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20210922061809.736124-1-pcc@google.com> <87k0j8zo35.fsf@disp2133>
 <202109220755.B0CFED9F5@keescook> <CAG48ez1wQZ2Jte_JRS92Njw89abpU5kGCk8KPyEdC93XX33NRA@mail.gmail.com>
 <CAMn1gO5_L-+Gjm2GGGPAa8JhZj+Xf-zZ4MDzHjb7xtANFG8c5A@mail.gmail.com> <202109251909.B7BB577BA@keescook>
In-Reply-To: <202109251909.B7BB577BA@keescook>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 22 Nov 2021 21:17:54 -0800
Message-ID: <CAMn1gO4mbxb8ukCb5Ne6FM4R4QDQQ+rMtO6TROfKpzFr9gsbTg@mail.gmail.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
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

On Sat, Sep 25, 2021 at 7:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 24, 2021 at 02:50:04PM -0700, Peter Collingbourne wrote:
> > On Wed, Sep 22, 2021 at 8:59 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 5:30 PM Kees Cook <keescook@chromium.org> wrote:
> > > > On Wed, Sep 22, 2021 at 09:23:10AM -0500, Eric W. Biederman wrote:
> > > > > Peter Collingbourne <pcc@google.com> writes:
> > > > > > This patch introduces a kernel feature known as uaccess logging.
> > > > > > [...]
> > > > > [...]
> > > > > How is logging the kernel's activity like this not a significant
> > > > > information leak?  How is this safe for unprivileged users?
> > > > [...]
> > > > Regardless, this is a pretty useful tool for this kind of fuzzing.
> > > > Perhaps the timing exposure could be mitigated by having the kernel
> > > > collect the record in a separate kernel-allocated buffer and flush the
> > > > results to userspace at syscall exit? (This would solve the
> > > > copy_to_user() recursion issue too.)
> >
> > Seems reasonable. I suppose that in terms of timing information we're
> > already (unavoidably) exposing how long the syscall took overall, and
> > we probably shouldn't deliberately expose more than that.
>
> Right -- I can't think of anything that can really use this today,
> but it very much feels like the kind of information that could aid in
> a timing race.

Okay, this now goes via a kernel-allocated buffer.

> > That being said, I'm wondering if that has security implications on
> > its own if it's then possible for userspace to manipulate the kernel
> > into allocating a large buffer (either at prctl() time or as a result
> > of getting the kernel to do a large number of uaccesses). Perhaps it
> > can be mitigated by limiting the size of the uaccess buffer provided
> > at prctl() time.
>
> There are a lot of exact-size allocation controls already (which I think
> is an unavoidable but separate issue[1]), but perhaps this could be
> mitigated by making the reserved buffer be PAGE_SIZE granular?

I was more thinking about userspace causing a kernel OOM or something
by making the kernel allocate large buffers. I decided to mitigate it
by putting an upper limit on the size of the kernel-side buffer.

Since it sounds like exact-size allocations are a pre-existing issue
we probably don't need to do anything about them at this time.

> > > One aspect that might benefit from some clarification on intended
> > > behavior is: what should happen if there are BPF tracing programs
> > > running (possibly as part of some kind of system-wide profiling or
> > > such) that poke around in userspace memory with BPF's uaccess helpers
> > > (especially "bpf_copy_from_user")?
> >
> > I think we should probably be ignoring those accesses, since we cannot
> > know a priori whether the accesses are directly associated with the
> > syscall or not, and this is after all a best-effort mechanism.
>
> Perhaps the "don't log this uaccess" flag I suggested could be
> repurposed by BPF too, as a general "make this access invisible to
> PR_LOG_UACCESS" flag? i.e. this bit:

Since we ended up not needing this flag (because of the kernel-side
buffer) I ended up just making BPF use raw_copy_from_user().

> > > > Instead of reimplementing copy_*_user() with a new wrapper that
> > > > bypasses some checks and adds others and has to stay in sync, etc,
> > > > how about just adding a "recursion" flag? Something like:
> > > >
> > > >     copy_from_user(...)
> > > >         instrument_copy_from_user(...)
> > > >             uaccess_buffer_log_read(...)
> > > >                 if (current->uaccess_buffer.writing)
> > > >                     return;
> > > >                 uaccess_buffer_log(...)
> > > >                     current->uaccess_buffer.writing = true;
> > > >                     copy_to_user(...)
> > > >                     current->uaccess_buffer.writing = false;
>
>
>
> > > > This would likely only make sense for SECCOMP_RET_TRACE or _TRAP if the
> > > > program wants to collect the results after every syscall. And maybe this
> > > > won't make any sense across exec (losing the mm that was used during
> > > > SECCOMP_SET_UACCESS_TRACE_BUFFER). Hmmm.
> > >
> > > And then I guess your plan would be that userspace would be expected
> > > to use the userspace instruction pointer
> > > (seccomp_data::instruction_pointer) to indicate instructions that
> > > should be traced?
>
> That could be one way -- but seccomp filters would allow a bunch of
> ways.
>
> > >
> > > Or instead of seccomp, you could do it kinda like
> > > https://www.kernel.org/doc/html/latest/admin-guide/syscall-user-dispatch.html
> > > , with a prctl that specifies a specific instruction pointer?
> >
> > Given a choice between these two options, I would prefer the prctl()
> > because userspace programs may already be using seccomp filters and
> > sanitizers shouldn't interfere with it.
>
> That's fair -- the "I wish we could make complex decisions about which
> syscalls to act on" sounds like seccomp.
>
> > However, in either the seccomp filter or prctl() case, you still have
> > the problem of deciding where to log to. Keep in mind that you would
> > need to prevent intervening async signals (that occur between when the
> > syscall happens and when we read the log) from triggering additional
>
> Could the sig handler also set the "make the uaccess invisible" flag?
> (It would need to be a "depth" flag, most likely.)

It's more complicated than that because you can longjmp() out of a
signal handler and that won't necessarily call sigreturn(). The kernel
doesn't really have a concept of "depth" as applied to signal
handlers, it's all managed on the userspace stack.

I brainstormed this with Dmitry a bit out of band and we came up with
a nice solution that avoids the two syscalls, is arch-generic and
avoids the problem with asynchronous signal handlers. I'll paste a bit
from the documentation that I wrote, but please see the full
documentation in v2 patch 5/5 for more details.

The feature may be used via the following prctl:

.. code-block:: c

  uint64_t addr = 0; /* Generally will be a TLS slot or equivalent */
  prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &addr, 0, 0, 0);

Supplying a non-zero address as the second argument to ``prctl``
will cause the kernel to read an address from that address on each
kernel entry (referred to as the *uaccess descriptor address*).

When entering the kernel to handle a syscall with a non-zero uaccess
descriptor address, the kernel will read a data structure of type
``struct uaccess_descriptor`` from the uaccess descriptor address,
which is defined as follows:

.. code-block:: c

  struct uaccess_descriptor {
    uint64_t addr, size;
  };

This data structure contains the address and size (in array elements)
of a *uaccess buffer*, which is an array of data structures of type
``struct uaccess_buffer_entry``. Before returning to userspace, the
kernel will log information about uaccesses to sequential entries
in the uaccess buffer. It will also store ``NULL`` to the uaccess
descriptor address, and store the address and size of the unused
portion of the uaccess buffer to the uaccess descriptor.

[...]

When entering the kernel for a reason other than a syscall (for
example, when IPI'd due to an incoming asynchronous signal) with
a non-zero uaccess descriptor address, any signals other
than ``SIGKILL`` and ``SIGSTOP`` are masked as if by calling
``sigprocmask(SIG_SETMASK, set, NULL)`` where ``set`` has been
initialized with ``sigfillset(set)``. This is to prevent incoming
signals from interfering with uaccess logging.

Peter
