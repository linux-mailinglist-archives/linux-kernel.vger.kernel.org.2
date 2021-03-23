Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85759345457
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhCWA71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:59:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:63366 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhCWA7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:59:09 -0400
IronPort-SDR: hYKcuz6TBMtnoHFmyKRqGKW7AyN0lJQo6g2YMXEL/Af4aZ7wRMsHx3OGafYsgFM9AUNSJUTRPE
 1nwfQd8xWpjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188061149"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188061149"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:09 -0700
IronPort-SDR: teWCQMhQWj8rWy8khKlAmdGbYX74Cj+IUWpYvoKx7mIjzyMfY53uRbbk6CpN6NNvdEFKmpbJCP
 4BE0ZXKFX9dg==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414728323"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:06 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/5] soundwire: intel: add missing \n in dev_err()
Date:   Tue, 23 Mar 2021 08:58:51 +0800
Message-Id: <20210323005855.20890-2-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/intel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d2254ee2fee2..e2e95115832a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -997,7 +997,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s",
+		dev_err(dai->dev, "failed to get dma data in %s\n",
 			__func__);
 		return -EIO;
 	}
@@ -1061,7 +1061,7 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 
 	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
 	if (ret < 0) {
-		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
+		dev_err(dai->dev, "intel_free_stream: failed %d\n", ret);
 		return ret;
 	}
 
@@ -1634,7 +1634,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 
 	ret = intel_link_power_down(sdw);
 	if (ret) {
-		dev_err(dev, "Link power down failed: %d", ret);
+		dev_err(dev, "Link power down failed: %d\n", ret);
 		return ret;
 	}
 
@@ -1669,7 +1669,7 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 
 		ret = intel_link_power_down(sdw);
 		if (ret) {
-			dev_err(dev, "Link power down failed: %d", ret);
+			dev_err(dev, "Link power down failed: %d\n", ret);
 			return ret;
 		}
 
@@ -1693,7 +1693,7 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 
 		ret = intel_link_power_down(sdw);
 		if (ret) {
-			dev_err(dev, "Link power down failed: %d", ret);
+			dev_err(dev, "Link power down failed: %d\n", ret);
 			return ret;
 		}
 
@@ -1742,7 +1742,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 
 	ret = intel_init(sdw);
 	if (ret) {
-		dev_err(dev, "%s failed: %d", __func__, ret);
+		dev_err(dev, "%s failed: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -1826,7 +1826,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
 		ret = intel_init(sdw);
 		if (ret) {
-			dev_err(dev, "%s failed: %d", __func__, ret);
+			dev_err(dev, "%s failed: %d\n", __func__, ret);
 			return ret;
 		}
 
@@ -1871,7 +1871,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
 		ret = intel_init(sdw);
 		if (ret) {
-			dev_err(dev, "%s failed: %d", __func__, ret);
+			dev_err(dev, "%s failed: %d\n", __func__, ret);
 			return ret;
 		}
 
@@ -1949,7 +1949,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 
 		ret = intel_init(sdw);
 		if (ret) {
-			dev_err(dev, "%s failed: %d", __func__, ret);
+			dev_err(dev, "%s failed: %d\n", __func__, ret);
 			return ret;
 		}
 
-- 
2.17.1

