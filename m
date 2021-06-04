Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38D439B7F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFDLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhFDLeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFFE16142D;
        Fri,  4 Jun 2021 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806336;
        bh=/PIiltEyNMBNXT8yeoBzndiKGXomcSozlO2Zttror6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ue0JD7jS90ayhLNBJQZiKD1yBtSVzpjZtp+pkQNImbrdrkQ+543h4ZU4oXe8GAhzJ
         RexMiuSiLG4rLVtR7JAg1XVsMd6VmAwgbfpRGmLmF9ZyDMWCP/jdEASf/JYoBhNqwM
         ojanR3zjQ6tm5Pphoeadv4tlfUFHrs1SF++J8cxrl/e35ppwIkFnWTIZH/gnDqTryQ
         XUm/6QFRRbAHYh5dnC93SyrG/GCLrSwSPQm8nRsLUNlUzJgEa6R23J3LsaaOf5olmB
         zNzdkIPrquEKJ1BsswDIq2Rhi1iXYhbMGTYP4/FluJcp+xSYII8XGvUAHLajOEVBJ4
         9NmWnQ34hCH4w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/6] posix-cpu-timers: Force next expiration recalc after itimer reset
Date:   Fri,  4 Jun 2021 13:31:59 +0200
Message-Id: <20210604113159.26177-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604113159.26177-1-frederic@kernel.org>
References: <20210604113159.26177-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an itimer deactivates a previously armed expiration, it simply
doesn't do anything. As a result the process wide cputime counter keeps
running and the tick dependency stays set until we reach the old
ghost expiration value.

This can be reproduced with the following snippet:

	void trigger_process_counter(void)
	{
		struct itimerval n = {};

		n.it_value.tv_sec = 100;
		setitimer(ITIMER_VIRTUAL, &n, NULL);
		n.it_value.tv_sec = 0;
		setitimer(ITIMER_VIRTUAL, &n, NULL);
	}

Fix this with resetting the relevant base expiration. This is similar
to disarming a timer.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index d8325a906314..8a1ec78a7ebb 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1407,8 +1407,6 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			}
 		}
 
-		if (!*newval)
-			return;
 		*newval += now;
 	}
 
-- 
2.25.1

