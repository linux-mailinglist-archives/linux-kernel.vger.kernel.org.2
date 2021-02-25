Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E146B324C24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhBYIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:38:13 -0500
Received: from foss.arm.com ([217.140.110.172]:47698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235927AbhBYIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:38:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB0A1063;
        Thu, 25 Feb 2021 00:37:20 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.11.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A06F3F70D;
        Thu, 25 Feb 2021 00:37:18 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        qperret@google.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 2/2] sched/fair: use lsub_positive in cpu_util_next()
Date:   Thu, 25 Feb 2021 08:36:12 +0000
Message-Id: <20210225083612.1113823-3-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225083612.1113823-1-vincent.donnefort@arm.com>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

The sub_positive local version is saving an explicit load-store and is
enough for the cpu_util_next() usage.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 146ac9fec4b6..1364f8b95214 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6525,7 +6525,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	 * util_avg should already be correct.
 	 */
 	if (task_cpu(p) == cpu && dst_cpu != cpu)
-		sub_positive(&util, task_util(p));
+		lsub_positive(&util, task_util(p));
 	else if (task_cpu(p) != cpu && dst_cpu == cpu)
 		util += task_util(p);
 
-- 
2.25.1

