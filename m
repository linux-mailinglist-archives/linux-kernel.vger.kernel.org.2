Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22342345509
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCWBhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:37:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:12196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhCWBhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:37:18 -0400
IronPort-SDR: 9linQ+7uxITRR3/npm+JtXKd0/kpXoeloZ9SG+QbGeF3Xi6ViFtKNbHukgLAcLELZ7pVkPxc3t
 rANrmTH/UPKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="187066693"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="187066693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:37:18 -0700
IronPort-SDR: LueoOJ57yC2M11WdP6HPLUdVCcQLqXPql8W9NOXNUZYp5PE2gecktI2IXUFwLsiEYUXHBHABtb
 kq3yvkGYnABQ==
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="408068969"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:37:14 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: cadence: only prepare attached devices on clock stop
Date:   Tue, 23 Mar 2021 09:37:07 +0800
Message-Id: <20210323013707.21455-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We sometimes see COMMAND_IGNORED responses during the clock stop
sequence. It turns out we already have information if devices are
present on a link, so we should only prepare those when they
are attached.

In addition, even when COMMAND_IGNORED are received, we should still
proceed with the clock stop. The device will not be prepared but
that's not a problem.

The only case where the clock stop will fail is if the Cadence IP
reports an error (including a timeout), or if the devices throw a
COMMAND_FAILED response.

BugLink: https://github.com/thesofproject/linux/issues/2621
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d05442e646a3..57c59a33ce61 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1450,10 +1450,12 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 	}
 
 	/* Prepare slaves for clock stop */
-	ret = sdw_bus_prep_clk_stop(&cdns->bus);
-	if (ret < 0) {
-		dev_err(cdns->dev, "prepare clock stop failed %d", ret);
-		return ret;
+	if (slave_present) {
+		ret = sdw_bus_prep_clk_stop(&cdns->bus);
+		if (ret < 0 && ret != -ENODATA) {
+			dev_err(cdns->dev, "prepare clock stop failed %d\n", ret);
+			return ret;
+		}
 	}
 
 	/*
-- 
2.17.1

