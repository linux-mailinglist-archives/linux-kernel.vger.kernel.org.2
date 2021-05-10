Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0C377E32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhEJIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhEJIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:30:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3123C061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:29:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so9624055pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raydium-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nti7k0aWmxKKtAKgFMSnvSLPYcjIi1zTilsQciHI1RE=;
        b=JQQ85+wK04UnJ+t/Fsh0eQzUazMsnG6ZikOBKRF4hOdbbaDcxfJDjBAV1ggI1/wIAL
         twbH/ZZ949LO1fHhUFt2/Wvp1lshyw6xQ3aIqeFgyJXhmpFR8vB0fQyqObI21+435AP+
         +D79Fz6Pxnfqbe/OxSLSJnVY/OZq0gV95NvuVFCqlRWgZIvoG8/Kd8KhsGt/pWE8o0pX
         C9zo9ZigI+qomKDAa+QPSFIW5BEWfe5hdUQrPwsF/6Ok5Hirlq+20rgea0yjsMxDbDXZ
         Qsa5SVBzRzck5f04da4ERSPQXVG9okEfYiljm7WMQEtCrCeq1tPgMuOr6XD/U5ArDUau
         +ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nti7k0aWmxKKtAKgFMSnvSLPYcjIi1zTilsQciHI1RE=;
        b=m76Ij7BxJOelJVjs4tPGrElGV3WQiz1++Ij3am1Kz0+G0sz+dg2bDKgSgBJ9BcNqdq
         wXNlpx/6mg5AuF6mZqnhlQsPFNUOXF97+n0HdlZ98GyIfWRdJDqJHmtz+yXI0yhEDpmE
         XfkYlhLZqSi67MWRYJDPcd480iofktmzt+r2aZl/UwplhpiQ3w5YuxwJSiqOT+6vOovb
         8aVLiNbG0ENaVLc5/qp2SsKmBf03lx1e7dhJDyd7sxqJNVVVhH8H0DtD+HTPe4XsdXXR
         GD2Gvutxykz8b7o8tOxcFvPlDVeufdaWN9Ku5NDxpOIjdp8OlcmNKmfGgU8vKQuO7RIq
         9lPA==
X-Gm-Message-State: AOAM531JSJMDcEdZ2vgAt2sVjZyx39FfABrFxGlWG9zbLfb/kBrBeZ55
        kA/0B+bs5tZfJJtakpCR1kk4vw==
X-Google-Smtp-Source: ABdhPJyRJkxsjD55cX9CgdaAkxuFt8akxHSTSjfCDpWDYMQcVQklWjgQi3qKpx4t1rG1+7hVcH7ODw==
X-Received: by 2002:a17:90b:19c4:: with SMTP id nm4mr16844674pjb.102.1620635375332;
        Mon, 10 May 2021 01:29:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:590:a0b:68e6:4109:c7b2:3cc])
        by smtp.gmail.com with ESMTPSA id ge4sm18791463pjb.49.2021.05.10.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:29:34 -0700 (PDT)
From:   "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>
X-Google-Original-From: "simba.hsu" <simba.hsu@rad-ic.com>
To:     dmitry.torokhov@gmail.com, simba.hsu@rad-ic.com,
        furquan@google.com, seanpaul@chromium.org, rrangle@chromium.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        KP.li@rad-ic.com, jeffrey.lin@rad-ic.com,
        "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>
Subject: [PATCH] driver:input:touchscreen: improve the mechanism of auto-update
Date:   Mon, 10 May 2021 16:27:08 +0800
Message-Id: <20210510082708.41844-1-simba.hsu@rad-ic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>

Once auto-update has been interrupted, touch IC will be stuck in
recovery mode forever and it will lead to touch malfunction.
This patch makes auto-update available when touch IC is in
recovery mode to avoid touch malfunction.

Signed-off-by: simba.hsu <simba.hsu@rad-ic.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 53 ++++++++++++++++++----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 4d2d22a86977..50f6fbbe4775 100644
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
@@ -289,6 +291,44 @@ static int raydium_i2c_sw_reset(struct i2c_client *client)
 
 	return 0;
 }
+static int raydium_i2c_query_ts_BL_info(struct raydium_data *ts)
+{
+	struct i2c_client *client = ts->client;
+	static const u8 get_hwid[7] = {RM_BOOT_CMD_READHWID,
+					 0x10, 0xc0, 0x01, 0x00, 0x04, 0x00};
+	int error;
+	u8 rbuf[5] = {0, 0, 0, 0, 0};
+	u32 tmpdata = 0;
+
+	error = raydium_i2c_send(client,
+				 RM_CMD_BOOT_WRT, get_hwid, sizeof(get_hwid));
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
+	error = raydium_i2c_read(client,
+				 RM_CMD_BOOT_CHK, rbuf, sizeof(rbuf));
+	if (!error) {
+		tmpdata = (rbuf[1]<<24|rbuf[2]<<16|rbuf[3]<<8|rbuf[4]);
+		ts->info.hw_ver = tmpdata;
+		dev_err(&client->dev, "HWID %08X\n", ts->info.hw_ver);
+	} else {
+		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
+		dev_err(&client->dev, "raydium_i2c_read HWID failed, %X, %X, %X, %X\n",
+					 rbuf[1], rbuf[2], rbuf[3], rbuf[4]);
+	}
+	ts->info.main_ver = 0xff;
+	ts->info.sub_ver = 0xff;
+
+	return error;
+}
 
 static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 {
@@ -388,13 +428,10 @@ static int raydium_i2c_initialize(struct raydium_data *ts)
 	if (error)
 		ts->boot_mode = RAYDIUM_TS_BLDR;
 
-	if (ts->boot_mode == RAYDIUM_TS_BLDR) {
-		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
-		ts->info.main_ver = 0xff;
-		ts->info.sub_ver = 0xff;
-	} else {
+	if (ts->boot_mode == RAYDIUM_TS_BLDR)
+		raydium_i2c_query_ts_BL_info(ts);
+	else
 		raydium_i2c_query_ts_info(ts);
-	}
 
 	return error;
 }
@@ -1218,7 +1255,7 @@ static SIMPLE_DEV_PM_OPS(raydium_i2c_pm_ops,
 			 raydium_i2c_suspend, raydium_i2c_resume);
 
 static const struct i2c_device_id raydium_i2c_id[] = {
-	{ "raydium_i2c" , 0 },
+	{ "raydium_i2c", 0 },
 	{ "rm32380", 0 },
 	{ /* sentinel */ }
 };
-- 
2.25.1

