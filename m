Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA30422B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhJEOhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:37:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E7C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:35:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y26so87704394lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ziF/R1LISi9m0sMghR9TEp0K4nRAOLPcUVkKeZiW1E=;
        b=wfLeaxd3hmQqpgznnrtbMLgnbIebWgUsbQ1kRxDbUE0gXUdPmL74xD+q85fTc8v/q0
         wo/F8kdo8OIcbydmubHikA6xkNyv6Vcb5Iat7kAbx9EdQZNoSrc90GSkGkC6Q2bywrlR
         2OwsHjYiNuD+wfZT+PmxCZTB2pbpD647w8aDzfra2qmmdo0lVEIVL0UJUG8SOIYfdJIm
         fVWPK3CIYzDy/mMqJYp8phMao3ZyYb8W4LjvwjU5SMaWMeu5Vvkj/kfEKwtwcnpOCvS3
         j/vsGeYeiynXl9XDXIkuYbkiNLBeFNnDK3GXdoMpTE3Kx7lIK2+RgdLX5o7zHkuP9wig
         8LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ziF/R1LISi9m0sMghR9TEp0K4nRAOLPcUVkKeZiW1E=;
        b=0TZf8kg7ZsI6BlaQC4J8mGHuMCDduuw2sT5ItZEjvwfm4xKvolrWZExM3xX2hxD/+L
         J03fKsGH+oZ+jXPsriB0ca0v6S5UjNQmmVOHSrorQQ/aCjPvwXM/x/fXkk7G6aUCv2HC
         W9EA0Vs78bkAVi6h82JNsIiCcxe3MoUa9zq11tOcac6iuaqxrgdo9vBGKHNn/xoCeseD
         fjadK0So02nhXm5nIO2+iWke5AZTv6+QrPp2tN7rQS4oECs08XfSBA+OzglnofrTNB6v
         Jfuok+ji6cYLAbx04UssbmJgOsRpuuheoDpsv+6vHz4DY6Cy0wrCTx5EgVKHjswLCISV
         tXrw==
X-Gm-Message-State: AOAM532edID5KeHThl0UjHeU8U2k8zku7nXtEH3CIVEQFxtGidHZAh0B
        RjgrQsr93Xrpa+POIza3pWguug==
X-Google-Smtp-Source: ABdhPJx7kuRooYbFcBOabMZUbCnACo88UphCNfI9sBuLpIbR9wIQWeTaByEmax2QO++B8GtouFAKXA==
X-Received: by 2002:a19:6a16:: with SMTP id u22mr3996901lfu.444.1633444540799;
        Tue, 05 Oct 2021 07:35:40 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id q5sm1969931lfo.225.2021.10.05.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:35:40 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 2/2] staging: most: dim2: use device release method
Date:   Tue,  5 Oct 2021 17:34:50 +0300
Message-Id: <20211005143448.8660-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YVwofSvwGTv3kHjh@kroah.com>
References: <YVwofSvwGTv3kHjh@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 723de0f9171e ("staging: most: remove device from interface
structure") moved registration of driver-provided struct device to
the most subsystem. This updated dim2 driver as well.

However, struct device passed to register_device() becomes refcounted,
and must not be explicitly deallocated, but must provide release method
instead. Which is incompatible with managing it via devres.

This patch makes the device structure allocated without devres, adds
device release method, and moves device destruction there.

Fixes: 723de0f9171e ("staging: most: remove device from interface structure")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/staging/most/dim2/dim2.c | 55 +++++++++++++++++---------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index bb6dd508e531..4c0c3bc91ac0 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -734,6 +734,23 @@ static int get_dim2_clk_speed(const char *clock_speed, u8 *val)
 	return -EINVAL;
 }
 
+static void dim2_release(struct device *d)
+{
+	struct dim2_hdm *dev = container_of(d, struct dim2_hdm, dev);
+	unsigned long flags;
+
+	kthread_stop(dev->netinfo_task);
+
+	spin_lock_irqsave(&dim_lock, flags);
+	dim_shutdown();
+	spin_unlock_irqrestore(&dim_lock, flags);
+
+	if (dev->disable_platform)
+		dev->disable_platform(to_platform_device(d->parent));
+
+	kfree(dev);
+}
+
 /*
  * dim2_probe - dim2 probe handler
  * @pdev: platform device structure
@@ -755,7 +772,7 @@ static int dim2_probe(struct platform_device *pdev)
 
 	enum { MLB_INT_IDX, AHB0_INT_IDX };
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
@@ -767,19 +784,21 @@ static int dim2_probe(struct platform_device *pdev)
 				      "microchip,clock-speed", &clock_speed);
 	if (ret) {
 		dev_err(&pdev->dev, "missing dt property clock-speed\n");
-		return ret;
+		goto err_free_dev;
 	}
 
 	ret = get_dim2_clk_speed(clock_speed, &dev->clk_speed);
 	if (ret) {
 		dev_err(&pdev->dev, "bad dt property clock-speed\n");
-		return ret;
+		goto err_free_dev;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dev->io_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dev->io_base))
-		return PTR_ERR(dev->io_base);
+	if (IS_ERR(dev->io_base)) {
+		ret = PTR_ERR(dev->io_base);
+		goto err_free_dev;
+	}
 
 	of_id = of_match_node(dim2_of_match, pdev->dev.of_node);
 	pdata = of_id->data;
@@ -787,7 +806,7 @@ static int dim2_probe(struct platform_device *pdev)
 		if (pdata->enable) {
 			ret = pdata->enable(pdev);
 			if (ret)
-				return ret;
+				goto err_free_dev;
 		}
 		dev->disable_platform = pdata->disable;
 		if (pdata->fcnt)
@@ -882,24 +901,19 @@ static int dim2_probe(struct platform_device *pdev)
 	dev->most_iface.request_netinfo = request_netinfo;
 	dev->most_iface.driver_dev = &pdev->dev;
 	dev->most_iface.dev = &dev->dev;
-	dev->dev.init_name = "dim2_state";
+	dev->dev.init_name = dev->name;
 	dev->dev.parent = &pdev->dev;
+	dev->dev.release = dim2_release;
 
-	ret = most_register_interface(&dev->most_iface);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register MOST interface\n");
-		goto err_stop_thread;
-	}
-
-	return 0;
+	return most_register_interface(&dev->most_iface);
 
-err_stop_thread:
-	kthread_stop(dev->netinfo_task);
 err_shutdown_dim:
 	dim_shutdown();
 err_disable_platform:
 	if (dev->disable_platform)
 		dev->disable_platform(pdev);
+err_free_dev:
+	kfree(dev);
 
 	return ret;
 }
@@ -913,17 +927,8 @@ static int dim2_probe(struct platform_device *pdev)
 static int dim2_remove(struct platform_device *pdev)
 {
 	struct dim2_hdm *dev = platform_get_drvdata(pdev);
-	unsigned long flags;
 
 	most_deregister_interface(&dev->most_iface);
-	kthread_stop(dev->netinfo_task);
-
-	spin_lock_irqsave(&dim_lock, flags);
-	dim_shutdown();
-	spin_unlock_irqrestore(&dim_lock, flags);
-
-	if (dev->disable_platform)
-		dev->disable_platform(pdev);
 
 	return 0;
 }
-- 
2.30.2

