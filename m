Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C5459B74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKWFUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhKWFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so31720966ybj.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WnbN2WHJuwFnL4IOV+xjdSYZIdIftm6M1MM6VwFhDyU=;
        b=absSZZ6H1oUiIpJEEvRJIHiXodcyzXJspzMXOUPAB1YYEDvycWnw2y/mxAzkOYvm2/
         pFoAASiK6i4of+P7y+8+Z1yDoXc/phZVj5BnNegabIwA0iF6pvSTvz8xZpxRrbSPRXFt
         xSkPOweumCKXcPMNDaNqsAnEsbQ6mZ8aDWlPccGhellTn0MaPwdo+0bk7IW7rC582Fqz
         DRlab0Hp3edgegjeRQqVlwSM6QECZcB4QDe5ew2P/sMrpqyFYo7nE8yb9N7UT+5L1XQu
         UHdsILzRYX/LU6Qo22rTAY2m+t5Z2hujeiYChUZ1FQRCLIZMKVjftT22NQuFBvJH8WIW
         OTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WnbN2WHJuwFnL4IOV+xjdSYZIdIftm6M1MM6VwFhDyU=;
        b=dwy9wungOEfK5CgVLZZG3P5nAN9qGdYJJLoGGXr1v28wNGhfOVPWUMOvM2wLCakMkE
         NPQayU4FIa9xw/8MkKaJO68+YuXd8DuYwVVB2Jq21Bpjo0OOrutWsgvs50gIMulyngGq
         1S681CeCOpow2od+mjWeVfhDGngQ8oMcTdfbh5ePX9r6MtTYNZmVWtaseFTSgIRpXdq0
         wZx4fJ/lhrUYGEuBs8lK3KOzqII6I7ZFzqrGwUpx0s+xjwsdWe+txryA+5KLAQffcjc4
         mP5SXKYb+ak3tFfT51zl5A5kr6BZyK7ja28v1am0z0Zwa6hmp9DI26D1HJDKqrSmX3k/
         Te6A==
X-Gm-Message-State: AOAM53303bZXZRubayWjCJB2xBvBaXCJSstelUjmS7Dl34yBJTLJGwgY
        GBYndT1dRvZnQcmZ7a9HiPvIHrE=
X-Google-Smtp-Source: ABdhPJwhNxj+zpR+Fx+rIu5+4mS6nvMpxvIxFmtF8I7aqbb9NNs54TXo5a9+XtoXb7vf/VGGHZee4ys=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:a876:2e6a:b5f:3d90])
 (user=pcc job=sendgmr) by 2002:a25:b31c:: with SMTP id l28mr3184719ybj.9.1637644626102;
 Mon, 22 Nov 2021 21:17:06 -0800 (PST)
Date:   Mon, 22 Nov 2021 21:16:53 -0800
Message-Id: <20211123051658.3195589-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 0/5] kernel: introduce uaccess logging
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
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
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a kernel feature known as uaccess
logging, which allows userspace programs to be made aware of the
address and size of uaccesses performed by the kernel during
the servicing of a syscall. More details on the motivation
for and interface to this feature are available in the file
Documentation/admin-guide/uaccess-logging.rst added by the final
patch in the series.

Because we don't have a common kernel entry/exit code path that is used
on all architectures, uaccess logging is only implemented for arm64
and architectures that use CONFIG_GENERIC_ENTRY, i.e. x86 and s390.

The proposed interface is the result of numerous iterations and
prototyping and is based on a proposal by Dmitry Vyukov. The interface
preserves the correspondence between uaccess log identity and syscall
identity while tolerating incoming asynchronous signals in the interval
between setting up the logging and the actual syscall. We considered
a number of alternative designs but rejected them for various reasons:

- The design from v1 of this patch [1] proposed notifying the kernel
  of the address and size of the uaccess buffer via a prctl that
  would also automatically mask and unmask asynchronous signals as
  needed, but this would require multiple syscalls per "real" syscall,
  harming performance.

- We considered extending the syscall calling convention to
  designate currently-unused registers to be used to pass the
  location of the uaccess buffer, but this was rejected for being
  architecture-specific.

- One idea that we considered involved using the stack pointer address
  as a unique identifier for the syscall, but this currently would
  need to be arch-specific as we currently do not appear to have an
  arch-generic way of retrieving the stack pointer; the userspace
  side would also need some arch-specific code for this to work. It's
  also possible that a longjmp() past the signal handler would make
  the stack pointer address not unique enough for this purpose.

We also evaluated implementing this on top of the existing tracepoint
facility, but concluded that it is not suitable for this purpose:

- Tracepoints have a per-task granularity at best, whereas we really want
  to trace per-syscall. This is so that we can exclude syscalls that
  should not be traced, such as syscalls that make up part of the
  sanitizer implementation (to avoid infinite recursion when e.g. printing
  an error report).

- Tracing would need to be synchronous in order to produce useful
  stack traces. For example this could be achieved using the new SIGTRAP
  on perf events mechanism. However, this would require logging each
  access to the stack (in the form of a sigcontext) and this is more
  likely to overflow the stack due to being much larger than a uaccess
  buffer entry as well as being unbounded, in contrast to the bounded
  buffer size passed to prctl(). An approach based on signal handlers is
  also likely to fall foul of the asynchronous signal issues mentioned
  previously, together with needing sigreturn to be handled specially
  (because it copies a sigcontext from userspace) otherwise we could
  never return from the signal handler. Furthermore, arguments to the
  trace events are not available to SIGTRAP. (This on its own wouldn't
  be insurmountable though -- we could add the arguments as fields
  to siginfo.)

- The API in https://www.kernel.org/doc/Documentation/trace/ftrace.txt
  -- e.g. trace_pipe_raw gives access to the internal ring buffer, but
  I don't think it's usable because it's per-CPU and not per-task.

- Tracepoints can be used by eBPF programs, but eBPF programs may
  only be loaded as root, among other potential headaches.

[1] https://lore.kernel.org/all/20210922061809.736124-1-pcc@google.com/

Peter Collingbourne (5):
  fs: use raw_copy_from_user() to copy mount() data
  uaccess-buffer: add core code
  uaccess-buffer: add CONFIG_GENERIC_ENTRY support
  arm64: add support for uaccess logging
  Documentation: document uaccess logging

 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/uaccess-logging.rst | 149 ++++++++++++++++++
 arch/Kconfig                                  |   6 +
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/kernel/signal.c                    |   5 +
 arch/arm64/kernel/syscall.c                   |   3 +
 fs/exec.c                                     |   2 +
 fs/namespace.c                                |   7 +-
 include/linux/instrumented.h                  |   5 +-
 include/linux/sched.h                         |   4 +
 include/linux/uaccess-buffer-log-hooks.h      |  59 +++++++
 include/linux/uaccess-buffer.h                |  79 ++++++++++
 include/uapi/linux/prctl.h                    |   3 +
 include/uapi/linux/uaccess-buffer.h           |  25 +++
 kernel/Makefile                               |   1 +
 kernel/bpf/helpers.c                          |   6 +-
 kernel/entry/common.c                         |   7 +
 kernel/fork.c                                 |   3 +
 kernel/signal.c                               |   4 +-
 kernel/sys.c                                  |   6 +
 kernel/uaccess-buffer.c                       | 125 +++++++++++++++
 21 files changed, 497 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/uaccess-logging.rst
 create mode 100644 include/linux/uaccess-buffer-log-hooks.h
 create mode 100644 include/linux/uaccess-buffer.h
 create mode 100644 include/uapi/linux/uaccess-buffer.h
 create mode 100644 kernel/uaccess-buffer.c

-- 
2.34.0.rc2.393.gf8c9666880-goog

