Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCDB3A47B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFKRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhFKRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:20:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C664C0613A3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:18:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x16so776692pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJwTxQIhOmA7Nh49mNVrK7VVuZXaJBaKZqQJNslv2fU=;
        b=TDxd/0ku7qsfDFtpoOxtzswOwRAtY7gKsL1XRkqEExzAUiLkD5mOILH1Ibv9vCbI4o
         PRcV8dJaHfD3HaTUBg19jWY/I51Sy+GN1m3IgdWN0kXZJgn+s/mzfFb5QWopH/+b64kz
         QIIvnKekLqdLpxb2rQha8eFo81V7GqTTMNI6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJwTxQIhOmA7Nh49mNVrK7VVuZXaJBaKZqQJNslv2fU=;
        b=fBDLn8AgRYn4e2UMw0L719YdiPZpFVbgb26PbSl8/je3YU57jNyFWKDKd2Cy5iMr4C
         2Zw/Ttok2LPPM4853fi9VsEn2JeBOb5cSDRHxZ0B6xRak1rwljE7unKSuvacmBjyHHwf
         v4VV43m6Z5JCIK+XJLV2VWwlu+very5zN/fWAn+KheWZBQtIUbzP165gJ6GKHiRCbMCy
         um2S9v7PipWfS9zAZw38xmnSdTFG/wLnhDrd8lOzN1vL5nwVm/iCvRvBrD25xz1/XU41
         y3fmQZE1AAjYnpItUJq7IBPCfpL4sKM5fz5BRjV8jig4P/g9FDYkTvL047dp3t4BhZ4F
         HWnA==
X-Gm-Message-State: AOAM533MUJI/1SQ7EIgBIkq4Hci0/PRXfk0G1AJhWp1MnBSqCIhHaPfg
        /9p2Sg/+B+QMYU+J8imHOaHr5A==
X-Google-Smtp-Source: ABdhPJw195FLMV+AUfHuGIGRAOWQEVKJWzVnV9dRQjabCiE5MADUPUVt72oiuAjH9mxGSChntYtYkQ==
X-Received: by 2002:a63:f4b:: with SMTP id 11mr4703830pgp.250.1623431895780;
        Fri, 11 Jun 2021 10:18:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:4128:5428:5cd0:cfa5])
        by smtp.gmail.com with ESMTPSA id f17sm5837850pgm.37.2021.06.11.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:18:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 07/11] drm/bridge: ti-sn65dsi86: Promote the AUX channel to its own sub-dev
Date:   Fri, 11 Jun 2021 10:17:43 -0700
Message-Id: <20210611101711.v10.7.If89144992cb9d900f8c91a8d1817dbe00f543720@changeid>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611171747.1263039-1-dianders@chromium.org>
References: <20210611171747.1263039-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On its own, this change looks a little strange and doesn't do too much
useful. To understand why we're doing this we need to look forward to
future patches where we're going to probe our panel using the new DP
AUX bus. See the patch ("drm/bridge: ti-sn65dsi86: Add support for the
DP AUX bus").

Let's think about the set of steps we'll want to happen when we have
the DP AUX bus:

1. We'll create the DP AUX bus.
2. We'll populate the devices on the DP AUX bus (AKA our panel).
3. For setting up the bridge-related functions of ti-sn65dsi86 we'll
   need to get a reference to the panel.

If we do #1 - #3 in a single probe call things _mostly_ will work, but
it won't be massively robust. Let's explore.

First let's think of the easy case of no -EPROBE_DEFER. In that case
in step #2 when we populate the devices on the DP AUX bus it will
actually try probing the panel right away. Since the panel probe
doesn't defer then in step #3 we'll get a reference to the panel and
we're golden.

Second, let's think of the case when the panel returns
-EPROBE_DEFER. In that case step #2 won't synchronously create the
panel (it'll just add the device to the defer list to do it
later). Step #3 will fail to get the panel and the bridge sub-device
will return -EPROBE_DEFER. We'll depopulate the DP AUX bus. Later
we'll try the whole sequence again. Presumably the panel will
eventually stop returning -EPROBE_DEFER and we'll go back to the first
case where things were golden. So this case is OK too even if it's a
bit ugly that we have to keep creating / deleting the AUX bus over and
over.

So where is the problem? As I said, it's mostly about robustness. I
don't believe that step #2 (creating the sub-devices) is really
guaranteed to be synchronous. This is evidenced by the fact that it's
allowed to "succeed" by just sticking the device on the deferred
list. If anything about the process changes in Linux as a whole and
step #2 just kicks off the probe of the DP AUX endpoints (our panel)
in the background then we'd be in trouble because we might never get
the panel in step #3.

Adding an extra sub-device means we just don't need to worry about
it. We'll create the sub-device for the DP AUX bus and it won't go
away until the whole ti-sn65dsi86 driver goes away. If the bridge
sub-device defers (maybe because it can't find the panel) that won't
depopulate the DP AUX bus and so we don't need to worry about it.

NOTE: there's a little bit of a trick here. Though the AUX channel can
run without the MIPI-to-eDP bits of the code, the MIPI-to-eDP bits
can't run without the AUX channel. We could come up a complicated
signaling scheme (have the MIPI-to-eDP bits return EPROBE_DEFER for a
while or wait on some sort of completion), but it seems simple enough
to just not even bother creating the bridge device until the AUX
channel probes. That's what we'll do.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

(no changes since v9)

Changes in v9:
- Properly set the of_node of sn65dsi86 auxbus devices now.

Changes in v7:
- Beefed up commit message in context of the DP AUX bus.
- Remove use of now-dropped drm_dp_aux_register_ddc() call.
- Set the proper sub-device "dev" pointer in the AUX structure.

Changes in v6:
- Use new drm_dp_aux_register_ddc() calls.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 70 +++++++++++++++++++--------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 45a2969afb2b..8e61005cf4ad 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -116,6 +116,7 @@
  * struct ti_sn65dsi86 - Platform data for ti-sn65dsi86 driver.
  * @bridge_aux:   AUX-bus sub device for MIPI-to-eDP bridge functionality.
  * @gpio_aux:     AUX-bus sub device for GPIO controller functionality.
+ * @aux_aux:      AUX-bus sub device for eDP AUX channel functionality.
  *
  * @dev:          Pointer to the top level (i2c) device.
  * @regmap:       Regmap for accessing i2c.
@@ -148,6 +149,7 @@
 struct ti_sn65dsi86 {
 	struct auxiliary_device		bridge_aux;
 	struct auxiliary_device		gpio_aux;
+	struct auxiliary_device		aux_aux;
 
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -1333,11 +1335,6 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	if (ret)
 		return ret;
 
-	pdata->aux.name = "ti-sn65dsi86-aux";
-	pdata->aux.dev = pdata->dev;
-	pdata->aux.transfer = ti_sn_aux_transfer;
-	drm_dp_aux_init(&pdata->aux);
-
 	pdata->bridge.funcs = &ti_sn_bridge_funcs;
 	pdata->bridge.of_node = np;
 
@@ -1406,17 +1403,10 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	struct device *dev = pdata->dev;
 	int ret;
 
-	/*
-	 * NOTE: It would be nice to set the "of_node" of our children to be
-	 * the same "of_node"" that the top-level component has. That doesn't
-	 * work, though, since pinctrl will try (and fail) to reserve the
-	 * pins again. Until that gets sorted out the children will just need
-	 * to look at the of_node of the main device.
-	 */
-
 	aux->name = name;
 	aux->dev.parent = dev;
 	aux->dev.release = ti_sn65dsi86_noop;
+	device_set_of_node_from_dev(&aux->dev, dev);
 	ret = auxiliary_device_init(aux);
 	if (ret)
 		return ret;
@@ -1432,6 +1422,34 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	return ret;
 }
 
+static int ti_sn_aux_probe(struct auxiliary_device *adev,
+			   const struct auxiliary_device_id *id)
+{
+	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
+
+	pdata->aux.name = "ti-sn65dsi86-aux";
+	pdata->aux.dev = &adev->dev;
+	pdata->aux.transfer = ti_sn_aux_transfer;
+	drm_dp_aux_init(&pdata->aux);
+
+	/*
+	 * The eDP to MIPI bridge parts don't work until the AUX channel is
+	 * setup so we don't add it in the main driver probe, we add it now.
+	 */
+	return ti_sn65dsi86_add_aux_device(pdata, &pdata->bridge_aux, "bridge");
+}
+
+static const struct auxiliary_device_id ti_sn_aux_id_table[] = {
+	{ .name = "ti_sn65dsi86.aux", },
+	{},
+};
+
+static struct auxiliary_driver ti_sn_aux_driver = {
+	.name = "aux",
+	.probe = ti_sn_aux_probe,
+	.id_table = ti_sn_aux_id_table,
+};
+
 static int ti_sn65dsi86_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -1490,10 +1508,11 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 	 * motiviation here is to solve the chicken-and-egg problem of probe
 	 * ordering. The bridge wants the panel to be there when it probes.
 	 * The panel wants its HPD GPIO (provided by sn65dsi86 on some boards)
-	 * when it probes. There will soon be other devices (DDC I2C bus, PWM)
-	 * that have the same problem. Having sub-devices allows the some sub
-	 * devices to finish probing even if others return -EPROBE_DEFER and
-	 * gets us around the problems.
+	 * when it probes. The panel and maybe backlight might want the DDC
+	 * bus. Soon the PWM provided by the bridge chip will have the same
+	 * problem. Having sub-devices allows the some sub devices to finish
+	 * probing even if others return -EPROBE_DEFER and gets us around the
+	 * problems.
 	 */
 
 	if (IS_ENABLED(CONFIG_OF_GPIO)) {
@@ -1502,7 +1521,13 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	return ti_sn65dsi86_add_aux_device(pdata, &pdata->bridge_aux, "bridge");
+	/*
+	 * NOTE: At the end of the AUX channel probe we'll add the aux device
+	 * for the bridge. This is because the bridge can't be used until the
+	 * AUX channel is there and this is a very simple solution to the
+	 * dependency problem.
+	 */
+	return ti_sn65dsi86_add_aux_device(pdata, &pdata->aux_aux, "aux");
 }
 
 static struct i2c_device_id ti_sn65dsi86_id[] = {
@@ -1539,12 +1564,18 @@ static int __init ti_sn65dsi86_init(void)
 	if (ret)
 		goto err_main_was_registered;
 
-	ret = auxiliary_driver_register(&ti_sn_bridge_driver);
+	ret = auxiliary_driver_register(&ti_sn_aux_driver);
 	if (ret)
 		goto err_gpio_was_registered;
 
+	ret = auxiliary_driver_register(&ti_sn_bridge_driver);
+	if (ret)
+		goto err_aux_was_registered;
+
 	return 0;
 
+err_aux_was_registered:
+	auxiliary_driver_unregister(&ti_sn_aux_driver);
 err_gpio_was_registered:
 	ti_sn_gpio_unregister();
 err_main_was_registered:
@@ -1557,6 +1588,7 @@ module_init(ti_sn65dsi86_init);
 static void __exit ti_sn65dsi86_exit(void)
 {
 	auxiliary_driver_unregister(&ti_sn_bridge_driver);
+	auxiliary_driver_unregister(&ti_sn_aux_driver);
 	ti_sn_gpio_unregister();
 	i2c_del_driver(&ti_sn65dsi86_driver);
 }
-- 
2.32.0.272.g935e593368-goog

