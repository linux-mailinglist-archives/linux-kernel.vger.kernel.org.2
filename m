Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662C44146E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhIVKqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbhIVKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:46:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:44:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so5332474wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZ2ylxWSgiHY2Wph0uA4W2nTRyXysTCXIO/hfhkVBVU=;
        b=jkDLkfAA1BnlKpq/mXrCFZZOZgedQ4k9h6ZMRSxsrXcRv8Uy/R1MyjMF6Ty82Ncq22
         gkxPefNEp3+K/K4/Una4pNqglBGfXcZ8iqgmu0++UX3hYh0BcXnAe76X6GurBZoRDvwS
         JDfshmORPgUxbCEb9bRA5IkkWKOJ0clOoiEpJ3ol5OMvU4cd0uDPVyabFmWICOzPzCwT
         TWHLHjUNNv/Y0s5t2lr1ZzrdBV9w21gcql55MS0axXnYtHMEIQCnbVxtqqfoXUO+WFL/
         az5HiQyoOPSOZ1GQ1jiv6IG3Z11A062Gu6+Ocwkb8Ofo60vkNZ+wengErIq2XEmmd6j/
         gckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZ2ylxWSgiHY2Wph0uA4W2nTRyXysTCXIO/hfhkVBVU=;
        b=SIZgM0AHAWwMmc+pt/OKW1fYO4wF8VsBrcew5p3iEcDAxOdmBwMme6icPUfdMMc1T0
         DfDXEIjaySJa6h3F+9zpZzqDDVdID67t0WNLZeiAwp3GlGQGG/2u9Z30EJfLOFhR5fmX
         I/bi53/Vh5r1+UqefmkACzYy+eo0S1l9aNmdg9VUjJsOESh3sB5Gk4XdwLh5Klq1BYQs
         6CLyUmaa4b6hYJsGb9cnxJKHHO/C2l/Q4YgeU9mJ75qh8e9zL06eTujLOgNVzwv/7xY3
         SPt1aTzWhQkRtDLlaGLQtf9Y9tve3GXHFJYGW3dGUsZLIFcx4XYhBcQllJg5wgEO53P4
         LysA==
X-Gm-Message-State: AOAM531/DHyzZrxOdc+YI0WoowMHBlozgQKYqQ1t/w/ftJvDJAGxV12M
        L7BnMa2GKlmDYuVtiG9hYdZ5Cg==
X-Google-Smtp-Source: ABdhPJywvcKRrt9kaaFAbW0k+qrN9kq4J1fUi/e0zhknCgm3CIZGsnCBjpqqrQ+eOGEIsNjNpL9inw==
X-Received: by 2002:a05:600c:414d:: with SMTP id h13mr9604630wmm.121.1632307477380;
        Wed, 22 Sep 2021 03:44:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:d1cb:58a8:28e2:c853])
        by smtp.gmail.com with ESMTPSA id j14sm1770907wrp.21.2021.09.22.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 03:44:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 12:44:30 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Collingbourne <pcc@google.com>
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
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
Message-ID: <YUsJDpmePAIj7Zsi@elver.google.com>
References: <20210922061809.736124-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922061809.736124-1-pcc@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:18PM -0700, Peter Collingbourne wrote:
> This patch introduces a kernel feature known as uaccess logging.
> With uaccess logging, the userspace program passes the address and size
> of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> is a request for the kernel to log any uaccesses made during the next
> syscall to the uaccess buffer. When the next syscall returns, the address
> one past the end of the logged uaccess buffer entries is written to the
> location specified by the third argument to the prctl(). In this way,
> the userspace program may enumerate the uaccesses logged to the access
> buffer to determine which accesses occurred.
> 
> Uaccess logging has several use cases focused around bug detection
> tools:
> 
> 1) Userspace memory safety tools such as ASan, MSan, HWASan and tools
>    making use of the ARM Memory Tagging Extension (MTE) need to monitor
>    all memory accesses in a program so that they can detect memory
>    errors. For accesses made purely in userspace, this is achieved
>    via compiler instrumentation, or for MTE, via direct hardware
>    support. However, accesses made by the kernel on behalf of the
>    user program via syscalls (i.e. uaccesses) are invisible to these
>    tools. With MTE there is some level of error detection possible in
>    the kernel (in synchronous mode, bad accesses generally result in
>    returning -EFAULT from the syscall), but by the time we get back to
>    userspace we've lost the information about the address and size of the
>    failed access, which makes it harder to produce a useful error report.
> 
>    With the current versions of the sanitizers, we address this by
>    interposing the libc syscall stubs with a wrapper that checks the
>    memory based on what we believe the uaccesses will be. However, this
>    creates a maintenance burden: each syscall must be annotated with
>    its uaccesses in order to be recognized by the sanitizer, and these
>    annotations must be continuously updated as the kernel changes. This
>    is especially burdensome for syscalls such as ioctl(2) which have a
>    large surface area of possible uaccesses.
> 
> 2) Verifying the validity of kernel accesses. This can be achieved in
>    conjunction with the userspace memory safety tools mentioned in (1).
>    Even a sanitizer whose syscall wrappers have complete knowledge of
>    the kernel's intended API may vary from the kernel's actual uaccesses
>    due to kernel bugs. A sanitizer with knowledge of the kernel's actual
>    uaccesses may produce more accurate error reports that reveal such
>    bugs.
> 
>    An example of such a bug, which was found by an earlier version of this
>    patch together with a prototype client of the API in HWASan, was fixed
>    by commit d0efb16294d1 ("net: don't unconditionally copy_from_user
>    a struct ifreq for socket ioctls"). Although this bug turned out to
>    relatively harmless, it was a bug nonetheless and it's always possible
>    that more serious bugs of this sort may be introduced in the future.
> 
> 3) Kernel fuzzing. We may use the list of reported kernel accesses to
>    guide a kernel fuzzing tool such as syzkaller (so that it knows which
>    parts of user memory to fuzz), as an alternative to providing the tool
>    with a list of syscalls and their uaccesses (which again thanks to
>    (2) may not be accurate).
> 
> All signals except SIGKILL and SIGSTOP are masked for the interval
> between the prctl() and the next syscall in order to prevent handlers
> for intervening asynchronous signals from issuing syscalls that may
> cause uaccesses from the wrong syscall to be logged.
> 
> The format of a uaccess buffer entry is defined as follows:
> 
> struct access_buffer_entry {

uaccess_buffer_entry (missing 'u')?

Here and below.

>   u64 addr, size, flags;
> };
> 
> The meaning of addr and size should be obvious. On arm64, tag bits
> are preserved in the addr field. The current meaning of the flags
> field is that bit 0 indicates whether the access was a read (clear)
> or a write (set). The meaning of all other flag bits is reserved.
> All fields are of type u64 in order to avoid compat concerns.
> 
> Here is an example of a code snippet that will enumerate the accesses
> performed by a uname(2) syscall:
> 
> struct access_buffer_entry entries[64];
> uint64_t entries_end64 = (uint64_t)&entries;
> struct utsname un;
> prctl(PR_LOG_UACCESS, entries, sizeof(entries), &entries_end64, 0);
> uname(&un);
> struct access_buffer_entry *entries_end = (struct uaccess_buffer_entry *)entries_end64;
> for (struct acccess_buffer_entry *i = entries; i != entries_end; ++i) {
>   printf("%s at 0x%lu size 0x%lx\n",
>          entries[i].flags & UACCESS_BUFFER_FLAG_WRITE ? "WRITE" : "READ",
> 	 (unsigned long)entries[i].addr, (unsigned long)entries[i].size);
> }

I think it would be good to persist information like this in dedicated
Documentation. If I had to guess, Documentation/admin-guide/uaccess-buffer.rst
could be the appropriate location.

It also allows to write some background, and then shorten the commit
message / cover letter (details can be placed in Documentation,
including the example).

> Uaccess buffers are a "best-effort" mechanism for logging uaccesses. Of
> course, not all of the accesses may fit in the buffer, but aside from
> that, there are syscalls such as async I/O that are currently missed due
> to the uaccesses occurring on a different kernel task (this is analogous
> to how async I/O accesses are exempt from userspace MTE checks). We
> view this as acceptable, as the access buffer can be sized sufficiently
> large to handle syscalls that make a reasonable number of uaccesses,
> and syscalls that use a different task for uaccesses are rare. In
> many cases, the sanitizer does not need to see every memory access,
> so it's fine if we miss the odd uaccess here and there. Even for those
> sanitizers that do need to see every memory access it still represents
> a much lower maintenance burden if we just have to handle the unusual
> syscalls specially.
> 
> Because we don't have a common kernel entry/exit code path that is used
> on all architectures, uaccess logging is only implemented for arm64 and
> architectures that use CONFIG_GENERIC_ENTRY, i.e. x86 and s390.
> 
> One downside of this ABI is that it involves making two syscalls per
> "real" syscall, which can harm performance. One possible way to avoid
> this may be to have the prctl() register the uaccess buffer location
> once at thread startup and use the same location for all syscalls in
> the thread. However, because the program may be making syscalls very
> early, before TLS is available, this may not always work. Furthermore,
> because of the same asynchronous signal concerns that prompted temporarily
> masking signals after the prctl(), the syscall stub would need to be made
> reentrant, and it is unclear whether this is feasible without manually
> masking asynchronous signals using rt_sigprocmask(2) while reading the
> uaccess buffer, defeating the purpose of avoiding the extra syscall.
> 
> One idea that we considered involved using the stack pointer address as
> a unique identifier for the syscall, but this currently would need to be
> arch-specific as we currently do not appear to have an arch-generic way
> of retrieving the stack pointer; the userspace side would also need some
> arch-specific code for this to work. It's also possible that a longjmp()
> past the signal handler would make the stack pointer address not unique
> enough for this purpose.
> 
> On the other hand, by allocating the uaccess log on the stack and blocking
> asynchronous signals for the interval between the prctl() and the "real"
> syscall, we can avoid any reentrancy and TLS concerns.
> 
> Another way to avoid the overhead may be to use an architecture-specific
> calling convention to pass the address of the uaccess buffer to the kernel
> at syscall time in registers currently unused for syscall arguments. For
> example, one arm64-specific scheme that was used in a previous iteration
> of the patch was:
> 
> - Bit 0 of the immediate argument to the SVC instruction must be set.
> - Register X6 contains the address of the access buffer.
> - Register X7 contains the size of the access buffer in bytes.
> - On return, X6 will contain the address of the memory location following
>   any access buffer entries written by the kernel.
> 
> However, this would need to be implemented separately for each
> architecture (and some of them don't have enough registers anyway),
> whereas the prctl() is (at least in theory) architecture-generic.
> 
> We also evaluated implementing this on top of the existing tracepoint
> facility, but concluded that it is not suitable for this purpose:
> 
> - Tracepoints have a per-task granularity at best, whereas we really want
>   to trace per-syscall. This is so that we can exclude syscalls that
>   should not be traced, such as syscalls that make up part of the
>   sanitizer implementation (to avoid infinite recursion when e.g. printing
>   an error report).
> 
> - Tracing would need to be synchronous in order to produce useful
>   stack traces. For example this could be achieved using the new SIGTRAP
>   on perf events mechanism. However, this would require logging each
>   access to the stack (in the form of a sigcontext) and this is more
>   likely to overflow the stack due to being much larger than a uaccess
>   buffer entry as well as being unbounded, in contrast to the bounded
>   buffer size passed to prctl(). An approach based on signal handlers is
>   also likely to fall foul of the asynchronous signal issues mentioned
>   previously, together with needing sigreturn to be handled specially
>   (because it copies a sigcontext from userspace) otherwise we could
>   never return from the signal handler. Furthermore, arguments to the
>   trace events are not available to SIGTRAP. (This on its own wouldn't
>   be insurmountable though -- we could add the arguments as fields
>   to siginfo.)
> 
> - The API in https://www.kernel.org/doc/Documentation/trace/ftrace.txt
>   -- e.g. trace_pipe_raw gives access to the internal ring buffer, but
>   I don't think it's useable because it's per-CPU and not per-task.
> 
> - Tracepoints can be used by eBPF programs, but eBPF programs may
>   only be loaded as root, among other potential headaches.
> 
> Link: https://linux-review.googlesource.com/id/I6581765646501a5631b281d670903945ebadc57d
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  arch/Kconfig                        |   6 ++
>  arch/arm64/Kconfig                  |   1 +
>  arch/arm64/kernel/syscall.c         |   2 +

The arch-enablement changes should be their own patches (one for arm64,
and another for the generic entry code). And it probably further helps
reviewability by moving bits of the commit message into a cover letter
and Documentation.

So I think there should be at least 4 patches (core code, arm64, generic
entry, Documentation).

>  include/linux/instrumented.h        |   5 +-
>  include/linux/sched.h               |   3 +
>  include/linux/uaccess_buffer.h      |  43 ++++++++++
>  include/linux/uaccess_buffer_info.h |  23 ++++++
>  include/uapi/linux/prctl.h          |   9 +++
>  kernel/Makefile                     |   1 +
>  kernel/entry/common.c               |   3 +
>  kernel/sys.c                        |   6 ++
>  kernel/uaccess_buffer.c             | 118 ++++++++++++++++++++++++++++
>  12 files changed, 219 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/uaccess_buffer.h
>  create mode 100644 include/linux/uaccess_buffer_info.h
>  create mode 100644 kernel/uaccess_buffer.c
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8df1c7102643..a427f6440cc9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -31,6 +31,7 @@ config HOTPLUG_SMT
>  	bool
>  
>  config GENERIC_ENTRY
> +       select UACCESS_BUFFER
>         bool
>  
>  config KPROBES
> @@ -1288,6 +1289,11 @@ config ARCH_HAS_ELFCORE_COMPAT
>  config ARCH_HAS_PARANOID_L1D_FLUSH
>  	bool
>  
> +config UACCESS_BUFFER

This is not a user-selectable config option, so I think the name should
be HAVE_ARCH_UACCESS_BUFFER.

> +	bool
> +	help
> +	  Select if the architecture's syscall entry/exit code supports uaccess buffers.
> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..4764e5fd7ba9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -221,6 +221,7 @@ config ARM64
>  	select THREAD_INFO_IN_TASK
>  	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>  	select TRACE_IRQFLAGS_SUPPORT
> +	select UACCESS_BUFFER

Once it's called HAVE_ARCH_UACCESS_BUFFER, it should also be reordered
to be in alphabetical order with other selects here to reduce risk of
merge conflicts (when things are added at the end).

>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 50a0f1a38e84..c3f8652d84a5 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -139,7 +139,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  			goto trace_exit;
>  	}
>  
> +	uaccess_buffer_syscall_entry();
>  	invoke_syscall(regs, scno, sc_nr, syscall_table);
> +	uaccess_buffer_syscall_exit();

I think this is missing an #include <linux/access_buffer.h>, although
it's currently implicit via instrumented.h.

>  
>  	/*
>  	 * The tracing status may have changed under our feet, so we have to
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 42faebbaa202..9144936edcb1 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -2,7 +2,7 @@
>  
>  /*
>   * This header provides generic wrappers for memory access instrumentation that
> - * the compiler cannot emit for: KASAN, KCSAN.
> + * the compiler cannot emit for: KASAN, KCSAN, access buffers.
>   */
>  #ifndef _LINUX_INSTRUMENTED_H
>  #define _LINUX_INSTRUMENTED_H
> @@ -11,6 +11,7 @@
>  #include <linux/kasan-checks.h>
>  #include <linux/kcsan-checks.h>
>  #include <linux/types.h>
> +#include <linux/uaccess_buffer.h>

instrumented.h is included from almost everywhere. Like is done for
KASAN and KCSAN, it helps to minimize the header required for the
checks.

In this case, for consistency with the others, I recommend having a
header <linux/uaccess-buffer-checks.h> with just the 2 functions
required here.  And then put the rest (including the struct) into
<linux/uaccess-buffer.h>.

>  /**
>   * instrument_read - instrument regular read access
> @@ -117,6 +118,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>  	kasan_check_read(from, n);
>  	kcsan_check_read(from, n);
> +	uaccess_buffer_log_write(to, n);
>  }
>  
>  /**
> @@ -134,6 +136,7 @@ instrument_copy_from_user(const void *to, const void __user *from, unsigned long
>  {
>  	kasan_check_write(to, n);
>  	kcsan_check_write(to, n);
> +	uaccess_buffer_log_read(from, n);
>  }
>  
>  #endif /* _LINUX_INSTRUMENTED_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e12b524426b0..3fecb0487b97 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -34,6 +34,7 @@
>  #include <linux/rseq.h>
>  #include <linux/seqlock.h>
>  #include <linux/kcsan.h>
> +#include <linux/uaccess_buffer_info.h>
>  #include <asm/kmap_size.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> @@ -1487,6 +1488,8 @@ struct task_struct {
>  	struct callback_head		l1d_flush_kill;
>  #endif
>  
> +	struct uaccess_buffer_info	uaccess_buffer;
> +
>  	/*
>  	 * New fields for task_struct should be added above here, so that
>  	 * they are included in the randomized portion of task_struct.
> diff --git a/include/linux/uaccess_buffer.h b/include/linux/uaccess_buffer.h
> new file mode 100644
> index 000000000000..3b81f2a192a4
> --- /dev/null
> +++ b/include/linux/uaccess_buffer.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ACCESS_BUFFER_H
> +#define _LINUX_ACCESS_BUFFER_H
> +
> +#include <asm-generic/errno-base.h>
> +
> +#ifdef CONFIG_UACCESS_BUFFER
> +
> +void uaccess_buffer_log_read(const void __user *from, unsigned long n);
> +void uaccess_buffer_log_write(void __user *to, unsigned long n);
> +

As suggested above, the above 2 functions above can go into a single
header uaccess-buffer-checks.h (which also doesn't need to include
errno-base.h).

The rest below (merged with the struct definition) can then go into the
second header.

> +void uaccess_buffer_syscall_entry(void);
> +void uaccess_buffer_syscall_exit(void);
> +
> +int uaccess_buffer_set_logging(unsigned long addr, unsigned long size,
> +			       unsigned long store_end_addr);
> +
> +#else
> +
> +static inline void uaccess_buffer_log_read(const void __user *from,
> +					   unsigned long n)
> +{
> +}
> +static inline void uaccess_buffer_log_write(void __user *to, unsigned long n)
> +{
> +}
> +
> +static inline void uaccess_buffer_syscall_entry(void)
> +{
> +}
> +static inline void uaccess_buffer_syscall_exit(void)
> +{
> +}
> +
> +static inline int uaccess_buffer_set_logging(unsigned long addr,
> +					     unsigned long size,
> +					     unsigned long store_end_addr)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +#endif  /* _LINUX_ACCESS_BUFFER_H */
> diff --git a/include/linux/uaccess_buffer_info.h b/include/linux/uaccess_buffer_info.h
> new file mode 100644
> index 000000000000..a6cefe6e73b5
> --- /dev/null
> +++ b/include/linux/uaccess_buffer_info.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ACCESS_BUFFER_INFO_H
> +#define _LINUX_ACCESS_BUFFER_INFO_H
> +
> +#include <uapi/asm/signal.h>
> +
> +#ifdef CONFIG_UACCESS_BUFFER
> +
> +struct uaccess_buffer_info {

Please add comments for each variable if possible.

> +	unsigned long addr, size;
> +	unsigned long store_end_addr;
> +	sigset_t saved_sigmask;
> +	u8 state;

I think 'state' is less clear than it could be. Looking at the rest of
the code, 'state' could just be 'enabled' (or 'enable_count')?

> +};
> +
> +#else
> +
> +struct uaccess_buffer_info {
> +};

I'm not sure what's cleaner: a) in the #else case defining an empty
struct, or b) in the #else case not defining the struct and guarding the
use in sched.h with an #ifdef.

(b) is currently the standard way of doing it, and unless it improves
readability elsewhere (e.g. need to pass current->uaccess_buffer to a
function outside kernel/uaccess_buffer.c), I'd probably just do (b).

> +#endif
> +
> +#endif  /* _LINUX_ACCESS_BUFFER_INFO_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 43bd7f713c39..d8baacaef800 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -269,4 +269,13 @@ struct prctl_mm_map {
>  # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
>  # define PR_SCHED_CORE_MAX		4
>  
> +/* Log uaccesses to a user-provided buffer */
> +#define PR_LOG_UACCESS			63
> +
> +/* Format of the entries in the uaccess log. */
> +struct uaccess_buffer_entry {
> +	__u64 addr, size, flags;

Comments for the above variables (in which case putting them on their
own line would be preferred).

> +};
> +# define UACCESS_BUFFER_FLAG_WRITE	1 /* access was a write */

The struct and UACCESS_BUFFER_FLAG_WRITE does not belong in prctl.h, and
should probably go in another appropriate header in uapi/linux.

> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 4df609be42d0..75a5d95ce9c3 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -115,6 +115,7 @@ obj-$(CONFIG_KCSAN) += kcsan/
>  obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
>  obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
>  obj-$(CONFIG_CFI_CLANG) += cfi.o
> +obj-$(CONFIG_UACCESS_BUFFER) += uaccess_buffer.o
>  
>  obj-$(CONFIG_PERF_EVENTS) += events/
>  
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index bf16395b9e13..c7e7ff8cbab3 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -89,6 +89,8 @@ __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
>  	if (work & SYSCALL_WORK_ENTER)
>  		syscall = syscall_trace_enter(regs, syscall, work);
>  
> +	uaccess_buffer_syscall_entry();

This is also missing an #include.

> +
>  	return syscall;
>  }
>  
> @@ -273,6 +275,7 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>  			local_irq_enable();
>  	}
>  
> +	uaccess_buffer_syscall_exit();
>  	rseq_syscall(regs);
>  
>  	/*
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8fdac0d90504..df487600773c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -42,6 +42,7 @@
>  #include <linux/version.h>
>  #include <linux/ctype.h>
>  #include <linux/syscall_user_dispatch.h>
> +#include <linux/uaccess_buffer.h>
>  
>  #include <linux/compat.h>
>  #include <linux/syscalls.h>
> @@ -2530,6 +2531,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
>  		break;
>  #endif
> +	case PR_LOG_UACCESS:
> +		if (arg5)
> +			return -EINVAL;
> +		error = uaccess_buffer_set_logging(arg2, arg3, arg4);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/kernel/uaccess_buffer.c b/kernel/uaccess_buffer.c
> new file mode 100644
> index 000000000000..b9da89887c4b
> --- /dev/null
> +++ b/kernel/uaccess_buffer.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0

This is a new file, and probably needs a Copyright header. See
e.g. mm/kfence/core.c for template.

> +#include <linux/compat.h>
> +#include <linux/prctl.h>
> +#include <linux/sched.h>
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <linux/uaccess_buffer.h>
> +#include <linux/uaccess_buffer_info.h>
> +
> +#ifdef CONFIG_UACCESS_BUFFER
> +

The #ifdef is redundant, given the Makefile already guards compilation
of this file.

> +/*
> + * We use a separate implementation of copy_to_user() that avoids the call
> + * to instrument_copy_to_user() as this would otherwise lead to infinite
> + * recursion.
> + */
> +static unsigned long
> +uaccess_buffer_copy_to_user(void __user *to, const void *from, unsigned long n)
> +{
> +	if (!access_ok(to, n))
> +		return n;
> +	return raw_copy_to_user(to, from, n);
> +}
> +
> +static void uaccess_buffer_log(unsigned long addr, unsigned long size,
> +			      unsigned long flags)
> +{
> +	struct uaccess_buffer_entry entry;
> +
> +	if (current->uaccess_buffer.size < sizeof(entry) ||
> +	    unlikely(uaccess_kernel()))
> +		return;
> +	entry.addr = addr;
> +	entry.size = size;
> +	entry.flags = flags;
> +
> +	/*
> +	 * If our uaccess fails, abort the log so that the end address writeback
> +	 * does not occur and userspace sees zero accesses.
> +	 */
> +	if (uaccess_buffer_copy_to_user(
> +		    (void __user *)current->uaccess_buffer.addr, &entry,
> +		    sizeof(entry))) {
> +		current->uaccess_buffer.state = 0;
> +		current->uaccess_buffer.addr = current->uaccess_buffer.size = 0;
> +	}
> +
> +	current->uaccess_buffer.addr += sizeof(entry);
> +	current->uaccess_buffer.size -= sizeof(entry);
> +}
> +
> +void uaccess_buffer_log_read(const void __user *from, unsigned long n)
> +{
> +	uaccess_buffer_log((unsigned long)from, n, 0);
> +}
> +EXPORT_SYMBOL(uaccess_buffer_log_read);
> +
> +void uaccess_buffer_log_write(void __user *to, unsigned long n)
> +{
> +	uaccess_buffer_log((unsigned long)to, n, UACCESS_BUFFER_FLAG_WRITE);
> +}
> +EXPORT_SYMBOL(uaccess_buffer_log_write);
> +
> +int uaccess_buffer_set_logging(unsigned long addr, unsigned long size,
> +			       unsigned long store_end_addr)
> +{
> +	sigset_t temp_sigmask;
> +
> +	current->uaccess_buffer.addr = addr;
> +	current->uaccess_buffer.size = size;
> +	current->uaccess_buffer.store_end_addr = store_end_addr;
> +
> +	/*
> +	 * Allow 2 syscalls before resetting the state: the current one (i.e.
> +	 * prctl) and the next one, whose accesses we want to log.
> +	 */
> +	current->uaccess_buffer.state = 2;
> +
> +	/*
> +	 * Temporarily mask signals so that an intervening asynchronous signal
> +	 * will not interfere with the logging.
> +	 */
> +	current->uaccess_buffer.saved_sigmask = current->blocked;
> +	sigfillset(&temp_sigmask);
> +	sigdelsetmask(&temp_sigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
> +	__set_current_blocked(&temp_sigmask);
> +
> +	return 0;
> +}
> +
> +void uaccess_buffer_syscall_entry(void)
> +{
> +	/*
> +	 * The current syscall may be e.g. rt_sigprocmask, and therefore we want
> +	 * to reset the mask before the syscall and not after, so that our
> +	 * temporary mask is unobservable.
> +	 */
> +	if (current->uaccess_buffer.state == 1)
> +		__set_current_blocked(&current->uaccess_buffer.saved_sigmask);
> +}
> +
> +void uaccess_buffer_syscall_exit(void)
> +{
> +	if (current->uaccess_buffer.state > 0) {

This could just be 

+       if (!current->uaccess_buffer.state)
+               return;

.. which avoids the deep nesting below and helps with formatting.

This is also the point where the name 'state' just seems too generic, and
'enabled' (or 'enable_count') would make it clearer what is happening.

> +		--current->uaccess_buffer.state;
> +		if (current->uaccess_buffer.state == 0) {
> +			u64 addr64 = current->uaccess_buffer.addr;
> +
> +			uaccess_buffer_copy_to_user(
> +				(void __user *)
> +					current->uaccess_buffer.store_end_addr,
> +				&addr64, sizeof(addr64));
> +			current->uaccess_buffer.addr = current->uaccess_buffer.size = 0;
> +		}
> +	}
> +}
> +
> +#endif

Thanks,
-- Marco
