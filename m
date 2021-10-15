Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3669D42F4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbhJOONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbhJOONV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:13:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B0DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:11:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r18so26807619wrg.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/l0Ehr0hN3gdq8P9wc6WB+d9mjY1ba6Pwx1xklvzGFE=;
        b=COWJY3S3HVBm38qSt+SY+IzP4X5KLFdEMyOeNmTAM9C1XECvQN1OsPAxRoBIniWNpe
         BDxalVBJsUcoMXDjKbeGc2iker0qZKKj9Ie/xf64AJp6JmZLhjvLhwekXz86mqOkx5H6
         zFWYzWapj0ILXiwwdCmn6W/o7skCHp8YgYJh3Wd2JbMJ/xCcJlkjB8crHTcFPyhkEx3F
         czC6jBSXZEER99zJt6FyulyRKgyVsw+6f1xXP25MOYYso3u1GqrDw3v64ATGYTsXxBJl
         nh7WZ30o3hR5TH/EfJ4/rKPkmCsR9CPfZEntur5NJdDrUAdZ6eL52vjOhT3s7OUt+nt2
         kg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/l0Ehr0hN3gdq8P9wc6WB+d9mjY1ba6Pwx1xklvzGFE=;
        b=hcZ8LniIw/D5/bgNe0wPLTDDt9cGGqxq1O+WV/pN8JWGDnM4bFnWkLA/mk7v/0xdvw
         QHeD6MxLFqgVK+OvwBZbkELJNBku772M6TBWSBzegf1MBY7ojJeWZ5dOZw1u49Olnfpz
         HMtmXL4jTLYsq99GTzIWRI7q/Jhjv8OOyDVCwgd896E/vHqky0T9RumI4LoaaPgcBe44
         Rj7nCR1Cg8AY+MvxU6DOfdJaOK6sq/wgdQfFuVecMCtA6wlGldfhd1k2b5WX6hAjueIS
         wLJ/vecaf0cbC7sfYP6cMtJCzZWijd0wLmYEqXJ2TBXHROG5tf5ehlrfBUbnRocfaL2u
         +U9w==
X-Gm-Message-State: AOAM533bMpRn1vdM/t/Em2207fNDMixLVQMrR1XoP4wRcPTLelUsdAkJ
        CEf0wYA7askqBYx+ibfuhhMr3A==
X-Google-Smtp-Source: ABdhPJxhnZTPHdrXN9wZhVZR52wCiThQFMI8PqiE8nOcS7plw649C8vClqkbt4hw+8ne598gMMRZTQ==
X-Received: by 2002:adf:8b98:: with SMTP id o24mr14755731wra.302.1634307072822;
        Fri, 15 Oct 2021 07:11:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6e3:13bd:45ae:5eeb])
        by smtp.gmail.com with ESMTPSA id f15sm4971434wrt.38.2021.10.15.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:11:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/6] drm/meson: remove useless recursive components matching
Date:   Fri, 15 Oct 2021 16:11:03 +0200
Message-Id: <20211015141107.2430800-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015141107.2430800-1-narmstrong@baylibre.com>
References: <20211015141107.2430800-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; h=from:subject; bh=oCHRvKY4DUunQPKqQle3sJaGRdDcBfi+zreDie2LrWE=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhaYolnyX6k3x3JLsmrS3+lhvHZsU9i/66xJC8E04m 6OJQ1ZKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYWmKJQAKCRB33NvayMhJ0T3WEA Cny9MGCazvlcxUanmEjoBua87F74vWSOrHONMv003E0U6XxuaNx9V7dZeynKchhcZ7yF17LbcMc3Rh PxbFIci0Y2DEcMBlUB7EmZsZQecfp6OjuWu6k7gQM02P0kIveRwzWpwV+1cu0PJ6xpzV2SyPrxbUcW zz6lg09Qs50eDFiLMJrszgbmoGrNdtqs01JAXWGUQ24AZq0myrVUijzujX8x1Z7V1QP6Sse55R1tCk JjYCwqFk5WXup4cZp0S9c+Pq9m9Vco89mJD/3jD6gBj5dabZCANbF7tOS95OBtjNsVekw0QyF1kdtw En36Q3zJl8oa/E9Lhr8zTgATokh46RzFdujXg5EkACeNBZtIQPU9abTE7pshTY9Eo30QaGqSoYosmq QwhzHdWeihBEj8mk8wsIDvQTalAhJuErMlcihmdTZeo1oN/rbxrKdsQuMzThmJlm6zL6kOhyTzBywc K09X48fuNj4fPE1T0a/MJrf0lDIgQhPus2a7Yw+3RV9QQBr0LsPCENgtTVoFS+/k40BMg4PXt/G+HY NdfeUS/g4D5+x3Q/v9LNwTQ3D6dsg6ukxli3xVZ4h1qqCibPYFEwNOXbUOW/Q/3UYoeBjdiMnk9ZHd +hbUtskikyy9E2r8jIAMikZMzcA2I3EuJnVNqMdnZxRXYZeVL14JjV8tDJEw==
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 62 +++++++++++--------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 7f41a33592c8..97ebc07357bb 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -426,46 +426,6 @@ static int compare_of(struct device *dev, void *data)
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
@@ -477,6 +437,13 @@ static void meson_drv_shutdown(struct platform_device *pdev)
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
@@ -491,8 +458,21 @@ static int meson_drv_probe(struct platform_device *pdev)
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
+		dev_dbg(&pdev->dev, "parent %pOF remote match add %pOF parent %s\n",
+			np, remote, dev_name(&pdev->dev));
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

