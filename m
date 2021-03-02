Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6932A325
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381961AbhCBIrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:47:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:9397 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446335AbhCBIdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:33:06 -0500
IronPort-SDR: lHFgXLrq/JBPHwhR+lFK/2Frnnt199URsiQBVGN+miIgwiZ++oRf3Qg9Fw7viWGMays7RsF5ra
 qe2JBFnh0vaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="183340420"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183340420"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:31 -0800
IronPort-SDR: xAlpQ8JXAmQ+n8fC89bie0evDYi+YCMqQXG2YNdWADQCthuTTF9VGQiK2yCWnJZzLAG1JTToOU
 9V+Qs2wrzwRQ==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406613472"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:27 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/3] soundwire: bus: handle master quirks for bus clash and parity
Date:   Tue,  2 Mar 2021 16:27:19 +0800
Message-Id: <20210302082720.12322-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional interrupt status read/clear if the master quirks are set.

In the case of the parity, the master quirk is only applied if the
Slave doesn't already have a parity-related quirk.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/bus.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 46885429928a..04eb879de145 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1253,6 +1253,7 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 static int sdw_initialize_slave(struct sdw_slave *slave)
 {
 	struct sdw_slave_prop *prop = &slave->prop;
+	int status;
 	int ret;
 	u8 val;
 
@@ -1260,6 +1261,44 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
+	if (slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH) {
+		/* Clear bus clash interrupt before enabling interrupt mask */
+		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
+		if (status < 0) {
+			dev_err(&slave->dev,
+				"SDW_SCP_INT1 (BUS_CLASH) read failed:%d\n", status);
+			return status;
+		}
+		if (status & SDW_SCP_INT1_BUS_CLASH) {
+			dev_warn(&slave->dev, "Bus clash detected before INT mask is enabled\n");
+			ret = sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_BUS_CLASH);
+			if (ret < 0) {
+				dev_err(&slave->dev,
+					"SDW_SCP_INT1 (BUS_CLASH) write failed:%d\n", ret);
+				return ret;
+			}
+		}
+	}
+	if ((slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY) &&
+	    !(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
+		/* Clear parity interrupt before enabling interrupt mask */
+		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
+		if (status < 0) {
+			dev_err(&slave->dev,
+				"SDW_SCP_INT1 (PARITY) read failed:%d\n", status);
+			return status;
+		}
+		if (status & SDW_SCP_INT1_PARITY) {
+			dev_warn(&slave->dev, "PARITY error detected before INT mask is enabled\n");
+			ret = sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_PARITY);
+			if (ret < 0) {
+				dev_err(&slave->dev,
+					"SDW_SCP_INT1 (PARITY) write failed:%d\n", ret);
+				return ret;
+			}
+		}
+	}
+
 	/*
 	 * Set SCP_INT1_MASK register, typically bus clash and
 	 * implementation-defined interrupt mask. The Parity detection
-- 
2.17.1

