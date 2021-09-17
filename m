Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E704100AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbhIQVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhIQVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:20:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C220DC061574;
        Fri, 17 Sep 2021 14:19:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g1so38707690lfj.12;
        Fri, 17 Sep 2021 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QU/gSfvrTlEI0VAxlhyF77wj/vF6Q07KQb2aU2V2KkY=;
        b=FFg3ZNncl0/QlBN0xg5srb2wwy2ZpiN4fxnIMxRNT2XIrm7ki4XaCo/YVqhnK2JiwR
         bXoGj87Yx5z1y+tizL4HlLYNNFC93mGBAypsv+MvU+RbheKF26ictKyDuKVNCKqPyXsO
         2y+HS77j62r6JsCM/W9Xk8xdm0HMEQEElwXuSMCSrh9aL3XZFK2GhdMb+tBkxxDk8OJz
         ylzxUAFcZOTJ1gOnZH9DqJoOjgTSqRPvvJ6THIypwONThktrVUGMf8b57duRnXJPMlte
         WV30jtNs37VXm9ElpMe9stIQHUlWVkzbJF+QVrc7ZUR0Vo28KnVPW8iCTQhocOjhBp8T
         QzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QU/gSfvrTlEI0VAxlhyF77wj/vF6Q07KQb2aU2V2KkY=;
        b=skH9zbQ8nMbaFR8ODO4xQpqRgJXbdtvnU17y/5ZhWG6otmw5GB/kOFXZcHXnK9WSi7
         jFx7vl3K2JL6+K85KSSvedpv539UJcQfWnAZ2MCpo5fp0zWednOH3U42RI91wW/xvF3X
         Z1QEW5Tx1aevQv1D7AKepzOu8PCkoOihIATVd1YjWsKmzKlEeW7NO3SfsFjPDeEPk+f8
         I54Ho9SPDWpoU0SSwf6nV/n5N02zQ4Hue33NjiTdZYv7dZnzkOOWTljNBSY3/rwtvlLt
         ZlS7PxASIn8kbG0iD5c4GmCt6t+LJQ/pg0dVzP5ASdIDwr53u5dudNF+AH7MVgpc0oVw
         lefA==
X-Gm-Message-State: AOAM531L6ycQ+/YgxJ1nLXMvTNyWGFqIyUAwpLFHZAEukurVmZ2D3kCq
        rSPtKIStuYCP0Zrn+7RFLyc=
X-Google-Smtp-Source: ABdhPJwj3osrQxV9JUBgBqoBeQEH4y3fH7CKyU2mKq8XcgRMg9e5TcHcXN5BUMX06egwwlB74Nhx7Q==
X-Received: by 2002:a19:c388:: with SMTP id t130mr9532401lff.601.1631913565991;
        Fri, 17 Sep 2021 14:19:25 -0700 (PDT)
Received: from localhost.localdomain (95-42-179-94.pool.ukrtel.net. [94.179.42.95])
        by smtp.gmail.com with ESMTPSA id h17sm196037lfg.258.2021.09.17.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:18:58 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Bernhard Seibold <mail@bernhard-seibold.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] hwmon: (nct6775) Use superio_*() function pointers in sio_data.
Date:   Sat, 18 Sep 2021 00:18:08 +0300
Message-Id: <20210917211811.39271-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917211811.39271-1-pauk.denis@gmail.com>
References: <20210917211811.39271-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for platform specific callbacks usage:
* Rearrange code for directly use struct nct6775_sio_data in superio_*()
  functions.
* Use superio function pointers in nct6775_sio_data struct instead direct
  calls.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---
Changes in v8:
  - Without changes.

Changes in v7:
  - Without changes.
  
Changes in v6:
  - Split patch with replace direct calls to function pointers.

Changes in v5:
  - Without changes.

Changes in v4:
  - Fix naming conflict with inb, outb by add sio prefix to callbacks in
    nct6775_sio_data.

Changes in v3:
  - Use nct6775 function pointers in struct nct6775_data instead direct calls.
  - make function declarations one line.

Changes in v2:
  - Split changes to separate patches.
  - Rearrange code for directly use struct nct6775_sio_data in superio_*()
    functions.
---
 drivers/hwmon/nct6775.c | 189 ++++++++++++++++++++++------------------
 1 file changed, 104 insertions(+), 85 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5bd15622a85f..9b503c88e20d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -133,30 +133,46 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
 
-static inline void
-superio_outb(int ioreg, int reg, int val)
+struct nct6775_sio_data {
+	int sioreg;
+	enum kinds kind;
+
+	/* superio_() callbacks  */
+	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
+	int (*sio_inb)(struct nct6775_sio_data *sio_data, int reg);
+	void (*sio_select)(struct nct6775_sio_data *sio_data, int ld);
+	int (*sio_enter)(struct nct6775_sio_data *sio_data);
+	void (*sio_exit)(struct nct6775_sio_data *sio_data);
+};
+
+static void superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(reg, ioreg);
 	outb(val, ioreg + 1);
 }
 
-static inline int
-superio_inb(int ioreg, int reg)
+static int superio_inb(struct nct6775_sio_data *sio_data, int reg)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(reg, ioreg);
 	return inb(ioreg + 1);
 }
 
-static inline void
-superio_select(int ioreg, int ld)
+static void superio_select(struct nct6775_sio_data *sio_data, int ld)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(SIO_REG_LDSEL, ioreg);
 	outb(ld, ioreg + 1);
 }
 
-static inline int
-superio_enter(int ioreg)
+static int superio_enter(struct nct6775_sio_data *sio_data)
 {
+	int ioreg = sio_data->sioreg;
+
 	/*
 	 * Try to reserve <ioreg> and <ioreg + 1> for exclusive access.
 	 */
@@ -169,9 +185,10 @@ superio_enter(int ioreg)
 	return 0;
 }
 
-static inline void
-superio_exit(int ioreg)
+static void superio_exit(struct nct6775_sio_data *sio_data)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(0xaa, ioreg);
 	outb(0x02, ioreg);
 	outb(0x02, ioreg + 1);
@@ -1217,11 +1234,6 @@ struct nct6775_data {
 	u8 sio_reg_enable;
 };
 
-struct nct6775_sio_data {
-	int sioreg;
-	enum kinds kind;
-};
-
 struct sensor_device_template {
 	struct device_attribute dev_attr;
 	union {
@@ -3410,6 +3422,7 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
+	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	int nr = to_sensor_dev_attr(attr)->index - INTRUSION_ALARM_BASE;
 	unsigned long val;
 	u8 reg;
@@ -3425,19 +3438,19 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	 * The CR registers are the same for all chips, and not all chips
 	 * support clearing the caseopen status through "regular" registers.
 	 */
-	ret = superio_enter(data->sioreg);
+	ret = sio_data->sio_enter(sio_data);
 	if (ret) {
 		count = ret;
 		goto error;
 	}
 
-	superio_select(data->sioreg, NCT6775_LD_ACPI);
-	reg = superio_inb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
+	sio_data->sio_select(sio_data, NCT6775_LD_ACPI);
+	reg = sio_data->sio_inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
 	reg |= NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	sio_data->sio_outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
 	reg &= ~NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
-	superio_exit(data->sioreg);
+	sio_data->sio_outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	sio_data->sio_exit(sio_data);
 
 	data->valid = false;	/* Force cache refresh */
 error:
@@ -3542,29 +3555,28 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 }
 
 static void
-nct6775_check_fan_inputs(struct nct6775_data *data)
+nct6775_check_fan_inputs(struct nct6775_data *data, struct nct6775_sio_data *sio_data)
 {
 	bool fan3pin = false, fan4pin = false, fan4min = false;
 	bool fan5pin = false, fan6pin = false, fan7pin = false;
 	bool pwm3pin = false, pwm4pin = false, pwm5pin = false;
 	bool pwm6pin = false, pwm7pin = false;
-	int sioreg = data->sioreg;
 
 	/* Store SIO_REG_ENABLE for use during resume */
-	superio_select(sioreg, NCT6775_LD_HWM);
-	data->sio_reg_enable = superio_inb(sioreg, SIO_REG_ENABLE);
+	sio_data->sio_select(sio_data, NCT6775_LD_HWM);
+	data->sio_reg_enable = sio_data->sio_inb(sio_data, SIO_REG_ENABLE);
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind == nct6775) {
-		int cr2c = superio_inb(sioreg, 0x2c);
+		int cr2c = sio_data->sio_inb(sio_data, 0x2c);
 
 		fan3pin = cr2c & BIT(6);
 		pwm3pin = cr2c & BIT(7);
 
 		/* On NCT6775, fan4 shares pins with the fdc interface */
-		fan4pin = !(superio_inb(sioreg, 0x2A) & 0x80);
+		fan4pin = !(sio_data->sio_inb(sio_data, 0x2A) & 0x80);
 	} else if (data->kind == nct6776) {
-		bool gpok = superio_inb(sioreg, 0x27) & 0x80;
+		bool gpok = sio_data->sio_inb(sio_data, 0x27) & 0x80;
 		const char *board_vendor, *board_name;
 
 		board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
@@ -3580,7 +3592,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 			if (!strcmp(board_name, "Z77 Pro4-M")) {
 				if ((data->sio_reg_enable & 0xe0) != 0xe0) {
 					data->sio_reg_enable |= 0xe0;
-					superio_outb(sioreg, SIO_REG_ENABLE,
+					sio_data->sio_outb(sio_data, SIO_REG_ENABLE,
 						     data->sio_reg_enable);
 				}
 			}
@@ -3589,32 +3601,32 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 		if (data->sio_reg_enable & 0x80)
 			fan3pin = gpok;
 		else
-			fan3pin = !(superio_inb(sioreg, 0x24) & 0x40);
+			fan3pin = !(sio_data->sio_inb(sio_data, 0x24) & 0x40);
 
 		if (data->sio_reg_enable & 0x40)
 			fan4pin = gpok;
 		else
-			fan4pin = superio_inb(sioreg, 0x1C) & 0x01;
+			fan4pin = sio_data->sio_inb(sio_data, 0x1C) & 0x01;
 
 		if (data->sio_reg_enable & 0x20)
 			fan5pin = gpok;
 		else
-			fan5pin = superio_inb(sioreg, 0x1C) & 0x02;
+			fan5pin = sio_data->sio_inb(sio_data, 0x1C) & 0x02;
 
 		fan4min = fan4pin;
 		pwm3pin = fan3pin;
 	} else if (data->kind == nct6106) {
-		int cr24 = superio_inb(sioreg, 0x24);
+		int cr24 = sio_data->sio_inb(sio_data, 0x24);
 
 		fan3pin = !(cr24 & 0x80);
 		pwm3pin = cr24 & 0x08;
 	} else if (data->kind == nct6116) {
-		int cr1a = superio_inb(sioreg, 0x1a);
-		int cr1b = superio_inb(sioreg, 0x1b);
-		int cr24 = superio_inb(sioreg, 0x24);
-		int cr2a = superio_inb(sioreg, 0x2a);
-		int cr2b = superio_inb(sioreg, 0x2b);
-		int cr2f = superio_inb(sioreg, 0x2f);
+		int cr1a = sio_data->sio_inb(sio_data, 0x1a);
+		int cr1b = sio_data->sio_inb(sio_data, 0x1b);
+		int cr24 = sio_data->sio_inb(sio_data, 0x24);
+		int cr2a = sio_data->sio_inb(sio_data, 0x2a);
+		int cr2b = sio_data->sio_inb(sio_data, 0x2b);
+		int cr2f = sio_data->sio_inb(sio_data, 0x2f);
 
 		fan3pin = !(cr2b & 0x10);
 		fan4pin = (cr2b & 0x80) ||			// pin 1(2)
@@ -3630,24 +3642,24 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 		 * NCT6779D, NCT6791D, NCT6792D, NCT6793D, NCT6795D, NCT6796D,
 		 * NCT6797D, NCT6798D
 		 */
-		int cr1a = superio_inb(sioreg, 0x1a);
-		int cr1b = superio_inb(sioreg, 0x1b);
-		int cr1c = superio_inb(sioreg, 0x1c);
-		int cr1d = superio_inb(sioreg, 0x1d);
-		int cr2a = superio_inb(sioreg, 0x2a);
-		int cr2b = superio_inb(sioreg, 0x2b);
-		int cr2d = superio_inb(sioreg, 0x2d);
-		int cr2f = superio_inb(sioreg, 0x2f);
+		int cr1a = sio_data->sio_inb(sio_data, 0x1a);
+		int cr1b = sio_data->sio_inb(sio_data, 0x1b);
+		int cr1c = sio_data->sio_inb(sio_data, 0x1c);
+		int cr1d = sio_data->sio_inb(sio_data, 0x1d);
+		int cr2a = sio_data->sio_inb(sio_data, 0x2a);
+		int cr2b = sio_data->sio_inb(sio_data, 0x2b);
+		int cr2d = sio_data->sio_inb(sio_data, 0x2d);
+		int cr2f = sio_data->sio_inb(sio_data, 0x2f);
 		bool dsw_en = cr2f & BIT(3);
 		bool ddr4_en = cr2f & BIT(4);
 		int cre0;
 		int creb;
 		int cred;
 
-		superio_select(sioreg, NCT6775_LD_12);
-		cre0 = superio_inb(sioreg, 0xe0);
-		creb = superio_inb(sioreg, 0xeb);
-		cred = superio_inb(sioreg, 0xed);
+		sio_data->sio_select(sio_data, NCT6775_LD_12);
+		cre0 = sio_data->sio_inb(sio_data, 0xe0);
+		creb = sio_data->sio_inb(sio_data, 0xeb);
+		cred = sio_data->sio_inb(sio_data, 0xed);
 
 		fan3pin = !(cr1c & BIT(5));
 		fan4pin = !(cr1c & BIT(6));
@@ -4502,11 +4514,11 @@ static int nct6775_probe(struct platform_device *pdev)
 	/* Initialize the chip */
 	nct6775_init_device(data);
 
-	err = superio_enter(sio_data->sioreg);
+	err = sio_data->sio_enter(sio_data);
 	if (err)
 		return err;
 
-	cr2a = superio_inb(sio_data->sioreg, 0x2a);
+	cr2a = sio_data->sio_inb(sio_data, 0x2a);
 	switch (data->kind) {
 	case nct6775:
 		data->have_vid = (cr2a & 0x40);
@@ -4532,17 +4544,17 @@ static int nct6775_probe(struct platform_device *pdev)
 	 * We can get the VID input values directly at logical device D 0xe3.
 	 */
 	if (data->have_vid) {
-		superio_select(sio_data->sioreg, NCT6775_LD_VID);
-		data->vid = superio_inb(sio_data->sioreg, 0xe3);
+		sio_data->sio_select(sio_data, NCT6775_LD_VID);
+		data->vid = sio_data->sio_inb(sio_data, 0xe3);
 		data->vrm = vid_which_vrm();
 	}
 
 	if (fan_debounce) {
 		u8 tmp;
 
-		superio_select(sio_data->sioreg, NCT6775_LD_HWM);
-		tmp = superio_inb(sio_data->sioreg,
-				  NCT6775_REG_CR_FAN_DEBOUNCE);
+		sio_data->sio_select(sio_data, NCT6775_LD_HWM);
+		tmp = sio_data->sio_inb(sio_data,
+				    NCT6775_REG_CR_FAN_DEBOUNCE);
 		switch (data->kind) {
 		case nct6106:
 		case nct6116:
@@ -4565,15 +4577,15 @@ static int nct6775_probe(struct platform_device *pdev)
 			tmp |= 0x7e;
 			break;
 		}
-		superio_outb(sio_data->sioreg, NCT6775_REG_CR_FAN_DEBOUNCE,
+		sio_data->sio_outb(sio_data, NCT6775_REG_CR_FAN_DEBOUNCE,
 			     tmp);
 		dev_info(&pdev->dev, "Enabled fan debounce for chip %s\n",
 			 data->name);
 	}
 
-	nct6775_check_fan_inputs(data);
+	nct6775_check_fan_inputs(data, sio_data);
 
-	superio_exit(sio_data->sioreg);
+	sio_data->sio_exit(sio_data);
 
 	/* Read fan clock dividers immediately */
 	nct6775_init_fan_common(dev, data);
@@ -4613,15 +4625,15 @@ static int nct6775_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static void nct6791_enable_io_mapping(int sioaddr)
+static void nct6791_enable_io_mapping(struct nct6775_sio_data *sio_data)
 {
 	int val;
 
-	val = superio_inb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
+	val = sio_data->sio_inb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
 	if (val & 0x10) {
 		pr_info("Enabling hardware monitor logical device mappings.\n");
-		superio_outb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
-			     val & ~0x10);
+		sio_data->sio_outb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
+			       val & ~0x10);
 	}
 }
 
@@ -4643,29 +4655,29 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
 static int __maybe_unused nct6775_resume(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int sioreg = data->sioreg;
+	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	int i, j, err = 0;
 	u8 reg;
 
 	mutex_lock(&data->update_lock);
 	data->bank = 0xff;		/* Force initial bank selection */
 
-	err = superio_enter(sioreg);
+	err = sio_data->sio_enter(sio_data);
 	if (err)
 		goto abort;
 
-	superio_select(sioreg, NCT6775_LD_HWM);
-	reg = superio_inb(sioreg, SIO_REG_ENABLE);
+	sio_data->sio_select(sio_data, NCT6775_LD_HWM);
+	reg = sio_data->sio_inb(sio_data, SIO_REG_ENABLE);
 	if (reg != data->sio_reg_enable)
-		superio_outb(sioreg, SIO_REG_ENABLE, data->sio_reg_enable);
+		sio_data->sio_outb(sio_data, SIO_REG_ENABLE, data->sio_reg_enable);
 
 	if (data->kind == nct6791 || data->kind == nct6792 ||
 	    data->kind == nct6793 || data->kind == nct6795 ||
 	    data->kind == nct6796 || data->kind == nct6797 ||
 	    data->kind == nct6798)
-		nct6791_enable_io_mapping(sioreg);
+		nct6791_enable_io_mapping(sio_data);
 
-	superio_exit(sioreg);
+	sio_data->sio_exit(sio_data);
 
 	/* Restore limits */
 	for (i = 0; i < data->in_num; i++) {
@@ -4728,12 +4740,14 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	int err;
 	int addr;
 
-	err = superio_enter(sioaddr);
+	sio_data->sioreg = sioaddr;
+
+	err = sio_data->sio_enter(sio_data);
 	if (err)
 		return err;
 
-	val = (superio_inb(sioaddr, SIO_REG_DEVID) << 8) |
-		superio_inb(sioaddr, SIO_REG_DEVID + 1);
+	val = (sio_data->sio_inb(sio_data, SIO_REG_DEVID) << 8) |
+		sio_data->sio_inb(sio_data, SIO_REG_DEVID + 1);
 	if (force_id && val != 0xffff)
 		val = force_id;
 
@@ -4777,38 +4791,37 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
-		superio_exit(sioaddr);
+		sio_data->sio_exit(sio_data);
 		return -ENODEV;
 	}
 
 	/* We have a known chip, find the HWM I/O address */
-	superio_select(sioaddr, NCT6775_LD_HWM);
-	val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
-	    | superio_inb(sioaddr, SIO_REG_ADDR + 1);
+	sio_data->sio_select(sio_data, NCT6775_LD_HWM);
+	val = (sio_data->sio_inb(sio_data, SIO_REG_ADDR) << 8)
+	    | sio_data->sio_inb(sio_data, SIO_REG_ADDR + 1);
 	addr = val & IOREGION_ALIGNMENT;
 	if (addr == 0) {
 		pr_err("Refusing to enable a Super-I/O device with a base I/O port 0\n");
-		superio_exit(sioaddr);
+		sio_data->sio_exit(sio_data);
 		return -ENODEV;
 	}
 
 	/* Activate logical device if needed */
-	val = superio_inb(sioaddr, SIO_REG_ENABLE);
+	val = sio_data->sio_inb(sio_data, SIO_REG_ENABLE);
 	if (!(val & 0x01)) {
 		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
-		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
+		sio_data->sio_outb(sio_data, SIO_REG_ENABLE, val | 0x01);
 	}
 
 	if (sio_data->kind == nct6791 || sio_data->kind == nct6792 ||
 	    sio_data->kind == nct6793 || sio_data->kind == nct6795 ||
 	    sio_data->kind == nct6796 || sio_data->kind == nct6797 ||
 	    sio_data->kind == nct6798)
-		nct6791_enable_io_mapping(sioaddr);
+		nct6791_enable_io_mapping(sio_data);
 
-	superio_exit(sioaddr);
+	sio_data->sio_exit(sio_data);
 	pr_info("Found %s or compatible chip at %#x:%#x\n",
 		nct6775_sio_names[sio_data->kind], sioaddr, addr);
-	sio_data->sioreg = sioaddr;
 
 	return addr;
 }
@@ -4842,6 +4855,12 @@ static int __init sensors_nct6775_init(void)
 	 * nct6775 hardware monitor, and call probe()
 	 */
 	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
+		sio_data.sio_outb = superio_outb;
+		sio_data.sio_inb = superio_inb;
+		sio_data.sio_select = superio_select;
+		sio_data.sio_enter = superio_enter;
+		sio_data.sio_exit = superio_exit;
+
 		address = nct6775_find(sioaddr[i], &sio_data);
 		if (address <= 0)
 			continue;
-- 
2.33.0

