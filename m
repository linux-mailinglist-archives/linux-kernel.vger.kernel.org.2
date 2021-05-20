Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3D38B780
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhETT0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhETT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:26:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:25:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j14so17034789wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+vggG1CoHSou3Tv2b3Zjd8F6Ymbag0NJHzvEr61D8uE=;
        b=PB3Yxw9WBiA6SAj0MlZFwI1BMzHYEUC8zBjlLq9P3mp4VPRmZ9bSeHkDiLyqLmXA9x
         QO9Sf9ywnDlaG9C1VyA0/Pc2x4r0VYGHTx+nC3BUIEsY809H5zl61VOix5xFW1+Umgn8
         0aplVJHwktPt7HDME2himS0sigVin7FGRg3gSLYlvBkRMDnQx6nzC0mE6dRYufwmXbN/
         MppBBtqeFeujB53f3FS4CSuKwIicnhHKdNQCG3BNcfotLwn1t9tVdgmrZpwVm3JkZRXV
         Eb38eWJMl1w6mtvH2BYrvHjk4TqgjXiq2StAwMeYowL0ionTvmiEeGW6dLEqP7EjzwYM
         /0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vggG1CoHSou3Tv2b3Zjd8F6Ymbag0NJHzvEr61D8uE=;
        b=ETN5qm7rgziU9uQdnKl5p61BRaleNWbov/+ckhApZQitPFZ7Sv6oofLydeWyn9y4lo
         +3uvG/zBXtxp8Sb8gpKPKr5olNcBQ/9Avc1P38zDwnvrs3bjsLMO8lXL1kMbDYaFb2mY
         4MtS+xxQVOGpLoEZ1feRWGNm1pDZ4YfTZg+S9x8uUwO2HDYn9HVne3q0zIeJWtH5QOd1
         nD/fFlJ7OXbLb7U0/99FJDaCpWdJH/qznkgl4YP//o8xPCHAvr8fsp6hPUoMprQ4kNbW
         0vQ1vBsy0j/AWme4wUJ3qZ/3n5YPLHKiIHMu/8QXao3Mg2Ov3NDF1sIJxiELOZsgV4JT
         kh7w==
X-Gm-Message-State: AOAM532U3t81LcDHHSlkX/JpiCM+gi0g8DPrN0c203xYSAECS/NPY66T
        LCwm0CnQrHoBHCL0ZKvZuM+k7nSqNyYsyA==
X-Google-Smtp-Source: ABdhPJxYTjNwlfkDduYxLviPKzFc73spnkprAipSJsC/LCWr7n2XQJToCE+Xm4DAGf/RAg9kZWXyHQ==
X-Received: by 2002:adf:fc44:: with SMTP id e4mr5817805wrs.23.1621538710390;
        Thu, 20 May 2021 12:25:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:658e:1e64:dd7a:c8e? (p200300ea8f384600658e1e64dd7a0c8e.dip0.t-ipconnect.de. [2003:ea:8f38:4600:658e:1e64:dd7a:c8e])
        by smtp.googlemail.com with ESMTPSA id m9sm4142651wrq.78.2021.05.20.12.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 12:25:09 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] eeprom: ee1004: Let device core handle attribute eeprom
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
Message-ID: <082be5db-46ef-6ddd-c33f-b30d5037a3f5@gmail.com>
Date:   Thu, 20 May 2021 21:25:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating/removing the attribute ourselves, just declare the
attribute and let the device core handle it. This allows to simplify
the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- open-code the proposed BIN_ATTRIBUTES_GROUPS macro
I leave it to you which version you prefer.
---
 drivers/misc/eeprom/ee1004.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 252e15ba6..d61acdaba 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -89,7 +89,7 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 	return status;
 }
 
-static ssize_t ee1004_read(struct file *filp, struct kobject *kobj,
+static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 			   struct bin_attribute *bin_attr,
 			   char *buf, loff_t off, size_t count)
 {
@@ -160,15 +160,19 @@ static ssize_t ee1004_read(struct file *filp, struct kobject *kobj,
 	return requested;
 }
 
-static const struct bin_attribute eeprom_attr = {
-	.attr = {
-		.name = "eeprom",
-		.mode = 0444,
-	},
-	.size = EE1004_EEPROM_SIZE,
-	.read = ee1004_read,
+static BIN_ATTR_RO(eeprom, EE1004_EEPROM_SIZE);
+
+static struct bin_attribute *ee1004_attrs[] = {
+	&bin_attr_eeprom,
+	NULL
+};
+
+static const struct attribute_group ee1004_group = {
+	.bin_attrs = ee1004_attrs,
 };
 
+__ATTRIBUTE_GROUPS(ee1004);
+
 static int ee1004_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -222,11 +226,6 @@ static int ee1004_probe(struct i2c_client *client,
 		ee1004_current_page);
 	mutex_unlock(&ee1004_bus_lock);
 
-	/* Create the sysfs eeprom file */
-	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
-	if (err)
-		goto err_clients_lock;
-
 	dev_info(&client->dev,
 		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
 		 EE1004_EEPROM_SIZE);
@@ -237,8 +236,6 @@ static int ee1004_probe(struct i2c_client *client,
 
 	return 0;
 
- err_clients_lock:
-	mutex_lock(&ee1004_bus_lock);
  err_clients:
 	if (--ee1004_dev_count == 0) {
 		for (cnr--; cnr >= 0; cnr--) {
@@ -255,8 +252,6 @@ static int ee1004_remove(struct i2c_client *client)
 {
 	int i;
 
-	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
-
 	/* Remove page select clients if this is the last device */
 	mutex_lock(&ee1004_bus_lock);
 	if (--ee1004_dev_count == 0) {
@@ -275,6 +270,7 @@ static int ee1004_remove(struct i2c_client *client)
 static struct i2c_driver ee1004_driver = {
 	.driver = {
 		.name = "ee1004",
+		.dev_groups = ee1004_groups,
 	},
 	.probe = ee1004_probe,
 	.remove = ee1004_remove,
-- 
2.31.1

