Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E46346F32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhCXCFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbhCXCEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231F6C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v8so7107218plz.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Shg+pgFuqhjKojct4aONdGKbwTLLBsXFzdCZNx164CE=;
        b=JAJr9yVLg1fiPzovDztNPVAmjhjuii4QZhY89wWXGVQRdUTMAsHxXgZgCCTSQEsHav
         G0WyP+V3chnrD9yN08cb8Lu6MID1kBkac6fStR9+EPVyV7jNX50aKP+v2D0fSd5QK7nm
         IE3ugOM1VPSXUyZJu2eHyC5n9JPexlosu09cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Shg+pgFuqhjKojct4aONdGKbwTLLBsXFzdCZNx164CE=;
        b=sPWIfkhPEm8dS3S1smtv2NkUSTwimxp+eszYS2qN2EAzqg3AOc1BnSunrgRphXSfd3
         NDXn9JeFQtjT/g9aqXuLq2s8yKZFiWKD2ZCepgn3UYjrNMnvtyQmUzTTucMfNlyCPULT
         ghBAbpoIX+zwGNRyFS2hlCPH2WwYS9K11NzOdeebUKEsU1Mh6y0S5Vk4yp4UuMSABhqo
         egHorXyRmAVkJ+ufV23fAcLLM8olSe55LE/BfRxyUapWAOrDX+v1KpiqwzhIxy1X4Cgz
         Qd5vMtUyShdw6BpqhvNwIY5fvsNqRJ8jFZQb8enE1mw97/4iZT79rz/vxL5h3RugN58I
         O2xQ==
X-Gm-Message-State: AOAM530d2Aq1dXS5RT4+fk0woV/p/fvSspDBRx4TDmVErKr88Z9Tcu6Z
        X3+9VGjns7qts3eQg82rGkWokA==
X-Google-Smtp-Source: ABdhPJw8dEnE2SAhUg10lugEgqBR+5D+RTT5DQxMWes32or039A/eCJK++QprrTJR/6Id5mfKJOW1A==
X-Received: by 2002:a17:90a:9f8c:: with SMTP id o12mr906781pjp.215.1616551486577;
        Tue, 23 Mar 2021 19:04:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:46 -0700 (PDT)
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
        x86@kernel.org
Subject: [PATCH v2 00/12] Add build ID to stacktraces
Date:   Tue, 23 Mar 2021 19:04:31 -0700
Message-Id: <20210324020443.1815557-1-swboyd@chromium.org>
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

Stephen Boyd (12):
  buildid: Add API to parse build ID out of buffer
  buildid: Add method to get running kernel's build ID
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
  kdump: Use vmlinux_build_id() to simplify

 Documentation/core-api/printk-formats.rst |  9 +++
 arch/arm64/kernel/stacktrace.c            |  2 +-
 arch/x86/kernel/dumpstack.c               |  4 +-
 include/linux/buildid.h                   |  3 +
 include/linux/crash_core.h                |  6 +-
 include/linux/kallsyms.h                  | 13 +++-
 include/linux/module.h                    |  6 +-
 kernel/crash_core.c                       | 41 +----------
 kernel/kallsyms.c                         | 73 ++++++++++++++-----
 kernel/module.c                           | 24 +++++-
 lib/buildid.c                             | 75 +++++++++++++++----
 lib/dump_stack.c                          |  5 +-
 lib/vsprintf.c                            |  6 +-
 scripts/decode_stacktrace.sh              | 89 +++++++++++++++++++----
 14 files changed, 251 insertions(+), 105 deletions(-)


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
https://chromeos.dev

