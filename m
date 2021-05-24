Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AA38E2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhEXIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhEXIuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:50:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b7so13888416wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5XYnGgjQLfXAwzBqnvDeEJmpGJf7QdaLcq5EkqtCqY=;
        b=rFZMpMjPh9qPQVpWtJNroPAjaG9btF9BKCVIZhbov3WeRznSBjTy340Tql20tr3SSP
         qfXGcoLmpnntYODWXFts/WZPRGE9V3hl0gLXEHECzhJaPxEmJoSgayk0k8WKpPlJ96Is
         /Nv9UKewHLj0iTM0sj2cJlWLD1T5n7yomdxNt6ErHKQDIT76wrvDbxaAqDpBwVNVWEiP
         3zbTvU9h4stDykVLnNyTYjcaE3AI+jXmyrkv6locfHn+umPNIO6v6mW3Qo4IpE+nCV6p
         gjWTCzOKlJcaIRGKpCKdWKHmo7CLyfo2TiV/8AUfVocYVYgR/xtOqVMOT4U0Et5Aak4S
         ndCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5XYnGgjQLfXAwzBqnvDeEJmpGJf7QdaLcq5EkqtCqY=;
        b=Mn2M7mzc8CBsf46YTfIphL3UA68eMXEMYJQ7YHGtrSBF7PRaitggoJaW+na21yFEUL
         4DPNKiOlRV9DKDorlkkxRzfdfXH2THaxZWgC0rNxOt8AJFG3BsWFIbXbrlGLMsbqcq5P
         xAEkGS9dCPI+X72Yag6fBCeK9pMk2OWU1wwIKr1bV36hQViDL9DPzu5u5j0S4TdST6Ej
         vh45tevZ0dQCsD2rVoMaKSdSr7hGF2F94ctjarSO5Poviq/3Z2HyU0TShR3OemIw95Ig
         lKkptxmIbZNJPFUSkZtvF/m01yLf5bh02oMKHZVvZ19xhFDM1TgSUiIpXhBmVDSY/F+x
         bmcg==
X-Gm-Message-State: AOAM533liz4EDqQclH7DXTYoCQ88m7+qkhx4tN4Mhw6N7yjjFLlaXpJJ
        rr/19JmWG2FaH2fZuZG4Dz0Mrw==
X-Google-Smtp-Source: ABdhPJymOqnXVZaOLgJfzISbh459JyJYVrd4gL1YMZ6OpJF1tqcIWRJ8mRqiEJUhTu9x6DjX4B/JQQ==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr8765619wmf.58.1621846123303;
        Mon, 24 May 2021 01:48:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x206sm4034548wmx.47.2021.05.24.01.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 01:48:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 2/9] ASoC: codecs: wcd-clsh: add new version support
Date:   Mon, 24 May 2021 09:48:21 +0100
Message-Id: <20210524084828.12787-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
References: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From WCD937X Class H controller has changed significantly, so add support
to this new version for WCD937X and WCD938X Codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd-clsh-v2.c | 348 ++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wcd-clsh-v2.h |  16 ++
 2 files changed, 354 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 817d8259758c..485d1932391a 100644
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
 
+static void wcd_clsh_v3_set_buck_mode(struct snd_soc_component *component,
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
+static void wcd_clsh_v2_set_hph_mode(struct snd_soc_component *comp, int mode)
 {
 	int val = 0, gain = 0, res_val;
 	int ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
@@ -264,6 +320,48 @@ static void wcd_clsh_set_hph_mode(struct snd_soc_component *comp,
 				ipeak);
 }
 
+static void wcd_clsh_v3_set_hph_mode(struct snd_soc_component *component,
+				  int mode)
+{
+	u8 val;
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
@@ -289,6 +387,130 @@ static void wcd_clsh_set_buck_regulator_mode(struct snd_soc_component *comp,
 					WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H);
 }
 
+static void wcd_clsh_v3_set_buck_regulator_mode(struct snd_soc_component *component,
+						int mode)
+{
+	snd_soc_component_update_bits(component, WCD9XXX_ANA_RX_SUPPLIES,
+			    0x02, 0x00);
+}
+
+static void wcd_clsh_v3_set_flyback_mode(struct snd_soc_component *component,
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
+static void wcd_clsh_v3_force_iq_ctl(struct snd_soc_component *component,
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
@@ -316,6 +538,38 @@ static void wcd_clsh_state_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
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
@@ -353,10 +607,10 @@ static void wcd_clsh_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
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
@@ -374,6 +628,38 @@ static void wcd_clsh_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
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
@@ -411,10 +697,10 @@ static void wcd_clsh_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
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
@@ -432,6 +718,32 @@ static void wcd_clsh_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
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
@@ -472,16 +784,30 @@ static int _wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl, int req_state,
 {
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
@@ -504,6 +830,7 @@ static bool wcd_clsh_is_state_valid(int state)
 	case WCD_CLSH_STATE_HPHL:
 	case WCD_CLSH_STATE_HPHR:
 	case WCD_CLSH_STATE_LO:
+	case WCD_CLSH_STATE_AUX:
 		return true;
 	default:
 		return false;
@@ -565,6 +892,7 @@ struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(struct snd_soc_component *comp,
 
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

