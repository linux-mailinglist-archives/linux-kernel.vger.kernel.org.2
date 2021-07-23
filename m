Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605D43D39CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhGWLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:14:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:17835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234727AbhGWLOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:14:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211921811"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="211921811"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455069789"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:10 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 4/6] ASoC: SOF: intel: move sof_intel_dsp_desc() forward
Date:   Fri, 23 Jul 2021 19:54:49 +0800
Message-Id: <20210723115451.7245-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
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

