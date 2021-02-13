Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3928D31AB30
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBMMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:07:54 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36399 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhBMMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:07:51 -0500
Received: by mail-lj1-f176.google.com with SMTP id k22so1527181ljg.3;
        Sat, 13 Feb 2021 04:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnTBU1+fTq7WCrFIKnTtQ8WkLlihATaeGTPRkGLiE34=;
        b=X4+7ifdtP3CY8HxOOkPjJuUeEccJ2msPjjf5JAmM3txVLgivL2QpWnZrmM44v1hynf
         ZD0Fm86L8tZJR84roMWGuqoAtZkfBanDMVSB2B0msIAN0ybBG9P7Qso06zlsWIt+dOdj
         RTrREOBUSoH6UmG+8OyXK7NFNfyEGvzrDgIlJbF21S7JmOo3i+h/dqDs7iMhSE1lOdIl
         8S1YoILTjxRagmlC79pvrQ6J7JGqKD3bnKuxoY1MrBg/MXa/Dku0lQPJf9aAa5Xdlk4o
         pRFRSeR0yoLZhrWyeeotTYcpHRS7BppB71U2XabmJAt/z9kL4K0EsFloHBan7dNkycTs
         p8Dg==
X-Gm-Message-State: AOAM531vJqBwgnbnz9u5ndBrHo/jJfWCk0eiIBzFwIzgNogWVY5vefh0
        +B3xQBGg1u42AT0p07onRTw=
X-Google-Smtp-Source: ABdhPJymzneR3YwaNqRS8ezgKX9krTo8PVlWLJhEHOaQ2poYAdT31jq/OmB2MJP2z4m1qRk5Js1wEw==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr4373471ljk.206.1613218029069;
        Sat, 13 Feb 2021 04:07:09 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id h15sm1272111lfc.279.2021.02.13.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 04:07:08 -0800 (PST)
Date:   Sat, 13 Feb 2021 14:07:02 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 3/7] hwmon: raspberry-pi: Clean-up few drivers by using
 managed work init
Message-ID: <1ee4b1bcc926b60e513e8f5cd586e744de2cb12d.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/hwmon/raspberrypi-hwmon.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index d3a64a35f7a9..acfa674932bc 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -106,6 +106,7 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_hwmon_data *data;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -119,7 +120,10 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 							       &rpi_chip_info,
 							       NULL);
 
-	INIT_DELAYED_WORK(&data->get_values_poll_work, get_values_poll);
+	ret = devm_delayed_work_autocancel(dev, &data->get_values_poll_work,
+					   get_values_poll);
+	if (ret)
+		return ret;
 	platform_set_drvdata(pdev, data);
 
 	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
@@ -128,18 +132,8 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(data->hwmon_dev);
 }
 
-static int rpi_hwmon_remove(struct platform_device *pdev)
-{
-	struct rpi_hwmon_data *data = platform_get_drvdata(pdev);
-
-	cancel_delayed_work_sync(&data->get_values_poll_work);
-
-	return 0;
-}
-
 static struct platform_driver rpi_hwmon_driver = {
 	.probe = rpi_hwmon_probe,
-	.remove = rpi_hwmon_remove,
 	.driver = {
 		.name = "raspberrypi-hwmon",
 	},
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
