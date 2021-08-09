Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80BF3E428C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhHIJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:23:27 -0400
Received: from foss.arm.com ([217.140.110.172]:56508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhHIJX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:23:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C3E31B;
        Mon,  9 Aug 2021 02:23:06 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86EE83F40C;
        Mon,  9 Aug 2021 02:23:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, lkp@intel.com
Subject: [PATCH] firmware: arm_scmi: Use WARN_ON() to check configured transports
Date:   Mon,  9 Aug 2021 10:22:45 +0100
Message-Id: <20210809092245.8730-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a WARN_ON() when SCMI stack is loaded to check the consistency of
configured SCMI transports instead of the current compile-time check
BUILD_BUG_ON() to avoid breaking bot-builds on random bad configs.

Bail-out early and noisy during SCMI stack initialization if no transport
was enabled in configuration since SCMI cannot work without at least one
enabled transport and such constraint cannot be enforced in Kconfig due to
circular dependency issues.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b28111ea7c8b..b406b3f78f46 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2067,9 +2067,11 @@ static int __init scmi_driver_init(void)
 {
 	int ret;
 
-	scmi_bus_init();
+	/* Bail out if no SCMI transport was configured */
+	if (WARN_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT)))
+		return -EINVAL;
 
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT));
+	scmi_bus_init();
 
 	/* Initialize any compiled-in transport which provided an init/exit */
 	ret = scmi_transports_init();
-- 
2.17.1

