Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7B30F22F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhBDLaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235741AbhBDL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612437958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2JJirzNCMB8GeU4K/HSJ3JSolOZZuiPMutvN9QVsto=;
        b=PUR0+8mfTmGFObq6P0HYEsQgD7PwMib0u9tEtof5C7C4418Jo4kM33DPxBBC42zU71jte1
        uJf1K+PvbGfcOiri05kxYHPK0v1M2sdd/o4zBagZcvw3bH1TLNZkrOyowkxlbsvei3+0YT
        7jIlxO02MZ0y9IqQn/K7GNgJBRyLUU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-BGRrvUPxOouc1CjV2OKHhg-1; Thu, 04 Feb 2021 06:25:54 -0500
X-MC-Unique: BGRrvUPxOouc1CjV2OKHhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8ACA1936B60;
        Thu,  4 Feb 2021 11:25:52 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-112.ams2.redhat.com [10.36.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4698F5B695;
        Thu,  4 Feb 2021 11:25:50 +0000 (UTC)
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
Subject: [PATCH v4 resend 13/13] ASoC: Intel: bytcr_wm5102: Add jack detect support
Date:   Thu,  4 Feb 2021 12:25:02 +0100
Message-Id: <20210204112502.88362-14-hdegoede@redhat.com>
In-Reply-To: <20210204112502.88362-1-hdegoede@redhat.com>
References: <20210204112502.88362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jack detect support by creating a jack and calling
snd_soc_component_set_jack to register the created jack
with the codec.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 28 ++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index f38850eb2eaf..cdfe203ed9fa 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -31,6 +32,7 @@
 #define WM5102_MAX_SYSCLK_11025	45158400 /* max sysclk for 11.025K family */
 
 struct byt_wm5102_private {
+	struct snd_soc_jack jack;
 	struct clk *mclk;
 	struct gpio_desc *spkvdd_en_gpio;
 };
@@ -177,11 +179,23 @@ static const struct snd_kcontrol_new byt_wm5102_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static struct snd_soc_jack_pin byt_wm5102_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct byt_wm5102_private *priv = snd_soc_card_get_drvdata(card);
-	int ret;
+	struct snd_soc_component *component = asoc_rtd_to_codec(runtime, 0)->component;
+	int ret, jack_type;
 
 	card->dapm.idle_bias_off = true;
 
@@ -210,6 +224,18 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	jack_type = ARIZONA_JACK_MASK | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	ret = snd_soc_card_jack_new(card, "Headset", jack_type,
+				    &priv->jack, byt_wm5102_pins,
+				    ARRAY_SIZE(byt_wm5102_pins));
+	if (ret) {
+		dev_err(card->dev, "Error creating jack: %d\n", ret);
+		return ret;
+	}
+
+	snd_soc_component_set_jack(component, &priv->jack, NULL);
+
 	return 0;
 }
 
-- 
2.29.2

