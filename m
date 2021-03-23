Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29823345459
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhCWA7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:59:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:63366 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231172AbhCWA7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:59:15 -0400
IronPort-SDR: NgnXM4xfwGxOe+FwF+CK4w02MBx2T4OY6GuzGqh2gzbzZkNcIBIeVOm4A8j4yQ3uFoeD/viKtY
 /UFJFffGo6rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188061153"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188061153"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:15 -0700
IronPort-SDR: F1wX+Xi+TbDUIKuJ9J+eNAu6OlRmZx+5UQFaNA7+CyjpxgmWPG7aXO/qho9LIuxdvKlR+mKTK7
 Wi8oGcndI/2g==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414728350"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:12 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/5] soundwire: cadence: add missing \n in dev_err()
Date:   Tue, 23 Mar 2021 08:58:53 +0800
Message-Id: <20210323005855.20890-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
References: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We fixed a lot of warnings in 2019 but the magic of copy-paste keeps
adding new ones...

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d05442e646a3..1b50cf7abe66 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1462,7 +1462,7 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 	 */
 	ret = sdw_bus_clk_stop(&cdns->bus);
 	if (ret < 0 && slave_present && ret != -ENODATA) {
-		dev_err(cdns->dev, "bus clock stop failed %d", ret);
+		dev_err(cdns->dev, "bus clock stop failed %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

