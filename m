Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56710380749
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhENKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhENKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:35:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:34:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso1219206wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5XYnGgjQLfXAwzBqnvDeEJmpGJf7QdaLcq5EkqtCqY=;
        b=OGi1kg+B9Ago3gv1uYbYb5COplBv5x9nudxLGU9HHqWBfvQ7KbSkOdaAp+bjh2LSV5
         2U1Da76cd0HtxsEHbUkDtSKLsdrojBoedecTZMhV+rpINu4OH0spcvGu53CQIL2DEBUd
         LYpUGhXIvZwLC+s0/c2p41mnH5AacelCh92sBI8SJfLgWpLxdt0ITlYygJ1lYjdsroMT
         1OElQkuJIAxeVgsX0qlr5e32ZXoXg4IUg+lybiMXrfQHhFIFltwCyK3mlTxPTNT+ZWlK
         TTBFwSAT6VYKNozibI+VNlmo4WQQDEn2FZ3K7cD2m57meFT74MTqgfvQXIciGPjp6rtV
         yIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5XYnGgjQLfXAwzBqnvDeEJmpGJf7QdaLcq5EkqtCqY=;
        b=EIaLtPpBxl6qp/sojXEul8uEgUqhdJZ7d236V8DiwrXGwp3LoCYVBhYhxPe1Tb68SL
         LsWNWcvYdDHJCqcpypeDPyyoOE64z0cRESszwfpDN1euN7J0m0mrqlKXx24v+8azXlLt
         IaZDPoF8rVOyQg7xSseeGGsnQP6YTqAwAgOGsDNfCnpvfgBX+GH1iyu0n1UAfYY6rv/E
         8yz8klk8nqz2Jbg4nzL4fiokZ0v0o4uQi4a3N9i9oLU4WjeaikGTA/6/PRBqc4uKqXUy
         lm9SQl5oqIEGuha0hVA3w4HRe+ge/dl3vMoDRhRy0G0128XWYOC9fyUkJbp9IZgnE0A+
         Ik5Q==
X-Gm-Message-State: AOAM532GS9YMTtbFjGix/vker+vdNZdV4/HznMsRsxJA3BfBkSAzralF
        H4sMgprX424TLX3VKlx8aKB2ROQtnyU9Vvee
X-Google-Smtp-Source: ABdhPJzSohnE3m/WrjsS2Ch4U1QnhYM5I5BeF/pcV6oQQd3ZWDCeqUR3QWp0Rdh4sdnyY+qQnEwjSQ==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr50584275wmj.48.1620988471395;
        Fri, 14 May 2021 03:34:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k16sm5015498wmi.44.2021.05.14.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:34:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 2/9] ASoC: codecs: wcd-clsh: add new version support
Date:   Fri, 14 May 2021 11:33:58 +0100
Message-Id: <20210514103405.29927-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
References: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
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

