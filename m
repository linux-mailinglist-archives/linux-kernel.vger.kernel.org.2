Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F063309A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhCHImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:42:45 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36102 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhCHIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:42:30 -0500
Received: by mail-lf1-f41.google.com with SMTP id f1so19743291lfu.3;
        Mon, 08 Mar 2021 00:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5kFGyZzdj7+9ana+CylbHpDJ5vAWDz6vl9rTM9ymI4=;
        b=Fdf5pmemwEYZFjH8pfruc5m4T9s4i/Qmt75yQIz3klrRtQEsMDTQjhxiF8h1wV8RwW
         3EOojSQl0rZn7upPYJejLPil87ot0N0+KG0nv6UP937UAJBxsGgjxCIKfyJ+ZJYEPv3t
         F+2XOfNh1X0V+ozaZyLa0xnhNfzCOb1DeNMUWlkZprFqLvq663ZHH/oazbAoHgKI4At/
         aY39LRownQTImcvgMnkgtsPj5AhVpBnNEkCVgGHBOAzr6hgeyHow1uDkcvz6u1jSoLdC
         trHoJTGx3vGLTmVYYwydPbxjHkB1I40OPDag6ch90AOyM6+g5rM7QsG1ZNVpghrdpVCx
         LhCQ==
X-Gm-Message-State: AOAM533mhe6OChciso/zX8oyMOI50dKrx8+wn06AdoK/fVW09Y7GROGl
        dnOLoXJJXQtVVVmRDykJ9zWSnmp773Q=
X-Google-Smtp-Source: ABdhPJwOyrJUv4ZaAz9pTaag+sO8qvX2pRjUb1hD8810+gOPW8HaPdm2YpiZfdyFtFMdympDnxOk8w==
X-Received: by 2002:a19:ab0a:: with SMTP id u10mr14590171lfe.540.1615192949523;
        Mon, 08 Mar 2021 00:42:29 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id q16sm1274808lfu.153.2021.03.08.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:42:29 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:42:23 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [RFC PATCH v2 5/8] platform/x86: gpd pocket fan: Clean-up by using
 managed work init
Message-ID: <8145029a07864bfbd6a41acae66a36dbd51f0b30.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
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
