Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA193FF79F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348535AbhIBXFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbhIBXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:05:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D75C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:04:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g192-20020a25dbc9000000b0059bd2958c8aso4592539ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fE4xWbnNUsaH2L2+9e5Jc7xWeW6lJkVzW9cJr5tZCTo=;
        b=H+Pvky7XU9ApAtzwgpgQVBA1tHgUZtMeP5w3daltJpilyFci7Rzq5wpVDReU38JFzr
         4YfB0wERKVKz4KGFlZPTfMGyn+JCX1VswHHkFPf8bN16ODi9e3hY0BevWI5Tz2QcTMug
         +diSdJBgTG73ywUdQT4hqxzOnYeqhWWaJCdFxLzBXqYuMfowNu4XNAREsttUCS5K58Cd
         LWpqkJfAwbIIOYOA0dUwhrTTyxy8qdK41/dzkGdKYrSSancrEiR4xCtKW2uNlnnn6C5C
         CyjniDyeQaxbraSES6WCwQyI9mbjsUeNSaYLyopI1U383UCtHrmM1a18KMJ1dex7LDwT
         0NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fE4xWbnNUsaH2L2+9e5Jc7xWeW6lJkVzW9cJr5tZCTo=;
        b=OWN6cIWu1rLevScoJ47E0Ru36OIHHT+XqDXKYXkUPWNdR50xNdRMIXvcZG0e8rntdf
         3DIsm5Gh3jxL3d7Y3WHzbj484cXUunPdFw6xlyI9WhxbSwIPOCbyLDdbdkJ8QSxbISlE
         gdCtlOvgdZFlxgY1KPTVpLYkWj6atdYKRLpYslPxi8RgNSrP2cPp4vRegE6XUuy6qeAJ
         04Bdj76ljWe4CQ4fAvga3wqB7lErTbup9DZIsTbUs4ra1Jh7LaTE7FCLTzUwtgXX+CgM
         VlDdA3P1Vc3H5888OGkB1ggPbCD4k4/nfNIGW/kCoUtFRkM1F5hQiMALevkkFjd7bwvf
         co8Q==
X-Gm-Message-State: AOAM531pZP1lHz4QCpHlYnpQ/LpSe+DWJ9YaH0A+8WlKsFsvavjTMT2+
        8N8YXytxIBbZoLj0vvbbxgnboHUwaU8D/YQ=
X-Google-Smtp-Source: ABdhPJxWgcYcIBBK376uC3gnVCUb/S4Lj9Rk7QhgF79UpRu0Ye+Nb1O88qm7IOAAT/bpyFwsdRjCxBFBgy1vRQc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7cb7:1ee7:33cb:da76])
 (user=saravanak job=sendgmr) by 2002:a25:1bc6:: with SMTP id
 b189mr1031877ybb.338.1630623890909; Thu, 02 Sep 2021 16:04:50 -0700 (PDT)
Date:   Thu,  2 Sep 2021 16:04:41 -0700
In-Reply-To: <20210902230442.1515531-1-saravanak@google.com>
Message-Id: <20210902230442.1515531-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v2 2/2] drivers: bus: simple-pm-bus: Add support for probing
 simple bus only devices
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF platform code sets up simple bus only devices (i.e. devices that
won't match with any other driver) to get probed by the simple-pm-bus to
keep fw_devlink from blocking probe() or sync_state() [1] callbacks of
other devices. There's no need to populate the child devices since the
OF platform code would do that anyway, so return early for these simple
bus only devices.

[1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Saravana Kannan <saravanak@google.com>
---
 drivers/bus/simple-pm-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 01a3d0cd08ed..91d52021b7f9 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -19,6 +19,13 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 
+	/*
+	 * These are transparent bus devices (not simple-pm-bus matches) that
+	 * get populated automatically.  So, don't need to do anything more.
+	 */
+	if (pdev->driver_override)
+		return 0;
+
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_enable(&pdev->dev);
-- 
2.33.0.153.gba50c8fa24-goog

