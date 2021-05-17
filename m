Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3D3826E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhEQI0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:26:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235248AbhEQIZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:25:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7399106F;
        Mon, 17 May 2021 01:24:39 -0700 (PDT)
Received: from e113131-lin.cambridge.arm.com (e113131-lin.cambridge.arm.com [10.1.195.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76DFD3F719;
        Mon, 17 May 2021 01:24:38 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 3/3] sched/doc: Update the CPU capacity asymmetry bits
Date:   Mon, 17 May 2021 09:23:51 +0100
Message-Id: <1621239831-5870-4-git-send-email-beata.michalska@arm.com>
In-Reply-To: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation bits referring to capacity aware scheduling
with regards to newly introduced SD_ASYM_CPUCAPACITY_FULL sched_domain
flag.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
 Documentation/scheduler/sched-capacity.rst | 6 ++++--
 Documentation/scheduler/sched-energy.rst   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 9b7cbe4..805f85f 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -284,8 +284,10 @@ whether the system exhibits asymmetric CPU capacities. Should that be the
 case:
 
 - The sched_asym_cpucapacity static key will be enabled.
-- The SD_ASYM_CPUCAPACITY flag will be set at the lowest sched_domain level that
-  spans all unique CPU capacity values.
+- The SD_ASYM_CPUCAPACITY_FULL flag will be set at the lowest sched_domain
+  level that spans all unique CPU capacity values.
+- The SD_ASYM_CPUCAPACITY flag will be set for any sched_domain that spans
+  CPUs with any range of asymmetry.
 
 The sched_asym_cpucapacity static key is intended to guard sections of code that
 cater to asymmetric CPU capacity systems. Do note however that said key is
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index afe02d3..8fbce5e 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -328,7 +328,7 @@ section lists these dependencies and provides hints as to how they can be met.
 
 As mentioned in the introduction, EAS is only supported on platforms with
 asymmetric CPU topologies for now. This requirement is checked at run-time by
-looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
+looking for the presence of the SD_ASYM_CPUCAPACITY_FULL flag when the scheduling
 domains are built.
 
 See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
-- 
2.7.4

