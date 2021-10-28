Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7137743E040
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJ1Lws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:52:48 -0400
Received: from foss.arm.com ([217.140.110.172]:53958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJ1Lwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:52:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 971761063;
        Thu, 28 Oct 2021 04:50:20 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937093F5A1;
        Thu, 28 Oct 2021 04:50:19 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] sched/core: Export pelt_thermal_tp
Date:   Thu, 28 Oct 2021 12:50:05 +0100
Message-Id: <20211028115005.873539-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't use this tracepoint in modules without having the symbol
exported first, fix that.

Fixes: 765047932f15 ("sched/pelt: Add support to track thermal pressure")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2611b9cf503..2f7a1d8f5f17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
-- 
2.25.1

