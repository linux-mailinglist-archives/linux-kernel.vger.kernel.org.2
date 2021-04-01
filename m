Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7294A350EA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhDAGAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:00:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64819 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhDAF7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:59:33 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1315wVec071555;
        Thu, 1 Apr 2021 14:58:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Thu, 01 Apr 2021 14:58:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1315wRvm071431
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Apr 2021 14:58:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] kernel: initialize cpumask before parsing
Date:   Thu,  1 Apr 2021 14:58:23 +0900
Message-Id: <20210401055823.3929-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN complains that new_value at cpumask_parse_user() from
write_irq_affinity() from irq_affinity_proc_write() is uninitialized.

  [  148.133411][ T5509] =====================================================
  [  148.135383][ T5509] BUG: KMSAN: uninit-value in find_next_bit+0x325/0x340
  [  148.137819][ T5509]
  [  148.138448][ T5509] Local variable ----new_value.i@irq_affinity_proc_write created at:
  [  148.140768][ T5509]  irq_affinity_proc_write+0xc3/0x3d0
  [  148.142298][ T5509]  irq_affinity_proc_write+0xc3/0x3d0
  [  148.143823][ T5509] =====================================================

Since bitmap_parse() from cpumask_parse_user() calls find_next_bit(),
any alloc_cpumask_var() + cpumask_parse_user() sequence has possibility
that find_next_bit() accesses uninitialized cpu mask variable. Fix this
problem by replacing alloc_cpumask_var() with zalloc_cpumask_var().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/irq/proc.c    | 4 ++--
 kernel/profile.c     | 2 +-
 kernel/trace/trace.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 98138788cb04..7c5cd42df3b9 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -144,7 +144,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
 		return -EIO;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	if (type)
@@ -238,7 +238,7 @@ static ssize_t default_affinity_write(struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(buffer, count, new_value);
diff --git a/kernel/profile.c b/kernel/profile.c
index 6f69a4195d56..c2ebddb5e974 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -430,7 +430,7 @@ static ssize_t prof_cpu_mask_proc_write(struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(buffer, count, new_value);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eccb4e1187cc..7607dc8a20b2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4827,7 +4827,7 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
-	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
-- 
2.18.4

