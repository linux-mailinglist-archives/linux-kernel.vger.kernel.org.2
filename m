Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB40D394B11
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhE2ISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhE2IS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD5C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i5so4356094pgm.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUrOP0WIocj59m22tS9ZNky+Mdhqy6xTmlTN4QR6iMw=;
        b=IIGYNq4UBx9wJ6pE4E1sJVHPHpHBkMR6wSRDhdhvExpQW2DgnNnxoOkfKXBaTzG2v3
         eaEgWGKfr8Zp6mnJ8GNGMEiCrBS93YzK4AB9dgxTpuiSLpnNZck84Wo8DUJbZyigDMmG
         A2wjjqHx3xw/zEbFGVQCekcP35jKqDU6+vFMc2Y67hqdoqkYhIQksIwXYq527eVbiAqS
         scShJ9jfHtk1vMIaE+4eTywACbJxvjqw2MLCYQc+13OPGNhb9dyCoiKZO53zWeanve50
         fVX0TaOf+6EBv7Usv1AmVdVbTtS3cDNqrv6NbuOqqR1V981mqLjKaSDsj2vN4Rs9yqHA
         RSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUrOP0WIocj59m22tS9ZNky+Mdhqy6xTmlTN4QR6iMw=;
        b=uieSxqWvk2aMI9svZsK0CQhIcOr6A4WbzHHVGFDaimTLHQV0ersaYHL/p2YBjZTB0g
         Kdes0dWMGR5irnhb+uztSQvw69e2EKggxM9gsa/pKDj849ok/8/3pKYoSCn5Gj7spwZf
         F02/qvfMTPoZuhO4v6yV0OQbcG4ACbgr37j9QRG92PlZiHmIANQ8Zs6CyffEmUaSLj50
         As/3b9b/we50P0RmgtlV0pNvyhJjIRGxB0EUauVtIygVcu73t0rXkjymrHAmeKj/oIfI
         Elic7RvokolozAIM67KvpFnEH+xv7sEclsuMwrYhfOE0x0eX+Cv9uk8bbcBqkxQSsrPL
         I+/Q==
X-Gm-Message-State: AOAM5336DB208rSTipUBzfGlhot8ESUMRDq9IhRlrVHHRuiNbwxLkNQg
        Yg4SgjDn43qGzHapD61IykfadKxcb7RRTNXi
X-Google-Smtp-Source: ABdhPJzJQXE9qn2bh8eshCgngO3Txr10wGBl1RUKBlJFaM4D2NPFDNw90iFbSFnb+j1w1lCsyIOT4g==
X-Received: by 2002:a63:e709:: with SMTP id b9mr12953505pgi.18.1622276210816;
        Sat, 29 May 2021 01:16:50 -0700 (PDT)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id b12sm6613960pgs.52.2021.05.29.01.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:16:50 -0700 (PDT)
From:   houdek.ryan@fex-emu.org
X-Google-Original-From: Houdek.Ryan@fex-emu.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>
Subject: [PATCH 1/4] Move userspace syscall dispatch outside of common entry
Date:   Sat, 29 May 2021 01:16:17 -0700
Message-Id: <20210529081620.164422-2-Houdek.Ryan@fex-emu.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
References: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Houdek.Ryan@fex-emu.org>

This will allow other architectures to support userspace syscall
dispatch without supporting the syscall common entry.

Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/Kconfig                          | 4 ++++
 include/linux/syscall_user_dispatch.h | 4 +++-
 kernel/entry/Makefile                 | 3 ++-
 kernel/entry/common.c                 | 3 +--
 kernel/entry/common.h                 | 7 -------
 kernel/entry/syscall_user_dispatch.c  | 2 --
 6 files changed, 10 insertions(+), 13 deletions(-)
 delete mode 100644 kernel/entry/common.h

diff --git a/arch/Kconfig b/arch/Kconfig
index c45b770d3579..def67ebbae83 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -30,7 +30,11 @@ config SET_FS
 config HOTPLUG_SMT
 	bool
 
+config SYSCALL_USER_DISPATCH
+       bool
+
 config GENERIC_ENTRY
+       select SYSCALL_USER_DISPATCH
        bool
 
 config KPROBES
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..9d1e244d7021 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -7,7 +7,7 @@
 
 #include <linux/thread_info.h>
 
-#ifdef CONFIG_GENERIC_ENTRY
+#ifdef CONFIG_SYSCALL_USER_DISPATCH
 
 struct syscall_user_dispatch {
 	char __user	*selector;
@@ -16,6 +16,8 @@ struct syscall_user_dispatch {
 	bool		on_dispatch;
 };
 
+bool syscall_user_dispatch(struct pt_regs *regs);
+
 int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 			      unsigned long len, char __user *selector);
 
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 095c775e001e..35684390d56e 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -9,5 +9,6 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o syscall_user_dispatch.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_SYSCALL_USER_DISPATCH)	+= syscall_user_dispatch.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a0b3b04fb596..84ea1e66e0b2 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,8 +5,7 @@
 #include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
-
-#include "common.h"
+#include <linux/syscall_user_dispatch.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
deleted file mode 100644
index f6e6d02f07fe..000000000000
--- a/kernel/entry/common.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _COMMON_H
-#define _COMMON_H
-
-bool syscall_user_dispatch(struct pt_regs *regs);
-
-#endif
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index c240302f56e2..352da8427b01 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -14,8 +14,6 @@
 
 #include <asm/syscall.h>
 
-#include "common.h"
-
 static void trigger_sigsys(struct pt_regs *regs)
 {
 	struct kernel_siginfo info;
-- 
2.30.2

