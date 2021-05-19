Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CAF3893D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhESQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355237AbhESQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:35:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9E8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:34:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so3688073wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yeOypvCFreJqvKE/EJgAL3o31zFp5JBvfkpUC+AuPD0=;
        b=pSDM3ZcjVTiLLgkt2M1SDUo7MOPz6/HZbhbJd7ycv9gI04Cs+GuGg12ukOQAtQkp6v
         WadRpUrrVJZPEkDgG5SdzrW9QuYDPmiJ2C78HArhYs+iS5ZfJB4hIcqluEqKxpv1vGkU
         FwxNnZevu5dhZM26xFTsgfKCGLbH4MEdpAcQaoc+0v6CYh+j4ab+y1ZLnTBmH7Dn0etC
         VSr4Nbq/OK0bkB2cPjEltbj9MiIGpFVU9x242rfIJ4n6CrB7YR/SN2iovL0puVGisLmO
         j3aq2srf+Xk18+1SbUv60nYEYB3+A+/dh8hiYqMJv25GpDME7DDmRqlFZ4WQ9YGk67rH
         zNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yeOypvCFreJqvKE/EJgAL3o31zFp5JBvfkpUC+AuPD0=;
        b=iRspkFKQ0P8T11c7MNUwhpFLBux2sGvum4dYp1WB5qkv7rpxB1+hJdwqKmtlcc2faY
         pRwlZBC7yR2OU5UhipjB0eCSb6vYjcSRF80ZCVUJdVIkzS2NhboVBoAw4bBrHsnO8f2J
         ZwC624MvZLDaUkF+MtrdF9JJE1kfEGaDiPWXQtL1ON113L7q2TkHEakGamCxPSRwo+iU
         HqQiEhLK1fF26WbT4lPVmq/dU3garkShDf3bnD0+sUgN0xH0owtWFS+yP+IBJfulpx5V
         pegF+WjdOGTpKWUbRWI5MAnpKQvIbnW8fVVnPOglthm0z2ENmXm5Ze3LjSdKXIiajA/5
         X/Sg==
X-Gm-Message-State: AOAM530xcf2kuaoUHkg2QI1Ci+sr8NsURQ+XTtwMlk/xBuXCBvj+ojjS
        fnKcBerTzhJ4RbO5ePXNxajL8MxJ0R3w6w==
X-Google-Smtp-Source: ABdhPJzw/wbXxIcmqWP7AO8acrSl/TfMab6jYdQzToMMNJj1+zWiHwYIzk9s2AvbubGm+bH2B2P5hg==
X-Received: by 2002:a1c:1bd6:: with SMTP id b205mr184161wmb.170.1621442071947;
        Wed, 19 May 2021 09:34:31 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:e5dc:6577:6b94:e9e7? (p200300ea8f384600e5dc65776b94e9e7.dip0.t-ipconnect.de. [2003:ea:8f38:4600:e5dc:6577:6b94:e9e7])
        by smtp.googlemail.com with ESMTPSA id f13sm23902896wrt.86.2021.05.19.09.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:34:31 -0700 (PDT)
Subject: [PATCH 2/2] eeprom: ee1004: Let device core handle attribute eeprom
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
Message-ID: <8a6c77f2-f84a-311b-c2b9-21798f690e4d@gmail.com>
Date:   Wed, 19 May 2021 18:34:27 +0200
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
 drivers/misc/eeprom/ee1004.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 252e15ba6..0950d4d9d 100644
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
@@ -160,15 +160,15 @@ static ssize_t ee1004_read(struct file *filp, struct kobject *kobj,
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
 };
 
+BIN_ATTRIBUTE_GROUPS(ee1004);
+
 static int ee1004_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -222,11 +222,6 @@ static int ee1004_probe(struct i2c_client *client,
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
@@ -237,8 +232,6 @@ static int ee1004_probe(struct i2c_client *client,
 
 	return 0;
 
- err_clients_lock:
-	mutex_lock(&ee1004_bus_lock);
  err_clients:
 	if (--ee1004_dev_count == 0) {
 		for (cnr--; cnr >= 0; cnr--) {
@@ -255,8 +248,6 @@ static int ee1004_remove(struct i2c_client *client)
 {
 	int i;
 
-	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
-
 	/* Remove page select clients if this is the last device */
 	mutex_lock(&ee1004_bus_lock);
 	if (--ee1004_dev_count == 0) {
@@ -275,6 +266,7 @@ static int ee1004_remove(struct i2c_client *client)
 static struct i2c_driver ee1004_driver = {
 	.driver = {
 		.name = "ee1004",
+		.dev_groups = ee1004_groups,
 	},
 	.probe = ee1004_probe,
 	.remove = ee1004_remove,
-- 
2.31.1


