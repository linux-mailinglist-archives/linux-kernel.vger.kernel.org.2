Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCD34A3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCZJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:15:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:23494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhCZJPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:45 -0400
IronPort-SDR: q+fb2tv+J9FfIbK5Dj68WnTu5U2yMdR1dp8qScNeApKxsTLkEex1RKsQ6YPZuEn8x1GGbszQcx
 gNobg1soWFvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269568"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269568"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:36 -0700
IronPort-SDR: NOvwMtJaoz5WG+xXOYwL/bLRH36ZzvRkA+RNjcEX8tDjTFgc3g7yIyBRPY8UluuCD9t3HwaTac
 VlQWF3x9ztQg==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463131"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:33 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 03/11] soundwire: bus: use consistent tests for return values
Date:   Fri, 26 Mar 2021 17:15:06 +0800
Message-Id: <20210326091514.20751-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We use different styles to check the return values of IO related
routines. The majority of the cases use 'if (ret < 0)', align the
remaining cases for consistency.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1c01cc192cbd..d39e5baa3e64 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -44,13 +44,13 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 	}
 
 	ret = sdw_get_id(bus);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(parent, "Failed to get bus id\n");
 		return ret;
 	}
 
 	ret = sdw_master_device_add(bus, parent, fwnode);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(parent, "Failed to add master device at link %d\n",
 			bus->link_id);
 		return ret;
@@ -121,7 +121,7 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 	else
 		ret = -ENOTSUPP; /* No ACPI/DT so error out */
 
-	if (ret) {
+	if (ret < 0) {
 		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
 		return ret;
 	}
@@ -422,7 +422,7 @@ sdw_bread_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr)
 
 	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
 			   SDW_MSG_FLAG_READ, &buf);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = sdw_transfer(bus, &msg);
@@ -440,7 +440,7 @@ sdw_bwrite_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value)
 
 	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
 			   SDW_MSG_FLAG_WRITE, &value);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sdw_transfer(bus, &msg);
@@ -454,7 +454,7 @@ int sdw_bread_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr)
 
 	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
 			   SDW_MSG_FLAG_READ, &buf);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = sdw_transfer_unlocked(bus, &msg);
@@ -472,7 +472,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 
 	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
 			   SDW_MSG_FLAG_WRITE, &value);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sdw_transfer_unlocked(bus, &msg);
@@ -749,7 +749,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 				 * dev_num
 				 */
 				ret = sdw_assign_device_num(slave);
-				if (ret) {
+				if (ret < 0) {
 					dev_err(bus->dev,
 						"Assign dev_num failed:%d\n",
 						ret);
@@ -886,7 +886,7 @@ static int sdw_slave_clk_stop_prepare(struct sdw_slave *slave,
 
 	ret = sdw_write_no_pm(slave, SDW_SCP_SYSTEMCTRL, val);
 
-	if (ret != 0)
+	if (ret < 0)
 		dev_err(&slave->dev,
 			"Clock Stop prepare failed for slave: %d", ret);
 
@@ -1748,7 +1748,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 	if (status[0] == SDW_SLAVE_ATTACHED) {
 		dev_dbg(bus->dev, "Slave attached, programming device number\n");
 		ret = sdw_program_device_num(bus);
-		if (ret)
+		if (ret < 0)
 			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
 		/*
 		 * programming a device number will have side effects,
@@ -1782,7 +1782,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 		case SDW_SLAVE_ALERT:
 			ret = sdw_handle_slave_alerts(slave);
-			if (ret)
+			if (ret < 0)
 				dev_err(&slave->dev,
 					"Slave %d alert handling failed: %d\n",
 					i, ret);
@@ -1801,7 +1801,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			attached_initializing = true;
 
 			ret = sdw_initialize_slave(slave);
-			if (ret)
+			if (ret < 0)
 				dev_err(&slave->dev,
 					"Slave %d initialization failed: %d\n",
 					i, ret);
@@ -1815,7 +1815,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		}
 
 		ret = sdw_update_slave_status(slave, status[i]);
-		if (ret)
+		if (ret < 0)
 			dev_err(&slave->dev,
 				"Update Slave status failed:%d\n", ret);
 		if (attached_initializing) {
-- 
2.17.1

