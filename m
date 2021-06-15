Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05543A86E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFOQye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFOQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:54:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so2248816wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BDbSO42bfxYS0kxJArV+zsiFX69/UAkGqgdna48yKik=;
        b=jYpzTwEMXSChpraoGKdpoBGMwLQfKWdcDhyobgtls88uccVx4xrmdjWZ4xJk45ftfD
         CoFPmD/4axc5CNJYdYEDhBy7y0MOFTdDDEB4aON2GlYv2BVy3ANeOynfQn7WLwYQA+iI
         AwfuYmZ33DdZ4xh5rhoFPBvMg1Bc0y2TIFMaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BDbSO42bfxYS0kxJArV+zsiFX69/UAkGqgdna48yKik=;
        b=iZ+jp3495/99QekoykznKdPm15/kNP8tgAcdQsLxtF0PGk2fv4HxVx980CcYZqtHAV
         cN6cU6GVgBoK8U2v55TERMZmnzFasb4Q70I6/CfeGVVj8EzOxZQYE7jqUzwUHFX/MMMn
         k3O2660Vka+8ojigZR5ZdTgfYCrW+b7Q+cyGFTzGVWzSfHWhWZSA6NCexoUde/wvXIZv
         LunssDTQLydeJwZQY5992JEfsDjOhIg2jUui+QTuZ1z2RSiTRbTQ8pMRSuBdsNI8bO7i
         +8UhyzeSvZo+4SmJDBsiAIQNRYzOJN5W4itEmq9QFci779UCYig9J8eCiyP7+izwNHXn
         +dkQ==
X-Gm-Message-State: AOAM531QeC/ABXlqZR2zC+vRd3lQlDffq92gO/5ytLg4Vi44dZF8Q6HO
        WKnpIzGdbR6jfS+DgyT0MbeMRIs4DF7GyVtZNf8=
X-Google-Smtp-Source: ABdhPJwLQcD3Jh8PphhY7WYAOC9oKxm2XVMUjQHJYRp7uVC40KMP2yHvU1BJGTllMVrkrnlUeapV9w==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr273590wml.74.1623775941733;
        Tue, 15 Jun 2021 09:52:21 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id l16sm2820389wmj.47.2021.06.15.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:52:21 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:52:20 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: [PATCH v7 0/5] printk: Userspace format indexing support
Message-ID: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a number of systems industry-wide that have a subset of their
functionality that works as follows:

1. Receive a message from local kmsg, serial console, or netconsole;
2. Apply a set of rules to classify the message;
3. Do something based on this classification (like scheduling a
   remediation for the machine), rinse, and repeat.

As a couple of examples of places we have this implemented just inside
Facebook, although this isn't a Facebook-specific problem, we have this
inside our netconsole processing (for alarm classification), and as part
of our machine health checking. We use these messages to determine
fairly important metrics around production health, and it's important
that we get them right.

While for some kinds of issues we have counters, tracepoints, or metrics
with a stable interface which can reliably indicate the issue, in order
to react to production issues quickly we need to work with the interface
which most kernel developers naturally use when developing: printk.

Most production issues come from unexpected phenomena, and as such
usually the code in question doesn't have easily usable tracepoints or
other counters available for the specific problem being mitigated. We
have a number of lines of monitoring defence against problems in
production (host metrics, process metrics, service metrics, etc), and
where it's not feasible to reliably monitor at another level, this kind
of pragmatic netconsole monitoring is essential.

As one would expect, monitoring using printk is rather brittle for a
number of reasons -- most notably that the message might disappear
entirely in a new version of the kernel, or that the message may change
in some way that the regex or other classification methods start to
silently fail.

One factor that makes this even harder is that, under normal operation,
many of these messages are never expected to be hit. For example, there
may be a rare hardware bug which one wants to detect if it was to ever
happen again, but its recurrence is not likely or anticipated. This
precludes using something like checking whether the printk in question
was printed somewhere fleetwide recently to determine whether the
message in question is still present or not, since we don't anticipate
that it should be printed anywhere, but still need to monitor for its
future presence in the long-term.

This class of issue has happened on a number of occasions, causing
unhealthy machines with hardware issues to remain in production for
longer than ideal. As a recent example, some monitoring around
blk_update_request fell out of date and caused semi-broken machines to
remain in production for longer than would be desirable.

Searching through the codebase to find the message is also extremely
fragile, because many of the messages are further constructed beyond
their callsite (eg. btrfs_printk and other module-specific wrappers,
each with their own functionality). Even if they aren't, guessing the
format and formulation of the underlying message based on the aesthetics
of the message emitted is not a recipe for success at scale, and our
previous issues with fleetwide machine health checking demonstrate as
much.

This provides a solution to the issue of silently changed or deleted
printks: we record pointers to all printk format strings known at
compile time into a new .printk_index section, both in vmlinux and
modules. At runtime, this can then be iterated by looking at
<debugfs>/printk/index/<module>, which emits the following format, both
readable by humans and able to be parsed by machines:

    $ head -1 vmlinux; shuf -n 5 vmlinux
    # <level[,flags]> filename:line function "format"
    <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
    <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
    <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
    <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
    <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"

This mitigates the majority of cases where we have a highly-specific
printk which we want to match on, as we can now enumerate and check
whether the format changed or the printk callsite disappeared entirely
in userspace. This allows us to catch changes to printks we monitor
earlier and decide what to do about it before it becomes problematic.

There is no additional runtime cost for printk callers or printk itself,
and the assembly generated is exactly the same.

---

v2:

- Use seq_printf instead of step by step accumulation
- Scope fptr closer to its use
- Prevent seq_file from needing to alloc a new buffer
- Always provide KERN_SOH + level, even if caller omitted it
- Provide one file per module
- Update changelog to show ease of parsing
- Provide printk -> _printk for ARCH=um (thanks, LKP robot)
- Move to debugfs (thanks, Steven)

---

v3:

- Reduce locking during open by moving size lifetime to the inode
- Don't explicitly check for debugfs errors (thanks, gregkh)

---

v4:

- Fix a missed `extern int printk` fixup in ia64 (thanks, lkp)

---

v5:

Thanks Petr for the extensive feedback.

- Move all module handling from module notifier to module.[ch] directly
- Change to readable output format
  - Handled by new string_escape(ESCAPE_PRINTF)
- Add file/line/function information
- Mass rename everything to printk_index/CONFIG_PRINTK_INDEX/pi_*
  - As a result, this version does away with the mutex/hashtable
- Use seq_file iteration API instead of simple_open
- Remove debugfs file first to avoid ENOENT
- Tear down backing datastructure if debugfs file creation fails
- Move code under ifdef guard to kernel/printk/index.c
- Add pi_sec (formerly printk_fmt_sec) documentation
- Handle coexisting LOG_CONT + level
- Add header to debugfs output
- ...and probably some other stuff I forgot. :-)

---

v6:

- Rebase on next-20210518
- Remove pi_sec, do on demand lookups instead
- Lookup debugfs file on demand
- pi_sec_{store,remove} now only changes debugfs, so renamed
- Don't check for debugfs failure (again)
- Extract lookup logic into pi_get_entry
- Make the stored struct `const __used`
- Use _p_func directly, which allows including void-returning functions
- Move more stuff outside PRINTK_INDEX #ifdef using __printk_index_emit
- Scope __{start,stop}_printk_index more tightly
- Move parse_prefix to printk_parse_prefix in internal.h
- Put PRINTK_INDEX definition below TRACEDATA
- Use a module notifier again
- pi_object -> pi_entry, with clearer vars
- Reword Kconfig
- Split out printk_info_flags/string_helpers stuff into patches
- Use seq_escape_str directly now that ESCAPE_APPEND exists
- Add dev_printk indexing support

---

v7:

- Rebase on next-20210615
- Change some GCC statement expressions where do {} while (0) could work
   - dev_* needs to be statement due to SCSI_LOG_ERROR_RECOVERY and similar
- Fix some weird continuation indentation
- Remove filename from index.c header
- Add explicit default case for non MODULE_STATE_COMING/MODULE_STATE_GOING
- Tersify !CONFIG_MODULES case for pi_setup_module_notifier
- Remove now unnecessary pi_start forward declaration
- Move to DEFINE_SEQ_ATTRIBUTE for dfs_index
- Add comment explaining why we have both ESCAPE_SPECIAL and subset as @only
- Remove post_fmt for now, since dev_printk doesn't have it and it looks rare
- Rename pre_fmt to subsys_fmt_prefix
- Avoid forward declarations for pi_{create,remove}_file by splitting
  pi_get_module_name from other CONFIG_MODULES dependents
- Don't show -1 for LOGLEVEL_DEFAULT with LOG_CONT, since it has a different
  semantic meaning
- Some improvements to comments based on feedback from Petr
- Split out printk_parse_prefix externalisation into a separate patch
- Move printk_parse_prefix into internal.h instead of printk_ringbuffer.h
- Now that level might be optional (eg. in LOG_CONT with no level case), update
  the header to match
- Reduce duplication in dev_printk

Chris Down (5):
  string_helpers: Escape double quotes in escape_special
  printk: Straighten out log_flags into printk_info_flags
  printk: Rework parse_prefix into printk_parse_prefix
  printk: Userspace format indexing support
  printk: index: Add indexing support to dev_printk

 MAINTAINERS                          |   5 +
 arch/arm/kernel/entry-v7m.S          |   2 +-
 arch/arm/lib/backtrace-clang.S       |   2 +-
 arch/arm/lib/backtrace.S             |   2 +-
 arch/arm/mach-rpc/io-acorn.S         |   2 +-
 arch/arm/vfp/vfphw.S                 |   6 +-
 arch/ia64/include/uapi/asm/cmpxchg.h |   4 +-
 arch/openrisc/kernel/entry.S         |   6 +-
 arch/powerpc/kernel/head_fsl_booke.S |   2 +-
 arch/um/include/shared/user.h        |   3 +-
 arch/x86/kernel/head_32.S            |   2 +-
 drivers/base/core.c                  |   6 +-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/dev_printk.h           |  66 ++++++---
 include/linux/module.h               |   5 +
 include/linux/printk.h               |  95 ++++++++++++-
 init/Kconfig                         |  14 ++
 kernel/module.c                      |   5 +
 kernel/printk/Makefile               |   1 +
 kernel/printk/index.c                | 195 +++++++++++++++++++++++++++
 kernel/printk/internal.h             |   8 ++
 kernel/printk/printk.c               |  60 ++++-----
 lib/string_helpers.c                 |   4 +
 lib/test-string_helpers.c            |  14 +-
 24 files changed, 446 insertions(+), 76 deletions(-)
 create mode 100644 kernel/printk/index.c

-- 
2.31.1

