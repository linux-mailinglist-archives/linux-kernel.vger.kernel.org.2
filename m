Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1739281C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhE0HC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhE0HCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:02:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A505C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:01:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l70so3010631pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r6TUxQsZ96+6w4ZrMzFEQfnydPgWIO6cIh8ukglOOA=;
        b=ohjQGKmpGzN9GGd6BueMz1sRy4RwzEp/9+DVrp7DeDR/LACNXRhynL22nNmx722Y3w
         43Q0S4hHdcjG6hOvnNKjWs6qpqex3dLkTYqikxcvb8q0+oHy2tYZdX2EQPvkVwAmyZsQ
         mz/xG1JO+8KtuacaNxK6JPuTdRbDn07Q1gtNWQd2dEU21V5xbzHVKwKotUKGXMeyq42F
         1m/5hedY0dT4eNisS/r2Pufa7HXnvOq/ae9YIOLlZY6DGcPZTEWsd05e0Y7K6rZoTAw2
         cCowHKO91QLjH01jg8I00yszkLpgoEUxHGTm2D5ZLwgbrUUdWQBy3kYY3v29rBg3FhIP
         fh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2r6TUxQsZ96+6w4ZrMzFEQfnydPgWIO6cIh8ukglOOA=;
        b=MvFnJH2mnlfEgKvSZQr+G1H7CcKz5JMfknC4an5N/mUECmBbGTCdBlYiRsEDZxcv66
         4350cDl8xkRmHAC1O8ZlnnueD1pZmf3I74ASE0YB38hVYqyHttgFx0jT+ITh8I7NJwRB
         z3Du2c6kCVYv/TmheHl6hdRARN5njZToMlKUt50qEtRQjfo0S0LsPLj7oBkdnFKbYXC3
         OQ4bzQRu9d34NeCu9AYTJc6f6OKvlQuPfNjzU3NENHH2+nPdhG+4qiLMgMGYTm+PctQA
         85dB0GCezkkCiidXyyEGX4yHPAUzmM6KQ2KJsnmuFYr+DVI1ZpVfJ/Ajw8vgfunZMTyN
         HWow==
X-Gm-Message-State: AOAM530nVNQgMFthIw8huQMe6oivD9w6Qw7LZ7bT8EUMK6Fc2R9NCDn6
        tc9htK6UH64aeWYs6ks2IsnaxgFXhws=
X-Google-Smtp-Source: ABdhPJw87nf/wLta7m8MHzXjyXn+882celEkHa2MlSZZXRDqhy1Eyoi/Z78Ido/FI4m2AvSr+/hpcQ==
X-Received: by 2002:a63:6f4e:: with SMTP id k75mr2395954pgc.434.1622098882212;
        Thu, 27 May 2021 00:01:22 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id z11sm536574pjp.0.2021.05.27.00.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 00:01:21 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: scom: Remove retries
Date:   Thu, 27 May 2021 16:31:09 +0930
Message-Id: <20210527070109.225198-1-joel@jms.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a functioning FSI link there is not need to retry a write when doing
a scom in the driver.

Allow the higher layers (eg. userspace) to attempt a retry if they want,
or to accept that the address they are talking to is not accessible.

By removing the retries we can separate the error handling from retry
logic. In particular -EBUSY was used to force the get/put scom logic to
retry.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
This will go in after Eddie's patch:

 https://lore.kernel.org/r/20210329151344.14246-1-eajames@linux.ibm.com

 drivers/fsi/fsi-scom.c | 88 ++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 60 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index b45bfab7b7f5..1d04ffa542c1 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -60,7 +60,6 @@
 #define XSCOM_ADDR_FORM1_HI_SHIFT	20
 
 /* Retries */
-#define SCOM_MAX_RETRIES		100	/* Retries on busy */
 #define SCOM_MAX_IND_RETRIES		10	/* Retries indirect not ready */
 
 struct scom_device {
@@ -247,7 +246,6 @@ static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
 				 sizeof(uint32_t));
 		return -EIO;
 	}
-	/* Return -EBUSY on PIB abort to force a retry */
 	if (status & SCOM_STATUS_PIB_ABORT)
 		return -EBUSY;
 	return 0;
@@ -284,69 +282,39 @@ static int handle_pib_status(struct scom_device *scom, uint8_t status)
 static int put_scom(struct scom_device *scom, uint64_t value,
 		    uint64_t addr)
 {
-	uint32_t status, dummy = -1;
-	int rc, retries;
-
-	for (retries = 0; retries < SCOM_MAX_RETRIES; retries++) {
-		rc = raw_put_scom(scom, value, addr, &status);
-		if (rc) {
-			/* Try resetting the bridge if FSI fails */
-			if (rc != -ENODEV && retries == 0) {
-				fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG,
-						 &dummy, sizeof(uint32_t));
-				rc = -EBUSY;
-			} else
-				return rc;
-		} else
-			rc = handle_fsi2pib_status(scom, status);
-		if (rc && rc != -EBUSY)
-			break;
-		if (rc == 0) {
-			rc = handle_pib_status(scom,
-					       (status & SCOM_STATUS_PIB_RESP_MASK)
-					       >> SCOM_STATUS_PIB_RESP_SHIFT);
-			if (rc && rc != -EBUSY)
-				break;
-		}
-		if (rc == 0)
-			break;
-		msleep(1);
-	}
-	return rc;
+	uint32_t status;
+	int rc;
+
+	rc = raw_put_scom(scom, value, addr, &status);
+	if (rc == -ENODEV)
+		return rc;
+
+	rc = handle_fsi2pib_status(scom, status);
+	if (rc)
+		return rc;
+
+	return handle_pib_status(scom,
+				 (status & SCOM_STATUS_PIB_RESP_MASK)
+				 >> SCOM_STATUS_PIB_RESP_SHIFT);
 }
 
 static int get_scom(struct scom_device *scom, uint64_t *value,
 		    uint64_t addr)
 {
-	uint32_t status, dummy = -1;
-	int rc, retries;
-
-	for (retries = 0; retries < SCOM_MAX_RETRIES; retries++) {
-		rc = raw_get_scom(scom, value, addr, &status);
-		if (rc) {
-			/* Try resetting the bridge if FSI fails */
-			if (rc != -ENODEV && retries == 0) {
-				fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG,
-						 &dummy, sizeof(uint32_t));
-				rc = -EBUSY;
-			} else
-				return rc;
-		} else
-			rc = handle_fsi2pib_status(scom, status);
-		if (rc && rc != -EBUSY)
-			break;
-		if (rc == 0) {
-			rc = handle_pib_status(scom,
-					       (status & SCOM_STATUS_PIB_RESP_MASK)
-					       >> SCOM_STATUS_PIB_RESP_SHIFT);
-			if (rc && rc != -EBUSY)
-				break;
-		}
-		if (rc == 0)
-			break;
-		msleep(1);
-	}
-	return rc;
+	uint32_t status;
+	int rc;
+
+	rc = raw_get_scom(scom, value, addr, &status);
+	if (rc == -ENODEV)
+		return rc;
+
+	rc = handle_fsi2pib_status(scom, status);
+	if (rc)
+		return rc;
+
+	return handle_pib_status(scom,
+				 (status & SCOM_STATUS_PIB_RESP_MASK)
+				 >> SCOM_STATUS_PIB_RESP_SHIFT);
 }
 
 static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
-- 
2.30.2

