Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F5B3BC42F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 01:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhGEXqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 19:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhGEXqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 19:46:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0B4D61975;
        Mon,  5 Jul 2021 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625528634;
        bh=LkjNHYltU2slKI5/7CCdHUU7NawqELcL6QiRGbBdKG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpeU80n2IR5XLKyNLnhjPX9fdPNm+8R1+4Xm0st/xaNE7MFKWSePBbzhsfE4UmrdX
         INB/OtK696+cI/L74RQ6zvgbRugr3jTLBusBFgWFqSuOUVuM25kSDSUVl3cqU9f/fg
         y0AWn5AzTq4ixsoadOHYbU1PUyAR3Z54DtavzN/37eyEPIg2ijrdgvRAApVnhOkGu4
         A11cI8Lmdywy2F9ueYF2WI1gJm6Ihff1JNK2wnsGLcvyjtjqNHl5n9YQThLPZBorce
         aUq/0D3h+Ox9RhzsnL3myLMuaaAjU7wpIJkkDxUe2BteBlG6fYR7BynjkAmutNFLFT
         2KpE/9+67uvWQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/2] rcu: Remove needless preemption disablement in rcu_all_qs()
Date:   Tue,  6 Jul 2021 01:43:44 +0200
Message-Id: <20210705234344.104239-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705234344.104239-1-frederic@kernel.org>
References: <20210705234344.104239-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preemption is already disabled when we write rcu_data.rcu_urgent_qs.
We can use __this_cpu_write() directly, although that path is mostly
used when CONFIG_PREEMPT=n.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 27b74352cccf..38b3d01424d7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -871,7 +871,7 @@ void rcu_all_qs(void)
 		preempt_enable();
 		return;
 	}
-	this_cpu_write(rcu_data.rcu_urgent_qs, false);
+	__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
 		rcu_momentary_dyntick_idle();
-- 
2.25.1

