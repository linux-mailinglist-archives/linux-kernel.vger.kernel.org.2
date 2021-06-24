Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57293B2A82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFXIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFXIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:41:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C94C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:39:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so5457640pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raydium-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ajTOyjYSJ0oov782itPNsymFCO3cX1BrHaaPfNpFmD8=;
        b=0m/vunNgQ/tTu6nbV8YIx/FLwYSZsKUbsNT5Hr9jX6QIq7caEoNGng3fmn66lra4Qi
         81gYzUC1JWSnFnJso883DhJkgNKEHBx85rfTl8kY77xnku+bLpPC/0PAZsEskBcuR1Pv
         YSqudlZZvFSAqWcHTAYJvo+KAlJ5Mo4ABkUrNDet8JpXYuwT2JPCu0WDObWTotWeY3f6
         P0uWI6yxoyCBYXAmK0mxNc8PjCj+8HTPYuWx6LsnoB/Xls+XcUXPFSux52xMLySiD2kP
         gckhbvvwhc/AJYmJGAfbIq2vlaanj+BS5yym8BlKJA/5iToPsCCwn/ykCp6d6U8cyo5j
         MzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ajTOyjYSJ0oov782itPNsymFCO3cX1BrHaaPfNpFmD8=;
        b=eVzW8X/79bZJrXWc8bWF51QMj1MBV8ng7g9EU5MTHnDNsGkiQC9ZwHHqIW7wMBloNX
         gwcUcFa+d44OGrEetRVpOnwtd6MwGhNcuez7iRr5tNwm22JlrYX5qs4BbU3mex1J3v5U
         /LzJ0gIyCNVGu0UbUvHXfQqSkLwPcCvn1C8rGTRoRg8QG72XiWTI2rfj71wTSZjROEUD
         JZybba5TeofRnZQb9a7CLAJfs5PjQ4ABzvg5GJtnFEc30eTIO2sAa3G4rzISX2qJUm7q
         GBmRprAabrnJOU9EeEiwMvUen6pJyL8Uo9HVJziYkkFUe4UhlSNsmcFJjchc63TfI/uS
         mf2g==
X-Gm-Message-State: AOAM530dlj+otcSinlzZwUG6EhSrwx1RQWGAghyCrM7gl7oa6wIQ3d8v
        WsEO0f9YxAaAsLejFT/Lg43vUA==
X-Google-Smtp-Source: ABdhPJwKthPtxXkaae/OY1X7xkFWlJNVbQx2G8tigfr8Gcu4lDaNyRzwQPzQRqHW2/Moe/zYH95Zdw==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr14220646pjs.207.1624523976337;
        Thu, 24 Jun 2021 01:39:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:1484:8b7e:ac0:b691:20b0])
        by smtp.gmail.com with ESMTPSA id a25sm2080228pff.54.2021.06.24.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:39:36 -0700 (PDT)
From:   "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>
X-Google-Original-From: "simba.hsu" <simba.hsu@rad-ic.com>
To:     dmitry.torokhov@gmail.com, simba.hsu@rad-ic.com,
        furquan@google.com, seanpaul@chromium.org, rrangle@chromium.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        KP.li@rad-ic.com, jeffrey.lin@rad-ic.com
Subject: [PATCH] Input: raydium_i2c_ts - read device version in bootloader mode
Date:   Thu, 24 Jun 2021 16:39:13 +0800
Message-Id: <20210624083913.14936-1-simba.hsu@rad-ic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support reading device ID when controller is in bootloader
mode, which may happen if firmware update has been interrupted.

Signed-off-by: simba.hsu <simba.hsu@rad-ic.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 52 ++++++++++++++++++----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 4d2d22a86977..d3f8cc3285a2 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -36,7 +36,8 @@
 #define RM_CMD_BOOT_CHK		0x33		/* send data check */
 #define RM_CMD_BOOT_READ	0x44		/* send wait bl data ready*/
 
-#define RM_BOOT_RDY		0xFF		/* bl data ready */
+#define RM_BOOT_RDY		0xFF			/* bl data ready */
+#define RM_BOOT_CMD_READHWID	0x0E	/* read hwid */
 
 /* I2C main commands */
 #define RM_CMD_QUERY_BANK	0x2B
@@ -155,6 +156,7 @@ static int raydium_i2c_xfer(struct i2c_client *client, u32 addr,
 	 * sent first. Else, skip the header i.e. xfer[0].
 	 */
 	int xfer_start_idx = (addr > 0xff) ? 0 : 1;
+
 	xfer_count -= xfer_start_idx;
 
 	ret = i2c_transfer(client->adapter, &xfer[xfer_start_idx], xfer_count);
@@ -290,6 +292,43 @@ static int raydium_i2c_sw_reset(struct i2c_client *client)
 	return 0;
 }
 
+static int raydium_i2c_query_ts_bootloader_info(struct raydium_data *ts)
+{
+	struct i2c_client *client = ts->client;
+	static const u8 get_hwid[7] = {RM_BOOT_CMD_READHWID,
+				0x10, 0xc0, 0x01, 0x00, 0x04, 0x00};
+	u8 rbuf[5] = {0};
+	u32 hw_ver;
+	int error;
+
+	error = raydium_i2c_send(client, RM_CMD_BOOT_WRT,
+			 get_hwid, sizeof(get_hwid));
+	if (error) {
+		dev_err(&client->dev, "WRT HWID command failed: %d\n", error);
+		return error;
+	}
+
+	error = raydium_i2c_send(client, RM_CMD_BOOT_ACK, rbuf, 1);
+	if (error) {
+		dev_err(&client->dev, "Ack HWID command failed: %d\n", error);
+		return error;
+	}
+
+	error = raydium_i2c_read(client, RM_CMD_BOOT_CHK, rbuf, sizeof(rbuf));
+	if (error) {
+		dev_err(&client->dev, "Read HWID command failed: %d (%4ph)\n",
+			error, rbuf + 1);
+		hw_ver = 0xffffffffUL;
+	} else
+		hw_ver = get_unaligned_be32(rbuf + 1);
+
+	ts->info.hw_ver = cpu_to_le32(hw_ver);
+	ts->info.main_ver = 0xff;
+	ts->info.sub_ver = 0xff;
+
+	return error;
+}
+
 static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
@@ -388,13 +427,10 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 	if (error)
 		ts->boot_mode = RAYDIUM_TS_BLDR;
 
-	if (ts->boot_mode == RAYDIUM_TS_BLDR) {
-		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
-		ts->info.main_ver = 0xff;
-		ts->info.sub_ver = 0xff;
-	} else {
+	if (ts->boot_mode == RAYDIUM_TS_BLDR)
+		raydium_i2c_query_ts_bootloader_info(ts);
+	else
 		raydium_i2c_query_ts_info(ts);
-	}
 
 	return error;
 }
@@ -1218,7 +1254,7 @@ static SIMPLE_DEV_PM_OPS(raydium_i2c_pm_ops,
 			 raydium_i2c_suspend, raydium_i2c_resume);
 
 static const struct i2c_device_id raydium_i2c_id[] = {
-	{ "raydium_i2c" , 0 },
+	{ "raydium_i2c", 0 },
 	{ "rm32380", 0 },
 	{ /* sentinel */ }
 };
-- 
2.25.1

