Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C03AD440
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhFRVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhFRVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:14:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E8C06175F;
        Fri, 18 Jun 2021 14:12:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m21so18748130lfg.13;
        Fri, 18 Jun 2021 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yt0BSTexIurBcE0nAITbWkaUHmp5dbQZvjYenG8vIbg=;
        b=K/42SDMAj0znlwahYBhl0x2JOmjsrGhuUp6jjMLaq5mpXsM9YGbShwP8vdZXb6vG/J
         JMn9TR7G4RFvjS8Lb985dbeyVxQf2vh+iQwl5aPCLBgOto3VrkFeinhHRIX5sfOrfd3J
         VOru5wZBFL2BADXRKJ0MknuaNk3ub1aVJeKbhKuvNDi4NqdXE62r6Cz94K0+60omxqUX
         1OKruu7oBi3xqHa8wFc4XPLBrfNR22y8BbS720TKJZpXcThLg7J65k98oOJZIhKGjbcj
         zqciJjfgKx0MhiHk6MxRvoZpVKgRz+5h9PYQIhQ90fxlRSQRMvG8pkVXGr4uh5F9tl/C
         VhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yt0BSTexIurBcE0nAITbWkaUHmp5dbQZvjYenG8vIbg=;
        b=TlhfZ6gyrFCSXBKMNxR37AxlLlcbRcmQp1urFLWgJrwuheVEiNCR7+IWQCHNsOYZTO
         R4PkK0nAHIAKKXg2zNliCsh+llmzTl7efcnIQkkYkotixjZjX2bb9CArG9bRc3y6/A6d
         iRhxfoW8Wj01vc+w6VvbCjac3rdBCxXvFJTbziS/GU8p6kSnwGPti9YH4xga3PUnxO21
         QTi/behN91485wwlYyHwh4uFi5wJstEDlDxY/gToODjtKfa7yO2MH3tqzb9faR9bJsrm
         3uVREvcO6ae8XvBVr0Z9YX2fDJELSvvGC1hC5H/BcUDXfxoGEkQSK7nVdP4hfVTgCxbP
         V7bQ==
X-Gm-Message-State: AOAM5329EwKpMesxgi2BXq+zGVMaLNP3vxQeqy4P6Zh6v0pvA7G6sYOX
        4ZZQ7+fhy0/NhHvn5Pvltqs=
X-Google-Smtp-Source: ABdhPJx4Cc33OigV7LRQR1q4T8/nSsRiVQlmW4dS4kxI7mgXhoq3UN8ktyJ0/63r6tpKYt/sIfWUoA==
X-Received: by 2002:ac2:551b:: with SMTP id j27mr4745358lfk.459.1624050755986;
        Fri, 18 Jun 2021 14:12:35 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id a8sm1183802ljq.127.2021.06.18.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:12:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 4/4] hwmon: (lm90) Disable interrupt on suspend
Date:   Sat, 19 Jun 2021 00:12:02 +0300
Message-Id: <20210618211202.2938-5-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618211202.2938-1-digetx@gmail.com>
References: <20210618211202.2938-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C accesses are prohibited and will error out after suspending of the
I2C controller, hence we need to ensure that interrupt won't fire on
suspend when it's too late. Disable interrupt across suspend/resume.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/lm90.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 658b486d2f5e..b53f17511b05 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1973,11 +1973,36 @@ static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 	}
 }
 
+static int __maybe_unused lm90_suspend(struct device *dev)
+{
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+
+	if (client->irq)
+		disable_irq(client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused lm90_resume(struct device *dev)
+{
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+
+	if (client->irq)
+		enable_irq(client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(lm90_pm_ops, lm90_suspend, lm90_resume);
+
 static struct i2c_driver lm90_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm90",
 		.of_match_table = of_match_ptr(lm90_of_match),
+		.pm	= &lm90_pm_ops,
 	},
 	.probe_new	= lm90_probe,
 	.alert		= lm90_alert,
-- 
2.30.2

