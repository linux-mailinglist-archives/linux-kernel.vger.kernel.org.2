Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB03D8F31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhG1NdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:33:05 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41507 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236614AbhG1NdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:33:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 69D39580B92;
        Wed, 28 Jul 2021 09:32:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 28 Jul 2021 09:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=oj0uWTcP4eN/7
        CWZDuDel6GfjZzcOM2ouml6hFdmYPA=; b=Slc460qMfo8dv8eoJrvCksRwXJP26
        FdN2UhmRDlnfq0LcrMhc+R43iu79h22MNTB4lCSBxc9Bd/V9i51IM5CQtWg0FdD1
        IPTPRcaBY8OBuJDvH3ngDPsCp7ITToLHVgyxcmBKQa3bMYcLUpr2fgdF7irkLDbu
        qRXewaVGlE5DVlDOWOT0Zcd2yXg+VRz67PzR1vJNtPDr4bdSy5tfpU4u+Qrm2zLb
        BJXHw8JciJpQhtZ6ofyt2OJWhQvOUgJEu9RuPtIqU3YDhkoucn4Qr8vZIUfk7BaT
        qxFaFQt89P2wGwxDAzHkve7Z5U2pSwChpl96IfsqiI6bKwoP20fEt6HRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=oj0uWTcP4eN/7CWZDuDel6GfjZzcOM2ouml6hFdmYPA=; b=E9ipdD5t
        ZlcBQy9QTB1kPmrL7dwvrn7EgRasv8XwE68licTQuITnJP9PSsnFTlXV+Y5aWh4R
        tzIg3og5O+dUdoiOFtJ5uut9RLz9FEYBK+JWiPOnzSAerOJQ63XmbuPyPmeNKvB4
        nZ1RMGmoxF4LZ+pDkyQtG9PgGirMnTSyuAz1ZgEX7m8Ko+553wgzpIC9PWwtY/lb
        QSXKurF3nnyC6tCbiL20aisxaXQzN9SdxZSR7ZXtCfQXcFwr1tzZQPaqIKXxRWQY
        01WRpiIWdgi1PPj2a6RswqI9p7NA8vtK+fZ6EwndTsXbObatamyZCRFjSLeD/TTo
        V0rkwg5hKSaUPQ==
X-ME-Sender: <xms:iVwBYddrKZVlWNnMQ3qskFOvoBPeWYA1EYhQ694O5eeJSl__SqZqQQ>
    <xme:iVwBYbMwsN2BTlfvwLosjcctHR3j_JuPJo3tbL-UY9j7xa__vT2N0WAtnXedQbchg
    ENzSYdNS8X63ij7us4>
X-ME-Received: <xmr:iVwBYWjmKcZsAEOGejVqgzqrPxKL2ANkLB2o64G0B7oSt-ZoEHo8hxhOQDyAjHFb4For-Qt36xbCY8AwdqMewy3cs68OdU20p_OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeelgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iVwBYW_2m-EfmLLFzri_qZ3kzWDBb8lAyMKX8FeaMi2iNdP4KjKq3A>
    <xmx:iVwBYZtrZ9uMzYEUjx6IJ4KfRJBMtcrhoXzrk-ytvPXT8QV_2i073w>
    <xmx:iVwBYVGvgHNcsR9yXRmJSPTxp1wo80_nNH7CS2PJQZzsCrW7qWBm7g>
    <xmx:i1wBYaMjmJvB8Zw20cJQ2NlqxUeqTVrY7zXvf5xxizmfwth2V0SVNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jul 2021 09:32:57 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 8/8] drm/panel: raspberrypi-touchscreen: Remove MIPI-DSI driver
Date:   Wed, 28 Jul 2021 15:32:29 +0200
Message-Id: <20210728133229.2247965-9-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728133229.2247965-1-maxime@cerno.tech>
References: <20210728133229.2247965-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was using a two-steps initialisation when probing with the
i2c probe first registering the MIPI-DSI device, and then when that
device was probed the driver would attach the device to its host. This
resulted in a fairly non-standard probe logic.

The previous commit changed that logic entirely though, resulting in a
completely empty MIPI-DSI device probe. Let's simplify the driver by
removing it entirely and just behave as a normal i2c driver.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../drm/panel/panel-raspberrypi-touchscreen.c | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 995c5cafb970..09937aa26c6a 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -483,16 +483,6 @@ static int rpi_touchscreen_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static int rpi_touchscreen_dsi_probe(struct mipi_dsi_device *dsi)
-{
-	return 0;
-}
-
-static struct mipi_dsi_driver rpi_touchscreen_dsi_driver = {
-	.driver.name = RPI_DSI_DRIVER_NAME,
-	.probe = rpi_touchscreen_dsi_probe,
-};
-
 static const struct of_device_id rpi_touchscreen_of_ids[] = {
 	{ .compatible = "raspberrypi,7inch-touchscreen-panel" },
 	{ } /* sentinel */
@@ -507,20 +497,7 @@ static struct i2c_driver rpi_touchscreen_driver = {
 	.probe = rpi_touchscreen_probe,
 	.remove = rpi_touchscreen_remove,
 };
-
-static int __init rpi_touchscreen_init(void)
-{
-	mipi_dsi_driver_register(&rpi_touchscreen_dsi_driver);
-	return i2c_add_driver(&rpi_touchscreen_driver);
-}
-module_init(rpi_touchscreen_init);
-
-static void __exit rpi_touchscreen_exit(void)
-{
-	i2c_del_driver(&rpi_touchscreen_driver);
-	mipi_dsi_driver_unregister(&rpi_touchscreen_dsi_driver);
-}
-module_exit(rpi_touchscreen_exit);
+module_i2c_driver(rpi_touchscreen_driver);
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("Raspberry Pi 7-inch touchscreen driver");
-- 
2.31.1

