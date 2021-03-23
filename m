Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85434545B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCWA75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:59:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:33058 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhCWA7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:59:23 -0400
IronPort-SDR: 2Utz0ZxiMhKXBnMF5jpKhTkP+yq30wR7kE7rXsLOCqD2hIlDwjjd8lTpP5gwGjB/twKwHuwdrn
 BZA1yL4tIoYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275477959"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="275477959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:21 -0700
IronPort-SDR: 7qxBLx3CGvs7MyQO7MGcZgnf6ogpFI0tiAOT6tDpFdUffLVQbmHzhNaYayqEjY/kQ0WBKHfXdp
 QUIvmhpTp4dw==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414728370"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 17:59:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 5/5] soundwire: qcom: add missing \n in dev_err()
Date:   Tue, 23 Mar 2021 08:58:55 +0800
Message-Id: <20210323005855.20890-6-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6d22df01f354..9cce09cba068 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -652,7 +652,7 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 		ret = snd_soc_dai_set_sdw_stream(codec_dai, sruntime,
 						 substream->stream);
 		if (ret < 0 && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "Failed to set sdw stream on %s",
+			dev_err(dai->dev, "Failed to set sdw stream on %s\n",
 				codec_dai->name);
 			sdw_release_stream(sruntime);
 			return ret;
-- 
2.17.1

