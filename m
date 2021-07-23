Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0169D3D39CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhGWLOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:14:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:17835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234756AbhGWLOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:14:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211921821"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="211921821"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455069799"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:13 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 5/6] ASoC: SOF: intel: add snd_sof_dsp_check_sdw_irq ops
Date:   Fri, 23 Jul 2021 19:54:50 +0800
Message-Id: <20210723115451.7245-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire IRQ status checks are platform-dependent, add new ops structure
to provide abstraction.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c  |  2 ++
 sound/soc/sof/intel/hda.c  | 13 ++++++++++++-
 sound/soc/sof/intel/hda.h  |  7 +++++++
 sound/soc/sof/intel/icl.c  |  1 +
 sound/soc/sof/intel/shim.h |  1 +
 sound/soc/sof/intel/tgl.c  |  4 ++++
 6 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index acc07cfbc8e3..e115e12a856f 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -349,6 +349,7 @@ const struct sof_intel_dsp_desc cnl_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(cnl_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
 
@@ -367,5 +368,6 @@ const struct sof_intel_dsp_desc jsl_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(jsl_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 79388489c4e2..c979581c6812 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -222,7 +222,7 @@ static int hda_sdw_exit(struct snd_sof_dev *sdev)
 	return 0;
 }
 
-static bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
+bool hda_common_check_sdw_irq(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hdev;
 	bool ret = false;
@@ -248,6 +248,17 @@ static bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
 	return ret;
 }
 
+static bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
+{
+	const struct sof_intel_dsp_desc *chip;
+
+	chip = get_chip_info(sdev->pdata);
+	if (chip && chip->check_sdw_irq)
+		return chip->check_sdw_irq(sdev);
+
+	return false;
+}
+
 static irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
 {
 	return sdw_intel_thread(irq, context);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 06ea0006999a..4fdfb108645c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -691,6 +691,7 @@ int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 int hda_sdw_startup(struct snd_sof_dev *sdev);
 void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
 void hda_sdw_process_wakeen(struct snd_sof_dev *sdev);
+bool hda_common_check_sdw_irq(struct snd_sof_dev *sdev);
 
 #else
 
@@ -736,6 +737,12 @@ static inline bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
 static inline void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
 {
 }
+
+static inline bool hda_common_check_sdw_irq(struct snd_sof_dev *sdev)
+{
+	return false;
+}
+
 #endif
 
 /* common dai driver */
diff --git a/sound/soc/sof/intel/icl.c b/sound/soc/sof/intel/icl.c
index 74a14b24794c..ee095b8f2d01 100644
--- a/sound/soc/sof/intel/icl.c
+++ b/sound/soc/sof/intel/icl.c
@@ -144,5 +144,6 @@ const struct sof_intel_dsp_desc icl_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(icl_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index ee031248d834..e9f7d4d7fcce 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -166,6 +166,7 @@ struct sof_intel_dsp_desc {
 	int ssp_base_offset;		/* base address of the SSPs */
 	u32 sdw_shim_base;
 	u32 sdw_alh_base;
+	bool (*check_sdw_irq)(struct snd_sof_dev *sdev);
 };
 
 extern const struct snd_sof_dsp_ops sof_tng_ops;
diff --git a/sound/soc/sof/intel/tgl.c b/sound/soc/sof/intel/tgl.c
index 73aa45bc6f2b..199d41a7dc9b 100644
--- a/sound/soc/sof/intel/tgl.c
+++ b/sound/soc/sof/intel/tgl.c
@@ -139,6 +139,7 @@ const struct sof_intel_dsp_desc tgl_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(tgl_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
 
@@ -157,6 +158,7 @@ const struct sof_intel_dsp_desc tglh_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(tglh_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
 
@@ -175,6 +177,7 @@ const struct sof_intel_dsp_desc ehl_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(ehl_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
 
@@ -193,5 +196,6 @@ const struct sof_intel_dsp_desc adls_chip_info = {
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
+	.check_sdw_irq	= hda_common_check_sdw_irq,
 };
 EXPORT_SYMBOL_NS(adls_chip_info, SND_SOC_SOF_INTEL_HDA_COMMON);
-- 
2.17.1

