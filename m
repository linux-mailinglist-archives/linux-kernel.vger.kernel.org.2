Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3141537C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhIVWcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhIVWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:32:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:30:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m11so5556866ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juNC+Yh0gIrBUb6L+xNkRsDJBnFyF6UYb7kNcoCnKGM=;
        b=NfqpceEaWmmHup5aFezQKm9k2U9cUf3eIA0++9NLgmZrNKzRgNSryISlUj5iDhPb20
         LV0KTolyFlBorK3r5zGiVOkHL98pQxilnPewHILwmnS6maAy2PA5afjbUeVrmRABouql
         DYryji4RsSu94V5GdaDs///FYOgeUFT3//BZVAik2kaeh30cLH1hFX4m0XnwWnwbU4XK
         SRDHMG26jgP8e5j0PdVFgpDnAzdnKqTcC0ZCQN97ztKQ0Kds5ukWRy1CXtkCWYQbdfRh
         zBWnfi7TzaiD1Uvw0PJnqCczvKqF8JuBNx+0wIihbMWhJMftCxxd6CbSIJiQ0hL0MikC
         5vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juNC+Yh0gIrBUb6L+xNkRsDJBnFyF6UYb7kNcoCnKGM=;
        b=S7x41xwLF/Jf4z/TazXqcbj90OiCroDNu6Gd+VgA6S55vDSnhbYcAEObMupr2OCZXx
         ZhHkeNqByWaP1CHHJYe6XAqAM5/vhfLsC2CcU63RnJy4RIndtx2wHtQc2wAVIBE5fB4e
         CAkAhOTZuvBVKBurKbW5g+qujD6DcQBoOmJxOsz/eYndk5CrIYs/oAYsGJy77qdjwCna
         WeWrbUKSGiQOCWRbf7AwdNlnccLT23yEEwx9W0x6iW5uSxEFZQ3B6ErWxfL+kvuEjMYr
         kZktAeS0rasiaQOlBvLkoZ5a/yN1A9YN/t1ckkSxYnAE2ewZn1VSt9G66YCmTxX7aYxV
         aD8Q==
X-Gm-Message-State: AOAM532M65vaZLQgExF4hB2RDJAkHCnmBBqM2BbEtl1H6ay9chjaAr5U
        30chKbPNYcgdJaSHhDsOoHQMFEdQ/XIoTEG88twjBg==
X-Google-Smtp-Source: ABdhPJzuV52YtxZhuXpXSkrYLJ/qVhpiQKRXog76B7iQrZ8gzwj1xbG9KAGnpMoASe7YA+XtmD46ObD3Q89COrDCf38=
X-Received: by 2002:a6b:5913:: with SMTP id n19mr1096556iob.91.1632349846464;
 Wed, 22 Sep 2021 15:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210922061809.736124-1-pcc@google.com> <CACT4Y+b=2L7CSYBxzO906b17ryU0H9anJEacnvP-WbAYLC4T1A@mail.gmail.com>
In-Reply-To: <CACT4Y+b=2L7CSYBxzO906b17ryU0H9anJEacnvP-WbAYLC4T1A@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 22 Sep 2021 15:30:35 -0700
Message-ID: <CAMn1gO6kqoQ1V7qySSGK7UoND_najvBrW0-EWe8FcrMJ+SArFQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Kees Cook <keescook@chromium.org>,
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Wed, Sep 22, 2021 at 6:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 22 Sept 2021 at 08:18, Peter Collingbourne <pcc@google.com> wrote:
> >
> > This patch introduces a kernel feature known as uaccess logging.
> > With uaccess logging, the userspace program passes the address and size
> > of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> > is a request for the kernel to log any uaccesses made during the next
> > syscall to the uaccess buffer. When the next syscall returns, the address
> > one past the end of the logged uaccess buffer entries is written to the
> > location specified by the third argument to the prctl(). In this way,
> > the userspace program may enumerate the uaccesses logged to the access
> > buffer to determine which accesses occurred.
> >
> > Uaccess logging has several use cases focused around bug detection
> > tools:
> >
> > 1) Userspace memory safety tools such as ASan, MSan, HWASan and tools
> >    making use of the ARM Memory Tagging Extension (MTE) need to monitor
> >    all memory accesses in a program so that they can detect memory
> >    errors. For accesses made purely in userspace, this is achieved
> >    via compiler instrumentation, or for MTE, via direct hardware
> >    support. However, accesses made by the kernel on behalf of the
> >    user program via syscalls (i.e. uaccesses) are invisible to these
> >    tools. With MTE there is some level of error detection possible in
> >    the kernel (in synchronous mode, bad accesses generally result in
> >    returning -EFAULT from the syscall), but by the time we get back to
> >    userspace we've lost the information about the address and size of the
> >    failed access, which makes it harder to produce a useful error report.
> >
> >    With the current versions of the sanitizers, we address this by
> >    interposing the libc syscall stubs with a wrapper that checks the
> >    memory based on what we believe the uaccesses will be. However, this
> >    creates a maintenance burden: each syscall must be annotated with
> >    its uaccesses in order to be recognized by the sanitizer, and these
> >    annotations must be continuously updated as the kernel changes. This
> >    is especially burdensome for syscalls such as ioctl(2) which have a
> >    large surface area of possible uaccesses.
> >
> > 2) Verifying the validity of kernel accesses. This can be achieved in
> >    conjunction with the userspace memory safety tools mentioned in (1).
> >    Even a sanitizer whose syscall wrappers have complete knowledge of
> >    the kernel's intended API may vary from the kernel's actual uaccesses
> >    due to kernel bugs. A sanitizer with knowledge of the kernel's actual
> >    uaccesses may produce more accurate error reports that reveal such
> >    bugs.
> >
> >    An example of such a bug, which was found by an earlier version of this
> >    patch together with a prototype client of the API in HWASan, was fixed
> >    by commit d0efb16294d1 ("net: don't unconditionally copy_from_user
> >    a struct ifreq for socket ioctls"). Although this bug turned out to
> >    relatively harmless, it was a bug nonetheless and it's always possible
> >    that more serious bugs of this sort may be introduced in the future.
> >
> > 3) Kernel fuzzing. We may use the list of reported kernel accesses to
> >    guide a kernel fuzzing tool such as syzkaller (so that it knows which
> >    parts of user memory to fuzz), as an alternative to providing the tool
> >    with a list of syscalls and their uaccesses (which again thanks to
> >    (2) may not be accurate).
> >
> > All signals except SIGKILL and SIGSTOP are masked for the interval
> > between the prctl() and the next syscall in order to prevent handlers
> > for intervening asynchronous signals from issuing syscalls that may
> > cause uaccesses from the wrong syscall to be logged.
> >
> > The format of a uaccess buffer entry is defined as follows:
> >
> > struct access_buffer_entry {
> >   u64 addr, size, flags;
> > };
> >
> > The meaning of addr and size should be obvious. On arm64, tag bits
> > are preserved in the addr field. The current meaning of the flags
> > field is that bit 0 indicates whether the access was a read (clear)
> > or a write (set). The meaning of all other flag bits is reserved.
> > All fields are of type u64 in order to avoid compat concerns.
> >
> > Here is an example of a code snippet that will enumerate the accesses
> > performed by a uname(2) syscall:
> >
> > struct access_buffer_entry entries[64];
> > uint64_t entries_end64 = (uint64_t)&entries;
> > struct utsname un;
> > prctl(PR_LOG_UACCESS, entries, sizeof(entries), &entries_end64, 0);
> > uname(&un);
> > struct access_buffer_entry *entries_end = (struct uaccess_buffer_entry *)entries_end64;
> > for (struct acccess_buffer_entry *i = entries; i != entries_end; ++i) {
> >   printf("%s at 0x%lu size 0x%lx\n",
> >          entries[i].flags & UACCESS_BUFFER_FLAG_WRITE ? "WRITE" : "READ",
> >          (unsigned long)entries[i].addr, (unsigned long)entries[i].size);
> > }
> >
> > Uaccess buffers are a "best-effort" mechanism for logging uaccesses. Of
> > course, not all of the accesses may fit in the buffer, but aside from
> > that, there are syscalls such as async I/O that are currently missed due
> > to the uaccesses occurring on a different kernel task (this is analogous
> > to how async I/O accesses are exempt from userspace MTE checks). We
> > view this as acceptable, as the access buffer can be sized sufficiently
> > large to handle syscalls that make a reasonable number of uaccesses,
> > and syscalls that use a different task for uaccesses are rare. In
> > many cases, the sanitizer does not need to see every memory access,
> > so it's fine if we miss the odd uaccess here and there. Even for those
> > sanitizers that do need to see every memory access it still represents
> > a much lower maintenance burden if we just have to handle the unusual
> > syscalls specially.
> >
> > Because we don't have a common kernel entry/exit code path that is used
> > on all architectures, uaccess logging is only implemented for arm64 and
> > architectures that use CONFIG_GENERIC_ENTRY, i.e. x86 and s390.
> >
> > One downside of this ABI is that it involves making two syscalls per
> > "real" syscall, which can harm performance. One possible way to avoid
> > this may be to have the prctl() register the uaccess buffer location
> > once at thread startup and use the same location for all syscalls in
> > the thread. However, because the program may be making syscalls very
> > early, before TLS is available, this may not always work. Furthermore,
> > because of the same asynchronous signal concerns that prompted temporarily
> > masking signals after the prctl(), the syscall stub would need to be made
> > reentrant, and it is unclear whether this is feasible without manually
> > masking asynchronous signals using rt_sigprocmask(2) while reading the
> > uaccess buffer, defeating the purpose of avoiding the extra syscall.
> >
> > One idea that we considered involved using the stack pointer address as
> > a unique identifier for the syscall, but this currently would need to be
> > arch-specific as we currently do not appear to have an arch-generic way
> > of retrieving the stack pointer; the userspace side would also need some
> > arch-specific code for this to work. It's also possible that a longjmp()
> > past the signal handler would make the stack pointer address not unique
> > enough for this purpose.
> >
> > On the other hand, by allocating the uaccess log on the stack and blocking
> > asynchronous signals for the interval between the prctl() and the "real"
> > syscall, we can avoid any reentrancy and TLS concerns.
> >
> > Another way to avoid the overhead may be to use an architecture-specific
> > calling convention to pass the address of the uaccess buffer to the kernel
> > at syscall time in registers currently unused for syscall arguments. For
> > example, one arm64-specific scheme that was used in a previous iteration
> > of the patch was:
> >
> > - Bit 0 of the immediate argument to the SVC instruction must be set.
> > - Register X6 contains the address of the access buffer.
> > - Register X7 contains the size of the access buffer in bytes.
> > - On return, X6 will contain the address of the memory location following
> >   any access buffer entries written by the kernel.
> >
> > However, this would need to be implemented separately for each
> > architecture (and some of them don't have enough registers anyway),
> > whereas the prctl() is (at least in theory) architecture-generic.
> >
> > We also evaluated implementing this on top of the existing tracepoint
> > facility, but concluded that it is not suitable for this purpose:
> >
> > - Tracepoints have a per-task granularity at best, whereas we really want
> >   to trace per-syscall. This is so that we can exclude syscalls that
> >   should not be traced, such as syscalls that make up part of the
> >   sanitizer implementation (to avoid infinite recursion when e.g. printing
> >   an error report).
> >
> > - Tracing would need to be synchronous in order to produce useful
> >   stack traces. For example this could be achieved using the new SIGTRAP
> >   on perf events mechanism. However, this would require logging each
> >   access to the stack (in the form of a sigcontext) and this is more
> >   likely to overflow the stack due to being much larger than a uaccess
> >   buffer entry as well as being unbounded, in contrast to the bounded
> >   buffer size passed to prctl(). An approach based on signal handlers is
> >   also likely to fall foul of the asynchronous signal issues mentioned
> >   previously, together with needing sigreturn to be handled specially
> >   (because it copies a sigcontext from userspace) otherwise we could
> >   never return from the signal handler. Furthermore, arguments to the
> >   trace events are not available to SIGTRAP. (This on its own wouldn't
> >   be insurmountable though -- we could add the arguments as fields
> >   to siginfo.)
> >
> > - The API in https://www.kernel.org/doc/Documentation/trace/ftrace.txt
> >   -- e.g. trace_pipe_raw gives access to the internal ring buffer, but
> >   I don't think it's useable because it's per-CPU and not per-task.
> >
> > - Tracepoints can be used by eBPF programs, but eBPF programs may
> >   only be loaded as root, among other potential headaches.
>
> Hi Peter,
>
> Is this intended to be used with real syscall only? I think for
> sanitizers we want to use this with libc syscall wrappers and more
> complex libc functions as well. Signal blocking assumes that there
> will be 1 and only 1 real syscall. I wonder if this can create
> problems with libc functions, in particular, if a libc function does
> >1 syscall, no syscalls, variable number of syscalls.

Yes, the intent is that this will only be used from the code that
executes the "real" syscall. Otherwise, as you point out, there's the
possibility of the libc function executing a different number of
syscalls, especially if symbol interposition comes into the picture.

Peter
