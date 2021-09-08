Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1465340409B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhIHVnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhIHVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:43:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEA9C061575;
        Wed,  8 Sep 2021 14:42:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s3so5819633ljp.11;
        Wed, 08 Sep 2021 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3SPb96sJ5zSBCc/zhKIXMywpd9Rw2IKYPacw2Mlp38=;
        b=I5EMYBwQvssRGRQoRO+Ydt4DHIoVSjBsLJX31m6N9TocK5C2MbeAzcyu4ZpuYDZEIJ
         1bR0JPqfYDhoiCUeVSndWjT5ZQaA/ihGzqH2weZ2sDwsATF8BAynu8ERNHHVfiBey0rQ
         SFLZ9GJN75wZoUSibuGbC29RcZzdVwe8M7C7f/yrJyKJv1nVicsEnDLSCN1adTYHINv6
         7ncqMqEu/DgyJv99CL9MJ6XjdkmM5jlDG9if8jyvU1DJIh8vey4XerDGwXErDcB9E8/6
         j10icxQQ/XsXe/AjzSBWg9jkeAyHN/XFEK9+mECgtdeOaQFa98YF/VgVX/rqhGASLHF0
         tPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3SPb96sJ5zSBCc/zhKIXMywpd9Rw2IKYPacw2Mlp38=;
        b=Tg9ESX9su6H35ndwrl1GD1XXH/6bEpYl+cxbOkI0EwRsuAkQM0wzFGjhrFbVxpkvC0
         rMDSXyXgXF8C8MLk9KyfwQ0atPBgdLXoxR6xeoTiOo6unZtl9VqEUQYKd30C5Cq5B5ow
         yc6SO0dUjmQMudJbGdJ9aEQRy3Wu5KyXILYNoYkenIwWWni/Utyrf+m9Om/Z7kyYkhae
         hlCJ9GWs3fHam5o4C/bUYzTEp8bMl0gAgw0YZJO3gkGHvrbGdzQ9IR3gvgv3sOTdQ+RO
         5vUIQFYn1Y6l6BpIO5QZO/bq8Y7yppFp4iA1a3RNa8b7l9W1U974oIci+ZU2msVmMCKH
         rvJg==
X-Gm-Message-State: AOAM532v/tnbiV4Ik7lqbPkGvAp6stKP4oEzvVui7pjNNIr4/tJ9miKx
        aW56jsMnpUu15zDwCTeBn9I=
X-Google-Smtp-Source: ABdhPJwsLihBeVQ0hghYI+aijbKi0eJAHEKUIzyxWmkwo3LCv3C66TSOPLQDZxAPEC9nmY8QE39BUQ==
X-Received: by 2002:a2e:912:: with SMTP id 18mr335629ljj.290.1631137320611;
        Wed, 08 Sep 2021 14:42:00 -0700 (PDT)
Received: from localhost.localdomain ([178.94.31.92])
        by smtp.gmail.com with ESMTPSA id d12sm25105lfj.78.2021.09.08.14.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 14:42:00 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
To:     pauk.denis@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (nct6775) Use superio function pointers (v2)
Date:   Thu,  9 Sep 2021 00:36:03 +0300
Message-Id: <20210908213605.9929-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908213605.9929-1-pauk.denis@gmail.com>
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
 <20210908213605.9929-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use superio function pointers in nct6775_sio_data instead direct calls.

v2: split changes to separate patches

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775.c | 141 ++++++++++++++++++++++------------------
 1 file changed, 76 insertions(+), 65 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3390de4c00f4..908521ce2ee8 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -136,9 +136,14 @@ enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
 struct nct6775_sio_data {
 	int sioreg;
 	enum kinds kind;
+	void (*outb)(struct nct6775_sio_data *sio_data, int reg, int val);
+	int (*inb)(struct nct6775_sio_data *sio_data, int reg);
+	void (*select)(struct nct6775_sio_data *sio_data, int ld);
+	int (*enter)(struct nct6775_sio_data *sio_data);
+	void (*exit)(struct nct6775_sio_data *sio_data);
 };
 
-static inline void
+static void
 superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
 {
 	int ioreg = sio_data->sioreg;
@@ -147,7 +152,7 @@ superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
 	outb(val, ioreg + 1);
 }
 
-static inline int
+static int
 superio_inb(struct nct6775_sio_data *sio_data, int reg)
 {
 	int ioreg = sio_data->sioreg;
@@ -156,7 +161,7 @@ superio_inb(struct nct6775_sio_data *sio_data, int reg)
 	return inb(ioreg + 1);
 }
 
-static inline void
+static void
 superio_select(struct nct6775_sio_data *sio_data, int ld)
 {
 	int ioreg = sio_data->sioreg;
@@ -165,7 +170,7 @@ superio_select(struct nct6775_sio_data *sio_data, int ld)
 	outb(ld, ioreg + 1);
 }
 
-static inline int
+static int
 superio_enter(struct nct6775_sio_data *sio_data)
 {
 	int ioreg = sio_data->sioreg;
@@ -182,7 +187,7 @@ superio_enter(struct nct6775_sio_data *sio_data)
 	return 0;
 }
 
-static inline void
+static void
 superio_exit(struct nct6775_sio_data *sio_data)
 {
 	int ioreg = sio_data->sioreg;
@@ -3436,19 +3441,19 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	 * The CR registers are the same for all chips, and not all chips
 	 * support clearing the caseopen status through "regular" registers.
 	 */
-	ret = superio_enter(sio_data);
+	ret = sio_data->enter(sio_data);
 	if (ret) {
 		count = ret;
 		goto error;
 	}
 
-	superio_select(sio_data, NCT6775_LD_ACPI);
-	reg = superio_inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
+	sio_data->select(sio_data, NCT6775_LD_ACPI);
+	reg = sio_data->inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
 	reg |= NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
 	reg &= ~NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
-	superio_exit(sio_data);
+	sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	sio_data->exit(sio_data);
 
 	data->valid = false;	/* Force cache refresh */
 error:
@@ -3562,20 +3567,20 @@ nct6775_check_fan_inputs(struct nct6775_data *data,
 	bool pwm6pin = false, pwm7pin = false;
 
 	/* Store SIO_REG_ENABLE for use during resume */
-	superio_select(sio_data, NCT6775_LD_HWM);
-	data->sio_reg_enable = superio_inb(sio_data, SIO_REG_ENABLE);
+	sio_data->select(sio_data, NCT6775_LD_HWM);
+	data->sio_reg_enable = sio_data->inb(sio_data, SIO_REG_ENABLE);
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind == nct6775) {
-		int cr2c = superio_inb(sio_data, 0x2c);
+		int cr2c = sio_data->inb(sio_data, 0x2c);
 
 		fan3pin = cr2c & BIT(6);
 		pwm3pin = cr2c & BIT(7);
 
 		/* On NCT6775, fan4 shares pins with the fdc interface */
-		fan4pin = !(superio_inb(sio_data, 0x2A) & 0x80);
+		fan4pin = !(sio_data->inb(sio_data, 0x2A) & 0x80);
 	} else if (data->kind == nct6776) {
-		bool gpok = superio_inb(sio_data, 0x27) & 0x80;
+		bool gpok = sio_data->inb(sio_data, 0x27) & 0x80;
 		const char *board_vendor, *board_name;
 
 		board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
@@ -3591,7 +3596,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data,
 			if (!strcmp(board_name, "Z77 Pro4-M")) {
 				if ((data->sio_reg_enable & 0xe0) != 0xe0) {
 					data->sio_reg_enable |= 0xe0;
-					superio_outb(sio_data, SIO_REG_ENABLE,
+					sio_data->outb(sio_data, SIO_REG_ENABLE,
 						     data->sio_reg_enable);
 				}
 			}
@@ -3600,32 +3605,32 @@ nct6775_check_fan_inputs(struct nct6775_data *data,
 		if (data->sio_reg_enable & 0x80)
 			fan3pin = gpok;
 		else
-			fan3pin = !(superio_inb(sio_data, 0x24) & 0x40);
+			fan3pin = !(sio_data->inb(sio_data, 0x24) & 0x40);
 
 		if (data->sio_reg_enable & 0x40)
 			fan4pin = gpok;
 		else
-			fan4pin = superio_inb(sio_data, 0x1C) & 0x01;
+			fan4pin = sio_data->inb(sio_data, 0x1C) & 0x01;
 
 		if (data->sio_reg_enable & 0x20)
 			fan5pin = gpok;
 		else
-			fan5pin = superio_inb(sio_data, 0x1C) & 0x02;
+			fan5pin = sio_data->inb(sio_data, 0x1C) & 0x02;
 
 		fan4min = fan4pin;
 		pwm3pin = fan3pin;
 	} else if (data->kind == nct6106) {
-		int cr24 = superio_inb(sio_data, 0x24);
+		int cr24 = sio_data->inb(sio_data, 0x24);
 
 		fan3pin = !(cr24 & 0x80);
 		pwm3pin = cr24 & 0x08;
 	} else if (data->kind == nct6116) {
-		int cr1a = superio_inb(sio_data, 0x1a);
-		int cr1b = superio_inb(sio_data, 0x1b);
-		int cr24 = superio_inb(sio_data, 0x24);
-		int cr2a = superio_inb(sio_data, 0x2a);
-		int cr2b = superio_inb(sio_data, 0x2b);
-		int cr2f = superio_inb(sio_data, 0x2f);
+		int cr1a = sio_data->inb(sio_data, 0x1a);
+		int cr1b = sio_data->inb(sio_data, 0x1b);
+		int cr24 = sio_data->inb(sio_data, 0x24);
+		int cr2a = sio_data->inb(sio_data, 0x2a);
+		int cr2b = sio_data->inb(sio_data, 0x2b);
+		int cr2f = sio_data->inb(sio_data, 0x2f);
 
 		fan3pin = !(cr2b & 0x10);
 		fan4pin = (cr2b & 0x80) ||			// pin 1(2)
@@ -3641,24 +3646,24 @@ nct6775_check_fan_inputs(struct nct6775_data *data,
 		 * NCT6779D, NCT6791D, NCT6792D, NCT6793D, NCT6795D, NCT6796D,
 		 * NCT6797D, NCT6798D
 		 */
-		int cr1a = superio_inb(sio_data, 0x1a);
-		int cr1b = superio_inb(sio_data, 0x1b);
-		int cr1c = superio_inb(sio_data, 0x1c);
-		int cr1d = superio_inb(sio_data, 0x1d);
-		int cr2a = superio_inb(sio_data, 0x2a);
-		int cr2b = superio_inb(sio_data, 0x2b);
-		int cr2d = superio_inb(sio_data, 0x2d);
-		int cr2f = superio_inb(sio_data, 0x2f);
+		int cr1a = sio_data->inb(sio_data, 0x1a);
+		int cr1b = sio_data->inb(sio_data, 0x1b);
+		int cr1c = sio_data->inb(sio_data, 0x1c);
+		int cr1d = sio_data->inb(sio_data, 0x1d);
+		int cr2a = sio_data->inb(sio_data, 0x2a);
+		int cr2b = sio_data->inb(sio_data, 0x2b);
+		int cr2d = sio_data->inb(sio_data, 0x2d);
+		int cr2f = sio_data->inb(sio_data, 0x2f);
 		bool dsw_en = cr2f & BIT(3);
 		bool ddr4_en = cr2f & BIT(4);
 		int cre0;
 		int creb;
 		int cred;
 
-		superio_select(sio_data, NCT6775_LD_12);
-		cre0 = superio_inb(sio_data, 0xe0);
-		creb = superio_inb(sio_data, 0xeb);
-		cred = superio_inb(sio_data, 0xed);
+		sio_data->select(sio_data, NCT6775_LD_12);
+		cre0 = sio_data->inb(sio_data, 0xe0);
+		creb = sio_data->inb(sio_data, 0xeb);
+		cred = sio_data->inb(sio_data, 0xed);
 
 		fan3pin = !(cr1c & BIT(5));
 		fan4pin = !(cr1c & BIT(6));
@@ -4516,11 +4521,11 @@ static int nct6775_probe(struct platform_device *pdev)
 	/* Initialize the chip */
 	nct6775_init_device(data);
 
-	err = superio_enter(sio_data);
+	err = sio_data->enter(sio_data);
 	if (err)
 		return err;
 
-	cr2a = superio_inb(sio_data, 0x2a);
+	cr2a = sio_data->inb(sio_data, 0x2a);
 	switch (data->kind) {
 	case nct6775:
 		data->have_vid = (cr2a & 0x40);
@@ -4546,16 +4551,16 @@ static int nct6775_probe(struct platform_device *pdev)
 	 * We can get the VID input values directly at logical device D 0xe3.
 	 */
 	if (data->have_vid) {
-		superio_select(sio_data, NCT6775_LD_VID);
-		data->vid = superio_inb(sio_data, 0xe3);
+		sio_data->select(sio_data, NCT6775_LD_VID);
+		data->vid = sio_data->inb(sio_data, 0xe3);
 		data->vrm = vid_which_vrm();
 	}
 
 	if (fan_debounce) {
 		u8 tmp;
 
-		superio_select(sio_data, NCT6775_LD_HWM);
-		tmp = superio_inb(sio_data,
+		sio_data->select(sio_data, NCT6775_LD_HWM);
+		tmp = sio_data->inb(sio_data,
 				  NCT6775_REG_CR_FAN_DEBOUNCE);
 		switch (data->kind) {
 		case nct6106:
@@ -4579,7 +4584,7 @@ static int nct6775_probe(struct platform_device *pdev)
 			tmp |= 0x7e;
 			break;
 		}
-		superio_outb(sio_data, NCT6775_REG_CR_FAN_DEBOUNCE,
+		sio_data->outb(sio_data, NCT6775_REG_CR_FAN_DEBOUNCE,
 			     tmp);
 		dev_info(&pdev->dev, "Enabled fan debounce for chip %s\n",
 			 data->name);
@@ -4587,7 +4592,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 	nct6775_check_fan_inputs(data, sio_data);
 
-	superio_exit(sio_data);
+	sio_data->exit(sio_data);
 
 	/* Read fan clock dividers immediately */
 	nct6775_init_fan_common(dev, data);
@@ -4631,10 +4636,10 @@ static void nct6791_enable_io_mapping(struct nct6775_sio_data *sio_data)
 {
 	int val;
 
-	val = superio_inb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
+	val = sio_data->inb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
 	if (val & 0x10) {
 		pr_info("Enabling hardware monitor logical device mappings.\n");
-		superio_outb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
+		sio_data->outb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
 			     val & ~0x10);
 	}
 }
@@ -4664,14 +4669,14 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 	mutex_lock(&data->update_lock);
 	data->bank = 0xff;		/* Force initial bank selection */
 
-	err = superio_enter(sio_data);
+	err = sio_data->enter(sio_data);
 	if (err)
 		goto abort;
 
-	superio_select(sio_data, NCT6775_LD_HWM);
-	reg = superio_inb(sio_data, SIO_REG_ENABLE);
+	sio_data->select(sio_data, NCT6775_LD_HWM);
+	reg = sio_data->inb(sio_data, SIO_REG_ENABLE);
 	if (reg != data->sio_reg_enable)
-		superio_outb(sio_data, SIO_REG_ENABLE, data->sio_reg_enable);
+		sio_data->outb(sio_data, SIO_REG_ENABLE, data->sio_reg_enable);
 
 	if (data->kind == nct6791 || data->kind == nct6792 ||
 	    data->kind == nct6793 || data->kind == nct6795 ||
@@ -4679,7 +4684,7 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 	    data->kind == nct6798)
 		nct6791_enable_io_mapping(sio_data);
 
-	superio_exit(sio_data);
+	sio_data->exit(sio_data);
 
 	/* Restore limits */
 	for (i = 0; i < data->in_num; i++) {
@@ -4744,12 +4749,12 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 
 	sio_data->sioreg = sioaddr;
 
-	err = superio_enter(sio_data);
+	err = sio_data->enter(sio_data);
 	if (err)
 		return err;
 
-	val = (superio_inb(sio_data, SIO_REG_DEVID) << 8) |
-		superio_inb(sio_data, SIO_REG_DEVID + 1);
+	val = (sio_data->inb(sio_data, SIO_REG_DEVID) << 8) |
+		sio_data->inb(sio_data, SIO_REG_DEVID + 1);
 	if (force_id && val != 0xffff)
 		val = force_id;
 
@@ -4793,26 +4798,26 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
-		superio_exit(sio_data);
+		sio_data->exit(sio_data);
 		return -ENODEV;
 	}
 
 	/* We have a known chip, find the HWM I/O address */
-	superio_select(sio_data, NCT6775_LD_HWM);
-	val = (superio_inb(sio_data, SIO_REG_ADDR) << 8)
-	    | superio_inb(sio_data, SIO_REG_ADDR + 1);
+	sio_data->select(sio_data, NCT6775_LD_HWM);
+	val = (sio_data->inb(sio_data, SIO_REG_ADDR) << 8)
+	    | sio_data->inb(sio_data, SIO_REG_ADDR + 1);
 	addr = val & IOREGION_ALIGNMENT;
 	if (addr == 0) {
 		pr_err("Refusing to enable a Super-I/O device with a base I/O port 0\n");
-		superio_exit(sio_data);
+		sio_data->exit(sio_data);
 		return -ENODEV;
 	}
 
 	/* Activate logical device if needed */
-	val = superio_inb(sio_data, SIO_REG_ENABLE);
+	val = sio_data->inb(sio_data, SIO_REG_ENABLE);
 	if (!(val & 0x01)) {
 		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
-		superio_outb(sio_data, SIO_REG_ENABLE, val | 0x01);
+		sio_data->outb(sio_data, SIO_REG_ENABLE, val | 0x01);
 	}
 
 	if (sio_data->kind == nct6791 || sio_data->kind == nct6792 ||
@@ -4821,7 +4826,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	    sio_data->kind == nct6798)
 		nct6791_enable_io_mapping(sio_data);
 
-	superio_exit(sio_data);
+	sio_data->exit(sio_data);
 	pr_info("Found %s or compatible chip at %#x:%#x\n",
 		nct6775_sio_names[sio_data->kind], sioaddr, addr);
 
@@ -4857,6 +4862,12 @@ static int __init sensors_nct6775_init(void)
 	 * nct6775 hardware monitor, and call probe()
 	 */
 	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
+		sio_data.outb = superio_outb;
+		sio_data.inb = superio_inb;
+		sio_data.select = superio_select;
+		sio_data.enter = superio_enter;
+		sio_data.exit = superio_exit;
+
 		address = nct6775_find(sioaddr[i], &sio_data);
 		if (address <= 0)
 			continue;
-- 
2.33.0

