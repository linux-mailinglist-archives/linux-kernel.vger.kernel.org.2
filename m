Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2D3C92FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhGNVYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhGNVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:24:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855AC061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:21:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so5079667edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8/bc9o6ImRq3WEIe9Pdfc2k5usBIjCoRIS0Uvdw4IE8=;
        b=OB5guEjh4blJ03UGIxA5YrZ1GM+4ucO9v42uHL04xI0hmlnYvupb69rBZ94lGhwaLN
         GzwP1+g/7AWLfBlPBY7GLfcTq3niHbf0x9Vfb/nqmhnrZpvcXnqgZu72lWFXXuVVjdqk
         PqIcgOrpOVJyVAiEoGqqT1ls7z+iKiH+w8OAcSf+K5pIXrPLh4vOy1FhxnK9BK448+ca
         fG2QZnBB2U1UB+wT/0HgoNhd6+77abZoWHUYfQc7AO0T4rBH3FptbiI34yHwrhJb5WE+
         3efM2lLRLBzeRKSaDhFCypq6vX2SY0PkcN43tnXQw9EPagnjuUNvIdowyfQeDZQiahSn
         iEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8/bc9o6ImRq3WEIe9Pdfc2k5usBIjCoRIS0Uvdw4IE8=;
        b=itjY2siX1l/1Yu7zHwX01u6tSkRcPRMrFhIjZONtTbUQreqp6pPp08RhsJrSS4gtxq
         gZUhgvM6VYYn3uh3uRCmKw3QQSaMqnj0An0uqAUYfzM9Cn5dK9w3oWdVv3SA0Ya85QiK
         JDT9pJkJBuMZiuKzt8pgSifOKV5i8dxQavMzaeUPcG2hh1HmhjMi7HLCk6gViKzuMvlG
         +gR+2hqRiELIxVhytm/PNPEkzFkgmF9t3vEYf3GfkHNDKvzyWCWnpPCkp4yAGtPup3rr
         WJM45hYwRYvPWzaXiF/kDXRi2tEJ7zOKvel0nj7GIPdtMKD87JaZtAxRGLJySwwvdV4b
         JQZA==
X-Gm-Message-State: AOAM532mCDptRKkIRFdpG5qJ7yQ1Upi3DsuTLC4+rmlsOCuJGZ8W2M3a
        HxyX+HUq2FT06Vj29mS/oA==
X-Google-Smtp-Source: ABdhPJzxDcNA1vDLPluaKS09JMmHXY1TArRbW7zFH5yNLFMmeI+/XmglxvkN6FU0FGGrUjjc/wmHFw==
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr505002edu.26.1626297711114;
        Wed, 14 Jul 2021 14:21:51 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.76])
        by smtp.gmail.com with ESMTPSA id c28sm1171664ejc.102.2021.07.14.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:21:50 -0700 (PDT)
Date:   Thu, 15 Jul 2021 00:21:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched: mark do_group_exit() as noreturn
Message-ID: <YO9VbRoMnaOgqGbu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_group_exit() calls do_exit() which doesn't return.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/sched/task.h |    2 +-
 kernel/exit.c              |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -77,7 +77,7 @@ static inline void exit_thread(struct task_struct *tsk)
 {
 }
 #endif
-extern void do_group_exit(int);
+__noreturn void do_group_exit(int);
 
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -895,8 +895,8 @@ SYSCALL_DEFINE1(exit, int, error_code)
  * Take down every thread in the group.  This is called by fatal signals
  * as well as by sys_exit_group (below).
  */
-void
-do_group_exit(int exit_code)
+__noreturn
+void do_group_exit(int exit_code)
 {
 	struct signal_struct *sig = current->signal;
 
