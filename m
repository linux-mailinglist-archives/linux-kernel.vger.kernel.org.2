Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5677390238
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhEYN03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:26:29 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47069 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233298AbhEYNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:25:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DCA1758070C;
        Tue, 25 May 2021 09:24:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 25 May 2021 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=m3jqrHUcLvTHp
        x0b4SsKGIVJ+DdDaje1iSf3ZfK37qk=; b=FDPwjmp0f2USjfe98TFZn/YeVgsFc
        ofGk6rqMTPcnr3AuTv6O6T6LDLwXdeDbr6jc6TMkF8SbHy1qELqLanKNRPQTLRHx
        8cJLDHM8hdBQAMGua9envdWRmFSOtiXh9ubcX1mRaGKvywVt1HaHqb1mq4HA2n7m
        a9ly/2uETZ33/0z7yD0HylD3bdQEEzBk95zkOi6I0G8cNzpCrOmIg1y3rTtDyLBC
        o+kDb5ho027OofRcHD/XOrf2F6Q9TcktkNH1J/t0qBkjSRoSMC+YRxvU67qKz9K3
        q7xv9h6WvM6Fdf+RmtuSYSXxaNDB8q2pEtExGbFm8ZRhDPtjfO8D+dctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=m3jqrHUcLvTHpx0b4SsKGIVJ+DdDaje1iSf3ZfK37qk=; b=opvUfrsh
        bg3bZ2mRB8yulvFszzrLnSug0JN4xdLWnREQo+PU6plQmFtJGAUM1YaE1dsRNa7t
        lxhSzNPgGfme0EvvaGj4+B53DL9Nvyd4B1aihYcZmFFJKUMXFASNoQ2OSZN0Fkbc
        8XiAdkSm/Nsh9qk0erjrcYIoQfW9Mkghulzds1Z2BMHtoksldA/KWrznj3TlGsZ9
        U7uH7AuYFhaoeAuc9xKuODlpNRlPCU3etJNTKlFhl/0RQKprYYe5J4oAsLGaRyB4
        NMaYqJZDmddMjXVQFWpzcWxaegOsODW8zrUR5vyWwUnfugh2/KNlQz6DQQCbJAi6
        YS3/JGIm/I6hlA==
X-ME-Sender: <xms:ePqsYKbo2bsNvCn5g4rOLs08WOcroIlhY1OcvwWvnSzGGj-Rid0pKQ>
    <xme:ePqsYNZOy3eGIofrJGLTzjZBJwfmkpVN_ik1TemFdJXM2W_ugJ6rBFhJz24SbbWj_
    Jn_p0mYj6Ot2ucFAdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ePqsYE8tDePLz03Oojiu_vYtm7msMtvvsHfsTn_MaUnfVODFbCleiQ>
    <xmx:ePqsYMqwCA-4iwMHwtVyRb7LqgvfymQ-WrE4Dy9ZiNo7XRneEfQowA>
    <xmx:ePqsYFqGBJihHv8Lgt0UPAMUuW0i_XuzSCZVHX-MsVu_FlNJ6E4f_A>
    <xmx:ePqsYLhjkn6p9tGrEcM9PWoJ8_EoX8Rh-q4I18IPMtcfG81nKs_sQQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 09:24:08 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 04/12] ASoC: hdmi-codec: Add iec958 controls
Date:   Tue, 25 May 2021 15:23:46 +0200
Message-Id: <20210525132354.297468-5-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525132354.297468-1-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IEC958 status bits can be exposed and modified by the userspace
through dedicated ALSA controls.

This patch implements those controls for the hdmi-codec driver. It
relies on a default value being setup at probe time that can later be
overridden by the control put.

The hw_params callback is then called with a buffer filled with the
proper bits for the current parameters being passed on so the underlying
driver can just reuse those bits as is.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 sound/soc/codecs/hdmi-codec.c | 66 +++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 65bde6f0ea1c..5d6324585a31 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -277,6 +277,7 @@ struct hdmi_codec_priv {
 	bool busy;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
+	u8 iec_status[5];
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -385,6 +386,47 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int hdmi_codec_iec958_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int hdmi_codec_iec958_default_get(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	memcpy(ucontrol->value.iec958.status, hcp->iec_status,
+	       sizeof(hcp->iec_status));
+
+	return 0;
+}
+
+static int hdmi_codec_iec958_default_put(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	memcpy(hcp->iec_status, ucontrol->value.iec958.status,
+	       sizeof(hcp->iec_status));
+
+	return 0;
+}
+
+static int hdmi_codec_iec958_mask_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	memset(ucontrol->value.iec958.status, 0xff,
+	       sizeof_field(struct hdmi_codec_priv, iec_status));
+
+	return 0;
+}
+
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -459,8 +501,9 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 		params_width(params), params_rate(params),
 		params_channels(params));
 
-	ret = snd_pcm_create_iec958_consumer_hw_params(params, hp.iec.status,
-						       sizeof(hp.iec.status));
+	memcpy(hp.iec.status, hcp->iec_status, sizeof(hp->iec_status));
+	ret = snd_pcm_fill_iec958_consumer_hw_params(params, hp.iec.status,
+						     sizeof(hp.iec.status));
 	if (ret < 0) {
 		dev_err(dai->dev, "Creating IEC958 channel status failed %d\n",
 			ret);
@@ -621,6 +664,20 @@ static const struct snd_soc_dai_ops hdmi_codec_spdif_dai_ops = {
 			 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
 struct snd_kcontrol_new hdmi_codec_controls[] = {
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READ,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, MASK),
+		.info = hdmi_codec_iec958_info,
+		.get = hdmi_codec_iec958_mask_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.info = hdmi_codec_iec958_info,
+		.get = hdmi_codec_iec958_default_get,
+		.put = hdmi_codec_iec958_default_put,
+	},
 	{
 		.access	= (SNDRV_CTL_ELEM_ACCESS_READ |
 			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
@@ -873,6 +930,11 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	hcp->hcd = *hcd;
 	mutex_init(&hcp->lock);
 
+	ret = snd_pcm_create_iec958_consumer_default(hcp->iec_status,
+						     sizeof(hcp->iec_status));
+	if (ret < 0)
+		return ret;
+
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.31.1

