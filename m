Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4337B41B8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbhI1Uw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbhI1Uwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:52:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84417C06161C;
        Tue, 28 Sep 2021 13:51:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 11so146184qvd.11;
        Tue, 28 Sep 2021 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=We+Hncm1dVQvjyDtLz/UlNXZ+UBYHqbLW/DDtyJJi3c=;
        b=PDoIdU8lxTm5ThnEPRbDJKoLBfGo/tgseca8fgFCeYDws8WWtddgGyjWdb0aXJde0p
         tjZ6JAvy18kJC9+srq37Q1/CvCwIMz07FNG+CyT8EImfvQHw/q5qxVrd557eMp3svXPD
         fn0sv5b3Sm3M9sn0wUxAZ6qTLw0BiwMaYRtFOUtJ58web4yUdd9ZN+dDguFvdCNQhbME
         /n3VuuJQvtDEL6lf8+IpAaqNVxm+jSrHahsjxq6KqIE9N1ieQPzBixqxxBJge+MAQcSF
         kuHdv7AeWHKfPSyw6WIA4OSx8CxwQA4NdrLWjfZra3J37mMjmpzuT5WO7HdaxepX8mk9
         yAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=We+Hncm1dVQvjyDtLz/UlNXZ+UBYHqbLW/DDtyJJi3c=;
        b=QbPSqZy3R3UhXbzBAtH90JSIqXeP9W3ga29CFKu5H2aCPrJZjKw8aSF0BdIJaRDBGi
         jN/hq2IvMQAMaSbgVtnbwFmWD7fH/pZImVAgleqzbGBngE7ypGKlVt76l+Md3IMQKIPK
         D6pner9S59tZqqyhTwT7qwgWRYDmY+uPIkZGF7MghidZw6R+sUVnhF6Ab2rhOcyquPnm
         U2JW3ce6086ppOjPA4qIDoM5o2x/B9yTUMWZtRMnasimdX4i/gc4jete5pPD09W1UplN
         EswAQxU2C6FAcXq5Lc2GL2hc1xEuFU3eOBPtRDelU2Kvsn7Q+bT1BYeh8T9zSzNDn02r
         Bwfg==
X-Gm-Message-State: AOAM531DHvXm8j57etA7qMxBW4qkidYp2ybMOcKNgngT79vrYPqkTHUI
        nXfPpcT1uTifATwZz/+VaLI=
X-Google-Smtp-Source: ABdhPJxHQF+glZA3UMYut+VTtrVbz09lGVld5XtgNBlf+IJHDS4Uukl4RY568e/zwxLPwSkwIpD3Uw==
X-Received: by 2002:a0c:e4c8:: with SMTP id g8mr8150201qvm.24.1632862269646;
        Tue, 28 Sep 2021 13:51:09 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id x3sm173004qkl.107.2021.09.28.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:51:09 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH v2] hwmon: (pmbus/ibm-cffps) max_power_out swap changes
Date:   Tue, 28 Sep 2021 20:50:51 +0000
Message-Id: <20210928205051.1222815-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bytes for max_power_out from the ibm-cffps devices differ in byte
order for some power supplies.

The Witherspoon power supply returns the bytes in MSB/LSB order.

The Rainier power supply returns the bytes in LSB/MSB order.

The Witherspoon power supply uses version cffps1. The Rainier power
supply should use version cffps2. If version is cffps1, swap the bytes
before output to max_power_out.

Tested:
    Witherspoon before: 3148. Witherspoon after: 3148.
    Rainier before: 53255. Rainier after: 2000.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index df712ce4b164..79bfcd2749a6 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -171,8 +171,14 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
 		cmd = CFFPS_SN_CMD;
 		break;
 	case CFFPS_DEBUGFS_MAX_POWER_OUT:
-		rc = i2c_smbus_read_word_swapped(psu->client,
-						 CFFPS_MAX_POWER_OUT_CMD);
+		if (cffps1 == psu->version) {
+			rc = i2c_smbus_read_word_swapped(psu->client,
+					CFFPS_MAX_POWER_OUT_CMD);
+		} else {
+			rc = i2c_smbus_read_word_data(psu->client,
+					CFFPS_MAX_POWER_OUT_CMD);
+		}
+
 		if (rc < 0)
 			return rc;
 
-- 
2.25.1

