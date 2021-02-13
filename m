Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA131AB34
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBMMKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:10:13 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45779 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhBMMKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:10:10 -0500
Received: by mail-lf1-f45.google.com with SMTP id j19so3242738lfr.12;
        Sat, 13 Feb 2021 04:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2M4fwXTZ4NN1Bg53CXaHkkwr7HGRZgG2bHGtuIrCq0=;
        b=hHHdM1jxFkIGBBSnM1w2tik6ueyJU5uLJpt2LZG61BNj3vVwKf4o+lK5989audQfKJ
         SIa6b0sB9/owf+b8rn62oGajsgckvU9tJIBq0YB8WGgTl2uZoWqhX5RqOEGxIbsbzrq+
         7BCSHz27O6O4j3i91+v8Mnjiy6rRFDF3kRxhiCRR4S6UnVBpqZWjqWa8Vdy4sPZImPxY
         gYAls7bPhfcn+revvn/0ebQl48oCPdkOX7XAdnXZICPsfVU1DDOdMOHjpAumXf6axVim
         76y4ausBnEmpq53sZng97vkuxn3vegDyiCVIXqUMIA/nwXLaZicLRasA7qCi0iNtU0UT
         t2Jg==
X-Gm-Message-State: AOAM533UehVMlBUGIuOfUoV7AN3cWHCMVDNnExI7TL3ClwLNd7xXQYXz
        2EC/RbTggHPWqVl+CACN9vcbCATavNs7NA==
X-Google-Smtp-Source: ABdhPJxH4aNBcGs6uz6cVC6DgK16LqoBHD+aGQkoN9amHEZjpc6DigqKnYOj/7CtGHf3sFYLmelkaw==
X-Received: by 2002:ac2:4257:: with SMTP id m23mr3752595lfl.99.1613218167576;
        Sat, 13 Feb 2021 04:09:27 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id r186sm1846172lff.169.2021.02.13.04.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 04:09:27 -0800 (PST)
Date:   Sat, 13 Feb 2021 14:09:20 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [RFC PATCH 4/7] platform/x86: gpd pocket fan: Clean-up by using
 managed work init
Message-ID: <8f29fefce4b7413742e18514bf10fee5bece81ef.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
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
 drivers/platform/x86/gpd-pocket-fan.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 5b516e4c2bfb..271ab902f046 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -124,7 +124,7 @@ static void gpd_pocket_fan_force_update(struct gpd_pocket_fan_data *fan)
 static int gpd_pocket_fan_probe(struct platform_device *pdev)
 {
 	struct gpd_pocket_fan_data *fan;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(temp_limits); i++) {
 		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
@@ -152,7 +152,10 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fan->dev = &pdev->dev;
-	INIT_DELAYED_WORK(&fan->work, gpd_pocket_fan_worker);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &fan->work,
+					   gpd_pocket_fan_worker);
+	if (ret)
+		return ret;
 
 	/* Note this returns a "weak" reference which we don't need to free */
 	fan->dts0 = thermal_zone_get_zone_by_name("soc_dts0");
@@ -177,14 +180,6 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpd_pocket_fan_remove(struct platform_device *pdev)
-{
-	struct gpd_pocket_fan_data *fan = platform_get_drvdata(pdev);
-
-	cancel_delayed_work_sync(&fan->work);
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int gpd_pocket_fan_suspend(struct device *dev)
 {
@@ -215,7 +210,6 @@ MODULE_DEVICE_TABLE(acpi, gpd_pocket_fan_acpi_match);
 
 static struct platform_driver gpd_pocket_fan_driver = {
 	.probe	= gpd_pocket_fan_probe,
-	.remove	= gpd_pocket_fan_remove,
 	.driver	= {
 		.name			= "gpd_pocket_fan",
 		.acpi_match_table	= gpd_pocket_fan_acpi_match,
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
