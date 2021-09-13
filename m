Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4909440983C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbhIMQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:03:37 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:13688 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344165AbhIMQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9LE002377;
        Mon, 13 Sep 2021 11:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uvU6r4Nqgz/YCOcaAcLLxBcuewaZ+lrmvctjnct3PTw=;
 b=Tfs2ineifu0UsNg13gwhy+uejkzRvWz78DcOV73dAZxN3ne2mQmyk7xYoPJWgFVV9xG+
 b59qekeOLVlZEZ02u+ACIgmYrhd0WjdmRrsGFoI+mWmpEjexBUDfYSRLjro149wXbPyL
 wjKJkphLKcm0+GMLr7yuUvsCNa06XILZJtaBm3sbIIxfyo1x13lWG2p9wlYtYGZMXdBX
 5M41eIKmaV8gTWr8C/tfO8RErwBCffNOZcjZ0TvOo1/UjNJwmyZaYATDWelNM4KRpD/7
 nLPekQFo7yj4uTXJJ54dC8906CcTFFUjoXgqvA+XrNcsn2MTb/Hce8x+Xm7usdQTU9WF SA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:21 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 65C0F2A9;
        Mon, 13 Sep 2021 16:01:21 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 12/16] ASoC: wm_adsp: Pass firmware names as parameters when starting DSP core
Date:   Mon, 13 Sep 2021 17:00:53 +0100
Message-ID: <20210913160057.103842-13-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IwwJbQSpALsUihXCDgwAeN3box0Fr9Ml
X-Proofpoint-ORIG-GUID: IwwJbQSpALsUihXCDgwAeN3box0Fr9Ml
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for moving the generic DSP support out of ASoC pass the
firmware names used when loading files as parameters as the generic code
can't refer directly to the array specific to wm_adsp. The code
remaining in wm_adsp.c doesn't need to change, it can continue to use
the string arrays directly.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 43 +++++++++++++++++++++++---------------
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1c8bf818dab9..c2e1eb8ff357 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1499,7 +1499,7 @@ static int cs_dsp_create_control(struct wm_adsp *dsp,
 	int ret;
 
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		if (ctl->fw_name == dsp->fw_name &&
 		    ctl->alg_region.alg == alg_region->alg &&
 		    ctl->alg_region.type == alg_region->type) {
 			if ((!subname && !ctl->subname) ||
@@ -1514,7 +1514,8 @@ static int cs_dsp_create_control(struct wm_adsp *dsp,
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
 		return -ENOMEM;
-	ctl->fw_name = wm_adsp_fw_text[dsp->fw];
+
+	ctl->fw_name = dsp->fw_name;
 	ctl->alg_region = *alg_region;
 	if (subname && dsp->fw_ver >= 2) {
 		ctl->subname_len = subname_len;
@@ -1836,7 +1837,7 @@ static bool cs_dsp_halo_validate_version(struct wm_adsp *dsp, unsigned int versi
 	}
 }
 
-static int cs_dsp_load(struct wm_adsp *dsp)
+static int cs_dsp_load(struct wm_adsp *dsp, const char *fw_file_name)
 {
 	LIST_HEAD(buf_list);
 	const struct firmware *firmware;
@@ -1859,7 +1860,7 @@ static int cs_dsp_load(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	snprintf(file, PAGE_SIZE, "%s-%s-%s.wmfw", dsp->part, dsp->fwf_name,
-		 wm_adsp_fw[dsp->fw].file);
+		 fw_file_name);
 	file[PAGE_SIZE - 1] = '\0';
 
 	ret = request_firmware(&firmware, file, dsp->dev);
@@ -2047,13 +2048,12 @@ static struct cs_dsp_coeff_ctl *cs_dsp_get_ctl(struct wm_adsp *dsp,
 					       unsigned int alg)
 {
 	struct cs_dsp_coeff_ctl *pos, *rslt = NULL;
-	const char *fw_txt = wm_adsp_fw_text[dsp->fw];
 
 	list_for_each_entry(pos, &dsp->ctl_list, list) {
 		if (!pos->subname)
 			continue;
 		if (strncmp(pos->subname, name, pos->subname_len) == 0 &&
-		    pos->fw_name == fw_txt &&
+		    pos->fw_name == dsp->fw_name &&
 		    pos->alg_region.alg == alg &&
 		    pos->alg_region.type == type) {
 			rslt = pos;
@@ -2131,7 +2131,7 @@ static void cs_dsp_ctl_fixup_base(struct wm_adsp *dsp,
 	struct cs_dsp_coeff_ctl *ctl;
 
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		if (ctl->fw_name == dsp->fw_name &&
 		    alg_region->alg == ctl->alg_region.alg &&
 		    alg_region->type == ctl->alg_region.type) {
 			ctl->alg_region.base = alg_region->base;
@@ -2582,7 +2582,7 @@ static int cs_dsp_halo_setup_algs(struct wm_adsp *dsp)
 	return ret;
 }
 
-static int cs_dsp_load_coeff(struct wm_adsp *dsp)
+static int cs_dsp_load_coeff(struct wm_adsp *dsp, const char *fw_file_name)
 {
 	LIST_HEAD(buf_list);
 	struct regmap *regmap = dsp->regmap;
@@ -2601,7 +2601,7 @@ static int cs_dsp_load_coeff(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	snprintf(file, PAGE_SIZE, "%s-%s-%s.bin", dsp->part, dsp->fwf_name,
-		 wm_adsp_fw[dsp->fw].file);
+		 fw_file_name);
 	file[PAGE_SIZE - 1] = '\0';
 
 	ret = request_firmware(&firmware, file, dsp->dev);
@@ -2837,13 +2837,15 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
 
-static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp)
+static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp, const char *fw_file_name, const char *fw_name)
 {
 	unsigned int val;
 	int ret;
 
 	mutex_lock(&dsp->pwr_lock);
 
+	dsp->fw_name = fw_name;
+
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 			   ADSP1_SYS_ENA, ADSP1_SYS_ENA);
 
@@ -2869,7 +2871,7 @@ static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp)
 		}
 	}
 
-	ret = cs_dsp_load(dsp);
+	ret = cs_dsp_load(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -2877,7 +2879,7 @@ static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp)
 	if (ret != 0)
 		goto err_ena;
 
-	ret = cs_dsp_load_coeff(dsp);
+	ret = cs_dsp_load_coeff(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -2952,7 +2954,9 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		ret = cs_dsp_adsp1_power_up(dsp);
+		ret = cs_dsp_adsp1_power_up(dsp,
+					    wm_adsp_fw[dsp->fw].file,
+					    wm_adsp_fw_text[dsp->fw]);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		cs_dsp_adsp1_power_down(dsp);
@@ -3172,12 +3176,15 @@ static void cs_dsp_halo_stop_watchdog(struct wm_adsp *dsp)
 			   HALO_WDT_EN_MASK, 0);
 }
 
-static void cs_dsp_power_up(struct wm_adsp *dsp)
+static void cs_dsp_power_up(struct wm_adsp *dsp, const char *fw_file_name,
+			    const char *fw_name)
 {
 	int ret;
 
 	mutex_lock(&dsp->pwr_lock);
 
+	dsp->fw_name = fw_name;
+
 	if (dsp->ops->enable_memory) {
 		ret = dsp->ops->enable_memory(dsp);
 		if (ret != 0)
@@ -3190,7 +3197,7 @@ static void cs_dsp_power_up(struct wm_adsp *dsp)
 			goto err_mem;
 	}
 
-	ret = cs_dsp_load(dsp);
+	ret = cs_dsp_load(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -3198,7 +3205,7 @@ static void cs_dsp_power_up(struct wm_adsp *dsp)
 	if (ret != 0)
 		goto err_ena;
 
-	ret = cs_dsp_load_coeff(dsp);
+	ret = cs_dsp_load_coeff(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -3258,7 +3265,9 @@ static void wm_adsp_boot_work(struct work_struct *work)
 					   struct wm_adsp,
 					   boot_work);
 
-	cs_dsp_power_up(dsp);
+	cs_dsp_power_up(dsp,
+			wm_adsp_fw[dsp->fw].file,
+			wm_adsp_fw_text[dsp->fw]);
 }
 
 int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index eee298e94946..3bad022c4bb1 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -94,6 +94,7 @@ struct wm_adsp {
 
 	struct list_head alg_regions;
 
+	const char *fw_name;
 	unsigned int fw_id;
 	unsigned int fw_id_version;
 	unsigned int fw_vendor_id;
-- 
2.33.0

