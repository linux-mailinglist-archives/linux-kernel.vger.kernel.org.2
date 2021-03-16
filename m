Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6C33D249
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhCPK72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhCPK6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:58:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B07C061763
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:58:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v4so7189169wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFH0lI1hpzdaY6kiLdtJWHhzzWfQOeJjC6UbGDX+dgs=;
        b=TaYqDIJ3z0IpEPkBP4Ohf/F9tXT6EYaiXHH8PMFvO8lJq1DqPPMxseTh4WwFbAH9+q
         e1oieG4P9EsN5z86BeQ6brj5bRH9NUZILicikVZaWRfMoOE5yMSwEgw/2wJmznz4DxqK
         2xEmcb+7Am/RsSLbVmG66tFxmBYmA+DBJMl62CWjReLUvrcSx38ERVRwvhc2aBZY+E5k
         nPS0cr9W9/9iKni97YJziWjdR8B4si6z1jK23RS18B7LBvigKz4X9ET7vXaFFJ/vOE/T
         9teqqT9yrPDtEXE92GJIgRit+Ng//e3FZh5C5ymAsR/6vqd5xp9eEWr7yYDzy6/nkuAp
         hdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFH0lI1hpzdaY6kiLdtJWHhzzWfQOeJjC6UbGDX+dgs=;
        b=ds4F18OHG2978cbBw7ONVlhqEY8HI6lHoildcHoyMpBlNc58tUpSvLKB4pWsmO/Xye
         PApJKJD/LPUvxagNY6V+GIrZHi2OOdR27hppkMC36EfptdveY3Rl0D20TVeSAKuoHSRq
         FWA0dLpBaPJ4F68aIinX/1pQnnFkViISd8G0jqJyspzNX9hP7PHEX5d17T6DBPX5i1q6
         EXU/zZCqqwIogflKHfwU/sZpM85Q/MUygtJlw3gbvGTHU+nuc+iiXFpK6mpU4fMblUZE
         tjDNzrnZ/qX1334wT6BRtyODs4xpYMOPjiGdmZzoCEC8cVe2EwWpVlSbHsFxptZbP8oO
         xZ0w==
X-Gm-Message-State: AOAM533wc4ZhGkMRmmQc0P2jQjsS1LRGC/7ZZqTqK6eSqmxnizCCX3DZ
        5Bb5MI2o3WWhnd3aNV4ySXNONQ==
X-Google-Smtp-Source: ABdhPJxdYG3vaD4muvTbmGHrNTUT3Umm9z3RZAHtCW4lUhTmPtMK4PuImqsIobrf4vRUivVHNWpCLw==
X-Received: by 2002:adf:90c2:: with SMTP id i60mr4246540wri.75.1615892318812;
        Tue, 16 Mar 2021 03:58:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t8sm21465956wrr.10.2021.03.16.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 03:58:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/7] ASoC: codecs: wcd-clsh: add new version support
Date:   Tue, 16 Mar 2021 10:58:23 +0000
Message-Id: <20210316105828.16436-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210316105828.16436-1-srinivas.kandagatla@linaro.org>
References: <20210316105828.16436-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From WCD937X Class H controller has changed significantly, so add support
to this new version for WCD937X and WCD938X Codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd-clsh-v2.c | 350 ++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wcd-clsh-v2.h |  16 ++
 2 files changed, 356 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 817d8259758c..60e2e784d190 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -88,6 +88,19 @@ struct wcd_clsh_ctrl {
 #define WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA	0x50
 #define WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA	0x30
 
+#define WCD9XXX_BASE_ADDRESS				0x3000
+#define WCD9XXX_ANA_RX_SUPPLIES				(WCD9XXX_BASE_ADDRESS+0x008)
+#define WCD9XXX_ANA_HPH					(WCD9XXX_BASE_ADDRESS+0x009)
+#define WCD9XXX_CLASSH_MODE_2				(WCD9XXX_BASE_ADDRESS+0x098)
+#define WCD9XXX_CLASSH_MODE_3				(WCD9XXX_BASE_ADDRESS+0x099)
+#define WCD9XXX_FLYBACK_VNEG_CTRL_1			(WCD9XXX_BASE_ADDRESS+0x0A5)
+#define WCD9XXX_FLYBACK_VNEG_CTRL_4			(WCD9XXX_BASE_ADDRESS+0x0A8)
+#define WCD9XXX_FLYBACK_VNEGDAC_CTRL_2			(WCD9XXX_BASE_ADDRESS+0x0AF)
+#define WCD9XXX_RX_BIAS_HPH_LOWPOWER			(WCD9XXX_BASE_ADDRESS+0x0BF)
+#define WCD9XXX_V3_RX_BIAS_FLYB_BUFF			(WCD9XXX_BASE_ADDRESS+0x0C7)
+#define WCD9XXX_HPH_PA_CTL1				(WCD9XXX_BASE_ADDRESS+0x0D1)
+#define WCD9XXX_HPH_NEW_INT_PA_MISC2			(WCD9XXX_BASE_ADDRESS+0x138)
+
 #define CLSH_REQ_ENABLE		true
 #define CLSH_REQ_DISABLE	false
 #define WCD_USLEEP_RANGE	50
@@ -137,6 +150,20 @@ static inline void wcd_clsh_set_buck_mode(struct snd_soc_component *comp,
 					WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_DEFAULT);
 }
 
+static inline void wcd_clsh_v3_set_buck_mode(struct snd_soc_component *component,
+					  int mode)
+{
+	if (mode == CLS_H_HIFI || mode == CLS_H_LOHIFI ||
+	    mode == CLS_AB_HIFI || mode == CLS_AB_LOHIFI)
+		snd_soc_component_update_bits(component,
+				WCD9XXX_ANA_RX_SUPPLIES,
+				0x08, 0x08); /* set to HIFI */
+	else
+		snd_soc_component_update_bits(component,
+				WCD9XXX_ANA_RX_SUPPLIES,
+				0x08, 0x00); /* set to default */
+}
+
 static inline void wcd_clsh_set_flyback_mode(struct snd_soc_component *comp,
 					     int mode)
 {
@@ -170,6 +197,36 @@ static void wcd_clsh_buck_ctrl(struct wcd_clsh_ctrl *ctrl,
 	usleep_range(500, 500 + WCD_USLEEP_RANGE);
 }
 
+static void wcd_clsh_v3_buck_ctrl(struct snd_soc_component *component,
+			       struct wcd_clsh_ctrl *ctrl,
+			       int mode,
+			       bool enable)
+{
+	/* enable/disable buck */
+	if ((enable && (++ctrl->buck_users == 1)) ||
+	   (!enable && (--ctrl->buck_users == 0))) {
+		snd_soc_component_update_bits(component,
+				WCD9XXX_ANA_RX_SUPPLIES,
+				(1 << 7), (enable << 7));
+		/*
+		 * 500us sleep is required after buck enable/disable
+		 * as per HW requirement
+		 */
+		usleep_range(500, 510);
+		if (mode == CLS_H_LOHIFI || mode == CLS_H_ULP ||
+			mode == CLS_H_HIFI || mode == CLS_H_LP)
+			snd_soc_component_update_bits(component,
+					WCD9XXX_CLASSH_MODE_3,
+					0x02, 0x00);
+
+		snd_soc_component_update_bits(component,
+					WCD9XXX_CLASSH_MODE_2,
+					0xFF, 0x3A);
+		/* 500usec delay is needed as per HW requirement */
+		usleep_range(500, 500 + WCD_USLEEP_RANGE);
+	}
+}
+
 static void wcd_clsh_flyback_ctrl(struct wcd_clsh_ctrl *ctrl,
 				  int mode,
 				  bool enable)
@@ -219,8 +276,7 @@ static void wcd_clsh_set_gain_path(struct wcd_clsh_ctrl *ctrl, int mode)
 					val);
 }
 
-static void wcd_clsh_set_hph_mode(struct snd_soc_component *comp,
-				  int mode)
+static void wcd_clsh_v2_set_hph_mode(struct snd_soc_component *comp,  int mode)
 {
 	int val = 0, gain = 0, res_val;
 	int ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
@@ -264,6 +320,49 @@ static void wcd_clsh_set_hph_mode(struct snd_soc_component *comp,
 				ipeak);
 }
 
+static void wcd_clsh_v3_set_hph_mode(struct snd_soc_component *component,
+				  int mode)
+{
+	u8 val = 0;
+
+	switch (mode) {
+	case CLS_H_NORMAL:
+		val = 0x00;
+		break;
+	case CLS_AB:
+	case CLS_H_ULP:
+		val = 0x0C;
+		break;
+	case CLS_AB_HIFI:
+	case CLS_H_HIFI:
+		val = 0x08;
+		break;
+	case CLS_H_LP:
+	case CLS_H_LOHIFI:
+	case CLS_AB_LP:
+	case CLS_AB_LOHIFI:
+		val = 0x04;
+		break;
+	default:
+		dev_err(component->dev, "%s:Invalid mode %d\n", __func__, mode);
+		return;
+	};
+
+	snd_soc_component_update_bits(component, WCD9XXX_ANA_HPH, 0x0C, val);
+}
+
+
+void wcd_clsh_set_hph_mode(struct wcd_clsh_ctrl *ctrl, int mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if (ctrl->codec_version >= WCD937X)
+		wcd_clsh_v3_set_hph_mode(comp, mode);
+	else
+		wcd_clsh_v2_set_hph_mode(comp, mode);
+
+}
+
 static void wcd_clsh_set_flyback_current(struct snd_soc_component *comp,
 					 int mode)
 {
@@ -289,6 +388,130 @@ static void wcd_clsh_set_buck_regulator_mode(struct snd_soc_component *comp,
 					WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H);
 }
 
+static void wcd_clsh_v3_set_buck_regulator_mode(struct snd_soc_component *component,
+						int mode)
+{
+	snd_soc_component_update_bits(component, WCD9XXX_ANA_RX_SUPPLIES,
+			    0x02, 0x00);
+}
+
+static inline void wcd_clsh_v3_set_flyback_mode(struct snd_soc_component *component,
+						int mode)
+{
+	if (mode == CLS_H_HIFI || mode == CLS_H_LOHIFI ||
+	    mode == CLS_AB_HIFI || mode == CLS_AB_LOHIFI) {
+		snd_soc_component_update_bits(component,
+				WCD9XXX_ANA_RX_SUPPLIES,
+				0x04, 0x04);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_FLYBACK_VNEG_CTRL_4,
+				0xF0, 0x80);
+	} else {
+		snd_soc_component_update_bits(component,
+				WCD9XXX_ANA_RX_SUPPLIES,
+				0x04, 0x00); /* set to Default */
+		snd_soc_component_update_bits(component,
+				WCD9XXX_FLYBACK_VNEG_CTRL_4,
+				0xF0, 0x70);
+	}
+}
+
+static inline void wcd_clsh_v3_force_iq_ctl(struct snd_soc_component *component,
+					 int mode, bool enable)
+{
+	if (enable) {
+		snd_soc_component_update_bits(component,
+				WCD9XXX_FLYBACK_VNEGDAC_CTRL_2,
+				0xE0, 0xA0);
+		/* 100usec delay is needed as per HW requirement */
+		usleep_range(100, 110);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_CLASSH_MODE_3,
+				0x02, 0x02);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_CLASSH_MODE_2,
+				0xFF, 0x1C);
+		if (mode == CLS_H_LOHIFI || mode == CLS_AB_LOHIFI) {
+			snd_soc_component_update_bits(component,
+					WCD9XXX_HPH_NEW_INT_PA_MISC2,
+					0x20, 0x20);
+			snd_soc_component_update_bits(component,
+					WCD9XXX_RX_BIAS_HPH_LOWPOWER,
+					0xF0, 0xC0);
+			snd_soc_component_update_bits(component,
+					WCD9XXX_HPH_PA_CTL1,
+					0x0E, 0x02);
+		}
+	} else {
+		snd_soc_component_update_bits(component,
+				WCD9XXX_HPH_NEW_INT_PA_MISC2,
+				0x20, 0x00);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_RX_BIAS_HPH_LOWPOWER,
+				0xF0, 0x80);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_HPH_PA_CTL1,
+				0x0E, 0x06);
+	}
+}
+
+static void wcd_clsh_v3_flyback_ctrl(struct snd_soc_component *component,
+				  struct wcd_clsh_ctrl *ctrl,
+				  int mode,
+				  bool enable)
+{
+	/* enable/disable flyback */
+	if ((enable && (++ctrl->flyback_users == 1)) ||
+	   (!enable && (--ctrl->flyback_users == 0))) {
+		snd_soc_component_update_bits(component,
+				WCD9XXX_FLYBACK_VNEG_CTRL_1,
+				0xE0, 0xE0);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_ANA_RX_SUPPLIES,
+				(1 << 6), (enable << 6));
+		/*
+		 * 100us sleep is required after flyback enable/disable
+		 * as per HW requirement
+		 */
+		usleep_range(100, 110);
+		snd_soc_component_update_bits(component,
+				WCD9XXX_FLYBACK_VNEGDAC_CTRL_2,
+				0xE0, 0xE0);
+		/* 500usec delay is needed as per HW requirement */
+		usleep_range(500, 500 + WCD_USLEEP_RANGE);
+	}
+}
+
+static void wcd_clsh_v3_set_flyback_current(struct snd_soc_component *component,
+				int mode)
+{
+	snd_soc_component_update_bits(component, WCD9XXX_V3_RX_BIAS_FLYB_BUFF,
+				0x0F, 0x0A);
+	snd_soc_component_update_bits(component, WCD9XXX_V3_RX_BIAS_FLYB_BUFF,
+				0xF0, 0xA0);
+	/* Sleep needed to avoid click and pop as per HW requirement */
+	usleep_range(100, 110);
+}
+
+static void wcd_clsh_v3_state_aux(struct wcd_clsh_ctrl *ctrl, int req_state,
+			      bool is_enable, int mode)
+{
+	struct snd_soc_component *component = ctrl->comp;
+
+	if (is_enable) {
+		wcd_clsh_v3_set_buck_mode(component, mode);
+		wcd_clsh_v3_set_flyback_mode(component, mode);
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_flyback_current(component, mode);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, mode, true);
+	} else {
+		wcd_clsh_v3_buck_ctrl(component, ctrl, mode, false);
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, mode, false);
+		wcd_clsh_v3_set_flyback_mode(component, CLS_H_NORMAL);
+		wcd_clsh_v3_set_buck_mode(component, CLS_H_NORMAL);
+	}
+}
+
 static void wcd_clsh_state_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
 			      bool is_enable, int mode)
 {
@@ -316,6 +539,38 @@ static void wcd_clsh_state_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
 	}
 }
 
+static void wcd_clsh_v3_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
+				 bool is_enable, int mode)
+{
+	struct snd_soc_component *component = ctrl->comp;
+
+	if (mode == CLS_H_NORMAL) {
+		dev_dbg(component->dev, "%s: Normal mode not applicable for hph_r\n",
+			__func__);
+		return;
+	}
+
+	if (is_enable) {
+		wcd_clsh_v3_set_buck_regulator_mode(component, mode);
+		wcd_clsh_v3_set_flyback_mode(component, mode);
+		wcd_clsh_v3_force_iq_ctl(component, mode, true);
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_flyback_current(component, mode);
+		wcd_clsh_v3_set_buck_mode(component, mode);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_hph_mode(component, mode);
+	} else {
+		wcd_clsh_v3_set_hph_mode(component, CLS_H_NORMAL);
+
+		/* buck and flyback set to default mode and disable */
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_v3_force_iq_ctl(component, CLS_H_NORMAL, false);
+		wcd_clsh_v3_set_flyback_mode(component, CLS_H_NORMAL);
+		wcd_clsh_v3_set_buck_mode(component, CLS_H_NORMAL);
+	}
+}
+
 static void wcd_clsh_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
 				 bool is_enable, int mode)
 {
@@ -353,10 +608,10 @@ static void wcd_clsh_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
 		wcd_clsh_set_flyback_current(comp, mode);
 		wcd_clsh_set_buck_mode(comp, mode);
 		wcd_clsh_buck_ctrl(ctrl, mode, true);
-		wcd_clsh_set_hph_mode(comp, mode);
+		wcd_clsh_v2_set_hph_mode(comp, mode);
 		wcd_clsh_set_gain_path(ctrl, mode);
 	} else {
-		wcd_clsh_set_hph_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_v2_set_hph_mode(comp, CLS_H_NORMAL);
 
 		if (mode != CLS_AB) {
 			snd_soc_component_update_bits(comp,
@@ -374,6 +629,38 @@ static void wcd_clsh_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
 	}
 }
 
+static void wcd_clsh_v3_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
+				 bool is_enable, int mode)
+{
+	struct snd_soc_component *component = ctrl->comp;
+
+	if (mode == CLS_H_NORMAL) {
+		dev_dbg(component->dev, "%s: Normal mode not applicable for hph_l\n",
+			__func__);
+		return;
+	}
+
+	if (is_enable) {
+		wcd_clsh_v3_set_buck_regulator_mode(component, mode);
+		wcd_clsh_v3_set_flyback_mode(component, mode);
+		wcd_clsh_v3_force_iq_ctl(component, mode, true);
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_flyback_current(component, mode);
+		wcd_clsh_v3_set_buck_mode(component, mode);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_hph_mode(component, mode);
+	} else {
+		wcd_clsh_v3_set_hph_mode(component, CLS_H_NORMAL);
+
+		/* set buck and flyback to Default Mode */
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_v3_force_iq_ctl(component, CLS_H_NORMAL, false);
+		wcd_clsh_v3_set_flyback_mode(component, CLS_H_NORMAL);
+		wcd_clsh_v3_set_buck_mode(component, CLS_H_NORMAL);
+	}
+}
+
 static void wcd_clsh_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
 				 bool is_enable, int mode)
 {
@@ -411,10 +698,10 @@ static void wcd_clsh_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
 		wcd_clsh_set_flyback_current(comp, mode);
 		wcd_clsh_set_buck_mode(comp, mode);
 		wcd_clsh_buck_ctrl(ctrl, mode, true);
-		wcd_clsh_set_hph_mode(comp, mode);
+		wcd_clsh_v2_set_hph_mode(comp, mode);
 		wcd_clsh_set_gain_path(ctrl, mode);
 	} else {
-		wcd_clsh_set_hph_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_v2_set_hph_mode(comp, CLS_H_NORMAL);
 
 		if (mode != CLS_AB) {
 			snd_soc_component_update_bits(comp,
@@ -432,6 +719,32 @@ static void wcd_clsh_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
 	}
 }
 
+static void wcd_clsh_v3_state_ear(struct wcd_clsh_ctrl *ctrl, int req_state,
+			       bool is_enable, int mode)
+{
+	struct snd_soc_component *component = ctrl->comp;
+
+	if (is_enable) {
+		wcd_clsh_v3_set_buck_regulator_mode(component, mode);
+		wcd_clsh_v3_set_flyback_mode(component, mode);
+		wcd_clsh_v3_force_iq_ctl(component, mode, true);
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_flyback_current(component, mode);
+		wcd_clsh_v3_set_buck_mode(component, mode);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, mode, true);
+		wcd_clsh_v3_set_hph_mode(component, mode);
+	} else {
+		wcd_clsh_v3_set_hph_mode(component, CLS_H_NORMAL);
+
+		/* set buck and flyback to Default Mode */
+		wcd_clsh_v3_flyback_ctrl(component, ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_v3_buck_ctrl(component, ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_v3_force_iq_ctl(component, CLS_H_NORMAL, false);
+		wcd_clsh_v3_set_flyback_mode(component, CLS_H_NORMAL);
+		wcd_clsh_v3_set_buck_mode(component, CLS_H_NORMAL);
+	}
+}
+
 static void wcd_clsh_state_ear(struct wcd_clsh_ctrl *ctrl, int req_state,
 			       bool is_enable, int mode)
 {
@@ -470,18 +783,33 @@ static void wcd_clsh_state_ear(struct wcd_clsh_ctrl *ctrl, int req_state,
 static int _wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl, int req_state,
 				    bool is_enable, int mode)
 {
+
 	switch (req_state) {
 	case WCD_CLSH_STATE_EAR:
-		wcd_clsh_state_ear(ctrl, req_state, is_enable, mode);
+		if (ctrl->codec_version >= WCD937X)
+			wcd_clsh_v3_state_ear(ctrl, req_state, is_enable, mode);
+		else
+			wcd_clsh_state_ear(ctrl, req_state, is_enable, mode);
 		break;
 	case WCD_CLSH_STATE_HPHL:
-		wcd_clsh_state_hph_l(ctrl, req_state, is_enable, mode);
+		if (ctrl->codec_version >= WCD937X)
+			wcd_clsh_v3_state_hph_l(ctrl, req_state, is_enable, mode);
+		else
+			wcd_clsh_state_hph_l(ctrl, req_state, is_enable, mode);
 		break;
 	case WCD_CLSH_STATE_HPHR:
-		wcd_clsh_state_hph_r(ctrl, req_state, is_enable, mode);
+		if (ctrl->codec_version >= WCD937X)
+			wcd_clsh_v3_state_hph_r(ctrl, req_state, is_enable, mode);
+		else
+			wcd_clsh_state_hph_r(ctrl, req_state, is_enable, mode);
 		break;
 	case WCD_CLSH_STATE_LO:
-		wcd_clsh_state_lo(ctrl, req_state, is_enable, mode);
+		if (ctrl->codec_version < WCD937X)
+			wcd_clsh_state_lo(ctrl, req_state, is_enable, mode);
+		break;
+	case WCD_CLSH_STATE_AUX:
+		if (ctrl->codec_version >= WCD937X)
+			wcd_clsh_v3_state_aux(ctrl, req_state, is_enable, mode);
 		break;
 	default:
 		break;
@@ -504,6 +832,7 @@ static bool wcd_clsh_is_state_valid(int state)
 	case WCD_CLSH_STATE_HPHL:
 	case WCD_CLSH_STATE_HPHR:
 	case WCD_CLSH_STATE_LO:
+	case WCD_CLSH_STATE_AUX:
 		return true;
 	default:
 		return false;
@@ -565,6 +894,7 @@ struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(struct snd_soc_component *comp,
 
 	ctrl->state = WCD_CLSH_STATE_IDLE;
 	ctrl->comp = comp;
+	ctrl->codec_version = version;
 
 	return ctrl;
 }
diff --git a/sound/soc/codecs/wcd-clsh-v2.h b/sound/soc/codecs/wcd-clsh-v2.h
index a6d0f2d0e9e3..4e3653058275 100644
--- a/sound/soc/codecs/wcd-clsh-v2.h
+++ b/sound/soc/codecs/wcd-clsh-v2.h
@@ -22,8 +22,11 @@ enum wcd_clsh_event {
 #define	WCD_CLSH_STATE_HPHL	BIT(1)
 #define	WCD_CLSH_STATE_HPHR	BIT(2)
 #define	WCD_CLSH_STATE_LO	BIT(3)
+#define	WCD_CLSH_STATE_AUX	BIT(4)
 #define WCD_CLSH_STATE_MAX	4
+#define WCD_CLSH_V3_STATE_MAX	5
 #define NUM_CLSH_STATES_V2	BIT(WCD_CLSH_STATE_MAX)
+#define NUM_CLSH_STATES_V3	BIT(WCD_CLSH_V3_STATE_MAX)
 
 enum wcd_clsh_mode {
 	CLS_H_NORMAL = 0, /* Class-H Default */
@@ -31,9 +34,20 @@ enum wcd_clsh_mode {
 	CLS_H_LP, /* Class-H Low Power */
 	CLS_AB, /* Class-AB */
 	CLS_H_LOHIFI, /* LoHIFI */
+	CLS_H_ULP, /* Ultra Low power */
+	CLS_AB_HIFI, /* Class-AB */
+	CLS_AB_LP, /* Class-AB Low Power */
+	CLS_AB_LOHIFI, /* Class-AB Low HIFI */
 	CLS_NONE, /* None of the above modes */
 };
 
+enum wcd_codec_version {
+	WCD9335  = 0,
+	WCD934X  = 1,
+	/* New CLSH after this */
+	WCD937X  = 2,
+	WCD938X  = 3,
+};
 struct wcd_clsh_ctrl;
 
 extern struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(
@@ -45,5 +59,7 @@ extern int wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl,
 				   enum wcd_clsh_event clsh_event,
 				   int nstate,
 				   enum wcd_clsh_mode mode);
+extern void wcd_clsh_set_hph_mode(struct wcd_clsh_ctrl *ctrl,
+				  int mode);
 
 #endif /* _WCD_CLSH_V2_H_ */
-- 
2.21.0

