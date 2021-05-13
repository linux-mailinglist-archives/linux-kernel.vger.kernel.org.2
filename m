Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0037FE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhEMUMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:12:33 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:34499 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhEMUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:12:31 -0400
Received: by mail-ej1-f50.google.com with SMTP id j14so231666ejy.1;
        Thu, 13 May 2021 13:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FqUDVg3RjZo3zQPVZeJKwzzDqDWCnGa+0mOwc8cESo=;
        b=T8mRvtStQLOKtL3M+kzEL1wMuxogC/PvwxZ2HNGRbQDUWRCKK+1XzBq2zKLt6ZnVmG
         fQ9By0HocFCQyIHwIgwJ6ge73u5bRN2yfp194dvy2mGy8d0StNXrGKwfU52VbzOw/NGd
         1cWvI6q8ney8SMzWpw017d3XLuwMjunEqMGnu2z9YDbxVnWjkkKQYT9w6tJDCLI2X0mi
         T7sVQ2lO4k8afD3odE0dVfdsYJPbdYzdvMvI1QIWyi6EFMacKdyvfF7296dAx1mgH7tG
         vuVGo9wG8+Bd8KxuACH4n57JGz5UlSEr7azZy45JPyYvU9uGo2jKVVEEWsQi4w0J2sp8
         iFpg==
X-Gm-Message-State: AOAM532R3KVys4lGgUlFyGqWkDGtoJupMvDiyxasaZGhT3ggKFfe+zZw
        wuaOiyLA2eFPQpmLmmJWjP4=
X-Google-Smtp-Source: ABdhPJzgcLH+eU5+IgWuqwAPcNFg0q1fMfnsNHtxst9kd6kY1SHf8O1F9SpKZYk6gyyj6i6nGBkNhQ==
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr44132905ejc.384.1620936679255;
        Thu, 13 May 2021 13:11:19 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id hz15sm2344019ejc.57.2021.05.13.13.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:11:18 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH] hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E VOUT
Date:   Thu, 13 May 2021 22:11:10 +0200
Message-Id: <20210513201110.313523-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After testing new YH-5151E devices, we found out that not all YH-5151E
work the same. The newly tested devices actually report vout correctly
in linear16 (even though they're still YH-5151E). We suspect that it is
because these new devices have a different firmware version, but that is
unconfirmed. The version cannot be queried through PMBus.

The compliant versions of YH-5151E report VOUT_MODE normally, so we turn
on the linear11 workaround only if VOUT_MODE doesn't report anything.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/pmbus/fsp-3y.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index 46252b17c008..073d960a0af5 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -37,6 +37,8 @@ struct fsp3y_data {
 	struct pmbus_driver_info info;
 	int chip;
 	int page;
+
+	bool vout_linear_11;
 };
 
 #define to_fsp3y_data(x) container_of(x, struct fsp3y_data, info)
@@ -108,11 +110,9 @@ static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
 	int rv;
 
 	/*
-	 * YH5151-E outputs vout in linear11. The conversion is done when
-	 * reading. Here, we have to inject pmbus_core with the correct
-	 * exponent (it is -6).
+	 * Inject an exponent for non-compliant YH5151-E.
 	 */
-	if (data->chip == yh5151e && reg == PMBUS_VOUT_MODE)
+	if (data->vout_linear_11 && reg == PMBUS_VOUT_MODE)
 		return 0x1A;
 
 	rv = set_page(client, page);
@@ -161,10 +161,9 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
 		return rv;
 
 	/*
-	 * YH-5151E is non-compliant and outputs output voltages in linear11
-	 * instead of linear16.
+	 * Handle YH-5151E non-compliant linear11 vout voltage.
 	 */
-	if (data->chip == yh5151e && reg == PMBUS_READ_VOUT)
+	if (data->vout_linear_11 && reg == PMBUS_READ_VOUT)
 		rv = sign_extend32(rv, 10) & 0xffff;
 
 	return rv;
@@ -256,6 +255,25 @@ static int fsp3y_probe(struct i2c_client *client)
 
 	data->info = fsp3y_info[data->chip];
 
+	/*
+	 * YH-5151E sometimes reports vout in linear11 and sometimes in
+	 * linear16. This depends on the exact individual piece of hardware. One
+	 * YH-5151E can use linear16 and another might use linear11 instead.
+	 *
+	 * The format can be recognized by reading VOUT_MODE - if it doesn't
+	 * report a valid exponent, then vout uses linear11. Otherwise, the
+	 * device is compliant and uses linear16.
+	 */
+	data->vout_linear_11 = false;
+	if (data->chip == yh5151e) {
+		rv = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
+		if (rv < 0)
+			return rv;
+
+		if (rv == 0xFF)
+			data->vout_linear_11 = true;
+	}
+
 	return pmbus_do_probe(client, &data->info);
 }
 
-- 
2.31.1

