Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0283C7DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 07:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhGNFQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:16:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:14138 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:16:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="190665815"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="190665815"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 22:14:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="505096283"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 22:13:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: cadence: add paranoid check on self-clearing bits
Date:   Wed, 14 Jul 2021 13:13:49 +0800
Message-Id: <20210714051349.13064-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The Cadence IP exposes a small number of self-clearing bits in
the MCP_CONTROL and MCP_CONFIG_UPDATE registers.

We currently do not check that those bits are indeed cleared,
e.g. during resume operations. That could lead to resuming peripheral
devices too early.

In addition, if we happen to read these registers, update one of the
fields and write the register back, we may be writing stale data that
might have been cleared in hardware. These sort of race conditions
could lead to e.g. doing a hw_reset twice or stopping a clock that
just restarted. There is no clear way of avoiding these potential race
conditions other than making sure that these registers fields are
cleared before any read-modify-write sequence. If we detect this sort
of errors, we only log them since there is no clear recovery
possible. The only way out is likely to restart the IP with a
suspend/resume cycle.

Note that the checks are performed before updating the registers, as
well as after the Intel 'sync go' sequence in multi-link mode. That
should cover both the start and end of suspend/resume hardware
configurations. The Multi-Master mode gates the configuration updates
until the 'sync go' signal is asserted, so we only check on init and
after the end of the 'sync go' sequence.

The duration of the usleep_range() was defined by the GSYNC frequency
used in multi-master mode. With a 4kHz frequency, any configuration
change might be deferred by up to 250us. Extending the range to
1000-1500us should guarantee that the configuration change is
completed without any significant impact on the overall resume
time.

Suggested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 47 ++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  4 +++
 drivers/soundwire/intel.c          | 14 +++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index c7372519452b..0b7f037e6cd0 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -979,6 +979,49 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 
 }
 
+/* paranoia check to make sure self-cleared bits are indeed cleared */
+void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string,
+				       bool initial_delay, int reset_iterations)
+{
+	u32 mcp_control;
+	u32 mcp_config_update;
+	int i;
+
+	if (initial_delay)
+		usleep_range(1000, 1500);
+
+	mcp_control = cdns_readl(cdns, CDNS_MCP_CONTROL);
+
+	/* the following bits should be cleared immediately */
+	if (mcp_control & CDNS_MCP_CONTROL_CMD_RST)
+		dev_err(cdns->dev, "%s failed: MCP_CONTROL_CMD_RST is not cleared\n", string);
+	if (mcp_control & CDNS_MCP_CONTROL_SOFT_RST)
+		dev_err(cdns->dev, "%s failed: MCP_CONTROL_SOFT_RST is not cleared\n", string);
+	if (mcp_control & CDNS_MCP_CONTROL_SW_RST)
+		dev_err(cdns->dev, "%s failed: MCP_CONTROL_SW_RST is not cleared\n", string);
+	if (mcp_control & CDNS_MCP_CONTROL_CLK_STOP_CLR)
+		dev_err(cdns->dev, "%s failed: MCP_CONTROL_CLK_STOP_CLR is not cleared\n", string);
+	mcp_config_update = cdns_readl(cdns, CDNS_MCP_CONFIG_UPDATE);
+	if (mcp_config_update & CDNS_MCP_CONFIG_UPDATE_BIT)
+		dev_err(cdns->dev, "%s failed: MCP_CONFIG_UPDATE_BIT is not cleared\n", string);
+
+	i = 0;
+	while (mcp_control & CDNS_MCP_CONTROL_HW_RST) {
+		if (i == reset_iterations) {
+			dev_err(cdns->dev, "%s failed: MCP_CONTROL_HW_RST is not cleared\n", string);
+			break;
+		}
+
+		dev_dbg(cdns->dev, "%s: MCP_CONTROL_HW_RST is not cleared at iteration %d\n", string, i);
+		i++;
+
+		usleep_range(1000, 1500);
+		mcp_control = cdns_readl(cdns, CDNS_MCP_CONTROL);
+	}
+
+}
+EXPORT_SYMBOL(sdw_cdns_check_self_clearing_bits);
+
 /*
  * init routines
  */
@@ -1256,6 +1299,8 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	cdns_init_clock_ctrl(cdns);
 
+	sdw_cdns_check_self_clearing_bits(cdns, __func__, false, 0);
+
 	/* reset msg_count to default value of FIFOLEVEL */
 	cdns->msg_count = cdns_readl(cdns, CDNS_MCP_FIFOLEVEL);
 
@@ -1500,6 +1545,8 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 	struct sdw_slave *slave;
 	int ret;
 
+	sdw_cdns_check_self_clearing_bits(cdns, __func__, false, 0);
+
 	/* Check suspend status */
 	if (sdw_cdns_is_clock_stop(cdns)) {
 		dev_dbg(cdns->dev, "Clock is already stopped\n");
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 6c039d456ba8..e587aede63bf 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -187,4 +187,8 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 			void *stream, bool pcm, int direction);
+
+void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string,
+				       bool initial_delay, int reset_iterations);
+
 #endif /* __SDW_CADENCE_H */
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 15668d6fecd6..fb9c23e13206 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -23,6 +23,7 @@
 #include "intel.h"
 
 #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
+#define INTEL_MASTER_RESET_ITERATIONS	10
 
 /*
  * debug/config flags for the Intel SoundWire Master.
@@ -1393,6 +1394,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 			goto err_interrupt;
 		}
 	}
+	sdw_cdns_check_self_clearing_bits(cdns, __func__,
+					  true, INTEL_MASTER_RESET_ITERATIONS);
 
 	/* Register DAIs */
 	ret = intel_register_dai(sdw);
@@ -1709,6 +1712,8 @@ static int __maybe_unused intel_resume(struct device *dev)
 			return ret;
 		}
 	}
+	sdw_cdns_check_self_clearing_bits(cdns, __func__,
+					  true, INTEL_MASTER_RESET_ITERATIONS);
 
 	/*
 	 * after system resume, the pm_runtime suspend() may kick in
@@ -1793,6 +1798,9 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 				return ret;
 			}
 		}
+		sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime TEARDOWN",
+						  true, INTEL_MASTER_RESET_ITERATIONS);
+
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
 		ret = intel_init(sdw);
 		if (ret) {
@@ -1866,6 +1874,9 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 				}
 			}
 		}
+		sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime BUS_RESET",
+						  true, INTEL_MASTER_RESET_ITERATIONS);
+
 	} else if (!clock_stop_quirks) {
 
 		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
@@ -1889,6 +1900,9 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 			dev_err(dev, "unable to resume master during resume\n");
 			return ret;
 		}
+
+		sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime no_quirks",
+						  true, INTEL_MASTER_RESET_ITERATIONS);
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.17.1

