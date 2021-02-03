Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA130D29C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhBCEWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhBCEVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:21:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 20:20:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z9so3783631pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 20:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86PpupjT3xW789z4kIExXP6I/NbTSm+SwrGSPSb7pLg=;
        b=JuUrrcprpnr1jSJX2aZc/uOw3msza3cdJ1+hbhl/CuCq7fCoJq7cgXeaaPDGAWjQNU
         gH88s2BmNamEfoo6VtPgygMufVFCIqBZtgp+doElqbB0yp8/spjGIGQz3CKkZSEm+/1H
         ZmpcUF9gKAOtTiWCqG4SHR9sUQK+XStREb8OCZJL2zZcXt7/Uh9AtGhTvwCyJ61xifRb
         3R3c7kHD13F3ncjn+9LwtrW4snFhrlBj2a2vjguDuiXEUQOnLjHrWb3+M5pPrywAzFCA
         B+D5G4hZm/ZD0cQcwCRUcuZgD9l1oj43uneIq1GYpzIsLvokL4ApIKA2uSN45pT0mvDl
         UJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86PpupjT3xW789z4kIExXP6I/NbTSm+SwrGSPSb7pLg=;
        b=RR2CDFsAcKMKuKOrDg177utBxPOuh5mucdtvA6PvTEUk7UF6IAML40gIwsai4lZ0lP
         pVi/HC5EIiDwlVSIlwx8BFfA3fB0LdYFEwM1ELrBzMajP+DNdwMiYb9yITp6Pa5fny23
         r6/F7hRmrPMArpD2kQGQLpE+yWfKn/fLJa8/YMl4Ud/peVp0644nMKayv7tyeQM2++xu
         l3JnXqrch5hegAaz3FyhDzbm9EHWcw3mpFvyNIqtv94WRzpkLFigfIqBfSZkyZY7DqnO
         jhCDououi0V/R0nR2d7hxCKnZNXqzyFFt1QXAR8yOdG7jfNVSkk95uvs8DGH67Xlvblc
         FaMQ==
X-Gm-Message-State: AOAM532XCvWilxytP/kE7bLwS/rWloc6qstu6SSfrqOpbvUeBOR4rjky
        72NheeTGeSwRRzUJ0XCwPbw=
X-Google-Smtp-Source: ABdhPJzsduQpVgf2IGZ5Co/h48jwzIKQsXBH0kL/GTanFPHVoyL+xu6PcU9kAOTx7LWGb0G4EnaHWw==
X-Received: by 2002:a17:90a:bd88:: with SMTP id z8mr1294005pjr.104.1612326022951;
        Tue, 02 Feb 2021 20:20:22 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id c5sm489375pgt.73.2021.02.02.20.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 20:20:22 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] sched/topology: Switch to sched_debug() for conditional sched domain printk
Date:   Wed,  3 Feb 2021 12:20:10 +0800
Message-Id: <20210203042010.799-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, the macro sched_debug_enabled has same function as
sched_debug() with return false for !SCHED_DEBUG. And sched_debug()
is a wapper of variable sched_debug_enabled for SCHED_DEBUG. We
can use the sched_debug() for all cases. So, let's remove the
unnecessary marco, also use sched_debug() in sched_domain_debug()
for code consistency.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5d3675c..402138c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -131,7 +131,7 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 {
 	int level = 0;
 
-	if (!sched_debug_enabled)
+	if (!sched_debug())
 		return;
 
 	if (!sd) {
@@ -152,7 +152,6 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 }
 #else /* !CONFIG_SCHED_DEBUG */
 
-# define sched_debug_enabled 0
 # define sched_domain_debug(sd, cpu) do { } while (0)
 static inline bool sched_debug(void)
 {
@@ -2113,7 +2112,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
-	if (rq && sched_debug_enabled) {
+	if (rq && sched_debug()) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
 	}
-- 
1.9.1

