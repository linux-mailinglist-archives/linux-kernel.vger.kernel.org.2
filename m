Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1EA416132
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbhIWOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241737AbhIWOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E26113E;
        Thu, 23 Sep 2021 07:39:32 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A7F33F718;
        Thu, 23 Sep 2021 07:39:30 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 1/5] coresight: trbe: irq handler: Do not disable TRBE if no action is needed
Date:   Thu, 23 Sep 2021 15:39:15 +0100
Message-Id: <20210923143919.2944311-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210923143919.2944311-1-suzuki.poulose@arm.com>
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ handler of the TRBE driver could race against the update_buffer()
in consuming the  IRQ. So, if the update_buffer() gets to processing the
TRBE irq, the TRBSR will be cleared. Thus by the time IRQ handler is
triggered, there is nothing to do there. Handle these cases and do not
disable the TRBE unnecessarily. Since the TRBSR can be read without
stopping the TRBE, we can check that before disabling the TRBE.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2cf28de2e447..e78800ba5b5b 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -762,12 +762,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	enum trbe_fault_action act;
 	u64 status;
 
-	/*
-	 * Ensure the trace is visible to the CPUs and
-	 * any external aborts have been resolved.
-	 */
-	trbe_drain_and_disable_local();
-
+	/* Reads to TRBSR_EL1 is fine when TRBE is active */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
 	/*
 	 * If the pending IRQ was handled by update_buffer callback
@@ -776,6 +771,11 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	if (!is_trbe_irq(status))
 		return IRQ_NONE;
 
+	/*
+	 * Ensure the trace is visible to the CPUs and
+	 * any external aborts have been resolved.
+	 */
+	trbe_drain_and_disable_local();
 	clr_trbe_irq();
 	isb();
 
-- 
2.24.1

