Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E101A36EA19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhD2MMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2MMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:12:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3542C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:11:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g65so6557855wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CC13qMvTdvBCfEYuNiDCZJobaHEjHZxq8P5a0QZdtXc=;
        b=X14AJPDlkVkNEVIX9g7+UTTAmbWGGctjy2/y34OgMHMOgsCyuCNebBr0hYkiJ0TVuB
         uuiPQDZou3QMXiaIuUjBqAS94UKyf7ITQ83mVpGjoJWVYRTdTmne/lMYeXtMH6KSEYgG
         TNQzUb8kNjjDGWZhUJKv0kGS9va9nT//1+jGC1Kz8gdWSl2VBeDM9AZLa3s7ia3hQTNd
         K3uGiX/Myi9A7uV08TT4EvgPbjbMGbwpUF4buRB5w9moFVJPF8Q87YaXTP40uk5esAoE
         uKM0IqYd7uj7RzuVDd5tMzMj911jlPs3A30q5ej4EEsb8HArdOVnAy5WtJ6A94L0e6cQ
         qFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CC13qMvTdvBCfEYuNiDCZJobaHEjHZxq8P5a0QZdtXc=;
        b=gi/MDEtrs2wvHokQ8s3Wy9KfGOkWjV0fRwHVdVZJC1q31SPKp3d4yj1kWZSzaHfQ1+
         +l6u/Hp/gYTAXMb17OtzARxYAZGb+077Kgo21P52Kz+E3NojuoerAH1XdXDzyVlDa6so
         GFxqoTEQc8C1fpGQUsAs646+T/IM8d/ecPkfUAcmWDkUjt08yMBn7EP1qFmTMnqOtscc
         Ch1J+zDyhikyzGwMyfz0pQc8vBgZ4kMXLlw0r4zapZh8qvo9QO/qtN1SaPzp8jJy2Vl1
         yfFbtjmNzK+98yFr+RdbFljrxRoGRU1bsbU3qmY1FkZS/Fy6YMVQ2Bk3UYPoTzrxsqoF
         YGAQ==
X-Gm-Message-State: AOAM530OOjlX+M7GuxRkhyDjmOKL4+dYmjvY7WMXu6ysh/wjfN5mrOwF
        XooymwMtzQm4bbZL70exwzu/rg==
X-Google-Smtp-Source: ABdhPJyXvLLMtW6YOY8kXf16jcHOoCucImYQ6t//OjljaEvzl2+wBfBjnhGXNR0ErdAc3Shl7gkiWA==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr36919791wmc.92.1619698316454;
        Thu, 29 Apr 2021 05:11:56 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-15.xnet.hr. [88.207.97.15])
        by smtp.googlemail.com with ESMTPSA id 18sm10075640wmo.47.2021.04.29.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:11:56 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] hwmon: lm75: Add TI TMP1075 support
Date:   Thu, 29 Apr 2021 14:11:49 +0200
Message-Id: <20210429121150.106804-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI TMP1075 is a LM75 compatible sensor, so lets
add support for it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/hwmon/lm75.rst |  6 ++++--
 drivers/hwmon/lm75.c         | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 81257d5fc48f..8d0ab4ad5fb5 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -93,9 +93,9 @@ Supported chips:
 
 	       https://www.st.com/resource/en/datasheet/stlm75.pdf
 
-  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75B, TMP75C, TMP175, TMP275
+  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75B, TMP75C, TMP175, TMP275, TMP1075
 
-    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75b', 'tmp75c', 'tmp275'
+    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75b', 'tmp75c', 'tmp275', 'tmp1075'
 
     Addresses scanned: none
 
@@ -119,6 +119,8 @@ Supported chips:
 
 	       https://www.ti.com/product/tmp275
 
+         https://www.ti.com/product/TMP1075
+
   * NXP LM75B, PCT2075
 
     Prefix: 'lm75b', 'pct2075'
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index e447febd121a..afdbb63237b9 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -50,6 +50,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	tmp75,
 	tmp75b,
 	tmp75c,
+	tmp1075,
 };
 
 /**
@@ -293,6 +294,13 @@ static const struct lm75_params device_params[] = {
 		.clr_mask = 1 << 5,	/*not one-shot mode*/
 		.default_resolution = 12,
 		.default_sample_time = MSEC_PER_SEC / 12,
+	},
+	[tmp1075] = { /* not one-shot mode, 27.5 ms sample rate */
+		.clr_mask = 1 << 5 | 1 << 6 | 1 << 7,
+		.default_resolution = 12,
+		.default_sample_time = 28,
+		.num_sample_times = 4,
+		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
 	}
 };
 
@@ -662,6 +670,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "tmp75", tmp75, },
 	{ "tmp75b", tmp75b, },
 	{ "tmp75c", tmp75c, },
+	{ "tmp1075", tmp1075, },
 	{ /* LIST END */ }
 };
 MODULE_DEVICE_TABLE(i2c, lm75_ids);
@@ -771,6 +780,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "ti,tmp75c",
 		.data = (void *)tmp75c
 	},
+	{
+		.compatible = "ti,tmp1075",
+		.data = (void *)tmp1075
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lm75_of_match);
-- 
2.31.1

