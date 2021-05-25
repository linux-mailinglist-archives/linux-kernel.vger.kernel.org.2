Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62D638FD84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhEYJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:12:57 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:55485 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232364AbhEYJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:12:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 1E685E2C;
        Tue, 25 May 2021 05:11:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 25 May 2021 05:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=WMExxbKpb723D
        6YVDVSHvvRRkWLWmEdwafytxkU3Fmc=; b=aoek5ABh1q7SanV3Owr+OAYGp9dh5
        XGK0744ecAByekZHKUN0LHI107HYQTxiBK8R1mveLV1xALhGJCre70QF5ry3N21J
        3STD8nQdbpEPoVe/oqeh7338ItnWBzYOAy1vfIs5w9CiqWimBrOKnC+PtQIf1duD
        Q6p35q/c+YhDzu1ug/fYSgXEnUohtFNjv4PrTGfzCzDHu/rKx97ss+IMoCcRwQW7
        ePa1tdBIMCpf/Lcr2CVKmfwQ2pbqTe3iHMoYXvzSQPfbupyTdXqrxazTDAAf7qbI
        Xo2pMYNSTNvITWTZoX9hHkNJ7ZdFY3nNKJceJ7jlocklz2gK1w1mIyakg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WMExxbKpb723D6YVDVSHvvRRkWLWmEdwafytxkU3Fmc=; b=U6BkRoNL
        XX/lshApFctlXIiwHgyA5n4R2AIkG2bAtA6KOrNcsN4erAGug0a0F5n8F//e+Eat
        ZKtcS/VA56OH7xbhRTzcm0ebuWtbiO7e35AsQVdHDdMOa7MgnGf4U1PHe7vV6Ujz
        ayLGcjy+FRW8jQnhHKX0NI+Y9+Af5MOemQkpAWzR2dBo5kXfs+NhbkW3cr8NQ/vk
        hXCwBCMEc6Kqfo9wRhX+wn43wzNFmmXIxeH8yEuxIYB9J8Q0NP4SjiL0XcUUsIzS
        dXqEWxKSUa/ftvg0sWrdXJRvGzzLxp326d9GkJi8+8//5VzvUa04iHR28hQ+omUY
        P7O359z58PBsGQ==
X-ME-Sender: <xms:L7-sYCR5ILG6ROOR87KgTb8edTp-AGE6ThmtRidCQzdJxR5ShCdMEw>
    <xme:L7-sYHwI0MR0KmSV8WIlE7hISSMN4bulrh_W-5uU0k3qZ4oX4lWrQGbjLAJ0zrbf9
    XT_olhtKJQrHBsDbow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:L7-sYP1c4wXCWEennw5ZGOLoqymiiXOSF6rPaTBzve8xKao-KWK7og>
    <xmx:L7-sYOBReSuR6llgRf_8R6ToIohbdXsx2-FUimArkrM2_0d0R-wLyQ>
    <xmx:L7-sYLjg-ni1VS2aUzQf9Z0K-xb495tUT153hLHG5cNi2NpK8Eu3dA>
    <xmx:L7-sYGSHndTl-l6SFEan8-H98HjzRl2Fu6v-P0MhGjm_Esl1qVFYlX7pIUE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 05:11:11 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Emma Anholt <emma@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 2/3] drm/vc4: hdmi: Move the HSM clock enable to runtime_pm
Date:   Tue, 25 May 2021 11:10:58 +0200
Message-Id: <20210525091059.234116-3-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525091059.234116-1-maxime@cerno.tech>
References: <20210525091059.234116-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to access the HDMI controller, we need to make sure the HSM
clock is enabled. If we were to access it with the clock disabled, the
CPU would completely hang, resulting in an hard crash.

Since we have different code path that would require it, let's move that
clock enable / disable to runtime_pm that will take care of the
reference counting for us.

Fixes: 4f6e3d66ac52 ("drm/vc4: Add runtime PM support to the HDMI encoder driver")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 41 +++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f9de8632a28b..867009a471e1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -632,7 +632,6 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
 		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
 
 	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
-	clk_disable_unprepare(vc4_hdmi->hsm_clock);
 	clk_disable_unprepare(vc4_hdmi->pixel_clock);
 
 	ret = pm_runtime_put(&vc4_hdmi->pdev->dev);
@@ -943,13 +942,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 		return;
 	}
 
-	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
-	if (ret) {
-		DRM_ERROR("Failed to turn on HSM clock: %d\n", ret);
-		clk_disable_unprepare(vc4_hdmi->pixel_clock);
-		return;
-	}
-
 	vc4_hdmi_cec_update_clk_div(vc4_hdmi);
 
 	if (pixel_rate > 297000000)
@@ -962,7 +954,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 	ret = clk_set_min_rate(vc4_hdmi->pixel_bvb_clock, bvb_rate);
 	if (ret) {
 		DRM_ERROR("Failed to set pixel bvb clock rate: %d\n", ret);
-		clk_disable_unprepare(vc4_hdmi->hsm_clock);
 		clk_disable_unprepare(vc4_hdmi->pixel_clock);
 		return;
 	}
@@ -970,7 +961,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 	ret = clk_prepare_enable(vc4_hdmi->pixel_bvb_clock);
 	if (ret) {
 		DRM_ERROR("Failed to turn on pixel bvb clock: %d\n", ret);
-		clk_disable_unprepare(vc4_hdmi->hsm_clock);
 		clk_disable_unprepare(vc4_hdmi->pixel_clock);
 		return;
 	}
@@ -2097,6 +2087,29 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int vc4_hdmi_runtime_suspend(struct device *dev)
+{
+	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(vc4_hdmi->hsm_clock);
+
+	return 0;
+}
+
+static int vc4_hdmi_runtime_resume(struct device *dev)
+{
+	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
+
 static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	const struct vc4_hdmi_variant *variant = of_device_get_match_data(dev);
@@ -2353,11 +2366,19 @@ static const struct of_device_id vc4_hdmi_dt_match[] = {
 	{}
 };
 
+
+static const struct dev_pm_ops vc4_hdmi_pm_ops = {
+	SET_RUNTIME_PM_OPS(vc4_hdmi_runtime_suspend,
+			   vc4_hdmi_runtime_resume,
+			   NULL)
+};
+
 struct platform_driver vc4_hdmi_driver = {
 	.probe = vc4_hdmi_dev_probe,
 	.remove = vc4_hdmi_dev_remove,
 	.driver = {
 		.name = "vc4_hdmi",
 		.of_match_table = vc4_hdmi_dt_match,
+		.pm = &vc4_hdmi_pm_ops,
 	},
 };
-- 
2.31.1

