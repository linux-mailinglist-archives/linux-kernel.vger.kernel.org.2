Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A875234545C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhCWBAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:00:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:63384 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhCWA7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:59:23 -0400
IronPort-SDR: rEePgS5oKtzQUiYM5drB2gEx0JyGWSbCYmCAvxQ4ZkjqGHDlg+1VQ4ZOcxBmBvcmiR8pgZnQM8
 Whvw1r63X+Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="188061161"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="188061161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:22 -0700
IronPort-SDR: Lwab92Cr7e8SJhfBRRzpWRBNK6FYvjtDlZ187zYcbUamm18txlaKHZ3WgWVvogPlikmHNZjD9k
 Nec8vWvQHhwQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414728360"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:15 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/5] soundwire: stream: add missing \n in dev_err()
Date:   Tue, 23 Mar 2021 08:58:54 +0800
Message-Id: <20210323005855.20890-5-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/stream.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 1099b5d1262b..4915676c4ac2 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1513,7 +1513,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 		if (bus->compute_params) {
 			ret = bus->compute_params(bus);
 			if (ret < 0) {
-				dev_err(bus->dev, "Compute params failed: %d",
+				dev_err(bus->dev, "Compute params failed: %d\n",
 					ret);
 				return ret;
 			}
@@ -1791,7 +1791,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 		if (bus->compute_params) {
 			ret = bus->compute_params(bus);
 			if (ret < 0) {
-				dev_err(bus->dev, "Compute params failed: %d",
+				dev_err(bus->dev, "Compute params failed: %d\n",
 					ret);
 				return ret;
 			}
@@ -1855,7 +1855,7 @@ static int set_stream(struct snd_pcm_substream *substream,
 	for_each_rtd_dais(rtd, i, dai) {
 		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
 		if (ret < 0) {
-			dev_err(rtd->dev, "failed to set stream pointer on dai %s", dai->name);
+			dev_err(rtd->dev, "failed to set stream pointer on dai %s\n", dai->name);
 			break;
 		}
 	}
@@ -1888,7 +1888,7 @@ int sdw_startup_stream(void *sdw_substream)
 
 	sdw_stream = sdw_alloc_stream(name);
 	if (!sdw_stream) {
-		dev_err(rtd->dev, "alloc stream failed for substream DAI %s", substream->name);
+		dev_err(rtd->dev, "alloc stream failed for substream DAI %s\n", substream->name);
 		ret = -ENOMEM;
 		goto error;
 	}
@@ -1927,7 +1927,7 @@ void sdw_shutdown_stream(void *sdw_substream)
 	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
 
 	if (IS_ERR(sdw_stream)) {
-		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
+		dev_err(rtd->dev, "no stream found for DAI %s\n", dai->name);
 		return;
 	}
 
-- 
2.17.1

