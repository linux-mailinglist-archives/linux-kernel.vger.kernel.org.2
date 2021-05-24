Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D638E74B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhEXNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:21:54 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40777 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232456AbhEXNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:21:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 52C0E4BD8;
        Mon, 24 May 2021 09:20:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 May 2021 09:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=PEtdrXwgBvaUwYIYPbiFDWIuN1
        zy2BnMNjbG9KPDQww=; b=raDgQZ894z5AEx1aq/o4yZGgZfrtlo/rcJpI6s9Xu/
        +9I1orRC8XaIuCREA85gMuoycLnNA7IKLB0NxuhLP92dE9A1YWgrgomv9TtFkTaa
        wyqtMWib8zwBtsHy+/H6yHPImgO9ZvhlzrS00HcjAWMEQu0MXGgVX8xxRHMNpRrh
        Nk037Y3FB3HN61UewzU7Fw0x1K1wEY5jYEMl1xC6SCCIBbq9x4wYAwTAhEz1Wbh6
        WiE+B6c9Da3ZTqPZBJbBd3ScECzmH6kQhhWIt483CSltHbqbgFsJ5usdLuBvxsYM
        ixiCRI7w89SVvwNmpfIJU7rduhHBAdyllftUTDWytlww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PEtdrXwgBvaUwYIYP
        biFDWIuN1zy2BnMNjbG9KPDQww=; b=vtWD0vmBm5kjpA1FZRYLn6uLKvV6fX6xB
        cSdtbrn15IxqkuQVgJHPzYHXgJyZTGz+n24+D95A1UbLT+DHqKkRLRSQEXoQRqo8
        O4PwdljJltaGG4e9M7khCRBhemhxBJQL1OX4SK0rco2RBMIwCEs20rx3zGQH4t7y
        VioAhUKO2ff/ubh2xzRH3lxpJ6hZ007NJDzGCNB9SbuSycZfLYh5i/NdwJAMw+1l
        fd8XHKLQP5ZB+rgmsqSmtabSx0zi6/G49YBysANo4UABz+yaVcDa78urbsEoy5pV
        fPLmvSHvCxyXTQSszl17NqUhNaLimn59rg18OmXbPkem8ac+E+vWA==
X-ME-Sender: <xms:E6irYMZmxfZdnUq12hPR4wwV_qajDO58xQoXWXgRXDjogXrup3rKvg>
    <xme:E6irYHbC4CYR8wdwRgj4i0K0aTtWJLA4OCTjnHkGyDIhNB4km9_eAFT_pqml79dNM
    K9Kp0x56MvycQf-gkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepjeffheduvddvvdelhfegleelfffgieejvdehgfeijedtieeuteejteefueekjeeg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:E6irYG8okQy7WRH9zoyC125SAYWJ6grssBtvw6kpHH3w9dD8AB3UPw>
    <xmx:E6irYGpdWZFGWlZBT4OyG30KleE3jY4Y8sHmq8OpEqZ0BBxIJ25_4A>
    <xmx:E6irYHrG9XLeKlqMKSsaCkpJYizzAiyzfm5Y79bPWivGrFJHkQq-pA>
    <xmx:FairYATmnu6f8hiqroB0tipVdzUNcte_QxK8pfFJcmZauzWxG0oYt_aJMYQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 09:20:19 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] drm/vc4: hdmi: Rely on interrupts to handle hotplug
Date:   Mon, 24 May 2021 15:20:18 +0200
Message-Id: <20210524132018.264396-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM currently polls for the HDMI connector status every 10s, which can
be an issue when we connect/disconnect a display quickly or the device
on the other end only issues a hotplug pulse (for example on EDID
change).

Switch the driver to rely on the internal controller logic for the
BCM2711/RPi4.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index c27b287d2053..3988969f7410 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1510,6 +1510,46 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 
 }
 
+static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
+{
+	struct vc4_hdmi *vc4_hdmi = priv;
+	struct drm_device *dev = vc4_hdmi->connector.dev;
+
+	if (dev)
+		drm_kms_helper_hotplug_event(dev);
+
+	return IRQ_HANDLED;
+}
+
+static int vc4_hdmi_hotplug_init(struct vc4_hdmi *vc4_hdmi)
+{
+	struct platform_device *pdev = vc4_hdmi->pdev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (vc4_hdmi->variant->external_irq_controller) {
+		ret = devm_request_threaded_irq(dev,
+						platform_get_irq_byname(pdev, "hpd-connected"),
+						NULL,
+						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
+						"vc4 hdmi hpd connected", vc4_hdmi);
+		if (ret)
+			return ret;
+
+		ret = devm_request_threaded_irq(dev,
+						platform_get_irq_byname(pdev, "hpd-removed"),
+						NULL,
+						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
+						"vc4 hdmi hpd disconnected", vc4_hdmi);
+		if (ret)
+			return ret;
+
+		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_DRM_VC4_HDMI_CEC
 static irqreturn_t vc4_cec_irq_handler_rx_thread(int irq, void *priv)
 {
@@ -2060,6 +2100,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_destroy_encoder;
 
+	ret = vc4_hdmi_hotplug_init(vc4_hdmi);
+	if (ret)
+		goto err_destroy_conn;
+
 	ret = vc4_hdmi_cec_init(vc4_hdmi);
 	if (ret)
 		goto err_destroy_conn;
-- 
2.31.1

