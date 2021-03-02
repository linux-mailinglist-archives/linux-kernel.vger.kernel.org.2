Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBE32A225
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836678AbhCBHTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:19:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:40676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835949AbhCBG32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:29:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614666521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKTEzRAv9CATlTY86zVJKrAJi0oI5ufBySa5XHkL5CQ=;
        b=X7bl6NLAT36hmm+YfGokUGd07bNGuuB0Fume650Et4E4Lh1KEaNyQpyv5euP3KiwBZFUfK
        EeIOh14lwHWL22+vBYnABbO7vAwr3hFcBrYDbHY1uUJZTKxbjELW0R6M/In89q3qMthONd
        1dlcPXyTerx2WiNIT2FjUoCerjAf1eU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47A57AF7E;
        Tue,  2 Mar 2021 06:28:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 2/4] kernel/smp: prepare more CSD lock debugging
Date:   Tue,  2 Mar 2021 07:28:36 +0100
Message-Id: <20210302062838.14267-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210302062838.14267-1-jgross@suse.com>
References: <20210302062838.14267-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to easily add more CSD lock debugging data to
struct call_function_data->csd move the call_single_data_t element
into a sub-structure.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 kernel/smp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d5f0b21ab55e..6d7e6dbe33dc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,8 +31,12 @@
 
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
+struct cfd_percpu {
+	call_single_data_t	csd;
+};
+
 struct call_function_data {
-	call_single_data_t	__percpu *csd;
+	struct cfd_percpu	__percpu *pcpu;
 	cpumask_var_t		cpumask;
 	cpumask_var_t		cpumask_ipi;
 };
@@ -55,8 +59,8 @@ int smpcfd_prepare_cpu(unsigned int cpu)
 		free_cpumask_var(cfd->cpumask);
 		return -ENOMEM;
 	}
-	cfd->csd = alloc_percpu(call_single_data_t);
-	if (!cfd->csd) {
+	cfd->pcpu = alloc_percpu(struct cfd_percpu);
+	if (!cfd->pcpu) {
 		free_cpumask_var(cfd->cpumask);
 		free_cpumask_var(cfd->cpumask_ipi);
 		return -ENOMEM;
@@ -71,7 +75,7 @@ int smpcfd_dead_cpu(unsigned int cpu)
 
 	free_cpumask_var(cfd->cpumask);
 	free_cpumask_var(cfd->cpumask_ipi);
-	free_percpu(cfd->csd);
+	free_percpu(cfd->pcpu);
 	return 0;
 }
 
@@ -694,7 +698,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	cpumask_clear(cfd->cpumask_ipi);
 	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+		call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
 
 		if (cond_func && !cond_func(cpu, info))
 			continue;
@@ -719,7 +723,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
-			csd = per_cpu_ptr(cfd->csd, cpu);
+			csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
 			csd_lock_wait(csd);
 		}
 	}
-- 
2.26.2

