Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15236E664
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbhD2H6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:58:37 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40679 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhD2H6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:58:36 -0400
Received: by mail-wr1-f50.google.com with SMTP id e5so37137865wrg.7;
        Thu, 29 Apr 2021 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RcNiggHuh6/s/ucuEsCg7coi7EiTpYqPHT/PDhDIPuU=;
        b=dcvs1VLlwLLUc3yZ1fEla+xmPHw4gfSl6aBAz/SrKdPys3WI4ql5ZvCdZtDeRVfMhF
         Jm8ptZvnkcjoNbE+jArE+9j5O2AZW1j/bMtruJSmhp72A5Z34PR0wNNoz1Ebf++dqpfe
         GBSU4A1BPCfqM+2VVLRls1hIbOBiC3K+uF/tOwzc4iXIMzaGoLgZhqgBdJVMh+xGUp0L
         vEEfsJX1PGHvqYWvZLavtPLBoDX5Jn61QZgvmuzJiPslNPycCT4ekKR8Zz+bulpLSkNf
         pWn5u0q2qhooXCowa57VXBg5tytN9b5ctFxfSpi+ILYbdpVuBvxTf8Rt2/JP1fy8SjGY
         QAiA==
X-Gm-Message-State: AOAM530MRTSkevM0cwiwjgUJ1Uh6vNIcZFngMJr0cAAH09r3NNUAJ3Bj
        PR3Lp4syD1EyDWH9WbqfmxP/x0OK/wOcIQ==
X-Google-Smtp-Source: ABdhPJyUMTSF7KoxBWiYnQhSJLRbpYc0Gd9vyfnVZYLBwMeLq+zWhsR+bX8DAOHX/UnhFziPoDk8lw==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr41768095wru.163.1619683068991;
        Thu, 29 Apr 2021 00:57:48 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id z14sm4037362wrt.54.2021.04.29.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:57:48 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Fix FSP-3Y YH-5151E non-compliant vout encoding
Date:   Thu, 29 Apr 2021 09:53:38 +0200
Message-Id: <20210429075337.110502-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't properly test the driver for YH-5151E, so it was completely
broken. Firstly, the log/real mapping was incorrect in one case.
Secondly, PMBus specifies that output voltages should be in the linear16
encoding. However, the YH-5151E is non-compliant and uses linear11.
YM-2151E isn't affected by this. Fix this by converting the values
inside the read functions. linear16 gets the exponent from the VOUT_MODE
command. The device doesn't support it, so I have to manually supply the
value for it.

Both supported devices have now been tested to report correct vout
values.

Fixes: 1734b4135a62 ("hwmon: Add driver for fsp-3y PSUs and PDUs")
Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/pmbus/fsp-3y.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index 564649e87e34..655690dde4d7 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -57,7 +57,7 @@ static int page_log_to_page_real(int page_log, enum chips chip)
 		case YH5151E_PAGE_12V_LOG:
 			return YH5151E_PAGE_12V_REAL;
 		case YH5151E_PAGE_5V_LOG:
-			return YH5151E_PAGE_5V_LOG;
+			return YH5151E_PAGE_5V_REAL;
 		case YH5151E_PAGE_3V3_LOG:
 			return YH5151E_PAGE_3V3_REAL;
 		}
@@ -103,8 +103,18 @@ static int set_page(struct i2c_client *client, int page_log)
 
 static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct fsp3y_data *data = to_fsp3y_data(info);
 	int rv;
 
+	/*
+	 * YH5151-E outputs vout in linear11. The conversion is done when
+	 * reading. Here, we have to inject pmbus_core with the correct
+	 * exponent (it is -6).
+	 */
+	if (data->chip == yh5151e && reg == PMBUS_VOUT_MODE)
+		return 0x1A;
+
 	rv = set_page(client, page);
 	if (rv < 0)
 		return rv;
@@ -114,6 +124,8 @@ static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
 
 static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct fsp3y_data *data = to_fsp3y_data(info);
 	int rv;
 
 	/*
@@ -144,7 +156,18 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_read_word_data(client, reg);
+	rv = i2c_smbus_read_word_data(client, reg);
+	if (rv < 0)
+		return rv;
+
+	/*
+	 * YH-5151E is non-compliant and outputs output voltages in linear11
+	 * instead of linear16.
+	 */
+	if (data->chip == yh5151e && reg == PMBUS_READ_VOUT)
+		rv = sign_extend32(rv, 10) & 0xffff;
+
+	return rv;
 }
 
 struct pmbus_driver_info fsp3y_info[] = {
-- 
2.31.1

