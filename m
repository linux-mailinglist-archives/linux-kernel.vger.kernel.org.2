Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D287A41D163
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbhI3C07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3C07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:26:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D02C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:25:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso913311pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DAkOxb0528ej0WflG9+DaiCcgFffO0DeMThM/Aa8KQ=;
        b=Ko3TFXuHcBEWGnh8tgySUXOhkd1hFz0HOU/ItU0CppKMUiMDynMVM2zIH3XrOFxsqF
         Mzf1b77lVii5Zd7XVOUhG+TeaL2rlUYnK3WJAfrbj2+ySNEfNprDXPkjJA8Ygj9xE5Qn
         /ukX5NY64K8oBS7CqBLIwGp5uB2CwKLTAk3gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DAkOxb0528ej0WflG9+DaiCcgFffO0DeMThM/Aa8KQ=;
        b=neJeMNbErxEoago5+HAubAWrnXtTKiTVpyJq9moA2tNkbHdICOAoJ1KUSebKxNeHZX
         n9my0AVR1g42zsymjbTIrN2uiDiZZ3fetESfu2eze0UcSz+JgusgUXPo8znP94wEq4Km
         ww1MP0D/9E3O1hbmLDK95L0oB0BfmlJ8t15yVYiKixkj+23rUrT6IKHYebDHVHeZfkrl
         KUOszt2/BGruO7pOp3F0W6ASwjINKeTgdIl88xvQRO10pOA9WdPeADHVeJ2QFYGADSXF
         LCW0x1LZrMSFzC4oZs1qjrdc1JC1rBj8USK2U8tKbuu0ji0BmNG5VpDerevJevK62YAP
         HBvA==
X-Gm-Message-State: AOAM533XtoOK3bzW6DL1umLnns9R5wxSm3zImcjL+plAWBDLzG/9XvMS
        9ab5/0ohgOuIlXI763QmkxTk43cY8qepaw==
X-Google-Smtp-Source: ABdhPJyFBfKyqTECNzaVfyIg6KRg6hirunVAy4XoXjG6Y3kUsMRYvokYRxw1mTJ3BgNtDUk0b8gFmA==
X-Received: by 2002:a17:902:7c17:b0:13e:2dd5:e5c4 with SMTP id x23-20020a1709027c1700b0013e2dd5e5c4mr1713152pll.68.1632968716621;
        Wed, 29 Sep 2021 19:25:16 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:479:c131:ee9:f257])
        by smtp.gmail.com with ESMTPSA id 126sm898070pgi.86.2021.09.29.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:25:16 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/5] platform/chrome: cros_usbpd_notify: Move ec_command()
Date:   Wed, 29 Sep 2021 19:23:50 -0700
Message-Id: <20210930022403.3358070-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210930022403.3358070-1-pmalani@chromium.org>
References: <20210930022403.3358070-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_command() can be used by other modules too. So, move it to a
common location and export it.

This patch does not introduce any functional changes.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 45 +++++++++++++++++++++
 drivers/platform/chrome/cros_usbpd_notify.c | 44 --------------------
 include/linux/platform_data/cros_ec_proto.h |  3 ++
 3 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index a34cf58c5ef7..67009b604630 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -910,3 +910,48 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
 	return sensor_count;
 }
 EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
+
+/**
+ * cros_ec_command - Send a command to the EC.
+ *
+ * @ec_dev: EC device
+ * @command: EC command
+ * @outdata: EC command output data
+ * @outsize: Size of outdata
+ * @indata: EC command input data
+ * @insize: Size of indata
+ *
+ * Return: >= 0 on success, negative error number on failure.
+ */
+int cros_ec_command(struct cros_ec_device *ec_dev,
+		    int command,
+		    uint8_t *outdata,
+		    int outsize,
+		    uint8_t *indata,
+		    int insize)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->command = command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outsize)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret < 0)
+		goto error;
+
+	if (insize)
+		memcpy(indata, msg->data, insize);
+error:
+	kfree(msg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cros_ec_command);
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index e718055f4313..39afdad897ce 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -53,50 +53,6 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
 
-/**
- * cros_ec_command - Send a command to the EC.
- *
- * @ec_dev: EC device
- * @command: EC command
- * @outdata: EC command output data
- * @outsize: Size of outdata
- * @indata: EC command input data
- * @insize: Size of indata
- *
- * Return: >= 0 on success, negative error number on failure.
- */
-static int cros_ec_command(struct cros_ec_device *ec_dev,
-			   int command,
-			   uint8_t *outdata,
-			   int outsize,
-			   uint8_t *indata,
-			   int insize)
-{
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->command = command;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outsize)
-		memcpy(msg->data, outdata, outsize);
-
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
-	if (ret < 0)
-		goto error;
-
-	if (insize)
-		memcpy(indata, msg->data, insize);
-error:
-	kfree(msg);
-	return ret;
-}
-
 static void cros_usbpd_get_event_and_notify(struct device  *dev,
 					    struct cros_ec_device *ec_dev)
 {
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 55844ece0b32..20b17c43caeb 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -231,6 +231,9 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
+int cros_ec_command(struct cros_ec_device *ec_dev, int command, uint8_t *outdata, int outsize,
+		    uint8_t *indata, int insize);
+
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *
-- 
2.33.0.685.g46640cef36-goog

