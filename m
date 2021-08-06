Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35D93E31E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbhHFWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244037AbhHFWsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:48:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C42161167;
        Fri,  6 Aug 2021 22:47:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mC8d5-003GzI-9D; Fri, 06 Aug 2021 18:47:51 -0400
Message-ID: <20210806224751.111394551@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Aug 2021 18:47:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Chao Qin <chao.qin@intel.com>, Lili Li <lili.li@intel.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH RT 1/2] printk: Enhance the condition check of msleep in pr_flush()
References: <20210806224723.958744677@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.56-rt49-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Chao Qin <chao.qin@intel.com>

[ Upstream commit 83e9288d9c4295d1195e9d780fcbc42c72ba4a83 ]

There is msleep in pr_flush(). If call WARN() in the early boot
stage such as in early_initcall, pr_flush() will run into msleep
when process scheduler is not ready yet. And then the system will
sleep forever.

Before the system_state is SYSTEM_RUNNING, make sure DO NOT sleep
in pr_flush().

Fixes: c0b395bd0fe3("printk: add pr_flush()")
Signed-off-by: Chao Qin <chao.qin@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20210719022649.3444072-1-chao.qin@intel.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/printk/printk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f56fd2e34cc7..53d90278494b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3545,7 +3545,9 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 	u64 diff;
 	u64 seq;
 
-	may_sleep = (preemptible() && !in_softirq());
+	may_sleep = (preemptible() &&
+		     !in_softirq() &&
+		     system_state >= SYSTEM_RUNNING);
 
 	seq = prb_next_seq(prb);
 
-- 
2.30.2
