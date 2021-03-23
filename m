Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98A33460A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhCWN6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:58:22 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40859 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhCWN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:57:33 -0400
Received: by mail-lj1-f176.google.com with SMTP id u10so25751868lju.7;
        Tue, 23 Mar 2021 06:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Y5ibif4oRVGIPHt/yiD0yXJ5yK2ywIn339mR6lOBUQ=;
        b=dRfQfqz4UTs3CqQbHxNzenkeyFgwSov3jiVoS9OsHHi8bmsLBNI8AGLV5t3fu7MjTv
         eiU/h2KpappO86YAfU797giSDYqbZaOibz4fl3BPxE/tuEWsIUIKiipbJ/WTlVJEz0jn
         3N4iJ5WJnw9vWI6jIcZr+OwRaRuIJrkcaOtFoN6PxoHaa0SqukhurUa63EYoYQIlT3rj
         llUQ9WTjfaculZMn2u94GvklkEifx5VW7TVpVAagl2zYsc9MGEsw22XzE9HZN3H4kpx+
         mpJHWk5HKpZ+lZ4MfV3cpB2rWb8VQ3cZVuRqQj85c1pqVZ/iNeRzt9m9egMc0enxCIoQ
         KawQ==
X-Gm-Message-State: AOAM5304hiUa1HG1pnzjLoUnx/hoGEJXpPQoCFmWYPeQHUD0oI/3quKX
        xUQk4Osvq28ebXfC0alwB1M=
X-Google-Smtp-Source: ABdhPJyMckocpBHAc0VpK9AtaTME8BqHmHgky3Gv5Ju0wZVgcOq1Fx7bMFiHBuQnQUdTBHUSa0+K3w==
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3023555ljk.233.1616507851525;
        Tue, 23 Mar 2021 06:57:31 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id y25sm2343628ljc.73.2021.03.23.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:57:30 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:57:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v3 4/8] hwmon: raspberry-pi: Clean-up few drivers by using
 managed work init
Message-ID: <4830f52d46278ea1c92ad7252f6050540346d8b7.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changelog from RFCv2:
 - RFC dropped. No functional changes.

 drivers/hwmon/raspberrypi-hwmon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index d3a64a35f7a9..805d396aa81b 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2018 Stefan Wahren <stefan.wahren@i2se.com>
  */
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
@@ -106,6 +107,7 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_hwmon_data *data;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -119,7 +121,10 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 							       &rpi_chip_info,
 							       NULL);
 
-	INIT_DELAYED_WORK(&data->get_values_poll_work, get_values_poll);
+	ret = devm_delayed_work_autocancel(dev, &data->get_values_poll_work,
+					   get_values_poll);
+	if (ret)
+		return ret;
 	platform_set_drvdata(pdev, data);
 
 	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
@@ -128,18 +133,8 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
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
