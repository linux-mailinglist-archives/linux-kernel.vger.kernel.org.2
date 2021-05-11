Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55529379F57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEKFvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:51:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:41540 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKFvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:51:40 -0400
IronPort-SDR: 6+a/Yu2Y3EhHhBw3DsjKBFuIbaYuddC5FHAxhphVg5jBWQRZkMMX7d61qEjl1p5ltVGmXFhxPU
 23c+2JBZjMlw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186497849"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186497849"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:50:34 -0700
IronPort-SDR: JwxCby8GjlLqq08831+dJxFqvOpq93xdcW725vcuaLR5Ksvy/7B7iN6SFcCMpMqd0YfIFpC0Hm
 +ZZ7MRHWE4LA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="471020665"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:49:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: bandwidth allocation: improve error messages
Date:   Tue, 11 May 2021 13:49:45 +0800
Message-Id: <20210511054945.29558-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In rare corner cases, we see an error with the log:

[  838.297840] soundwire sdw-master-1: Compute bus params failed: -22

That's not very useful, there can be two different error conditions
with the same -EINVAL code provided to the caller.

Let's add better dev_err() messages to figure out what went wrong.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 84d129587084..f7c66083a4dd 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -382,12 +382,18 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 		 */
 	}
 
-	if (i == clk_values)
+	if (i == clk_values) {
+		dev_err(bus->dev, "%s: could not find clock value for bandwidth %d\n",
+			__func__, bus->params.bandwidth);
 		return -EINVAL;
+	}
 
 	ret = sdw_select_row_col(bus, curr_dr_freq);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(bus->dev, "%s: could not find frame configuration for bus dr_freq %d\n",
+			__func__, curr_dr_freq);
 		return -EINVAL;
+	}
 
 	bus->params.curr_dr_freq = curr_dr_freq;
 	return 0;
@@ -404,10 +410,8 @@ int sdw_compute_params(struct sdw_bus *bus)
 
 	/* Computes clock frequency, frame shape and frame frequency */
 	ret = sdw_compute_bus_params(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Compute bus params failed: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Compute transport and port params */
 	ret = sdw_compute_port_params(bus);
-- 
2.17.1

