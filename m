Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAD343ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:38:10 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:43921 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCVHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:37:42 -0400
Received: by mail-lj1-f176.google.com with SMTP id y1so19774138ljm.10;
        Mon, 22 Mar 2021 00:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5kFGyZzdj7+9ana+CylbHpDJ5vAWDz6vl9rTM9ymI4=;
        b=p3dlyyGW6a9nw6HjiJv/2tpiNof8sOI1V9/cHU7fy/FuY5YMYQcjzJd1VwpKQ8knIl
         ATqsAwaTSU0x1cQsJNrQtEPsjlpQmETuS25Udsgy16JQypO1WcHHpKkxBxWk5zxiWoEA
         UFgWC2qDR7WrlILiYDbKt3rN0RxXanADQ3H9FM9AYqUTaD6TwMfj17D7Ff1DDN1KEGDq
         cwnMDu5jpTsxt6Nyt+rMrqbnH7gIMXh48Pv2lJaaKMf/EGb+9gud8YAu2U0pY+vnxMMf
         ydTzKabLBhbAnLgHe+6TGyX3xLs0khAHiAoRyKBL1PNJyQIdgQXM4SorwNUyzamavyNH
         ue2w==
X-Gm-Message-State: AOAM5305jBVUtB8Ct6Bdpmjzndll5FFxAEDjj6UAzntkxDqCyMmAOh4s
        tp73s1UVvugyhtPM39/ZqzY=
X-Google-Smtp-Source: ABdhPJxa3zbpkwHl9k9yz0kTlExrT2EXVcMa/LJqi6wmKPWKNIrGw6C2eFXyfU+HMci9+SYM3CiBmA==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr8928445ljj.485.1616398661031;
        Mon, 22 Mar 2021 00:37:41 -0700 (PDT)
Received: from localhost.localdomain (mobile-access-5673b7-246.dhcp.inet.fi. [86.115.183.246])
        by smtp.gmail.com with ESMTPSA id t201sm1514179lff.70.2021.03.22.00.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:37:40 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:37:35 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [RFC RESEND PATCH v2 5/8] platform/x86: gpd pocket fan: Clean-up by
 using managed work init
Message-ID: <a9be3f611aec7b758623b57646800d2c514d0744.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/platform/x86/gpd-pocket-fan.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 5b516e4c2bfb..7a20f68ae206 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/devm-helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -124,7 +125,7 @@ static void gpd_pocket_fan_force_update(struct gpd_pocket_fan_data *fan)
 static int gpd_pocket_fan_probe(struct platform_device *pdev)
 {
 	struct gpd_pocket_fan_data *fan;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(temp_limits); i++) {
 		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
@@ -152,7 +153,10 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fan->dev = &pdev->dev;
-	INIT_DELAYED_WORK(&fan->work, gpd_pocket_fan_worker);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &fan->work,
+					   gpd_pocket_fan_worker);
+	if (ret)
+		return ret;
 
 	/* Note this returns a "weak" reference which we don't need to free */
 	fan->dts0 = thermal_zone_get_zone_by_name("soc_dts0");
@@ -177,14 +181,6 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
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
@@ -215,7 +211,6 @@ MODULE_DEVICE_TABLE(acpi, gpd_pocket_fan_acpi_match);
 
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
