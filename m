Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D632B3B10B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFVXoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhFVXo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:44:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21FA7611CE;
        Tue, 22 Jun 2021 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405332;
        bh=cB5YfnTx+ap3znbKBOT6WsKQrk3kBvK/3xowpjSloKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKzFW23hPe59sZF1rXapU3eT7rtzBd9o33rTYEiTM5YuXGFxfqIw8cqZ1de34cmAL
         wTkiZyJyclbLMuxTvjBSvkB0+kzh3HIAF5Q/0RGSR8IddeeK61OnoOv1dbdttUOISg
         DQAVQ7orkBL47746HGQ8RM/J622CjRR+r/T0rPrfK4cfxwGXFRMzoJCIo5M3gNOaM/
         qt9qhh3PvugsFEbKKQZxfGFmVGkjUbGP5fxH9qV9s3RB7ont8bHNgpDK7GmyJPTEsW
         F5LdLK2qDa9oERL5Cxushw7FULDtVTWT7ysgYHd1aRtB6eL1//SHlQEiNtqOYzKoYf
         CWS8tvnz9VkOg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5/7] posix-cpu-timers: Remove confusing error code override
Date:   Wed, 23 Jun 2021 01:41:53 +0200
Message-Id: <20210622234155.119685-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622234155.119685-1-frederic@kernel.org>
References: <20210622234155.119685-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't reach this end of the function with an error. Unconfuse
reviewers about that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cc9f8be67694..1ac36e6ca6d6 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -744,8 +744,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		 */
 		cpu_timer_fire(timer);
 	}
-
-	ret = 0;
  out:
 	rcu_read_unlock();
 	if (old)
-- 
2.25.1

