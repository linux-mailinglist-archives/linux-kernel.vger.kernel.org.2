Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9334A3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCZJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:15:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:23502 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhCZJPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:45 -0400
IronPort-SDR: jQpJ9da+UGgQ/I2ixej3iltYZ7U4n+WTitY+0sXeh4QmP3tunvvBMXGbDXgWyY3y35P6VqWuay
 7uGLSvdpzySQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269573"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:39 -0700
IronPort-SDR: pQW47v0JFARr6JLBn0yoFidywlZkX2laYcBYO1f3AY0YiJ6VwYa1ENOIR5tKzggUHB8yu/VQVj
 Drx6fv2A3RXA==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463153"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 04/11] soundwire: bus: demote clock stop prepare log to dev_dbg()
Date:   Fri, 26 Mar 2021 17:15:07 +0800
Message-Id: <20210326091514.20751-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There is no real reason to provide this information except for debug
sessions, hence dev_dbg() is a better fit.

Reported-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d39e5baa3e64..8b6d8fe934ae 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -906,8 +906,8 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		}
 		val &= SDW_SCP_STAT_CLK_STP_NF;
 		if (!val) {
-			dev_info(bus->dev, "clock stop prep/de-prep done slave:%d",
-				 dev_num);
+			dev_dbg(bus->dev, "clock stop prep/de-prep done slave:%d",
+				dev_num);
 			return 0;
 		}
 
-- 
2.17.1

