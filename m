Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C836206A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhDPNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:02:15 -0400
Received: from foss.arm.com ([217.140.110.172]:41022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235528AbhDPNCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:02:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF13712FC;
        Fri, 16 Apr 2021 06:01:47 -0700 (PDT)
Received: from e113131-lin.cambridge.arm.com (e113131-lin.cambridge.arm.com [10.1.195.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88A563F85F;
        Fri, 16 Apr 2021 06:01:46 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [RFC PATCH 1/3] sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL sched_domain flag
Date:   Fri, 16 Apr 2021 14:01:23 +0100
Message-Id: <1618578085-29584-2-git-send-email-beata.michalska@arm.com>
In-Reply-To: <1618578085-29584-1-git-send-email-beata.michalska@arm.com>
References: <1618578085-29584-1-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
topology flag, to distinguish between shed_domains where any CPU
capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
a full range of CPU capacities is visible to all domain members
(SD_ASYM_CPUCAPACITY_FULL).

With the distinction between full and partial CPU capacity asymmetry,
the scope of the original SD_ASYM_CPUCAPACITY flag gets shifted, still
maintaining the existing behaviour when one is detected on a given
sched domain, allowing misfit migrations within sched domains that
do not observe full range of CPU capacities but still do have members
with different capacity values. It loses though it's meaning when it
comes to the lowest CPU asymmetry sched_domain level per-cpu pointer,
which is to be now denoted by SD_ASYM_CPUCAPACITY_FULL flag.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 include/linux/sched/sd_flags.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 34b21e9..57bde66 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
 SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
+ * Domain members have different CPU capacities spanning all unique CPU
+ * capacity values.
+ *
+ * SHARED_PARENT: Set from the topmost domain down to the first domain where
+ *		  all available CPU capacities are visible
+ * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
+ */
+SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
+
+/*
  * Domain members share CPU capacity (i.e. SMT)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
-- 
2.7.4

