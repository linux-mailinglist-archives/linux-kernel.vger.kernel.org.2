Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BD3B10B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFVXo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFVXo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F4756135A;
        Tue, 22 Jun 2021 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405330;
        bh=Pp7IXW9CuTZ/eAAexklW/FU0iA9vx3eezutjba+V8js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owdMhLV8JBllX74HI2RPdjnCKx1vh9k0Jy2wUlIkS7gNDdubmC6Q0Dhfj8MM+LIqf
         kFBJcTMOM6s3MrdvHSxUL/uCDo1WHNbNbii6Z+FU9MDZwLRMCLgE20lo38h5zK8RU8
         89in7GR7Jzv2ZOXQqF88760iucrw71FdOpxsWy4/h7UggErudcjfevgmATB5sRa+py
         7oytwJoyH424RWbtkXMdjB1SM1bKmYYib7lMND0ad/VprEOE3H0XT8wKbNmaMj0kX6
         PZJeR20NHKAWsNEqZbgP9SRpSCqnV+bg9IlaXXllFmkhCIFDQPADg2oDMPATel1JcQ
         XcAtW2vici6rw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4/7] posix-cpu-timers: Force next expiration recalc after itimer reset
Date:   Wed, 23 Jun 2021 01:41:52 +0200
Message-Id: <20210622234155.119685-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622234155.119685-1-frederic@kernel.org>
References: <20210622234155.119685-1-frederic@kernel.org>
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
index 13939f47c7b0..cc9f8be67694 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1379,8 +1379,6 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			}
 		}
 
-		if (!*newval)
-			return;
 		*newval += now;
 	}
 
-- 
2.25.1

