Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18887460919
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359154AbhK1Svm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 13:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhK1Sta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:49:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0268C06174A;
        Sun, 28 Nov 2021 10:46:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z5so62561683edd.3;
        Sun, 28 Nov 2021 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpnEgkip+Kt8m4w9l8JR2NtbEGgQKuW0np00Xo92hpg=;
        b=hh0Q9boFoXqFrYUuvsMPUYuGWC6x4nSAFx0ol3cUf6OUKmKkYGF1dhzLjtecbV6+D0
         4qRDANAEf0lfqSlg1cLJEMD+l5+oLFnBqOy/rUGIo4BZZwNmXGHpEzQ1cUqMWn4966H0
         bEzMaFtx5GnMRTKYqgYt8F4c7iIaoA9owclmY4OCTYJFxhZg01VO7amPl5XbaDdccCdR
         I3P7d8yLPuvllBlIWLaqRsS2kzlk2ypzqFFaDyuJZo28913LDr34dDsahuL6dsWAeFj7
         3wJ1AMcKQRLE0Vepvl7sVtFHAqCvjSRP8OfA51ekJ/jSlM4DMB7/Saez1yM8jrHIFG+1
         s9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpnEgkip+Kt8m4w9l8JR2NtbEGgQKuW0np00Xo92hpg=;
        b=7jpSDOlN4SRSdNwIbZn3qEYNt1t5mG2oZ3cMR4XiR8wlmuTxm1lqmOfXNHHphKd4GS
         wLcFvSLekRXvpHpqkxnS7MHvWzeiCymEgAB/24dAABGhyxCgvnottzZWq1EN434UvqJC
         4sSh9eLYXyWPhK3Fd697+Jc6jxRDy3gyqRkVzVfbtnO9KyY9WhbELyBr0Q0XlhirGB8k
         wjyTLuP99VeSXZ1h9AhYLvuXKgRru58Qw1AflhEwxlJJljaLC2a87HCrK/E4PSQXNKBT
         YIWx9BUa4tO8Yg1yoNOSNrWpW+pGfSCHlzrldLqKRPYLHnAjOYE438JMFW+IcUqSTEfZ
         r+JA==
X-Gm-Message-State: AOAM532Ot2JZQ0EG+gI2JD0H4/CgcbW1Ff1U6Cs+8Y0HrGc8T/vOFcr5
        IDnW87MMIu/xaRGNfmhVBVs=
X-Google-Smtp-Source: ABdhPJxOsQ54yX7NIsXdO48HC6ayenrjpqbywAyUyjdQm4LtgjUekdGUYvoZnAk2NDlw7oDodwzrwg==
X-Received: by 2002:a05:6402:d49:: with SMTP id ec9mr66552057edb.235.1638125172292;
        Sun, 28 Nov 2021 10:46:12 -0800 (PST)
Received: from localhost.localdomain ([94.179.32.10])
        by smtp.gmail.com with ESMTPSA id g1sm6072900eje.105.2021.11.28.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 10:46:12 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex
Date:   Sun, 28 Nov 2021 20:45:47 +0200
Message-Id: <20211128184549.9161-3-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211128184549.9161-1-pauk.denis@gmail.com>
References: <20211128184549.9161-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ACPI lock when the board has a separate lock for monitoring IO.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

---
Changes in v2:
- Fix commit message.
- Use an anonymous union for mutexes.
- Use temporary status varibale in acpi calls.
---
 drivers/hwmon/nct6775.c | 59 +++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 049c42ea66bb..206c20a1ae9b 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -140,6 +140,7 @@ struct nct6775_sio_data {
 	int ld;
 	enum kinds kind;
 	enum sensor_access access;
+	acpi_handle acpi_wmi_mutex;
 
 	/* superio_() callbacks  */
 	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
@@ -155,6 +156,8 @@ struct nct6775_sio_data {
 #define ASUSWMI_METHODID_RHWM		0x5248574D
 #define ASUSWMI_METHODID_WHWM		0x5748574D
 #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
+/* Wait for up to 0.5 s to acquire the lock */
+#define ASUSWMI_LOCK_TIMEOUT_MS		500
 
 static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
 {
@@ -1243,7 +1246,11 @@ struct nct6775_data {
 	unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
 	unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divreg);
 
-	struct mutex update_lock;
+	union {
+		struct mutex update_lock;	/* non ACPI lock */
+		acpi_handle acpi_wmi_mutex;	/* ACPI lock */
+	} mlock;
+
 	bool valid;		/* true if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
@@ -1563,6 +1570,26 @@ static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value
 	return res;
 }
 
+static int nct6775_wmi_lock(struct nct6775_data *data)
+{
+	acpi_status status;
+
+	status = acpi_acquire_mutex(data->mlock.acpi_wmi_mutex, NULL, ASUSWMI_LOCK_TIMEOUT_MS);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
+static void nct6775_wmi_unlock(struct nct6775_data *data, struct device *dev)
+{
+	acpi_status status;
+
+	status = acpi_release_mutex(data->mlock.acpi_wmi_mutex, NULL);
+	if (ACPI_FAILURE(status))
+		dev_err(dev, "Failed to release mutex.");
+}
+
 /*
  * On older chips, only registers 0x50-0x5f are banked.
  * On more recent chips, all registers are banked.
@@ -1922,14 +1949,14 @@ static void nct6775_update_pwm_limits(struct device *dev)
 
 static int nct6775_lock(struct nct6775_data *data)
 {
-	mutex_lock(&data->update_lock);
+	mutex_lock(&data->mlock.update_lock);
 
 	return 0;
 }
 
 static void nct6775_unlock(struct nct6775_data *data, struct device *dev)
 {
-	mutex_unlock(&data->update_lock);
+	mutex_unlock(&data->mlock.update_lock);
 }
 
 static struct nct6775_data *nct6775_update_device(struct device *dev)
@@ -4061,9 +4088,15 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->write_value = nct6775_wmi_write_value;
 	}
 
-	mutex_init(&data->update_lock);
-	data->lock = nct6775_lock;
-	data->unlock = nct6775_unlock;
+	if (sio_data->acpi_wmi_mutex) {
+		data->mlock.acpi_wmi_mutex = sio_data->acpi_wmi_mutex;
+		data->lock = nct6775_wmi_lock;
+		data->unlock = nct6775_wmi_unlock;
+	} else {
+		mutex_init(&data->mlock.update_lock);
+		data->lock = nct6775_lock;
+		data->unlock = nct6775_unlock;
+	}
 
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
@@ -5114,6 +5147,7 @@ static int __init sensors_nct6775_init(void)
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
 	const char *board_vendor, *board_name;
+	acpi_handle acpi_wmi_mutex = NULL;
 	u8 tmp;
 
 	err = platform_driver_register(&nct6775_driver);
@@ -5159,6 +5193,7 @@ static int __init sensors_nct6775_init(void)
 		found = true;
 
 		sio_data.access = access;
+		sio_data.acpi_wmi_mutex = acpi_wmi_mutex;
 
 		if (access == access_asuswmi) {
 			sio_data.sio_outb = superio_wmi_outb;
@@ -5186,11 +5221,13 @@ static int __init sensors_nct6775_init(void)
 			res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
 			res.flags = IORESOURCE_IO;
 
-			err = acpi_check_resource_conflict(&res);
-			if (err) {
-				platform_device_put(pdev[i]);
-				pdev[i] = NULL;
-				continue;
+			if (!acpi_wmi_mutex) {
+				err = acpi_check_resource_conflict(&res);
+				if (err) {
+					platform_device_put(pdev[i]);
+					pdev[i] = NULL;
+					continue;
+				}
 			}
 
 			err = platform_device_add_resources(pdev[i], &res, 1);
-- 
2.33.0

