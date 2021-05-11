Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E5379D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEKCyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:54:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:8275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhEKCyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:54:05 -0400
IronPort-SDR: 1+SOHC33RwjVc1u/tZH7FJSQsp4lgbbWZAtX/Q1Y0MqykmzZzO8aD1yPbdy/xox7sEtzGeqZbz
 3pbKSNjDH9qg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199392463"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199392463"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:52:59 -0700
IronPort-SDR: a+LmUs2pnZ3NWKyOeSYzMi/t/Df9BoWLcrqScvL0XZf5gG1VytkbFj1TPq1XCvFReO7mdS77gO
 kn6QP3tlBz7w==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436428063"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:52:56 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH] soundwire: cadence_master: always set CMD_ACCEPT
Date:   Tue, 11 May 2021 10:52:47 +0800
Message-Id: <20210511025247.25339-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The Cadence IP can be configured in two different ways to deal with
CMD_IGNORED replies to broadcast commands. The CMD_ACCEPT bitfield
controls whether the command is discarded or if the IP proceeds with
the change (typically a bank switch or clock stop command).

The existing code seems to be inconsistent:
a) For some historical reason, we set this CMD_ACCEPT bitfield during
the initialization, but we don't during a resume from a clock-stoppped
state.
b) In addition, the loop used in the clock-stop sequence is quite
racy, it's possible that a device has lost sync but it's still tagged
as ATTACHED.
c) If somehow a Device loses sync and is unable to ack a broadcast
command, we do not have an error handling mechanism anyways. The IP
should go ahead and let the Device regain sync at a later time.

Make sure the CMD_ACCEPT bit is always set.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 192dac10f0c2..25950422b085 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1428,20 +1428,6 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 		}
 	}
 
-	/*
-	 * This CMD_ACCEPT should be used when there are no devices
-	 * attached on the link when entering clock stop mode. If this is
-	 * not set and there is a broadcast write then the command ignored
-	 * will be treated as a failure
-	 */
-	if (!slave_present)
-		cdns_updatel(cdns, CDNS_MCP_CONTROL,
-			     CDNS_MCP_CONTROL_CMD_ACCEPT,
-			     CDNS_MCP_CONTROL_CMD_ACCEPT);
-	else
-		cdns_updatel(cdns, CDNS_MCP_CONTROL,
-			     CDNS_MCP_CONTROL_CMD_ACCEPT, 0);
-
 	/* commit changes */
 	ret = cdns_config_update(cdns);
 	if (ret < 0) {
@@ -1508,11 +1494,8 @@ int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
 	cdns_updatel(cdns, CDNS_MCP_CONTROL,
 		     CDNS_MCP_CONTROL_BLOCK_WAKEUP, 0);
 
-	/*
-	 * clear CMD_ACCEPT so that the command ignored
-	 * will be treated as a failure during a broadcast write
-	 */
-	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT, 0);
+	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
+		     CDNS_MCP_CONTROL_CMD_ACCEPT);
 
 	if (!bus_reset) {
 
-- 
2.17.1

