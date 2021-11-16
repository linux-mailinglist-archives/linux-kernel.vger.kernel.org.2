Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E08451C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbhKPAQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:16:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353457AbhKOXg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:36:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8127B6323A;
        Mon, 15 Nov 2021 23:34:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mmlUA-000otV-Km;
        Mon, 15 Nov 2021 18:34:02 -0500
Message-ID: <20211115233402.465081217@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Nov 2021 18:33:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Subject: [PATCH RT 4/9] preempt: Move preempt_enable_no_resched() to the RT block
References: <20211115233339.509057092@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.78-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

preempt_enable_no_resched() should point to preempt_enable() on
PREEMPT_RT so nobody is playing any preempt tricks and enables
preemption without checking for the need-resched flag.

This was misplaced in v3.14.0-rt1 und remained unnoticed until now.

Point preempt_enable_no_resched() and preempt_enable() on RT.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/preempt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index af39859f02ee..7b5b2ed55531 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -208,12 +208,12 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 # define preempt_enable_no_resched() sched_preempt_enable_no_resched()
-# define preempt_check_resched_rt() preempt_check_resched()
+# define preempt_check_resched_rt() barrier();
 #else
 # define preempt_enable_no_resched() preempt_enable()
-# define preempt_check_resched_rt() barrier();
+# define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
-- 
2.33.0
