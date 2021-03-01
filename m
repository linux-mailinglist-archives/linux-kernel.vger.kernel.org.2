Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADF3297C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbhCAWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbhCARtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8DC0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so27118pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3Lzi2uN/Y9F/XcvNTQPp0C3tT032B+1lln6fkGmxQM=;
        b=W6Y3xeLEBEydaudB2OKXdlRNkLkCmUgOSSaspm8H1hRvaOqBKzWqjGHnGL8h21eDor
         1+nzgqgsPmXt6thWpsj1DvCRf2Fvb2KINTGcPzZM1KApedY2Dxed/XS3byNczNPrDRNk
         UTFi2KeqBDJGV7iauQ0xLPRQWYFCRZu2dAomE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3Lzi2uN/Y9F/XcvNTQPp0C3tT032B+1lln6fkGmxQM=;
        b=Vz+0mIsaZRghtESvPvNepOqRHTInsMB+5aJjQAqFK/d7QB0xBflA+ce3h0e27NkQdb
         lGQRfmljTmNHVMefAlIYPzhZx3KEF1wss7k7T2j3y/ycu9YS0hR0MoheOrgkJWjKe87I
         Qn5ELa7AxijvieYJuY05wEz4f4TXtZo33zrlyatQorD9SB1ODbQLHqj6vXV2loWV9i1I
         th0OiZUn2qdtFSuySA7Wd99e/HPN3PE6Jwb578DcBGJ7RA6YDGqFGv50sOgAFZ3HDJW/
         IDdJLq3jmrRJrgd4Z3r3GvI+Kg2jLTqxiaLaZjeUVJ1foR16+KghwYKu5BzeNT9cQcPy
         eIoA==
X-Gm-Message-State: AOAM530isBHivaM6mVhQDx08xrEKb7z8QciMFiEgQuTbDPgqgDvLexna
        WCk9GjR7uEQtXEDGhO3hhs1kiA==
X-Google-Smtp-Source: ABdhPJzwFouF0rR1bCQLTwJzasePHVhOOCTepYinWvJ45raB0eARzkIWO56P0a8cra6XYVFiUl4zdw==
X-Received: by 2002:a17:902:bd0a:b029:e0:612:ad38 with SMTP id p10-20020a170902bd0ab02900e00612ad38mr17389147pls.30.1614620872137;
        Mon, 01 Mar 2021 09:47:52 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/7] Add build ID to stacktraces
Date:   Mon,  1 Mar 2021 09:47:42 -0800
Message-Id: <20210301174749.1269154-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the kernel's build ID to the stacktrace header printed
in oops messages, warnings, etc. and the build ID for any module that
appears in the stacktrace after the module name. The goal is to make the
stacktrace more self-contained and descriptive by including the relevant
build IDs in the kernel logs when something goes wrong. This can be used
by post processing tools like script/decode_stacktrace.sh and kernel
developers to easily locate the debug info associated with a kernel
crash and line up what line and file things started falling apart at.

This also includes a patch to make the buildid.c file use more const
arguments and consolidate logic into buildid.c from kdump. These are
left to the end as they were mostly cleanup patches. I don't know who
exactly maintains this so I guess Andrew is the best option to merge all
this code.

Here's an example lkdtm stacktrace

 WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
 CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 lr : lkdtm_do_action+0x24/0x40 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
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
  lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
  direct_entry+0x16c/0x1b4 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
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

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <kexec@lists.infradead.org>
Cc: <linux-doc@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vivek Goyal <vgoyal@redhat.com>

Stephen Boyd (7):
  buildid: Add method to get running kernel's build ID
  dump_stack: Add vmlinux build ID to stack traces
  buildid: Add API to parse build ID out of buffer
  module: Parse and stash build ID on insertion
  printk: Make %pS and friends print module build ID
  buildid: Mark some arguments const
  kdump: Use vmlinux_build_id() to simplify

 Documentation/core-api/printk-formats.rst |  6 ++
 include/linux/buildid.h                   |  4 +
 include/linux/kallsyms.h                  |  6 +-
 include/linux/module.h                    |  6 +-
 kernel/crash_core.c                       | 46 ++----------
 kernel/kallsyms.c                         | 45 ++++++++----
 kernel/module.c                           | 24 +++++-
 lib/buildid.c                             | 89 +++++++++++++++++++----
 lib/dump_stack.c                          |  5 +-
 9 files changed, 157 insertions(+), 74 deletions(-)


base-commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
-- 
https://chromeos.dev

