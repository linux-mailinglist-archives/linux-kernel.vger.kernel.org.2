Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2A32A28D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381595AbhCBIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:05:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:13749 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381489AbhCBHw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:52:59 -0500
IronPort-SDR: RfceoL4V5cX0DhuLSgTknlzlgEsOusq0wasTw6uiW7QLKMAtjMl9gOOoQNH7O2tnSMV5+YD/y/
 nKKcPiF7E9ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186782232"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186782232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:12 -0800
IronPort-SDR: Ty2gXSthuG83IcKpD6Fh4A7tEcHjHullYgyy6DLzHkzTUvzN6v57U8Q1hFz1T10rcCPMzRyzKK
 /HmwwQlPXDbA==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406597576"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:08 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/3] soundwire: add override addr ops
Date:   Tue,  2 Mar 2021 15:51:03 +0800
Message-Id: <20210302075105.11515-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Platform firmware may have incorrect _ADR values causing the driver
probes to fail. Add the override_ops, which when configured will allow
for quirks based on DMI etc to override the addr values.

Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/slave.c     | 8 +++++++-
 include/linux/soundwire/sdw.h | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 180f38bd003b..112b21967c7a 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -95,7 +95,7 @@ static bool find_slave(struct sdw_bus *bus,
 		       struct acpi_device *adev,
 		       struct sdw_slave_id *id)
 {
-	unsigned long long addr;
+	u64 addr;
 	unsigned int link_id;
 	acpi_status status;
 
@@ -108,6 +108,12 @@ static bool find_slave(struct sdw_bus *bus,
 		return false;
 	}
 
+	if (bus->ops->override_adr)
+		addr = bus->ops->override_adr(bus, addr);
+
+	if (!addr)
+		return false;
+
 	/* Extract link id from ADR, Bit 51 to 48 (included) */
 	link_id = SDW_DISCO_LINK_ID(addr);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d08039d65825..f0a3895e8faf 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -804,6 +804,7 @@ struct sdw_defer {
 /**
  * struct sdw_master_ops - Master driver ops
  * @read_prop: Read Master properties
+ * @override_adr: Override value read from firmware (quirk for buggy firmware)
  * @xfer_msg: Transfer message callback
  * @xfer_msg_defer: Defer version of transfer message callback
  * @reset_page_addr: Reset the SCP page address registers
@@ -813,7 +814,8 @@ struct sdw_defer {
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
-
+	u64 (*override_adr)
+			(struct sdw_bus *bus, u64 addr);
 	enum sdw_command_response (*xfer_msg)
 			(struct sdw_bus *bus, struct sdw_msg *msg);
 	enum sdw_command_response (*xfer_msg_defer)
-- 
2.17.1

