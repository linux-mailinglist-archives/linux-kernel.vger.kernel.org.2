Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA645CBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbhKXSIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:08:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350102AbhKXSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931A96104F;
        Wed, 24 Nov 2021 18:03:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcB-0027uu-NR;
        Wed, 24 Nov 2021 13:03:27 -0500
Message-ID: <20211124180327.553861475@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 08/13] locking: Drop might_resched() from might_sleep_no_state_check()
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

might_sleep_no_state_check() serves the same purpose as might_sleep()
except it is used before sleeping locks are acquired and therefore does
not check task_struct::state because the state is preserved.

That state is preserved in the locking slow path so we must not schedule
at the begin of the locking function because the state will be lost and
not preserved at that time.

Remove might_resched() from might_sleep_no_state_check() to avoid losing the
state before it is preserved.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2cff7554395d..6eb0ab994f4c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -222,7 +222,7 @@ extern void __cant_migrate(const char *file, int line);
 	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
 
 # define might_sleep_no_state_check() \
-	do { ___might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { ___might_sleep(__FILE__, __LINE__, 0); } while (0)
 
 /**
  * cant_sleep - annotation for functions that cannot sleep
-- 
2.33.0
