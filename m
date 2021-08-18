Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9383EF852
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhHRDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:02:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:40601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhHRDC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:02:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203392044"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203392044"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 20:01:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="462602171"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 20:01:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: cadence: do not extend reset delay
Date:   Wed, 18 Aug 2021 11:01:30 +0800
Message-Id: <20210818030130.17113-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The duration of the hw_reset is defined as 4096 cycles. The Cadence IP
allows for an additional delay which doesn't seem necessary in
practice: the actual reset sequence duration is defined by the sync_go
mechanism, not by the IP itself.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 0b7f037e6cd0..4fcc3ba93004 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1032,10 +1032,7 @@ EXPORT_SYMBOL(sdw_cdns_check_self_clearing_bits);
  */
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 {
-	/* program maximum length reset to be safe */
-	cdns_updatel(cdns, CDNS_MCP_CONTROL,
-		     CDNS_MCP_CONTROL_RST_DELAY,
-		     CDNS_MCP_CONTROL_RST_DELAY);
+	/* keep reset delay unchanged to 4096 cycles */
 
 	/* use hardware generated reset */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL,
-- 
2.17.1

