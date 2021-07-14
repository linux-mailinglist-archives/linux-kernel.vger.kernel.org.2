Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C883C7B23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhGNBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:45:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:50663 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhGNBpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:45:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="274100597"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="274100597"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 18:42:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="459796564"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 18:42:17 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: bus: filter out more -EDATA errors on clock stop
Date:   Wed, 14 Jul 2021 09:42:09 +0800
Message-Id: <20210714014209.17357-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We've added quite a few filters to avoid throwing errors if a Device
does not respond to commands during the clock stop sequences, but we
missed one.

This will lead to an isolated message
[ 6115.294412] soundwire sdw-master-1: SDW_SCP_STAT bread failed:-61

The callers already filter this error code, so there's no point in
keeping it at the lower level.

Since this is a recoverable error, make this dev_err() conditional and
only log cases with Command Failed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3e6d4addac2f..278a4fbdb88d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -896,7 +896,8 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 	do {
 		val = sdw_bread_no_pm(bus, dev_num, SDW_SCP_STAT);
 		if (val < 0) {
-			dev_err(bus->dev, "SDW_SCP_STAT bread failed:%d\n", val);
+			if (val != -ENODATA)
+				dev_err(bus->dev, "SDW_SCP_STAT bread failed:%d\n", val);
 			return val;
 		}
 		val &= SDW_SCP_STAT_CLK_STP_NF;
-- 
2.17.1

