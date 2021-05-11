Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C52379FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhEKGTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:19:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41659 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhEKGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:19:29 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lgLio-0001yI-6j
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 06:18:22 +0000
Received: by mail-ed1-f70.google.com with SMTP id r19-20020a05640251d3b02903888eb31cafso10348600edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 23:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbXPgmZrL4Pxh0/t8XE8baUOCONdkg5IyBFSdmqHWjM=;
        b=Rr1NcPiUi8xP5L3xnRBTmxV1cvcJd2t5JoBmCDJnPdpRf+oGuF0kZ1QZ2zDoa098nA
         ivEGHOjZcX3MGhRs+NxhplXiB2498B8PLewyYOFj+jv+/TSChlUJMYztwqpcRDlqGUWH
         3XW5rwR45XOjq8ZFnPsp8XRl3quIH+Sb2HiaScmPZgRSXUCR3aFe/hvr0+g6T2JOjcx/
         Cqytqrnsv01yizuS1zBSCuPe0e1Fa5e8SE29BlnZv3HoJCV2aSYxkhdxJPk4ioMaOdKJ
         5yXzEcg3UdjhTanZlk8+kxKp/xGQuySFNhL+2Fb5VC2gFTOxXUxTcGk8OlN1Cnyl9Ppa
         VcPg==
X-Gm-Message-State: AOAM531axqT166FM+ixJcjnhAnxZkWuGwl7nDiytN4f4Q++CFzmyd6gt
        cL7zTo7hei3OiH4appHjrYYIuJMRI2N5EN2E+QiSbqYxqZ2Lags3HKJjnxaPAW/56ZEmSCuP5Fz
        zoX2BYj7K6aqQsVHnTK0jgwAzOOFYrmzHRtCurFmjNw==
X-Received: by 2002:a17:906:9246:: with SMTP id c6mr30337748ejx.10.1620713901801;
        Mon, 10 May 2021 23:18:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuFUKxnlEC58W09fcC4t8RpefrIfBsHhh1rU2Dzq5wghcRbv5j9OslBqjPeLytqr3YNEzFFg==
X-Received: by 2002:a17:906:9246:: with SMTP id c6mr30337730ejx.10.1620713901627;
        Mon, 10 May 2021 23:18:21 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id gn36sm10616136ejc.23.2021.05.10.23.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 23:18:21 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     andrew@aj.id.au, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] watchdog: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 11 May 2021 08:18:12 +0200
Message-Id: <20210511061812.480172-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sprintf() in sysfs "show" functions to sysfs_emit() and
sysfs_emit_at() in order to check for buffer overruns in sysfs outputs.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/watchdog/aspeed_wdt.c          |  4 ++--
 drivers/watchdog/watchdog_dev.c        | 19 ++++++++++---------
 drivers/watchdog/watchdog_pretimeout.c |  4 ++--
 drivers/watchdog/ziirave_wdt.c         | 12 +++++++-----
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 7e00960651fa..933998e5a9de 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -175,8 +175,8 @@ static ssize_t access_cs0_show(struct device *dev,
 	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
 	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
 
-	return sprintf(buf, "%u\n",
-		      !(status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY));
+	return sysfs_emit(buf, "%u\n",
+			  !(status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY));
 }
 
 static ssize_t access_cs0_store(struct device *dev,
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 2946f3a63110..fe68a97973a5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -451,7 +451,8 @@ static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT, &wdd->status));
+	return sysfs_emit(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT,
+						  &wdd->status));
 }
 
 static ssize_t nowayout_store(struct device *dev, struct device_attribute *attr,
@@ -485,7 +486,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	status = watchdog_get_status(wdd);
 	mutex_unlock(&wd_data->lock);
 
-	return sprintf(buf, "0x%x\n", status);
+	return sysfs_emit(buf, "0x%x\n", status);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -494,7 +495,7 @@ static ssize_t bootstatus_show(struct device *dev,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", wdd->bootstatus);
+	return sysfs_emit(buf, "%u\n", wdd->bootstatus);
 }
 static DEVICE_ATTR_RO(bootstatus);
 
@@ -510,7 +511,7 @@ static ssize_t timeleft_show(struct device *dev, struct device_attribute *attr,
 	status = watchdog_get_timeleft(wdd, &val);
 	mutex_unlock(&wd_data->lock);
 	if (!status)
-		status = sprintf(buf, "%u\n", val);
+		status = sysfs_emit(buf, "%u\n", val);
 
 	return status;
 }
@@ -521,7 +522,7 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", wdd->timeout);
+	return sysfs_emit(buf, "%u\n", wdd->timeout);
 }
 static DEVICE_ATTR_RO(timeout);
 
@@ -530,7 +531,7 @@ static ssize_t pretimeout_show(struct device *dev,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", wdd->pretimeout);
+	return sysfs_emit(buf, "%u\n", wdd->pretimeout);
 }
 static DEVICE_ATTR_RO(pretimeout);
 
@@ -539,7 +540,7 @@ static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", wdd->info->identity);
+	return sysfs_emit(buf, "%s\n", wdd->info->identity);
 }
 static DEVICE_ATTR_RO(identity);
 
@@ -549,9 +550,9 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
 	if (watchdog_active(wdd))
-		return sprintf(buf, "active\n");
+		return sysfs_emit(buf, "active\n");
 
-	return sprintf(buf, "inactive\n");
+	return sysfs_emit(buf, "inactive\n");
 }
 static DEVICE_ATTR_RO(state);
 
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 01ca84be240f..7f257c3485cd 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -55,7 +55,7 @@ int watchdog_pretimeout_available_governors_get(char *buf)
 	mutex_lock(&governor_lock);
 
 	list_for_each_entry(priv, &governor_list, entry)
-		count += sprintf(buf + count, "%s\n", priv->gov->name);
+		count += sysfs_emit_at(buf, count, "%s\n", priv->gov->name);
 
 	mutex_unlock(&governor_lock);
 
@@ -68,7 +68,7 @@ int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
 
 	spin_lock_irq(&pretimeout_lock);
 	if (wdd->gov)
-		count = sprintf(buf, "%s\n", wdd->gov->name);
+		count = sysfs_emit(buf, "%s\n", wdd->gov->name);
 	spin_unlock_irq(&pretimeout_lock);
 
 	return count;
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 4297280807ca..6c9414d09684 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -445,8 +445,9 @@ static ssize_t ziirave_wdt_sysfs_show_firm(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = sprintf(buf, ZIIRAVE_FW_VERSION_FMT, w_priv->firmware_rev.major,
-		      w_priv->firmware_rev.minor);
+	ret = sysfs_emit(buf, ZIIRAVE_FW_VERSION_FMT,
+			 w_priv->firmware_rev.major,
+			 w_priv->firmware_rev.minor);
 
 	mutex_unlock(&w_priv->sysfs_mutex);
 
@@ -468,8 +469,9 @@ static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = sprintf(buf, ZIIRAVE_BL_VERSION_FMT, w_priv->bootloader_rev.major,
-		      w_priv->bootloader_rev.minor);
+	ret = sysfs_emit(buf, ZIIRAVE_BL_VERSION_FMT,
+			 w_priv->bootloader_rev.major,
+			 w_priv->bootloader_rev.minor);
 
 	mutex_unlock(&w_priv->sysfs_mutex);
 
@@ -491,7 +493,7 @@ static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
+	ret = sysfs_emit(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
 
 	mutex_unlock(&w_priv->sysfs_mutex);
 
-- 
2.27.0

