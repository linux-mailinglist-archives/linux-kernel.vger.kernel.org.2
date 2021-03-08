Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C43309A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhCHIml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:42:41 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41509 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhCHImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:42:10 -0500
Received: by mail-lj1-f171.google.com with SMTP id t9so15009915ljt.8;
        Mon, 08 Mar 2021 00:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Rc72VFcdGikA4iw93UKiEviUsRbqS+/SG2EjEpppYs=;
        b=L1mj9ibAnNJrt3gIz3iVq2i26OXWaaGkfj18PKZa5BqgqH7FIrbJaIRWX5tHDs22TW
         UK3g+oBwtxZWkE8g02vjn/5JfeEJ3yXSsB/x3j/ojgOjvKlJOaQtCEIMMY3uItiobR33
         6GJPYvictpub5DF/xYB8Bd+YC8xATkl1MxDyostngfTjlLRzq5WkASM793CYNkO1EqDo
         E/6CBQWZuDAwmNWPj92G/QNbM5BN5RNh1vgApYRxsvsVPuAxCrP/p8j/881BT/yvOTtG
         02lhncsSjiZDTsVpoWVGm8SMLjP32lpvGMMEbLvLrD8YEL6OLaNxL8J0CJ7CN3ip7r9/
         7xaQ==
X-Gm-Message-State: AOAM5309tFI5S44nNMnHkZ1/P5bi1TTmQfo2NpExkpkKJlpWxeRrhNoM
        6nnhSE3LnoOsinMwMIPvbW0=
X-Google-Smtp-Source: ABdhPJyvF17KR51z68fjsKEsD2lL1wLrpn3/JlN0L9xPG1TQUN/bej7MfF/02sPWBGYk5BFjbLfUFw==
X-Received: by 2002:a2e:5c84:: with SMTP id q126mr12947603ljb.61.1615192929108;
        Mon, 08 Mar 2021 00:42:09 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id r12sm1279128lfc.79.2021.03.08.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:42:08 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:42:02 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [RFC PATCH v2 4/8] hwmon: raspberry-pi: Clean-up few drivers by
 using managed work init
Message-ID: <8fea146d6037cea1cd089f20af42a92e800ff894.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
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
