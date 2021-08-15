Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B389C3ECB5C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhHOVdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbhHOV3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39BDC061292
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:29:11 -0700 (PDT)
Message-ID: <20210815211305.362730187@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9snN8xer+lJKJI12sG/6cncJ9Ea2JsEyaBt7/r26lmo=;
        b=20GuA7JKHjANPm/MKPqVcHnGb1qb24o2kjMcxiGmg4mPQ0V6Z9nH+zO+C46uNQ/P7I9Oa9
        3boVWYgYodN+FtgMdUiebxM6TfHPqzC690oKJxgDP25HojifFZfIa7VA6P19dAeybQuxmq
        Z05aTebtdO4pQ9Cd6yv7ps235TK9GTztP01tB9O0QydxTfESvouhH5F3Qno0E05m3s1Rxn
        7uNpm59WqfI+UJqr2hKpSjCanL/kBwC10AviyMPifIaP4VG9YqWc6BMT+pOwXtzpuXGM9p
        DuSBJed7M/xO3tslrmCfmXu4/aiZtAp5e5/ZCMiRK8v5sk1SohzL8fcam0MiXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9snN8xer+lJKJI12sG/6cncJ9Ea2JsEyaBt7/r26lmo=;
        b=U/PdtjmIiEbDXAJ6rPdCS8OV7Enl3vUNpCkSS1/0EDELVU/u15slA7TVjGmAb+Kemzngs0
        vlF/+a+QJukCcwDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 60/72] futex: Remove bogus condition for requeue PI
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:09 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For requeue PI it's required to establish PI state for the PI futex to
which waiters are requeued. This either acquires the user space futex on
behalf of the top most waiter on the inner 'waitqueue' futex or attaches to
the PI state of an existing waiter or creates on attached to the owner of
the futex.

This code can retry in case of failure, but retry can never happen when the
pi state was successfully created. The condition to run this code is:

  (task_count - nr_wake) < nr_requeue

which is always true because:

   task_count = 0
   nr_wake = 1
   nr_requeue >= 0

Remove it all together.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 kernel/futex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2000,7 +2000,7 @@ static int futex_requeue(u32 __user *uad
 		}
 	}
 
-	if (requeue_pi && (task_count - nr_wake < nr_requeue)) {
+	if (requeue_pi) {
 		struct task_struct *exiting = NULL;
 
 		/*

