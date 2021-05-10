Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846A37922B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhEJPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:12:59 -0400
Received: from foss.arm.com ([217.140.110.172]:60738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhEJPMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:12:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772BC1691;
        Mon, 10 May 2021 08:11:20 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BF773F719;
        Mon, 10 May 2021 08:11:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yejune Deng <yejune.deng@gmail.com>, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bristot@redhat.com
Subject: [PATCH 2/2] lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed
Date:   Mon, 10 May 2021 16:10:24 +0100
Message-Id: <20210510151024.2448573-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210510151024.2448573-1-valentin.schneider@arm.com>
References: <20210510151024.2448573-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yejune Deng <yejune.deng@gmail.com>

is_percpu_thread() more elegantly handles SMP vs UP, and further checks the
presence of PF_NO_SETAFFINITY. This lets us catch cases where
check_preemption_disabled() can race with a concurrent sched_setaffinity().

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
[Amended changelog]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 lib/smp_processor_id.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 1c1dbd300325..046ac6297c78 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (irqs_disabled())
 		goto out;
 
-	/*
-	 * Kernel threads bound to a single CPU can safely use
-	 * smp_processor_id():
-	 */
-	if (current->nr_cpus_allowed == 1)
+	if (is_percpu_thread())
 		goto out;
 
 #ifdef CONFIG_SMP
-- 
2.25.1

