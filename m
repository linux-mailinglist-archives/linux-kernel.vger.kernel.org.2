Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6C35DFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbhDMNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbhDMNTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:19:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F35C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:19:05 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x2so16955587oiv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lMWYPNRgjHfGJ2IGynOc/e2UwksaNHcfV33RwyFvJc=;
        b=MLovbU708M86ukdmzujhwKR2SfF/Kewm/N7w2ooqHqcICoeeDsN0mvEF8lIdDWF6jx
         jTASP6qAuAPkXVVP5kRdC4y7IuXIGhORnP44X7D2WktQgRCZCBoNKr7WR8yDojonIHrF
         mK0RFQSxYe8ZUHGnhSE6FTLFl0y7HXSIHDD4jnrHoinGB5ZKNBdjuA/Jg1ZkxB+m8wDD
         PG5WP3X6quMzfOaoEc6y/VEmWsbwLxbFXU7oGJD/NBdX2lGCFy+SEoIaDRVG89dYm9iH
         Od6CnjqrqyLfGO0ANRbBPLT20VmGtfbWXtHi4R3IxPgSYv8PRQ9z7Es58w7PYerLLxod
         BnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lMWYPNRgjHfGJ2IGynOc/e2UwksaNHcfV33RwyFvJc=;
        b=Q5/WFKXIkdIFnFbQhhQO59tX+/YKznJ7o8Zs8r/dSSCeXKF8kln5sds10qr8nedmuO
         2KgdKQK9YGhLRQ+5kPd++8Va70Bspxqfbl20a8maQL4AACflMsIjlDgGTd40RmGsgrKY
         vYjHvFy4AiWn1/zRumiQbaNpghgTKk7wFkwfg65sZHF2nkH+W05OtFZs4yadlwVCiRg7
         Uaci1HZ64C3QHTozMFq50pG9dgSNVLColNFVxjbO8UV4WRI+91RO5Xs7uP2NNGN1gabH
         SuElc1mQwIYpBk3O9ccAssd9mX3BM6xa4MsQGC/okWK6rT85LtwJZ1ZaG9ApIBPIvnBP
         UWPA==
X-Gm-Message-State: AOAM531Esdg4GJsCMaCSRBsHMERvnTjSuTfqUOQLKMC41Cycz31od+Ca
        jhp4GZGUTRtEwkmT83q7MBA=
X-Google-Smtp-Source: ABdhPJzRvTvT7S7M8GS+Uom/UCGNj2bqytIgONGBxPcyXrd5SArrwFHF091BOUOIBK7LKp/I8pg39g==
X-Received: by 2002:aca:39d6:: with SMTP id g205mr3282295oia.81.1618319944420;
        Tue, 13 Apr 2021 06:19:04 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id v1sm2854207ooh.3.2021.04.13.06.18.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Apr 2021 06:19:03 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH 1/1] sched/fair:Reduce unnecessary check preempt in the sched tick
Date:   Tue, 13 Apr 2021 21:18:42 +0800
Message-Id: <20210413131842.44430-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

If it has been determined that the current cpu need resched in the
early stage of for_each_sched_entity, then there is no need to check
preempt in the subsequent se->parent entity_tick.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536add..c0d135100d54 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4352,8 +4352,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	unsigned long ideal_runtime, delta_exec;
 	struct sched_entity *se;
+	struct rq *rq = rq_of(cfs_rq);
 	s64 delta;
 
+	/* If the TIF_NEED_RESCHED has been set, it is no need to check again */
+	if (test_tsk_need_resched(rq->curr))
+		return;
+
 	ideal_runtime = sched_slice(cfs_rq, curr);
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
-- 
2.18.2

