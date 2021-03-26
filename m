Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4554E34ABEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCZPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhCZPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:52:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A1C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:07 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d10so5410309ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWockdchS3a6xMrRD9YKnwNe5zKy6c1daS8+Rygs/lk=;
        b=XLQmazPLSIb9A4I0635PmtqGMQbnRr09ORmcybh+A9uGUq0VPeTwCy6jn5ixA6nLed
         PZoW14GS7h0TJWxD0tu39NvaBiE3RZbZ5psiOyzTfGmEL/p7T0IKc+U8GRCL/W/oR3IF
         gF2tot9WXgA++i2bT4kAF44KxYXIx0XP0lofcA1RKpyYeXzud4RAdZN0K6K7yrfiRbP0
         wq1J6bEBOm43Qito+DKWgDQyRb59MVES59NXIELPUtGfz6iH3xAE9gX/rGxp6aeLUem6
         CKe8jkzabkUT5TwXslp94cGawy0uVXNDVNUMU2wehw6MzhW36NtO8KxbyCBy76r14Q8g
         LcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWockdchS3a6xMrRD9YKnwNe5zKy6c1daS8+Rygs/lk=;
        b=g4VgPUw4M2PcuOtghN5mWjPAmZuifK0pbtTGR6mqOOorcqoTgzy+gUMem5CfvjMcDk
         wPpALDGIA8Kl6Pr5DtVkpQRQrmMIQpn6PdvefTqKwGzPA2jMr51xxa20YPlNkLjMWs1x
         zfYVgvy6AYuM9M+yljFt+HJL5zuYJcGw3XDuwZGfZ9+xo6zgnMicjBOhQuggd2qBAtlr
         oXKdSmaWLiFk20uouHnHwUwHAAJQaRqm845QTzg9UY8hliLC6wzdgK5JwZklsdxR1WqM
         O4oTAvDvVgkvdXUch+M6kPFwuxroYrwlKBO5dJEkFCL5/x/74po3x7M4UbC4+p1mlz46
         y1LQ==
X-Gm-Message-State: AOAM532M9AGoZVcyHqinmj+eT9Bmvz5thKbPHOzYv4bmKkxEqfg8h8Ob
        OemgI3JvEXD8+y+bvCOGfG8gsF9wMiRSaA==
X-Google-Smtp-Source: ABdhPJwZCT0+zs6TUK7b3YTT1LKTP4iuoK5r6PcgPUkJ/Cr1PTJvX1Pp8cjYWiiG99j+rx7XNsuNXA==
X-Received: by 2002:a05:6e02:1183:: with SMTP id y3mr9573639ili.147.1616773927126;
        Fri, 26 Mar 2021 08:52:07 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm4456337ilj.64.2021.03.26.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:52:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/10] Revert "kernel: treat PF_IO_WORKER like PF_KTHREAD for ptrace/signals"
Date:   Fri, 26 Mar 2021 09:51:18 -0600
Message-Id: <20210326155128.1057078-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
References: <20210326155128.1057078-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6fb8f43cede0e4bd3ead847de78d531424a96be9.

The IO threads do allow signals now, including SIGSTOP, and we can allow
ptrace attach. Attaching won't reveal anything interesting for the IO
threads, but it will allow eg gdb to attach to a task with io_urings
and IO threads without complaining. And once attached, it will allow
the usual introspection into regular threads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/ptrace.c | 2 +-
 kernel/signal.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 821cf1723814..61db50f7ca86 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -375,7 +375,7 @@ static int ptrace_attach(struct task_struct *task, long request,
 	audit_ptrace(task);
 
 	retval = -EPERM;
-	if (unlikely(task->flags & (PF_KTHREAD | PF_IO_WORKER)))
+	if (unlikely(task->flags & PF_KTHREAD))
 		goto out;
 	if (same_thread_group(task, current))
 		goto out;
diff --git a/kernel/signal.c b/kernel/signal.c
index af890479921a..76d85830d4fa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -91,7 +91,7 @@ static bool sig_task_ignored(struct task_struct *t, int sig, bool force)
 		return true;
 
 	/* Only allow kernel generated signals to this kthread */
-	if (unlikely((t->flags & (PF_KTHREAD | PF_IO_WORKER)) &&
+	if (unlikely((t->flags & PF_KTHREAD) &&
 		     (handler == SIG_KTHREAD_KERNEL) && !force))
 		return true;
 
@@ -1097,7 +1097,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	/*
 	 * Skip useless siginfo allocation for SIGKILL and kernel threads.
 	 */
-	if ((sig == SIGKILL) || (t->flags & (PF_KTHREAD | PF_IO_WORKER)))
+	if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.31.0

