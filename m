Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7430F22A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhBDL3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235549AbhBDL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612437953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkAbhZQwIoqyw3kd0AP35SQLJY8M1P264D/YxBBuadQ=;
        b=MeLrxAQIIE10sCgcxJjLiSY2G1ArVL1uLVFRd1XjiUaRdUBIjctzxzZUhoNDxXpGKH+Gb4
        K75S5dzzlahuCwSO2e3s73oufoTXfbMDfxjNPBBe07VBRUi36ib+70lO/WlrkbWkjIA9u/
        tffaSar7D9SO4Mv+lfmbbgIIYltnWbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-vwp_XK_lMNqNHtmjhyxTUQ-1; Thu, 04 Feb 2021 06:25:52 -0500
X-MC-Unique: vwp_XK_lMNqNHtmjhyxTUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D6A84E263;
        Thu,  4 Feb 2021 11:25:50 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-112.ams2.redhat.com [10.36.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44A6D627DD;
        Thu,  4 Feb 2021 11:25:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 resend 12/13] ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use the new jack library
Date:   Thu,  4 Feb 2021 12:25:01 +0100
Message-Id: <20210204112502.88362-13-hdegoede@redhat.com>
In-Reply-To: <20210204112502.88362-1-hdegoede@redhat.com>
References: <20210204112502.88362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all arizona codec drivers for which drivers/mfd/arizona-core.c used
to instantiate a "arizona-extcon" child-device use the new arizona-jack.c
library for jack-detection.

This has been tested on a Lenovo Yoga Tablet 2 1051L with a WM5102 codec.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/wm5102.c | 12 +++++++++++-
 sound/soc/codecs/wm5110.c | 12 +++++++++++-
 sound/soc/codecs/wm8997.c | 14 ++++++++++++--
 sound/soc/codecs/wm8998.c |  9 +++++++++
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 70d353b63fe0..b77595fb3ea8 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2004,6 +2004,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm5102 = {
 	.remove			= wm5102_component_remove,
 	.set_sysclk		= arizona_set_sysclk,
 	.set_pll		= wm5102_set_fll,
+	.set_jack		= arizona_jack_set_jack,
 	.name			= DRV_NAME,
 	.compress_ops		= &wm5102_compress_ops,
 	.controls		= wm5102_snd_controls,
@@ -2057,6 +2058,11 @@ static int wm5102_probe(struct platform_device *pdev)
 	if (ret != 0)
 		return ret;
 
+	/* This may return -EPROBE_DEFER, so do this early on */
+	ret = arizona_jack_codec_dev_probe(&wm5102->core, &pdev->dev);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(wm5102->fll); i++)
 		wm5102->fll[i].vco_mult = 1;
 
@@ -2089,7 +2095,7 @@ static int wm5102_probe(struct platform_device *pdev)
 				  wm5102);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
-		return ret;
+		goto err_jack_codec_dev;
 	}
 
 	ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
@@ -2123,6 +2129,8 @@ static int wm5102_probe(struct platform_device *pdev)
 err_dsp_irq:
 	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
+err_jack_codec_dev:
+	arizona_jack_codec_dev_remove(&wm5102->core);
 
 	return ret;
 }
@@ -2141,6 +2149,8 @@ static int wm5102_remove(struct platform_device *pdev)
 	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
 
+	arizona_jack_codec_dev_remove(&wm5102->core);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 4238929b2375..ef22051a3599 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2370,6 +2370,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm5110 = {
 	.remove			= wm5110_component_remove,
 	.set_sysclk		= arizona_set_sysclk,
 	.set_pll		= wm5110_set_fll,
+	.set_jack		= arizona_jack_set_jack,
 	.name			= DRV_NAME,
 	.compress_ops		= &wm5110_compress_ops,
 	.controls		= wm5110_snd_controls,
@@ -2424,6 +2425,11 @@ static int wm5110_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	/* This may return -EPROBE_DEFER, so do this early on */
+	ret = arizona_jack_codec_dev_probe(&wm5110->core, &pdev->dev);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(wm5110->fll); i++)
 		wm5110->fll[i].vco_mult = 3;
 
@@ -2456,7 +2462,7 @@ static int wm5110_probe(struct platform_device *pdev)
 				  wm5110);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
-		return ret;
+		goto err_jack_codec_dev;
 	}
 
 	ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
@@ -2490,6 +2496,8 @@ static int wm5110_probe(struct platform_device *pdev)
 err_dsp_irq:
 	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
+err_jack_codec_dev:
+	arizona_jack_codec_dev_remove(&wm5110->core);
 
 	return ret;
 }
@@ -2510,6 +2518,8 @@ static int wm5110_remove(struct platform_device *pdev)
 	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
 
+	arizona_jack_codec_dev_remove(&wm5110->core);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 229f2986cd96..4f5a848960e0 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1096,6 +1096,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8997 = {
 	.remove			= wm8997_component_remove,
 	.set_sysclk		= arizona_set_sysclk,
 	.set_pll		= wm8997_set_fll,
+	.set_jack		= arizona_jack_set_jack,
 	.controls		= wm8997_snd_controls,
 	.num_controls		= ARRAY_SIZE(wm8997_snd_controls),
 	.dapm_widgets		= wm8997_dapm_widgets,
@@ -1132,6 +1133,11 @@ static int wm8997_probe(struct platform_device *pdev)
 
 	arizona_init_dvfs(&wm8997->core);
 
+	/* This may return -EPROBE_DEFER, so do this early on */
+	ret = arizona_jack_codec_dev_probe(&wm8997->core, &pdev->dev);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(wm8997->fll); i++)
 		wm8997->fll[i].vco_mult = 1;
 
@@ -1163,10 +1169,10 @@ static int wm8997_probe(struct platform_device *pdev)
 
 	ret = arizona_init_vol_limit(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_jack_codec_dev;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_jack_codec_dev;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &soc_component_dev_wm8997,
@@ -1181,6 +1187,8 @@ static int wm8997_probe(struct platform_device *pdev)
 
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
+err_jack_codec_dev:
+	arizona_jack_codec_dev_remove(&wm8997->core);
 
 	return ret;
 }
@@ -1194,6 +1202,8 @@ static int wm8997_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_jack_codec_dev_remove(&wm8997->core);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 5413254295b7..f74af1c46933 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1316,6 +1316,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8998 = {
 	.remove			= wm8998_component_remove,
 	.set_sysclk		= arizona_set_sysclk,
 	.set_pll		= wm8998_set_fll,
+	.set_jack		= arizona_jack_set_jack,
 	.controls		= wm8998_snd_controls,
 	.num_controls		= ARRAY_SIZE(wm8998_snd_controls),
 	.dapm_widgets		= wm8998_dapm_widgets,
@@ -1350,6 +1351,11 @@ static int wm8998_probe(struct platform_device *pdev)
 	wm8998->core.arizona = arizona;
 	wm8998->core.num_inputs = 3;	/* IN1L, IN1R, IN2 */
 
+	/* This may return -EPROBE_DEFER, so do this early on */
+	ret = arizona_jack_codec_dev_probe(&wm8998->core, &pdev->dev);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(wm8998->fll); i++)
 		wm8998->fll[i].vco_mult = 1;
 
@@ -1392,6 +1398,7 @@ static int wm8998_probe(struct platform_device *pdev)
 	arizona_free_spk_irqs(arizona);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	arizona_jack_codec_dev_remove(&wm8998->core);
 
 	return ret;
 }
@@ -1405,6 +1412,8 @@ static int wm8998_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_jack_codec_dev_remove(&wm8998->core);
+
 	return 0;
 }
 
-- 
2.29.2

