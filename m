Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF83887AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhESGkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:40:22 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:38753 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhESGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:40:21 -0400
Received: from grover.RMN.KIBA.LAB.jp (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14J6bCP4005735;
        Wed, 19 May 2021 15:37:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14J6bCP4005735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621406233;
        bh=EjAQYV3rgfCUMvcmuINMAjm4oykdL+50ig+UQDmBe8k=;
        h=From:To:Cc:Subject:Date:From;
        b=qBKdZe/587Ni26JK58OudykSEZSpUPX0bEnvmOcD7kASYy4cequeofI3hO/5zjze9
         hPTxz5tVH1N8cX8oFPsWyDFsXxFX59oipOLy5B2I29Cf46d3zBVlAMbgymA+trVGPE
         aknA1EE+Z8gRI0CqvM1YadtD7Uwrb/NdAKwKWp4ianNhlTUwSuMCCsjYfbWLmkhrLg
         8t4AptsS4+QjwYzdMhMnSFsSgwW6tJiz5i3sjizpeWP3UHnJl43XcrDcg58uOHS6IH
         ZFtLMJuuDiVPPBRKQSpibpRnDgbaVjvzVtgtDBCcwXsUrk15FoeiJc5eGWWgzhvVIh
         ma8NRcmYwu/gg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched: fix a stale comment in pick_next_task()
Date:   Wed, 19 May 2021 15:37:09 +0900
Message-Id: <20210519063709.323162-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fair_sched_class->next no longer exists since commit a87e749e8fa1
("sched: Remove struct sched_class::next field").

Now the sched_class order is specified by the linker script.

Rewrite the comment in a more generic way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..fd3b7079b9f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4961,7 +4961,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (unlikely(p == RETRY_TASK))
 			goto restart;
 
-		/* Assumes fair_sched_class->next == idle_sched_class */
+		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
 			put_prev_task(rq, prev);
 			p = pick_next_task_idle(rq);
-- 
2.27.0

