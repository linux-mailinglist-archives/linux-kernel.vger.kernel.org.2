Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80BF38CB57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhEUQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:56:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237802AbhEUQ4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:56:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4A5E1480;
        Fri, 21 May 2021 09:54:52 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FD103F73D;
        Fri, 21 May 2021 09:54:51 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 1/3] PM / EM: Fix inefficient state detection
Date:   Fri, 21 May 2021 17:54:22 +0100
Message-Id: <1621616064-340235-2-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a debug message is printed if an inefficient state is detected
in the Energy Model. Unfortunately, it won't detect if the first state is
inefficient or if two successive states are. Fix this behavior.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 0c620eb..c4871a8 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -107,8 +107,7 @@ static void em_debug_remove_pd(struct device *dev) {}
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				int nr_states, struct em_data_callback *cb)
 {
-	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
-	unsigned long power, freq, prev_freq = 0;
+	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
 	struct em_perf_state *table;
 	int i, ret;
 	u64 fmax;
@@ -153,25 +152,19 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 		table[i].power = power;
 		table[i].frequency = prev_freq = freq;
-
-		/*
-		 * The hertz/watts efficiency ratio should decrease as the
-		 * frequency grows on sane platforms. But this isn't always
-		 * true in practice so warn the user if a higher OPP is more
-		 * power efficient than a lower one.
-		 */
-		opp_eff = freq / power;
-		if (opp_eff >= prev_opp_eff)
-			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
-					i, i - 1);
-		prev_opp_eff = opp_eff;
 	}
 
 	/* Compute the cost of each performance state. */
 	fmax = (u64) table[nr_states - 1].frequency;
-	for (i = 0; i < nr_states; i++) {
+	for (i = nr_states - 1; i >= 0; i--) {
 		table[i].cost = div64_u64(fmax * table[i].power,
 					  table[i].frequency);
+		if (table[i].cost >= prev_cost) {
+			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
+				table[i].frequency);
+		} else {
+			prev_cost = table[i].cost;
+		}
 	}
 
 	pd->table = table;
-- 
2.7.4

