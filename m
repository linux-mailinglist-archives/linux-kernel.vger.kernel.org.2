Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE03D59E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGZMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234281AbhGZMPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:15:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77D3F60F4F;
        Mon, 26 Jul 2021 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304133;
        bh=y9U4aRMH2+FIoT4mMj6e8sUhd+dWwoR0o4qU70Phlus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fmqa3jnmeTrFD6KP7ZS0gIJE5bgYKcfj6Nn/6CyLgZeeCabDwN1JCHerulS0jwjqw
         xZr2atL/T6ON3vc2YmuOwl9iTfhtAK64DWO8XTw6B1KYCT8/l/iL34sq+u/JH+j1uv
         +j1t0UGijdF0Tq8+LcCZLfjCayl54NOkZmYNkvIX93VcOKLfJQLnxn+ZywDCWOgcHv
         DnPNIaNgZug41leZEfmK3UcQ+xSDgx33svjeHTs0W/8sQ0RDEGUbYK2mTRVJ17WHR0
         FByve7SH7CaSVb3qNlLfEAnMxN8LmamtGF/zMg78ETTLEsTBK6XLMQ5qmugO+PviNN
         P9/tfSBm3rYdg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 4/6] posix-cpu-timers: Remove confusing error code override
Date:   Mon, 26 Jul 2021 14:55:11 +0200
Message-Id: <20210726125513.271824-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726125513.271824-1-frederic@kernel.org>
References: <20210726125513.271824-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't reach this end of the function with an error. Unconfuse
reviewers about that.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 5c71322b45c7..4fbbbc89ac4a 100644
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

