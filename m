Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281B3363B09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhDSF1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 01:27:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:44552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhDSF1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 01:27:51 -0400
IronPort-SDR: ya6AzH+K9CsXr/0OH2WCoJa/DLXfpM+DJVvJNamn78Cy4iF+h3B7vKOnTdi2jidgtptKEciqBM
 pDk+Ek5ojhfA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="193147297"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="193147297"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:27:21 -0700
IronPort-SDR: k9P6StV0RiSZa0lmn8oEu9RJBlXf11x55TwSqro0oc2XCxgyt1xWmSAYNJwvfBqBPt7ad8AlG5
 94mTEl8EAO0Q==
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="426370598"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:27:17 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/4] soundwire: bus: only use CLOCK_STOP_MODE0 and fix confusions
Date:   Mon, 19 Apr 2021 13:27:00 +0800
Message-Id: <20210419052703.2782-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419052703.2782-1-yung-chuan.liao@linux.intel.com>
References: <20210419052703.2782-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Existing devices and implementations only support the required
CLOCK_STOP_MODE0. All the code related to CLOCK_STOP_MODE1 has not
been tested and is highly questionable, with a clear confusion between
CLOCK_STOP_MODE1 and the simple clock stop state machine.

This patch removes all usages of CLOCK_STOP_MODE1 - which has no
impact on any solution - and fixes the use of the simple clock stop
state machine. The resulting code should be a lot more symmetrical and
easier to maintain.

Note that CLOCK_STOP_MODE1 is not supported in the SoundWire Device
Class specification so it's rather unlikely that we need to re-add
this mode later.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 100 ++++++++++++++--------------------
 include/linux/soundwire/sdw.h |   2 -
 2 files changed, 40 insertions(+), 62 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a9e0aa72654d..dc4033b6f2e9 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -821,26 +821,6 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	mutex_unlock(&bus->bus_lock);
 }
 
-static enum sdw_clk_stop_mode sdw_get_clk_stop_mode(struct sdw_slave *slave)
-{
-	enum sdw_clk_stop_mode mode;
-
-	/*
-	 * Query for clock stop mode if Slave implements
-	 * ops->get_clk_stop_mode, else read from property.
-	 */
-	if (slave->ops && slave->ops->get_clk_stop_mode) {
-		mode = slave->ops->get_clk_stop_mode(slave);
-	} else {
-		if (slave->prop.clk_stop_mode1)
-			mode = SDW_CLK_STOP_MODE1;
-		else
-			mode = SDW_CLK_STOP_MODE0;
-	}
-
-	return mode;
-}
-
 static int sdw_slave_clk_stop_callback(struct sdw_slave *slave,
 				       enum sdw_clk_stop_mode mode,
 				       enum sdw_clk_stop_type type)
@@ -933,7 +913,6 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
  */
 int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 {
-	enum sdw_clk_stop_mode slave_mode;
 	bool simple_clk_stop = true;
 	struct sdw_slave *slave;
 	bool is_slave = false;
@@ -955,10 +934,8 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 		/* Identify if Slave(s) are available on Bus */
 		is_slave = true;
 
-		slave_mode = sdw_get_clk_stop_mode(slave);
-		slave->curr_clk_stop_mode = slave_mode;
-
-		ret = sdw_slave_clk_stop_callback(slave, slave_mode,
+		ret = sdw_slave_clk_stop_callback(slave,
+						  SDW_CLK_STOP_MODE0,
 						  SDW_CLK_PRE_PREPARE);
 		if (ret < 0) {
 			dev_err(&slave->dev,
@@ -966,22 +943,29 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 			return ret;
 		}
 
-		ret = sdw_slave_clk_stop_prepare(slave,
-						 slave_mode, true);
-		if (ret < 0) {
-			dev_err(&slave->dev,
-				"pre-prepare failed:%d", ret);
-			return ret;
-		}
-
-		if (slave_mode == SDW_CLK_STOP_MODE1)
+		/* Only prepare a Slave device if needed */
+		if (!slave->prop.simple_clk_stop_capable) {
 			simple_clk_stop = false;
+
+			ret = sdw_slave_clk_stop_prepare(slave,
+							 SDW_CLK_STOP_MODE0,
+							 true);
+			if (ret < 0) {
+				dev_err(&slave->dev,
+					"pre-prepare failed:%d", ret);
+				return ret;
+			}
+		}
 	}
 
 	/* Skip remaining clock stop preparation if no Slave is attached */
 	if (!is_slave)
 		return ret;
 
+	/*
+	 * Don't wait for all Slaves to be ready if they follow the simple
+	 * state machine
+	 */
 	if (!simple_clk_stop) {
 		ret = sdw_bus_wait_for_clk_prep_deprep(bus,
 						       SDW_BROADCAST_DEV_NUM);
@@ -998,17 +982,13 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 		    slave->status != SDW_SLAVE_ALERT)
 			continue;
 
-		slave_mode = slave->curr_clk_stop_mode;
+		ret = sdw_slave_clk_stop_callback(slave,
+						  SDW_CLK_STOP_MODE0,
+						  SDW_CLK_POST_PREPARE);
 
-		if (slave_mode == SDW_CLK_STOP_MODE1) {
-			ret = sdw_slave_clk_stop_callback(slave,
-							  slave_mode,
-							  SDW_CLK_POST_PREPARE);
-
-			if (ret < 0) {
-				dev_err(&slave->dev,
-					"post-prepare failed:%d", ret);
-			}
+		if (ret < 0) {
+			dev_err(&slave->dev,
+				"post-prepare failed:%d", ret);
 		}
 	}
 
@@ -1059,7 +1039,6 @@ EXPORT_SYMBOL(sdw_bus_clk_stop);
  */
 int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 {
-	enum sdw_clk_stop_mode mode;
 	bool simple_clk_stop = true;
 	struct sdw_slave *slave;
 	bool is_slave = false;
@@ -1081,31 +1060,33 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 		/* Identify if Slave(s) are available on Bus */
 		is_slave = true;
 
-		mode = slave->curr_clk_stop_mode;
-
-		if (mode == SDW_CLK_STOP_MODE1) {
-			simple_clk_stop = false;
-			continue;
-		}
-
-		ret = sdw_slave_clk_stop_callback(slave, mode,
+		ret = sdw_slave_clk_stop_callback(slave, SDW_CLK_STOP_MODE0,
 						  SDW_CLK_PRE_DEPREPARE);
 		if (ret < 0)
 			dev_warn(&slave->dev,
 				 "clk stop deprep failed:%d", ret);
 
-		ret = sdw_slave_clk_stop_prepare(slave, mode,
-						 false);
+		/* Only de-prepare a Slave device if needed */
+		if (!slave->prop.simple_clk_stop_capable) {
+			simple_clk_stop = false;
 
-		if (ret < 0)
-			dev_warn(&slave->dev,
-				 "clk stop deprep failed:%d", ret);
+			ret = sdw_slave_clk_stop_prepare(slave, SDW_CLK_STOP_MODE0,
+							 false);
+
+			if (ret < 0)
+				dev_warn(&slave->dev,
+					 "clk stop deprep failed:%d", ret);
+		}
 	}
 
 	/* Skip remaining clock stop de-preparation if no Slave is attached */
 	if (!is_slave)
 		return 0;
 
+	/*
+	 * Don't wait for all Slaves to be ready if they follow the simple
+	 * state machine
+	 */
 	if (!simple_clk_stop)
 		sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
 
@@ -1117,8 +1098,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 		    slave->status != SDW_SLAVE_ALERT)
 			continue;
 
-		mode = slave->curr_clk_stop_mode;
-		sdw_slave_clk_stop_callback(slave, mode,
+		sdw_slave_clk_stop_callback(slave, SDW_CLK_STOP_MODE0,
 					    SDW_CLK_POST_DEPREPARE);
 	}
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ced07f8fde87..5d93d9949653 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -624,7 +624,6 @@ struct sdw_slave_ops {
 	int (*port_prep)(struct sdw_slave *slave,
 			 struct sdw_prepare_ch *prepare_ch,
 			 enum sdw_port_prep_ops pre_ops);
-	int (*get_clk_stop_mode)(struct sdw_slave *slave);
 	int (*clk_stop)(struct sdw_slave *slave,
 			enum sdw_clk_stop_mode mode,
 			enum sdw_clk_stop_type type);
@@ -675,7 +674,6 @@ struct sdw_slave {
 	struct list_head node;
 	struct completion port_ready[SDW_MAX_PORTS];
 	unsigned int m_port_map[SDW_MAX_PORTS];
-	enum sdw_clk_stop_mode curr_clk_stop_mode;
 	u16 dev_num;
 	u16 dev_num_sticky;
 	bool probed;
-- 
2.17.1

