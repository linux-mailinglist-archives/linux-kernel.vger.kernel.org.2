Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633344439E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhKBXny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhKBXnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:43:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5686C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:41:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e65so757659pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztFy+AIhTro45Wm/0WSCmIyJLR2meR9e0zaFbQwWOPE=;
        b=C0WPRzj4nG3Jbynwjw9puJw+3WLHNSuJwkJ+B0draM5st3HbUKDGyCaAXMB1yebh5g
         Z931U4Aw5C2nUBbgJtWmLpUcJdnM/Q9uwWFhmMjecK+UmJ/TaYVMioKqQ07BrTRIwwba
         0+1Igqg9Tbg0qyq5oOe3UKK0OyoW5Bqt+W2XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztFy+AIhTro45Wm/0WSCmIyJLR2meR9e0zaFbQwWOPE=;
        b=SQGNMS637SQ4oYF+eSSBbkUtsuTbD+PxOrXn8scTECZiqK+BSvSPC0euyFhDF4Tkjv
         Gu4mj8G5197qzfqcMl5xsyQmMN9AVuNra2FDUiR/EnytIbcUclKkRXwE7Xi7qPSXkWrP
         GTvhhHAwgG6gApxTjg2zxOKgPM2IopOcymXVZ97DYuRZtQUTjhRj48vUlvC4LlC148nu
         gEND+3nIPiDzFQaR2l+0kONoFfyVRAWL1YdJ2R+NnyN2cHQIzX328fITByMGU5GX9McF
         MeOVZ1m8e0HbPEc6FF58heHTMQ8Sl/21PSKtfLx1UBU+LMyquj7nCKsZkYOeYZQuOSIi
         zTGg==
X-Gm-Message-State: AOAM532QPmbFR3AO8monITw/4C4efjLaxTFV4kSAKbCnQ9r4UTTsWIvu
        o4aO+E2pFklW9sNZVpAsdGnIrun0JI2Zhg==
X-Google-Smtp-Source: ABdhPJyJi8JUw18UQD3rX3Oyor5l+xAfn3rBA6Lk5ErmPZg5jFoFgf94EubxEFR41EfsEw23Bx6r4w==
X-Received: by 2002:aa7:9219:0:b0:480:2117:8306 with SMTP id 25-20020aa79219000000b0048021178306mr27636727pfo.31.1635896475054;
        Tue, 02 Nov 2021 16:41:15 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3dd6:e5e8:407:748c])
        by smtp.gmail.com with ESMTPSA id f10sm245889pfe.82.2021.11.02.16.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:41:14 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_chardev: Export chardev ioctls to UAPI
Date:   Tue,  2 Nov 2021 16:41:13 -0700
Message-Id: <20211102234113.3896676-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ioctls and structures are part of the UAPI, export them as such by
moving the header to include/uapi/. We leave the version define out of
the header as it isn't part of the UAPI. Similarly, EC_MEMMAP_SIZE is
from the copy/pasted cros ec header so we just hardcode the array size
instead of exporting that define.

Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mfd/cros_ec_dev.c                     |  1 -
 drivers/platform/chrome/cros_ec_chardev.c     |  5 ++-
 include/linux/platform_data/cros_ec_proto.h   | 19 +-----------
 .../linux}/cros_ec_chardev.h                  | 31 +++++++++++++------
 4 files changed, 27 insertions(+), 29 deletions(-)
 rename include/{linux/platform_data => uapi/linux}/cros_ec_chardev.h (55%)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 8c08d1c55726..8c54381bbf45 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -12,7 +12,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/cros_ec_chardev.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/slab.h>
diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index e0bce869c49a..3116c5de9fa2 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -16,7 +16,6 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/platform_data/cros_ec_chardev.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
@@ -25,6 +24,10 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/cros_ec_chardev.h>
+
+#define CROS_EC_DEV_VERSION	"1.0.0"
+
 #define DRV_NAME		"cros-ec-chardev"
 
 /* Arbitrary bounded size for the event queue */
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 02599687770c..6fa882768239 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -13,6 +13,7 @@
 #include <linux/notifier.h>
 
 #include <linux/platform_data/cros_ec_commands.h>
+#include <uapi/linux/cros_ec_chardev.h>
 
 #define CROS_EC_DEV_NAME	"cros_ec"
 #define CROS_EC_DEV_FP_NAME	"cros_fp"
@@ -54,24 +55,6 @@ enum {
 	EC_MAX_MSG_BYTES	= 64 * 1024,
 };
 
-/**
- * struct cros_ec_command - Information about a ChromeOS EC command.
- * @version: Command version number (often 0).
- * @command: Command to send (EC_CMD_...).
- * @outsize: Outgoing length in bytes.
- * @insize: Max number of bytes to accept from the EC.
- * @result: EC's response to the command (separate from communication failure).
- * @data: Where to put the incoming data from EC and outgoing data to EC.
- */
-struct cros_ec_command {
-	uint32_t version;
-	uint32_t command;
-	uint32_t outsize;
-	uint32_t insize;
-	uint32_t result;
-	uint8_t data[];
-};
-
 /**
  * struct cros_ec_device - Information about a ChromeOS EC device.
  * @phys_name: Name of physical comms layer (e.g. 'i2c-4').
diff --git a/include/linux/platform_data/cros_ec_chardev.h b/include/uapi/linux/cros_ec_chardev.h
similarity index 55%
rename from include/linux/platform_data/cros_ec_chardev.h
rename to include/uapi/linux/cros_ec_chardev.h
index 7de8faaf77df..61f8690e86c4 100644
--- a/include/linux/platform_data/cros_ec_chardev.h
+++ b/include/uapi/linux/cros_ec_chardev.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
  * ChromeOS EC device interface.
  *
@@ -8,13 +8,26 @@
 #ifndef _UAPI_LINUX_CROS_EC_DEV_H_
 #define _UAPI_LINUX_CROS_EC_DEV_H_
 
-#include <linux/bits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
-#include <linux/platform_data/cros_ec_commands.h>
-
-#define CROS_EC_DEV_VERSION "1.0.0"
+/**
+ * struct cros_ec_command - Information about a ChromeOS EC command.
+ * @version: Command version number (often 0).
+ * @command: Command to send (EC_CMD_...).
+ * @outsize: Outgoing length in bytes.
+ * @insize: Max number of bytes to accept from the EC.
+ * @result: EC's response to the command (separate from communication failure).
+ * @data: Where to put the incoming data from EC and outgoing data to EC.
+ */
+struct cros_ec_command {
+	__u32 version;
+	__u32 command;
+	__u32 outsize;
+	__u32 insize;
+	__u32 result;
+	__u8 data[];
+};
 
 /**
  * struct cros_ec_readmem - Struct used to read mapped memory.
@@ -25,9 +38,9 @@
  *         read or negative on error.
  */
 struct cros_ec_readmem {
-	uint32_t offset;
-	uint32_t bytes;
-	uint8_t buffer[EC_MEMMAP_SIZE];
+	__u32 offset;
+	__u32 bytes;
+	__u8  buffer[255];
 };
 
 #define CROS_EC_DEV_IOC       0xEC
@@ -35,4 +48,4 @@ struct cros_ec_readmem {
 #define CROS_EC_DEV_IOCRDMEM  _IOWR(CROS_EC_DEV_IOC, 1, struct cros_ec_readmem)
 #define CROS_EC_DEV_IOCEVENTMASK _IO(CROS_EC_DEV_IOC, 2)
 
-#endif /* _CROS_EC_DEV_H_ */
+#endif /* _UAPI_LINUX_CROS_EC_DEV_H_ */

base-commit: 8bb7eca972ad531c9b149c0a51ab43a417385813
-- 
https://chromeos.dev

