Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B0134A3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhCZJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:15:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:23502 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhCZJPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:37 -0400
IronPort-SDR: HBmeBkW36qcvnA8mIjrrkRNS+vQDk8lSQnUE5qdaFTQYTRXo91rFfofVykToRCCM8eanNTIK7t
 RCZ/gC8YDXlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269562"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:33 -0700
IronPort-SDR: RF5j6OdW2lolHQ5vDF/92d3zBfcEV2xiffnyqc6SlcHhSoFO9Os8VizvW+SjZ1r9PETWRco5YM
 aE1fsPvIx7zw==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463117"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 02/11] soundwire: bus: test read status
Date:   Fri, 26 Mar 2021 17:15:05 +0800
Message-Id: <20210326091514.20751-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In the existing code we may read a negative error value but still mask
it and write it back.

Make sure all reads are tested and errors not propagated further.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 04eb879de145..1c01cc192cbd 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -875,8 +875,12 @@ static int sdw_slave_clk_stop_prepare(struct sdw_slave *slave,
 		if (wake_en)
 			val |= SDW_SCP_SYSTEMCTRL_WAKE_UP_EN;
 	} else {
-		val = sdw_read_no_pm(slave, SDW_SCP_SYSTEMCTRL);
-
+		ret = sdw_read_no_pm(slave, SDW_SCP_SYSTEMCTRL);
+		if (ret < 0) {
+			dev_err(&slave->dev, "SDW_SCP_SYSTEMCTRL read failed:%d\n", ret);
+			return ret;
+		}
+		val = ret;
 		val &= ~(SDW_SCP_SYSTEMCTRL_CLK_STP_PREP);
 	}
 
@@ -895,8 +899,12 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 	int val;
 
 	do {
-		val = sdw_bread_no_pm(bus, dev_num, SDW_SCP_STAT) &
-			SDW_SCP_STAT_CLK_STP_NF;
+		val = sdw_bread_no_pm(bus, dev_num, SDW_SCP_STAT);
+		if (val < 0) {
+			dev_err(bus->dev, "SDW_SCP_STAT bread failed:%d\n", val);
+			return val;
+		}
+		val &= SDW_SCP_STAT_CLK_STP_NF;
 		if (!val) {
 			dev_info(bus->dev, "clock stop prep/de-prep done slave:%d",
 				 dev_num);
-- 
2.17.1

