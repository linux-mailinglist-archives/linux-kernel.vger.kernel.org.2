Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76D13C8798
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhGNPeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbhGNPeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:34:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F8EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so1708568wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OyLLqXUZS1RpS+YuJ/yD57hTXnorkIuGBmzsYS7+c4=;
        b=I9awJWJ0TeowLx8ez7hQQZ/8uuMucKaiP0yybxoMUtTzmz+q9AuGACZsNk4a1dv1vn
         3zsplkFV6BR0AaOQKcx+YX73pjEwcEboTLS2zlV1drc9hjq15nfUlPo8y60oKguSMZn1
         ffeEPFk0EekBEpfBL0jXzkhgvuXrXN30/ZXkeu1LZry0im3i3gOGtxFC4dcUttgzwq9j
         5cWwAbbiXdgSbwUrZNLpef0zckbyjC77iqz2aLQG62TWbEyPNlqVIEQtzPs/vELhVeDa
         8ebT5xlk91pGSlnmm0z81JflnM7bgGD/Vl9kB8gnaKpmsyw92587tFyKWXyCLVVY+hyp
         rGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OyLLqXUZS1RpS+YuJ/yD57hTXnorkIuGBmzsYS7+c4=;
        b=Iz5RnwG3q18F4eXeLxxNK7Z4xhNLNKfO2LGucj2m/BTE9PonBBaoOQ7Wd0OAgMV/xF
         UvdYPQacMeHvlwOhf1HD7e0sXl1yb13UD70DxvYnBLGlio6wpUTqZ2fGQzu5PgvmCQrb
         f8yMAtdXk8O0v1HVv+2ZGjgrHJ0Gw3uDsERP+SGkMK3ZX9FPPXjHcYtQnIcegp4mIL5F
         t1dlbxSDFLPOm9SaJWWOcIm9vGXXDdPcwqNSA3rcJcp72nYEfI/AKko8WPwI5GUVv6QB
         nne9U+AvfyUgYapu959hYU02Zon7BOafTQRPnKCrdDYS0nOOjp/i10dY8fLwV+JtDJfe
         kvFQ==
X-Gm-Message-State: AOAM533lZB8Pwt6GbRcQ7Oww8orzY7ihldIqYtQqtLQAwCHvJMG1wd66
        8D+hhiO5yzOzMo2as9fYFPDzLw==
X-Google-Smtp-Source: ABdhPJw2hvqQsZQb1WOpVNbwCMQq/ueOlos522YhpGCyQEfSKmNIq0bd5/Bxni1/zrsfBOuKSxXr+A==
X-Received: by 2002:a1c:9dd6:: with SMTP id g205mr12006785wme.82.1626276677494;
        Wed, 14 Jul 2021 08:31:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:31:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 15/16] ASoC: qcom: audioreach: topology add dapm pga support
Date:   Wed, 14 Jul 2021 16:30:38 +0100
Message-Id: <20210714153039.28373-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/audioreach/topology.c | 62 +++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/audioreach/topology.c b/sound/soc/qcom/audioreach/topology.c
index 8080243a47ef..14ecb115e63e 100644
--- a/sound/soc/qcom/audioreach/topology.c
+++ b/sound/soc/qcom/audioreach/topology.c
@@ -706,6 +706,25 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 	return 0;
 }
 
+static int audioreach_widget_load_pga(struct snd_soc_component *component,
+					int index, struct snd_soc_dapm_widget *w,
+					struct snd_soc_tplg_dapm_widget *tplg_w)
+{
+	struct audioreach_module *mod;
+	struct snd_soc_dobj *dobj;
+	int ret;
+
+	ret = audioreach_widget_load_module_common(component, index, w, tplg_w);
+	if (ret)
+		return ret;
+
+	dobj = &w->dobj;
+	mod = dobj->private;
+	mod->gain = VOL_CTRL_DEFAULT_GAIN;
+
+	return 0;
+}
+
 static int audioreach_widget_ready(struct snd_soc_component *component,
 				   int index, struct snd_soc_dapm_widget *w,
 				   struct snd_soc_tplg_dapm_widget *tplg_w)
@@ -725,8 +744,9 @@ static int audioreach_widget_ready(struct snd_soc_component *component,
 		break;
 	case snd_soc_dapm_mixer:
 		return audioreach_widget_load_mixer(component, index, w, tplg_w);
-	case snd_soc_dapm_dai_link:
 	case snd_soc_dapm_pga:
+		return audioreach_widget_load_pga(component, index, w, tplg_w);
+	case snd_soc_dapm_dai_link:
 	case snd_soc_dapm_scheduler:
 	case snd_soc_dapm_out_drv:
 	default:
@@ -898,6 +918,40 @@ static int audioreach_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int audioreach_get_vol_ctrl_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *dw = snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct audioreach_module *mod = dw->dobj.private;
+
+	/* Check if the graph is active or not */
+	ucontrol->value.integer.value[0] = mod->gain;
+
+	return 0;
+}
+
+static int audioreach_put_vol_ctrl_audio_mixer(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *dw = snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct audioreach_module *mod = dw->dobj.private;
+	struct q6apm *apm = dev_get_drvdata(c->dev);
+	int vol = ucontrol->value.integer.value[0];
+
+	/* Check if the graph is active or not */
+	if (dw->power) {
+		audioreach_gain_set_vol_ctrl(apm, mod, vol);
+		mod->gain = vol;
+		return 1;
+	}
+
+	dev_err(apm->dev, "Unable to set volume as graph is not	active\n");
+	return 0;
+
+}
+
 static int audioreach_control_load_mix(struct snd_soc_component *scomp,
 					  struct snd_ar_control *scontrol,
 					  struct snd_kcontrol_new *kc,
@@ -948,6 +1002,10 @@ static int audioreach_control_load(struct snd_soc_component *scomp, int index,
 		dobj = &sm->dobj;
 		ret = audioreach_control_load_mix(scomp, scontrol, kc, hdr);
 		break;
+	case SND_SOC_AR_TPLG_VOL_CTL:
+		sm = (struct soc_mixer_control *)kc->private_value;
+		dobj = &sm->dobj;
+		break;
 	default:
 		dev_warn(scomp->dev, "control type not supported %d:%d:%d\n",
 			 hdr->ops.get, hdr->ops.put, hdr->ops.info);
@@ -972,6 +1030,8 @@ static int audioreach_control_unload(struct snd_soc_component *scomp,
 static const struct snd_soc_tplg_kcontrol_ops audioreach_io_ops[] = {
 	{SND_SOC_AR_TPLG_FE_BE_GRAPH_CTL_MIX, audioreach_get_audio_mixer,
 		audioreach_put_audio_mixer, snd_soc_info_volsw},
+	{SND_SOC_AR_TPLG_VOL_CTL, audioreach_get_vol_ctrl_audio_mixer,
+		audioreach_put_vol_ctrl_audio_mixer, snd_soc_info_volsw},
 };
 
 static struct snd_soc_tplg_ops audioreach_tplg_ops  = {
-- 
2.21.0

