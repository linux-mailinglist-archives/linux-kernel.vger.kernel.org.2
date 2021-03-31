Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66D634F601
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhCaBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:14:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:50710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232518AbhCaBOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:14:18 -0400
IronPort-SDR: aBgh8qG2POUQjFp4daM9tJhX9CFbdQiE9LSKQslbGWguMf/eo1C5PI2Ouq8rqEeI3SeVdqsUQ3
 CUTtiFWU0yyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179020197"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179020197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:14:18 -0700
IronPort-SDR: bYcIksVmFp8br8nMo6M9BC3z+tm3rWGb9583LLqWAxV20QaghRLeid/g09dSGG9s6CyGRCj/pu
 1qeiYudvAuxQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418414720"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:14:15 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: bus: handle errors in clock stop/start sequences
Date:   Wed, 31 Mar 2021 09:13:55 +0800
Message-Id: <20210331011355.14313-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

If a device lost sync and can no longer ACK a command, it may not be
able to enter a lower-power state but it will still be able to resync
when the clock restarts. In those cases, we want to continue with the
clock stop sequence.

This patch modifies the behavior when -ENODATA is received, with the
error level demoted to a dev_dbg() since it's a recoverable issue.

For consistency the log messages are also modified to be unique and
self-explanatory, and missing logs are also added on clock stop exit.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 70 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 9bd83c91a873..ea54a1f02252 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -848,8 +848,9 @@ static int sdw_slave_clk_stop_callback(struct sdw_slave *slave,
 	if (slave->ops && slave->ops->clk_stop) {
 		ret = slave->ops->clk_stop(slave, mode, type);
 		if (ret < 0) {
-			dev_err(&slave->dev,
-				"Clk Stop type =%d failed: %d\n", type, ret);
+			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+					   "Clk Stop mode %d type =%d failed: %d\n",
+					   mode, type, ret);
 			return ret;
 		}
 	}
@@ -878,7 +879,8 @@ static int sdw_slave_clk_stop_prepare(struct sdw_slave *slave,
 	} else {
 		ret = sdw_read_no_pm(slave, SDW_SCP_SYSTEMCTRL);
 		if (ret < 0) {
-			dev_err(&slave->dev, "SDW_SCP_SYSTEMCTRL read failed:%d\n", ret);
+			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+					   "SDW_SCP_SYSTEMCTRL read failed:%d\n", ret);
 			return ret;
 		}
 		val = ret;
@@ -888,8 +890,8 @@ static int sdw_slave_clk_stop_prepare(struct sdw_slave *slave,
 	ret = sdw_write_no_pm(slave, SDW_SCP_SYSTEMCTRL, val);
 
 	if (ret < 0)
-		dev_err(&slave->dev,
-			"Clock Stop prepare failed for slave: %d", ret);
+		sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+				   "SDW_SCP_SYSTEMCTRL write ignored:%d\n", ret);
 
 	return ret;
 }
@@ -907,7 +909,7 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		}
 		val &= SDW_SCP_STAT_CLK_STP_NF;
 		if (!val) {
-			dev_dbg(bus->dev, "clock stop prep/de-prep done slave:%d",
+			dev_dbg(bus->dev, "clock stop prep/de-prep done slave:%d\n",
 				dev_num);
 			return 0;
 		}
@@ -916,7 +918,7 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		retry--;
 	} while (retry);
 
-	dev_err(bus->dev, "clock stop prep/de-prep failed slave:%d",
+	dev_err(bus->dev, "clock stop prep/de-prep failed slave:%d\n",
 		dev_num);
 
 	return -ETIMEDOUT;
@@ -956,19 +958,18 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 		slave_mode = sdw_get_clk_stop_mode(slave);
 		slave->curr_clk_stop_mode = slave_mode;
 
-		ret = sdw_slave_clk_stop_callback(slave, slave_mode,
-						  SDW_CLK_PRE_PREPARE);
+		ret = sdw_slave_clk_stop_callback(slave, slave_mode, SDW_CLK_PRE_PREPARE);
 		if (ret < 0) {
-			dev_err(&slave->dev,
-				"pre-prepare failed:%d", ret);
+			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+					   "clock stop pre prepare cb failed:%d\n", ret);
 			return ret;
 		}
 
 		ret = sdw_slave_clk_stop_prepare(slave,
 						 slave_mode, true);
 		if (ret < 0) {
-			dev_err(&slave->dev,
-				"pre-prepare failed:%d", ret);
+			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+					   "clock stop prepare failed:%d\n", ret);
 			return ret;
 		}
 
@@ -999,13 +1000,11 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 		slave_mode = slave->curr_clk_stop_mode;
 
 		if (slave_mode == SDW_CLK_STOP_MODE1) {
-			ret = sdw_slave_clk_stop_callback(slave,
-							  slave_mode,
-							  SDW_CLK_POST_PREPARE);
-
+			ret = sdw_slave_clk_stop_callback(slave, slave_mode, SDW_CLK_POST_PREPARE);
 			if (ret < 0) {
-				dev_err(&slave->dev,
-					"post-prepare failed:%d", ret);
+				sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+						   "clock stop post-prepare cb failed:%d\n", ret);
+				return ret;
 			}
 		}
 	}
@@ -1033,12 +1032,8 @@ int sdw_bus_clk_stop(struct sdw_bus *bus)
 	ret = sdw_bwrite_no_pm(bus, SDW_BROADCAST_DEV_NUM,
 			       SDW_SCP_CTRL, SDW_SCP_CTRL_CLK_STP_NOW);
 	if (ret < 0) {
-		if (ret == -ENODATA)
-			dev_dbg(bus->dev,
-				"ClockStopNow Broadcast msg ignored %d", ret);
-		else
-			dev_err(bus->dev,
-				"ClockStopNow Broadcast msg failed %d", ret);
+		sdw_dev_dbg_or_err(bus->dev, ret != -ENODATA,
+				   "ClockStopNow Broadcast msg failed %d\n", ret);
 		return ret;
 	}
 
@@ -1086,26 +1081,24 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 			continue;
 		}
 
-		ret = sdw_slave_clk_stop_callback(slave, mode,
-						  SDW_CLK_PRE_DEPREPARE);
+		ret = sdw_slave_clk_stop_callback(slave, mode, SDW_CLK_PRE_DEPREPARE);
 		if (ret < 0)
-			dev_warn(&slave->dev,
-				 "clk stop deprep failed:%d", ret);
-
-		ret = sdw_slave_clk_stop_prepare(slave, mode,
-						 false);
+			dev_warn(&slave->dev, "clock stop pre deprepare cb failed:%d\n", ret);
 
+		ret = sdw_slave_clk_stop_prepare(slave, mode, false);
 		if (ret < 0)
-			dev_warn(&slave->dev,
-				 "clk stop deprep failed:%d", ret);
+			dev_warn(&slave->dev, "clock stop deprepare failed:%d\n", ret);
 	}
 
 	/* Skip remaining clock stop de-preparation if no Slave is attached */
 	if (!is_slave)
 		return 0;
 
-	if (!simple_clk_stop)
-		sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
+	if (!simple_clk_stop) {
+		ret = sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
+		if (ret < 0)
+			dev_warn(&slave->dev, "clock stop deprepare wait failed:%d\n", ret);
+	}
 
 	list_for_each_entry(slave, &bus->slaves, node) {
 		if (!slave->dev_num)
@@ -1116,8 +1109,9 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 			continue;
 
 		mode = slave->curr_clk_stop_mode;
-		sdw_slave_clk_stop_callback(slave, mode,
-					    SDW_CLK_POST_DEPREPARE);
+		ret = sdw_slave_clk_stop_callback(slave, mode, SDW_CLK_POST_DEPREPARE);
+		if (ret < 0)
+			dev_warn(&slave->dev, "clock stop post deprepare cb failed:%d\n", ret);
 	}
 
 	return 0;
-- 
2.17.1

