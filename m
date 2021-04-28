Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BD36D40D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhD1IjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:39:24 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41735 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhD1IjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:39:22 -0400
Received: by mail-wr1-f45.google.com with SMTP id d11so4257823wrw.8;
        Wed, 28 Apr 2021 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dhVOJV1v1xe2BZ8GwY6vRjyrU1hKrudsBliQOL/+ww=;
        b=RJp50+8EF1+q+Rh4lxlIuKjycZe99IILmUb4oOsQ0zKWeb49ZYIPXE6Xrwlfel0281
         /cMr6XchdzYoYQ9iZ6Y6DcemTQuBybmakehHpNoEU462RFi48v+N77MV2py/1PlWdWaN
         YCla7j+gC3HTATfBM+JUOJR3g/tuVD1t4ITP10cyRy6Pt7xHknwH3uztGN5GOd2qACji
         lKJZ7nk132SjF4FlH2c6jaukuPTUOzojAH3uEbvdk7KTlduJvdIKKlPHuUzNHTnfxmQa
         0JgO2XYmizZRVVj+R2ay2moaSswPn6/wgYXU+5Vk0Z5rwiClB/E9sCiZjbDR4rmm77/l
         ubtw==
X-Gm-Message-State: AOAM532c2yp4Th0ncSeyE/DMXgIOMEbEQWisyMP91ugBi12IcPn2+mC7
        Sgw+nQQPQAi/nnoTbWaVUMk=
X-Google-Smtp-Source: ABdhPJxeIlyzT+Hh4euDs5kEWw/ETIm1+5xE/vERWo8x1IsMSR5jLr0sQNkCGUekdomNHU4K6upGwA==
X-Received: by 2002:a5d:6383:: with SMTP id p3mr8032355wru.230.1619599117243;
        Wed, 28 Apr 2021 01:38:37 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id d14sm7438735wrp.12.2021.04.28.01.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 01:38:36 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH v2] Fix FSP-3Y YH-5151E non-compliant vout encoding
Date:   Wed, 28 Apr 2021 10:38:32 +0200
Message-Id: <20210428083833.4136346-1-kubernat@cesnet.cz>
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
encoding. However, the PDU is non-compliant and uses linear11. YM-2151E
isn't affected by this. Fix this by converting the values inside the
read functions. linear16 gets the exponent from the VOUT_MODE command.
The device doesn't support it, so I have to manually supply the value
for it.

Both supported devices have now been tested to report correct vout
values.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/pmbus/fsp-3y.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index 564649e87e34..dc147a79d6aa 100644
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
@@ -103,17 +103,28 @@ static int set_page(struct i2c_client *client, int page_log)
 
 static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct fsp3y_data *data = to_fsp3y_data(info);
 	int rv;
 
 	rv = set_page(client, page);
 	if (rv < 0)
 		return rv;
 
+	/*
+	 * YH5151-E outputs vout in linear11. The conversion is done later, but
+	 * I have to inject pmbus_core with the correct exponent.
+	 */
+	if (data->chip == yh5151e && reg == PMBUS_VOUT_MODE)
+		return 0x1A;
+
 	return i2c_smbus_read_byte_data(client, reg);
 }
 
 static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct fsp3y_data *data = to_fsp3y_data(info);
 	int rv;
 
 	/*
@@ -144,7 +155,18 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
 	if (rv < 0)
 		return rv;
 
-	return i2c_smbus_read_word_data(client, reg);
+	rv = i2c_smbus_read_word_data(client, reg);
+	if (rv < 0)
+		return rv;
+
+	/*
+	 * The PDU is non-compliant and outputs output voltages in linear11
+	 * instead of linear16.
+	 */
+	if (data->chip == yh5151e && reg == PMBUS_READ_VOUT)
+		rv = ((s16)((rv & 0x7ff) << 5)) >> 5;
+
+	return rv;
 }
 
 struct pmbus_driver_info fsp3y_info[] = {
-- 
2.31.1

