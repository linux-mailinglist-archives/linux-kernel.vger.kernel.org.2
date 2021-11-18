Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1079B455DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhKROSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:18:47 -0500
Received: from foss.arm.com ([217.140.110.172]:41424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhKROSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:18:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D437A101E;
        Thu, 18 Nov 2021 06:15:24 -0800 (PST)
Received: from localhost.localdomain (FVFF7649Q05P.cambridge.arm.com [10.1.31.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2B493F766;
        Thu, 18 Nov 2021 06:15:23 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 2/2] sched/fair: Fix task_fits_capacity() capacity type
Date:   Thu, 18 Nov 2021 14:14:11 +0000
Message-Id: <20211118141411.2623521-2-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118141411.2623521-1-vincent.donnefort@arm.com>
References: <20211118141411.2623521-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

capacity is an unsigned long value, compared with a task utilization which
is unsigned long as well. There's no need for an intermediate implicit
long cast.

Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8fde6e10e24b..26a88975f68a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4070,7 +4070,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
-static inline int task_fits_capacity(struct task_struct *p, long capacity)
+static inline int task_fits_capacity(struct task_struct *p,
+				     unsigned long capacity)
 {
 	return fits_capacity(uclamp_task_util(p), capacity);
 }
-- 
2.25.1

