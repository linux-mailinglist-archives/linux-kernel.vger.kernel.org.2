Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409033FF9A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhICEmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhICEmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:42:21 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4EC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 21:41:21 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ew6so2523772qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 21:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g6lstUz77p17jT66uK6+TEtSuPCVXfhN3mEjiZ91RTM=;
        b=PkGRhsTp6wud1ij0f7Frs7QW7mxnY8hNRn7DF70w3m/7O+wW+5tpFwtuwVpkNyTkFL
         tEbslYqhMetYxIkIBBNYUl95EZL1RS9du5t3ugyCOEFqV/qXsx6LBl7SGK14FYIV4wPJ
         HUgXMLvb8RKtxucZRXYVE/DLJctuaJjtgb/40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g6lstUz77p17jT66uK6+TEtSuPCVXfhN3mEjiZ91RTM=;
        b=VALKCNkZM9LwQ8TntMndEh19w77kNqHaqEJf3+u52wCwtzKMSJf5KsdQwt+8XmM0pV
         8H0f+pQGUPQh+RKFPv6ugw9Ek7Jn2uUje2vdQXcbBn3pLxKLZXC2+VOsiUizQjQe/ZpA
         qplvlYq+rgQ703SJZ3r4Sy6lqeeHTMo1qh2U7WT7/VwMVll+F5yBWDbhjXSteqM+MErV
         4MSndP+WyJxSgvotG6OUWJ7yKB6kGTBUiT5x2udPK3KraMgvUSE1UAyIrLTD3F2Sy+b0
         J2qiIT+qL5PzGAkHeYQuDj/6H+9J2V61VM0LBkTvxSnf5K37N0zJDX4JXiA/dJ/FD2z1
         UzbQ==
X-Gm-Message-State: AOAM532PUPQIMU4IGk7A8aDMXSBQVIV3npIu3HqzZ9U+6ihkvUjyNylu
        IDuYb5PpcJfCyrL4w2cGO+Tpd5+wLtCjivOKSLCpGeRwHFc5CssAh0xjdKRngOHXaxmwQdoL5Et
        4bBc3AmV9w1zUDuAMgn7J7AGxF7Trh8NUCzRl1NlSWYSuF9Vm7idT6Mz1kBkNho18f+d0jmfnzb
        IB
X-Google-Smtp-Source: ABdhPJyLudYAD+pADbCmKxpSlwND1dKzcs1KsK+iMC9Dlez4WO56cBNNY8TWCtauF9FQTBdke3JZZg==
X-Received: by 2002:ad4:5b8b:: with SMTP id 11mr1889265qvp.51.1630644080660;
        Thu, 02 Sep 2021 21:41:20 -0700 (PDT)
Received: from bunsen12.telenet.unc.edu (bunsen12.telenet.unc.edu. [204.85.191.56])
        by smtp.gmail.com with ESMTPSA id y185sm3084759qkb.36.2021.09.02.21.41.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 21:41:20 -0700 (PDT)
From:   Sagar Patel <sagarmp@cs.unc.edu>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, Sagar Patel <sagarmp@cs.unc.edu>
Subject: [PATCH] x86: remove unneeded personality.h includes
Date:   Fri,  3 Sep 2021 00:40:46 -0400
Message-Id: <1630644046-8853-1-git-send-email-sagarmp@cs.unc.edu>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sagar Patel <sagarmp@cs.unc.edu>
---
 arch/x86/ia32/ia32_signal.c  | 1 -
 arch/x86/kernel/process_32.c | 1 -
 arch/x86/kernel/signal.c     | 1 -
 arch/x86/kernel/sys_ia32.c   | 1 -
 arch/x86/kernel/sys_x86_64.c | 1 -
 arch/x86/um/signal.c         | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7..9b424a6 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -18,7 +18,6 @@
 #include <linux/wait.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/personality.h>
 #include <linux/compat.h>
 #include <linux/binfmts.h>
 #include <linux/syscalls.h>
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e..1868b19 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -30,7 +30,6 @@
 #include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
-#include <linux/personality.h>
 #include <linux/percpu.h>
 #include <linux/prctl.h>
 #include <linux/ftrace.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4d21e47..1968dee 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -20,7 +20,6 @@
 #include <linux/tracehook.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/personality.h>
 #include <linux/uaccess.h>
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
index 6cf6539..5478c5c 100644
--- a/arch/x86/kernel/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -32,7 +32,6 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/poll.h>
-#include <linux/personality.h>
 #include <linux/stat.h>
 #include <linux/rwsem.h>
 #include <linux/compat.h>
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 660b788..76c62f8 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -14,7 +14,6 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
-#include <linux/personality.h>
 #include <linux/random.h>
 #include <linux/uaccess.h>
 #include <linux/elf.h>
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 7c11c9e..8ff849f 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -5,7 +5,6 @@
  */
 
 
-#include <linux/personality.h>
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
 #include <asm/unistd.h>
-- 
2.7.4

