Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402D33D59E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhGZMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234072AbhGZMPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8681C60F46;
        Mon, 26 Jul 2021 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304131;
        bh=duAI6da3d0IJY3Ydyn7BrPpbzqS/tN31SpkrAKR6pyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1NeTOLJGKDiBwmqUBu8dNXMw3SoqYzIoWK2HWN5bciRtA9I3pDpr4FoxGrZHuOxl
         Yg/SHPfuf/qk9EFcVJe7GlpPBijLEHp8ljglFDRzttMaNdYS/hEDI0rg3rnylSEpXt
         PN2PRpL3jbPipMrB8Jd52iBzEzJXk8Xdpb4tjeV+EVACdo+aEH22uoR+MPdOLaAnOQ
         zXDhKY+T5VF3h97gRiVT+CB9u9D+pdPivuX+6EqxuAcYUyALwttxO7kzmZ3+aqu18B
         Yg6t/+Qj/wvrKrRSLlTAXhbWV4kmuihGa7LwFu13cW9J03d8AC4cXme6vFiEbhTfwh
         hg98lBcIgM/Qw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 3/6] posix-cpu-timers: Force next expiration recalc after itimer reset
Date:   Mon, 26 Jul 2021 14:55:10 +0200
Message-Id: <20210726125513.271824-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726125513.271824-1-frederic@kernel.org>
References: <20210726125513.271824-1-frederic@kernel.org>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 61c78b62fe6a..5c71322b45c7 100644
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

