Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67234F722
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhCaDFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhCaDFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5313C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a12so4644949pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7r8q4+jfsqYeWSmQl9ewOqEIRdKZ2+jiQXqx874UHs=;
        b=UTASMEMUx99NzjIyWpHr0/mcSp2UvLaPGwlBGhjTEX4Reie8C5xZwwYVbv51SF7m8p
         gR/lbTntdfxAlXU9VGtIUXBzgY0SibsG5+MxvZwWAsH/+xpb9Ky/dYRvIAdf/fgWPM/w
         J7wYZF1zOPt8WMWSAStbrO7dGspJtpl/yDgKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7r8q4+jfsqYeWSmQl9ewOqEIRdKZ2+jiQXqx874UHs=;
        b=frwNPpR9FO4PA//9dgZ5POJmYkNXG2lSu9s36vpfm0gteoe0gYQ9g4IYSoQx11wlFz
         K074Nz+Vi32IPbgGLYrEeiBlwiPUXJiFsd7rdcY70w/i+2BBF2R/WIxlUy8TsBPtE0I+
         M4lqMGbFNP70MlC4uGmPLGKjOk0+r2vPed8aHUexnid2WXEjhTwckc42UVH6UnQb5MKf
         BbRruWodnnOb1fH9zXoIBFqU4c6qMtLTe6xWT8CIOtI2JQlg6jIq+L99BGXaCNNikh1c
         I0QtvbBaYM/l6GMyuhUPmpiIFvSMqVAk28tmOfXHopjuPUP8/iWTzaa91TLSvXbHNEV9
         iH4Q==
X-Gm-Message-State: AOAM532Ph2gufpVfOt5vdJ058uG32h1Qh7sBIAMaXVjs4l/3l4wTM6FH
        USGnFvsV9irotGYZwDSMaydNtQ==
X-Google-Smtp-Source: ABdhPJzZ7w61YABPCh5iarbocuVmY15xbWpwl08B90IgwSEEUshWM4L54HpsqO1Rw1j4ZI3sZ1QM8A==
X-Received: by 2002:a63:f443:: with SMTP id p3mr1139952pgk.378.1617159923437;
        Tue, 30 Mar 2021 20:05:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org, Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Subject: [PATCH v3 00/12] Add build ID to stacktraces
Date:   Tue, 30 Mar 2021 20:05:08 -0700
Message-Id: <20210331030520.3816265-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the kernel's build ID[1] to the stacktrace header printed
in oops messages, warnings, etc. and the build ID for any module that
appears in the stacktrace after the module name. The goal is to make the
stacktrace more self-contained and descriptive by including the relevant
build IDs in the kernel logs when something goes wrong. This can be used
by post processing tools like script/decode_stacktrace.sh and kernel
developers to easily locate the debug info associated with a kernel
crash and line up what line and file things started falling apart at.

To show how this can be used I've included a patch to
decode_stacktrace.sh that downloads the debuginfo from a debuginfod
server.

This also includes some patches to make the buildid.c file use more
const arguments and consolidate logic into buildid.c from kdump. These
are left to the end as they were mostly cleanup patches. I don't know
who exactly maintains this so I guess Andrew is the best option to merge
all this code.

Here's an example lkdtm stacktrace on arm64.

 WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
 CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc0134fbca0
 x29: ffffffc0134fbca0 x28: ffffff92d53ba240
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000000000000 x24: ffffffe3622352c0
 x23: 0000000000000020 x22: ffffffe362233366
 x21: ffffffe3622352e0 x20: ffffffc0134fbde0
 x19: 0000000000000008 x18: 0000000000000000
 x17: ffffff929b6536fc x16: 0000000000000000
 x15: 0000000000000000 x14: 0000000000000012
 x13: ffffffe380ed892c x12: ffffffe381d05068
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000001 x8 : ffffffe362237000
 x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000001
 x3 : 0000000000000008 x2 : ffffff93fef25a70
 x1 : ffffff93fef15788 x0 : ffffffe3622352e0
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
  direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace 3d95032303e59e68 ]---

Changes from v2 (https://lore.kernel.org/r/20210324020443.1815557-1-swboyd@chromium.org):
 * Renamed symbol printing function to indicate build IDness
 * Put build ID information behind Kconfig knob
 * Build ID for vmlinux is calculated in early init instead of on demand
 * printk format is %pS[R]b

Changes from v1 (https://lore.kernel.org/r/20210301174749.1269154-1-swboyd@chromium.org):
 * New printk format %pSb and %pSr
 * Return binary format instead of hex format string from build ID APIs
 * Some new patches to cleanup buildid/decode_stacktrace.sh
 * A new patch to decode_stacktrace.sh to parse output

[1] https://fedoraproject.org/wiki/Releases/FeatureBuildId

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <kexec@lists.infradead.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-doc@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <x86@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: peter enderborg <peter.enderborg@sony.com>

Stephen Boyd (12):
  buildid: Add API to parse build ID out of buffer
  buildid: Stash away kernels build ID on init
  dump_stack: Add vmlinux build ID to stack traces
  module: Add printk format to add module build ID to stacktraces
  arm64: stacktrace: Use %pSb for backtrace printing
  x86/dumpstack: Use %pSb for backtrace printing
  scripts/decode_stacktrace.sh: Support debuginfod
  scripts/decode_stacktrace.sh: Silence stderr messages from
    addr2line/nm
  scripts/decode_stacktrace.sh: Indicate 'auto' can be used for base
    path
  buildid: Mark some arguments const
  buildid: Fix kernel-doc notation
  kdump: Use vmlinux_build_id to simplify

 Documentation/core-api/printk-formats.rst |  9 +++
 arch/arm64/kernel/stacktrace.c            |  2 +-
 arch/x86/kernel/dumpstack.c               |  4 +-
 include/linux/buildid.h                   |  4 +
 include/linux/crash_core.h                |  6 +-
 include/linux/kallsyms.h                  | 13 +++-
 include/linux/module.h                    |  6 +-
 init/main.c                               |  1 +
 kernel/crash_core.c                       | 41 +----------
 kernel/kallsyms.c                         | 73 ++++++++++++++-----
 kernel/module.c                           | 24 +++++-
 lib/Kconfig.debug                         | 11 +++
 lib/buildid.c                             | 73 +++++++++++++++----
 lib/dump_stack.c                          | 12 ++-
 lib/vsprintf.c                            |  3 +
 scripts/decode_stacktrace.sh              | 89 +++++++++++++++++++----
 16 files changed, 267 insertions(+), 104 deletions(-)


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
https://chromeos.dev

