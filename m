Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0734596B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhKVVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhKVVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:32:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14121C061574;
        Mon, 22 Nov 2021 13:29:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so35127989wra.10;
        Mon, 22 Nov 2021 13:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kjQjCZAFXGO+O6iSvObrjHAYThWMpPbKcYmuVE1qt0=;
        b=jVccfnZIFKtNccwACqa4Z4GPnNyA695OXpZcy0PVtQFmJ1NHhQuvhDduJzHk/JrcN+
         ydtbCO5Vz+AX9SkhOEu1p9WJDQj85iSr9JypwLt4fvIe68eljHSAjvH2XFOeAeJgncuP
         noSHZ0YRhTWQlBh6Awngyunhgm40coh2AmVB8ZPE29EM7HGLK6VfiuEJJCHMpFOBWcCR
         FfnjcA1wQ4kPF8wDUbb3HyR++q0g48ZJJ7mrvDk0TqpqfLim+odirqy3Jb6zrlv+NAb8
         SuFcuTBHq6hR9ip7JMZtKtFI4/gLRmR4m799z/WeSDowN9KkP0UqOQ1zCH6VELMb9qJc
         oIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kjQjCZAFXGO+O6iSvObrjHAYThWMpPbKcYmuVE1qt0=;
        b=kMszIvshl7ZLcAZX34J8uActrx/+EbDF75LlsfLNrdmHCCBdCj2Vu0A8QnKpY6bpdj
         4zAetAFqehPVlikO1mQEcTYzr5e2GguuxpBqo+G/wcZrm5BcfHryhli3bJ2sWNXf8SzK
         bPC4p142DK5lfckRatxPKucFxfY2R45Z4lIzw62efiCzsc6iqFe8LG0u3rh9j/cT1KHu
         8r/bPWOsCIdYryVHoWBsQBhpfpPFKU6vOA+i2ekakJhwn/btEUYyR4zn3k0ISoKnXUNz
         3pK4IqRhU6BToEwkeCHim9NsDF6v80e6aBSUW8pyCFsYlsPkB2EIDennawZ0LS4C/RNZ
         Qang==
X-Gm-Message-State: AOAM53197MTEdL9Mso+LU/n/1zhyZv4nx8UkcYZT8fdlXlf2+3NAw3IX
        maHjCxiatJ+f7yv4SUiMAPE=
X-Google-Smtp-Source: ABdhPJz5oaF1VEd8lvaX+0OU9POZbWHaf6pYHQNL6bOFMTPbm6IwE//dv4cxgNpI7TXnBvMxGS7e3w==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr367034wrt.375.1637616547566;
        Mon, 22 Nov 2021 13:29:07 -0800 (PST)
Received: from localhost.localdomain (149-45-179-94.pool.ukrtel.net. [94.179.45.149])
        by smtp.gmail.com with ESMTPSA id k8sm9767928wrn.91.2021.11.22.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:29:07 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
Date:   Mon, 22 Nov 2021 23:28:49 +0200
Message-Id: <20211122212850.321542-3-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122212850.321542-1-pauk.denis@gmail.com>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ACPI lock when board has separate lock for monitoring IO.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775.c | 46 +++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 049c42ea66bb..3aeb32093c35 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -140,6 +140,7 @@ struct nct6775_sio_data {
 	int ld;
 	enum kinds kind;
 	enum sensor_access access;
+	acpi_handle acpi_wmi_mutex;
 
 	/* superio_() callbacks  */
 	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
@@ -155,6 +156,7 @@ struct nct6775_sio_data {
 #define ASUSWMI_METHODID_RHWM		0x5248574D
 #define ASUSWMI_METHODID_WHWM		0x5748574D
 #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
+#define ASUSWMI_DELAY_MSEC_LOCK		500	/* Wait 0.5 s max. to get the lock */
 
 static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
 {
@@ -1243,7 +1245,9 @@ struct nct6775_data {
 	unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
 	unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divreg);
 
-	struct mutex update_lock;
+	struct mutex update_lock;	/* non ACPI lock */
+	acpi_handle acpi_wmi_mutex;	/* ACPI lock */
+
 	bool valid;		/* true if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
@@ -1563,6 +1567,20 @@ static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value
 	return res;
 }
 
+static int nct6775_wmi_lock(struct nct6775_data *data)
+{
+	if (ACPI_FAILURE(acpi_acquire_mutex(data->acpi_wmi_mutex, NULL, ASUSWMI_DELAY_MSEC_LOCK)))
+		return -EIO;
+
+	return 0;
+}
+
+static void nct6775_wmi_unlock(struct nct6775_data *data, struct device *dev)
+{
+	if (ACPI_FAILURE(acpi_release_mutex(data->acpi_wmi_mutex, NULL)))
+		dev_err(dev, "Failed to release mutex.");
+}
+
 /*
  * On older chips, only registers 0x50-0x5f are banked.
  * On more recent chips, all registers are banked.
@@ -4051,6 +4069,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 	data->kind = sio_data->kind;
 	data->sioreg = sio_data->sioreg;
+	data->acpi_wmi_mutex = sio_data->acpi_wmi_mutex;
 
 	if (sio_data->access == access_direct) {
 		data->addr = res->start;
@@ -4061,9 +4080,14 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->write_value = nct6775_wmi_write_value;
 	}
 
-	mutex_init(&data->update_lock);
-	data->lock = nct6775_lock;
-	data->unlock = nct6775_unlock;
+	if (data->acpi_wmi_mutex) {
+		data->lock = nct6775_wmi_lock;
+		data->unlock = nct6775_wmi_unlock;
+	} else {
+		mutex_init(&data->update_lock);
+		data->lock = nct6775_lock;
+		data->unlock = nct6775_unlock;
+	}
 
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
@@ -5114,6 +5138,7 @@ static int __init sensors_nct6775_init(void)
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
 	const char *board_vendor, *board_name;
+	acpi_handle acpi_wmi_mutex = NULL;
 	u8 tmp;
 
 	err = platform_driver_register(&nct6775_driver);
@@ -5159,6 +5184,7 @@ static int __init sensors_nct6775_init(void)
 		found = true;
 
 		sio_data.access = access;
+		sio_data.acpi_wmi_mutex = acpi_wmi_mutex;
 
 		if (access == access_asuswmi) {
 			sio_data.sio_outb = superio_wmi_outb;
@@ -5186,11 +5212,13 @@ static int __init sensors_nct6775_init(void)
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

