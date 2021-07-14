Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6D93C7BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbhGNCt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:49:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:8778 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237678AbhGNCt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:49:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210253422"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210253422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 19:46:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="493593226"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 19:46:33 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/6] ASoC: SOF: intel: move sof_intel_dsp_desc() forward
Date:   Wed, 14 Jul 2021 10:46:12 +0800
Message-Id: <20210714024614.9357-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714024614.9357-1-yung-chuan.liao@linux.intel.com>
References: <20210714024614.9357-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sof_intel_dsp_desc() will be used by hda_dsp_check_sdw_irq() in the
following commit.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e48e030f6005..79388489c4e2 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -41,6 +41,17 @@
 #define EXCEPT_MAX_HDR_SIZE	0x400
 #define HDA_EXT_ROM_STATUS_SIZE 8
 
+static const struct sof_intel_dsp_desc
+	*get_chip_info(struct snd_sof_pdata *pdata)
+{
+	const struct sof_dev_desc *desc = pdata->desc;
+	const struct sof_intel_dsp_desc *chip_info;
+
+	chip_info = desc->chip_info;
+
+	return chip_info;
+}
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
 /*
@@ -668,17 +679,6 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	return 0;
 }
 
-static const struct sof_intel_dsp_desc
-	*get_chip_info(struct snd_sof_pdata *pdata)
-{
-	const struct sof_dev_desc *desc = pdata->desc;
-	const struct sof_intel_dsp_desc *chip_info;
-
-	chip_info = desc->chip_info;
-
-	return chip_info;
-}
-
 static irqreturn_t hda_dsp_interrupt_handler(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
-- 
2.17.1

