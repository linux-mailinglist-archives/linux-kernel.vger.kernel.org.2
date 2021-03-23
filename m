Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A0345458
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCWA7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:59:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:63366 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhCWA7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:59:12 -0400
IronPort-SDR: tGjAll+aMYyyq9sT2r/qiHXTHtT8wb22nHv21LuWlY/XTHuCKtoNWRkERrQPIRAYXLjnO+AZ+5
 Ne96zZo8yoLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188061151"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188061151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:12 -0700
IronPort-SDR: sRu60T7p7qXveA0sE8lUKGVPJidnBMHfWbq7Sy41RVxRT9rRuwU5CWysHVNcZdoZgGk/sg+plu
 pIcGZBFS1TmA==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414728338"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:09 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/5] soundwire: bandwidth_allocation: add missing \n in dev_err()
Date:   Tue, 23 Mar 2021 08:58:52 +0800
Message-Id: <20210323005855.20890-3-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/generic_bandwidth_allocation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 0bdef38c9a30..a9abb9722fde 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -406,14 +406,14 @@ int sdw_compute_params(struct sdw_bus *bus)
 	/* Computes clock frequency, frame shape and frame frequency */
 	ret = sdw_compute_bus_params(bus);
 	if (ret < 0) {
-		dev_err(bus->dev, "Compute bus params failed: %d", ret);
+		dev_err(bus->dev, "Compute bus params failed: %d\n", ret);
 		return ret;
 	}
 
 	/* Compute transport and port params */
 	ret = sdw_compute_port_params(bus);
 	if (ret < 0) {
-		dev_err(bus->dev, "Compute transport params failed: %d", ret);
+		dev_err(bus->dev, "Compute transport params failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

