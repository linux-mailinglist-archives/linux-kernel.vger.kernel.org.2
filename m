Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61233C7BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhGNCtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:49:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:8778 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237490AbhGNCtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:49:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210253419"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210253419"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 19:46:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="493593216"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 19:46:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/6] ASoC: SOF: intel: hda: remove HDA_DSP_REG_SNDW_WAKE_STS definition
Date:   Wed, 14 Jul 2021 10:46:11 +0800
Message-Id: <20210714024614.9357-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714024614.9357-1-yung-chuan.liao@linux.intel.com>
References: <20210714024614.9357-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA_DSP_REG_SNDW_WAKE_STS is actually (SDW_SHIM_BASE + SDW_SHIM_WAKESTS)
and SDW_SHIM_BASE is platform-dependent. Removing HDA_DSP_REG_SNDW_WAKE_STS
and use (hdev->desc->sdw_shim_base + SDW_SHIM_WAKESTS) instead.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 2 +-
 sound/soc/sof/intel/hda.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e1e368ff2b12..e48e030f6005 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -249,7 +249,7 @@ static bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
 	hdev = sdev->pdata->hw_pdata;
 	if (hdev->sdw &&
 	    snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-			     HDA_DSP_REG_SNDW_WAKE_STS))
+			     hdev->desc->sdw_shim_base + SDW_SHIM_WAKESTS))
 		return true;
 
 	return false;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 4d44f8910393..06ea0006999a 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -233,7 +233,6 @@
 #define HDA_DSP_REG_ADSPIS2		(HDA_DSP_GEN_BASE + 0x14)
 
 #define HDA_DSP_REG_ADSPIS2_SNDW	BIT(5)
-#define HDA_DSP_REG_SNDW_WAKE_STS      0x2C192
 
 /* Intel HD Audio Inter-Processor Communication Registers */
 #define HDA_DSP_IPC_BASE		0x40
-- 
2.17.1

