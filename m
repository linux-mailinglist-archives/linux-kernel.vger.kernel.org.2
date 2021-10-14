Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5142DE14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhJNP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhJNP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:28:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB301C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i12so20682223wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQyJyeyxugDyeCUhn5i4YMOhGyD1g0TIMIamYKTURg8=;
        b=aUp3lJkhPh7AP+vd/IxIyLZ9pww2/86fdh30VMRPWAjOPgcYeMdPzrsxZP6sBE00E8
         pGgzyLGLmp7zVQ9cUv4mpduzaEXvlUsIaRQ5JV5NYw5sBZgTNhtsBPU8cWCoubF4OfIc
         We6escDBTXR7ecjOqAG4gkw4+7NGQRUo4+QsAzHDndGtbN1dr1o8V2Z1KEESagi+16Rl
         5fOOUoFuqRymwJctDz1xKKLZDd4T60MPavnGIjCNluwnnSLQII3vOnjSlAbJt3b7KJll
         vQmOM1DfYTWxh5JoOgbb+9xIQpmPQaoVZxhIPK6kR3U8HplWUWWagcbLKHRnB6FdBF16
         6gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQyJyeyxugDyeCUhn5i4YMOhGyD1g0TIMIamYKTURg8=;
        b=XMo2gzM+qB4/JRS2WU2YLl3HvVXgf6ijAYXAAUe4tV0G+sC43ZmdRZd5IdkQhXeZE2
         ISfUsXYVV1o3kIEOoPo5/g/C2BGsB3PAGWTPs8Fxc6fp94rGi3cb2aJA5sB55Z1tjaR+
         BkbjbBkkeE/8NK76+IzvZoF2vCoU8O0+5XIk0xqIlKSbAcFT0aQgC/411QXLRDK4D+6v
         jkO2BE7kZcxLLfa/ZiY4kmLqjAep8vJBXioxbr2mi71ONaeXMm/L6uBVe3NXxTjzS/lP
         VAlfZ0aVWnEEnFO7t0kcXeWH0Er05vdP6acrHCw9E2QlZJ9Pzg211lXOwpzBRKVcxnL3
         +Ghw==
X-Gm-Message-State: AOAM531+hMRyGX5VqBWEvT/tM2rIsYqFyC2xijfVDG8fBBZ6Dz5/qu/N
        wxNZuOv+NE6jj//cWkPlCHlZFkTNioGLpQ==
X-Google-Smtp-Source: ABdhPJxnLyE8e0XkabFsMCNQvlY0H++PdbAFZrHOuqQqMKmsmbK8aX172SuBdkcJX2Cj9DFX3GNU8g==
X-Received: by 2002:adf:bb93:: with SMTP id q19mr7638741wrg.423.1634225174291;
        Thu, 14 Oct 2021 08:26:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:209b:8400:2b80:b4ae])
        by smtp.gmail.com with ESMTPSA id k22sm2626790wrd.59.2021.10.14.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:26:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/7] drm/meson: remove useless recursive components matching
Date:   Thu, 14 Oct 2021 17:26:01 +0200
Message-Id: <20211014152606.2289528-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014152606.2289528-1-narmstrong@baylibre.com>
References: <20211014152606.2289528-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; h=from:subject; bh=hBDX9bpPEmClmGilczb0BvjIpqS0+aaehaCml/3nEUs=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhaEt/6ArrByBlXtYa4Vcu1Celjod/sPgyacJsGSYf F+mjdc+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYWhLfwAKCRB33NvayMhJ0UhTD/ sH5NZJVQx2YWy6sRmd61nqnsAGOSLvKNLmGt8xiRmm0Zb6ckWoeM30vuE14uVqqzR5ikE4cAk/T3jF 7/r1O/KwZkOPSCzUIFpNFuzUPkO2d0DjdyTSbkZFUEmBLmAwGFio3y6BQu8Pa4pURJP0FgXWNVYVye aT5CTX2lGsSJseYDx5JYNt6U71cmF9f78gV4+1PrRmu8s1rto3ltR/8K7WvWcURGAm8ordgWepmS5E 7dj0ZYEWUvKWJLZFePsoHZwXUGBcrSLd4N6AP285F8+1dD7pULchywDPVlue6vJwlfVy+QUJUvwu3j iXKQNRu2FzqliPbcwmbtkymy6kUvBdRKp3WPoRpPZgAdlEzZMklGMm0UiUFICCyKNt8Cwd9a9mYNGu fuOllgCaOoC/cdInuHDEQP3wZdS+m1dlbdFzVPhcYOqSDgtbVGa17Y9DBms8ypC0KWUmIh3TopYHun o3mNZ3G5AOzbil+PIl+oFEef6n9t/9w55rU9m1638cRpZOJknrxAdP8NWUDkV3//J6Ynq4UzVEcWbl H+4OkvqyX+UchzQ+NrfCQssWeD3aF6Vn+17AML3/MN48tFNupMUCvq106yYJeucpiIlDpfx805qymA hXLGWVK/F9bG9qFrA6ImJQW6Otdxc+H9TRc2JpYtS+iSrdbcW7dw6ohCHb/Q==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial design was recursive to cover all port/endpoints, but only the first layer
of endpoints should be covered by the components list.
This also breaks the MIPI-DSI init/bridge attach sequence, thus only parse the
first endpoints instead of recursing.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 62 +++++++++++--------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index bc0d60df04ae..b53606d8825f 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -427,46 +427,6 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
-/* Possible connectors nodes to ignore */
-static const struct of_device_id connectors_match[] = {
-	{ .compatible = "composite-video-connector" },
-	{ .compatible = "svideo-connector" },
-	{ .compatible = "hdmi-connector" },
-	{ .compatible = "dvi-connector" },
-	{}
-};
-
-static int meson_probe_remote(struct platform_device *pdev,
-			      struct component_match **match,
-			      struct device_node *parent,
-			      struct device_node *remote)
-{
-	struct device_node *ep, *remote_node;
-	int count = 1;
-
-	/* If node is a connector, return and do not add to match table */
-	if (of_match_node(connectors_match, remote))
-		return 1;
-
-	component_match_add(&pdev->dev, match, compare_of, remote);
-
-	for_each_endpoint_of_node(remote, ep) {
-		remote_node = of_graph_get_remote_port_parent(ep);
-		if (!remote_node ||
-		    remote_node == parent || /* Ignore parent endpoint */
-		    !of_device_is_available(remote_node)) {
-			of_node_put(remote_node);
-			continue;
-		}
-
-		count += meson_probe_remote(pdev, match, remote, remote_node);
-
-		of_node_put(remote_node);
-	}
-
-	return count;
-}
-
 static void meson_drv_shutdown(struct platform_device *pdev)
 {
 	struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
@@ -478,6 +438,13 @@ static void meson_drv_shutdown(struct platform_device *pdev)
 	drm_atomic_helper_shutdown(priv->drm);
 }
 
+/* Possible connectors nodes to ignore */
+static const struct of_device_id connectors_match[] = {
+	{ .compatible = "composite-video-connector" },
+	{ .compatible = "svideo-connector" },
+	{}
+};
+
 static int meson_drv_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
@@ -492,8 +459,21 @@ static int meson_drv_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		count += meson_probe_remote(pdev, &match, np, remote);
+		/* If an analog connector is detected, count it as an output */
+		if (of_match_node(connectors_match, remote)) {
+			++count;
+			of_node_put(remote);
+			continue;
+		}
+
+		DRM_DEBUG_DRIVER("parent %pOF remote match add %pOF parent %s\n",
+				  np, remote, dev_name(&pdev->dev));
+
+		component_match_add(&pdev->dev, &match, compare_of, remote);
+
 		of_node_put(remote);
+
+		++count;
 	}
 
 	if (count && !match)
-- 
2.25.1

