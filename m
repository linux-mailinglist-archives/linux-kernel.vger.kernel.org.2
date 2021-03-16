Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D00E33D30C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhCPL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhCPL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:29:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47955C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:29:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso1184508pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUcTdx81W1KLpMS8T4uNsDFl+EMfDfowzQ+Q5f4l7Pw=;
        b=NSHQgtFIadXmxGZ6BYHfAzyJW8BT7MXVxKQiIxru5DJje0exEUyr4vPkTBYdxgT9id
         1R4cZLcz7FmzWO1SVD5+VuZ/ulsQIgfUPzIZyFs6wIX0V0o/p/2IGABfAFnZfA9uwXk/
         AmbGcSxtPCCkGczUI9vxyNRmDncCSz4yY/coUQgPDKmZngbYcuAQU26mg/aJMGWUmkvN
         CAHXHUepdU/ZF5MtLvCM6j6SVu8kNtPr9WWAo52moRKA2DHSyB7QJ5+uxgbdFLm6LR8w
         9mUDpmai7GIVfZKOxZ89D43icniYWxRVmeFERNyLP2sQGnxKFnMmDPa1uoDDIlMryBo2
         kcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUcTdx81W1KLpMS8T4uNsDFl+EMfDfowzQ+Q5f4l7Pw=;
        b=tvgxWLZ730DEVmPZ52ihPc0K7jzJMGzWN0vCVzUg6qu3IQ6mWxiaE95G3Hxa2hxtYs
         oGcUgste/C4ZK1bOEnyX+X96Fian8W5Bb4ALfd/ScT2pnxN7g4cF2ZVEwe8x/MIZEwVU
         GtTgK97VI8QtylcLpisgVfHYR2DHAE67kxGxWR51M5Kfd9Y2Rzo63msgh5UP2XY74JAP
         ms9l4UVbDl734XbXoX8OnlIEggll9bSRYIo3DxC3m95D1LM2S+Lf1A+1p7KRfd+mfHQE
         yHormy1U6+dYGqcJ8+m+daE/hsz4A1egc0klqF7oCWnonssIDFX8Nv1sSjM+86nhSZEe
         tJpw==
X-Gm-Message-State: AOAM531tqSuGf2t1Fpy0/P0Rnq+WYscsNseNUyGtrDFqtguB1guve4fL
        k3A1IalTq1fF4nisoJh20Uk=
X-Google-Smtp-Source: ABdhPJxEPHq1A333fqqHyx0j1UvXW9tKnzkFp0GFyS9guQh+lSMPLtqhU2C9T4d40JDuXYHtzU1jTg==
X-Received: by 2002:a17:90a:7e8b:: with SMTP id j11mr4454511pjl.11.1615894146665;
        Tue, 16 Mar 2021 04:29:06 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 22sm2762569pjl.31.2021.03.16.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 04:29:06 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org
Cc:     walken@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] kernel:sys: Fix typo issue
Date:   Tue, 16 Mar 2021 19:29:04 +0800
Message-Id: <20210316112904.10661-1-cxfcosmos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofeng Cao <caoxiaofeng@yulong.com>

change 'infite'     to 'infinite'
change 'concurent'  to 'concurrent'
change 'memvers'    to 'members'
change 'decendants' to 'descendants'
change 'argumets'   to 'arguments'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 kernel/sys.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 2e2e3f378d97..ecc2f2efc31b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1584,7 +1584,7 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 
 	/*
 	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
-	 * infite. In case of RLIM_INFINITY the posix CPU timer code
+	 * infinite. In case of RLIM_INFINITY the posix CPU timer code
 	 * ignores the rlimit.
 	 */
 	 if (!retval && new_rlim && resource == RLIMIT_CPU &&
@@ -2023,7 +2023,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	}
 
 	/*
-	 * arg_lock protects concurent updates but we still need mmap_lock for
+	 * arg_lock protects concurrent updates but we still need mmap_lock for
 	 * read to exclude races with sys_brk.
 	 */
 	mmap_read_lock(mm);
@@ -2035,7 +2035,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	 * output in procfs mostly, except
 	 *
 	 *  - @start_brk/@brk which are used in do_brk_flags but kernel lookups
-	 *    for VMAs when updating these memvers so anything wrong written
+	 *    for VMAs when updating these members so anything wrong written
 	 *    here cause kernel to swear at userspace program but won't lead
 	 *    to any problem in kernel itself
 	 */
@@ -2137,7 +2137,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
 	error = -EINVAL;
 
 	/*
-	 * arg_lock protects concurent updates of arg boundaries, we need
+	 * arg_lock protects concurrent updates of arg boundaries, we need
 	 * mmap_lock for a) concurrent sys_brk, b) finding VMA for addr
 	 * validation.
 	 */
@@ -2204,7 +2204,7 @@ static int prctl_set_mm(int opt, unsigned long addr,
 	 * If command line arguments and environment
 	 * are placed somewhere else on stack, we can
 	 * set them up here, ARG_START/END to setup
-	 * command line argumets and ENV_START/END
+	 * command line arguments and ENV_START/END
 	 * for environment.
 	 */
 	case PR_SET_MM_START_STACK:
@@ -2252,8 +2252,8 @@ static int prctl_get_tid_address(struct task_struct *me, int __user * __user *ti
 static int propagate_has_child_subreaper(struct task_struct *p, void *data)
 {
 	/*
-	 * If task has has_child_subreaper - all its decendants
-	 * already have these flag too and new decendants will
+	 * If task has has_child_subreaper - all its descendants
+	 * already have these flag too and new descendants will
 	 * inherit it on fork, skip them.
 	 *
 	 * If we've found child_reaper - skip descendants in
-- 
2.25.1

