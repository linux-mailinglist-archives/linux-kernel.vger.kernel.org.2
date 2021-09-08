Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A72404094
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhIHVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhIHVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:41:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA694C061575;
        Wed,  8 Sep 2021 14:40:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t19so7152532lfe.13;
        Wed, 08 Sep 2021 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkJ4oKkSZmRwwViblD0+0r+GMlZXZnEoCSpvzQKM8to=;
        b=h5Rck+/5FO1yn7JIvBcSsTdcp3vsaYFR7jOwVf5cfRUjbC7XLDOfVmH4sfkKoSO8DE
         geQ+9v5bl2ZDHWG9MIqJa6/13EgkXOa6AxVHF/AtY1iUzmVjbQ6JrQU/o9WYIZG/I6+W
         /GEKYkD8u6DxMCjmUxQZhKjQsw3W8hB9hGVgO0U2DWhFwkC5jfHFQTrxjmZYsvvakjtx
         Ef31ggVrVo+7O01TqnnOxWOHtDGMOfb3/DqH1r+fiYkTHXHNxqO4gosoRMUevZk+m1f1
         MF7tOSYUFgziB7/KOMS8Jb+m1xHKyyNWaBxk19Cit5BG8onRVsCqqMpaeIXkq7LwOCQ/
         ajkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkJ4oKkSZmRwwViblD0+0r+GMlZXZnEoCSpvzQKM8to=;
        b=npToKKrS7ioEM20StHZC5NnWJL0EDiuSYGFhMGuDWWL7WgPntqNCtIoqghu2oGXRYe
         RcuhmIRmG6x3pHl8WiEzYd606/xXGqkXIJtgOyYgeg7Uf3CEWvSI4gzxdy14DrIRX7EN
         rklAwn2k4ntXTXcSa4M468kR8kZ6BJTgtGyY7PyBo2B3FUJZAAkK6IgJ/b91XvrrO5Du
         PDV2WI5UI4mLyWJysHJ3DcEEiqrG60vJsnrGznNnMcyH5yLrCnP87DbwYCq1WTizbHbL
         rb25/obCrJw9xsvI2r2z7okjOhee0FtA6uvlaRAaXYNkUSue3WOhoOxeiWCvZTGIMojy
         v38w==
X-Gm-Message-State: AOAM533bEJEIeu2yWerelxdCiBrhf+cgCc3zIVBdtV7fiw/RYSRwAnxU
        J36/m5pL9ApgKsOvwtAV8as=
X-Google-Smtp-Source: ABdhPJwh6BYy6UNip4io720MQCKy18D+TxLwbG5vf3AujQEuov+mCFVPecYzmmoGIkWFySblTd3LJw==
X-Received: by 2002:ac2:598a:: with SMTP id w10mr129208lfn.179.1631137231216;
        Wed, 08 Sep 2021 14:40:31 -0700 (PDT)
Received: from localhost.localdomain ([178.94.31.92])
        by smtp.gmail.com with ESMTPSA id d12sm25105lfj.78.2021.09.08.14.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 14:40:30 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
To:     pauk.denis@gmail.com
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (nct6775) Use sio_data in superio_* (v2)
Date:   Thu,  9 Sep 2021 00:36:02 +0300
Message-Id: <20210908213605.9929-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange code for directly use struct nct6775_sio_data in superio_* 
functions

v2: split changes to separate patches

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775.c | 173 ++++++++++++++++++++++------------------
 1 file changed, 94 insertions(+), 79 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5bd15622a85f..3390de4c00f4 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -133,30 +133,43 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
 
+struct nct6775_sio_data {
+	int sioreg;
+	enum kinds kind;
+};
+
 static inline void
-superio_outb(int ioreg, int reg, int val)
+superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(reg, ioreg);
 	outb(val, ioreg + 1);
 }
 
 static inline int
-superio_inb(int ioreg, int reg)
+superio_inb(struct nct6775_sio_data *sio_data, int reg)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(reg, ioreg);
 	return inb(ioreg + 1);
 }
 
 static inline void
-superio_select(int ioreg, int ld)
+superio_select(struct nct6775_sio_data *sio_data, int ld)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(SIO_REG_LDSEL, ioreg);
 	outb(ld, ioreg + 1);
 }
 
 static inline int
-superio_enter(int ioreg)
+superio_enter(struct nct6775_sio_data *sio_data)
 {
+	int ioreg = sio_data->sioreg;
+
 	/*
 	 * Try to reserve <ioreg> and <ioreg + 1> for exclusive access.
 	 */
@@ -170,8 +183,10 @@ superio_enter(int ioreg)
 }
 
 static inline void
-superio_exit(int ioreg)
+superio_exit(struct nct6775_sio_data *sio_data)
 {
+	int ioreg = sio_data->sioreg;
+
 	outb(0xaa, ioreg);
 	outb(0x02, ioreg);
 	outb(0x02, ioreg + 1);
@@ -1217,11 +1232,6 @@ struct nct6775_data {
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
@@ -3410,6 +3420,7 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
+	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	int nr = to_sensor_dev_attr(attr)->index - INTRUSION_ALARM_BASE;
 	unsigned long val;
 	u8 reg;
@@ -3425,19 +3436,19 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	 * The CR registers are the same for all chips, and not all chips
 	 * support clearing the caseopen status through "regular" registers.
 	 */
-	ret = superio_enter(data->sioreg);
+	ret = superio_enter(sio_data);
 	if (ret) {
 		count = ret;
 		goto error;
 	}
 
-	superio_select(data->sioreg, NCT6775_LD_ACPI);
-	reg = superio_inb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
+	superio_select(sio_data, NCT6775_LD_ACPI);
+	reg = superio_inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
 	reg |= NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	superio_outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
 	reg &= ~NCT6775_CR_CASEOPEN_CLR_MASK[nr];
-	superio_outb(data->sioreg, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
-	superio_exit(data->sioreg);
+	superio_outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
+	superio_exit(sio_data);
 
 	data->valid = false;	/* Force cache refresh */
 error:
@@ -3542,29 +3553,29 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 }
 
 static void
-nct6775_check_fan_inputs(struct nct6775_data *data)
+nct6775_check_fan_inputs(struct nct6775_data *data,
+		struct nct6775_sio_data *sio_data)
 {
 	bool fan3pin = false, fan4pin = false, fan4min = false;
 	bool fan5pin = false, fan6pin = false, fan7pin = false;
 	bool pwm3pin = false, pwm4pin = false, pwm5pin = false;
 	bool pwm6pin = false, pwm7pin = false;
-	int sioreg = data->sioreg;
 
 	/* Store SIO_REG_ENABLE for use during resume */
-	superio_select(sioreg, NCT6775_LD_HWM);
-	data->sio_reg_enable = superio_inb(sioreg, SIO_REG_ENABLE);
+	superio_select(sio_data, NCT6775_LD_HWM);
+	data->sio_reg_enable = superio_inb(sio_data, SIO_REG_ENABLE);
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind == nct6775) {
-		int cr2c = superio_inb(sioreg, 0x2c);
+		int cr2c = superio_inb(sio_data, 0x2c);
 
 		fan3pin = cr2c & BIT(6);
 		pwm3pin = cr2c & BIT(7);
 
 		/* On NCT6775, fan4 shares pins with the fdc interface */
-		fan4pin = !(superio_inb(sioreg, 0x2A) & 0x80);
+		fan4pin = !(superio_inb(sio_data, 0x2A) & 0x80);
 	} else if (data->kind == nct6776) {
-		bool gpok = superio_inb(sioreg, 0x27) & 0x80;
+		bool gpok = superio_inb(sio_data, 0x27) & 0x80;
 		const char *board_vendor, *board_name;
 
 		board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
@@ -3580,7 +3591,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 			if (!strcmp(board_name, "Z77 Pro4-M")) {
 				if ((data->sio_reg_enable & 0xe0) != 0xe0) {
 					data->sio_reg_enable |= 0xe0;
-					superio_outb(sioreg, SIO_REG_ENABLE,
+					superio_outb(sio_data, SIO_REG_ENABLE,
 						     data->sio_reg_enable);
 				}
 			}
@@ -3589,32 +3600,32 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 		if (data->sio_reg_enable & 0x80)
 			fan3pin = gpok;
 		else
-			fan3pin = !(superio_inb(sioreg, 0x24) & 0x40);
+			fan3pin = !(superio_inb(sio_data, 0x24) & 0x40);
 
 		if (data->sio_reg_enable & 0x40)
 			fan4pin = gpok;
 		else
-			fan4pin = superio_inb(sioreg, 0x1C) & 0x01;
+			fan4pin = superio_inb(sio_data, 0x1C) & 0x01;
 
 		if (data->sio_reg_enable & 0x20)
 			fan5pin = gpok;
 		else
-			fan5pin = superio_inb(sioreg, 0x1C) & 0x02;
+			fan5pin = superio_inb(sio_data, 0x1C) & 0x02;
 
 		fan4min = fan4pin;
 		pwm3pin = fan3pin;
 	} else if (data->kind == nct6106) {
-		int cr24 = superio_inb(sioreg, 0x24);
+		int cr24 = superio_inb(sio_data, 0x24);
 
 		fan3pin = !(cr24 & 0x80);
 		pwm3pin = cr24 & 0x08;
 	} else if (data->kind == nct6116) {
-		int cr1a = superio_inb(sioreg, 0x1a);
-		int cr1b = superio_inb(sioreg, 0x1b);
-		int cr24 = superio_inb(sioreg, 0x24);
-		int cr2a = superio_inb(sioreg, 0x2a);
-		int cr2b = superio_inb(sioreg, 0x2b);
-		int cr2f = superio_inb(sioreg, 0x2f);
+		int cr1a = superio_inb(sio_data, 0x1a);
+		int cr1b = superio_inb(sio_data, 0x1b);
+		int cr24 = superio_inb(sio_data, 0x24);
+		int cr2a = superio_inb(sio_data, 0x2a);
+		int cr2b = superio_inb(sio_data, 0x2b);
+		int cr2f = superio_inb(sio_data, 0x2f);
 
 		fan3pin = !(cr2b & 0x10);
 		fan4pin = (cr2b & 0x80) ||			// pin 1(2)
@@ -3630,24 +3641,24 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
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
+		int cr1a = superio_inb(sio_data, 0x1a);
+		int cr1b = superio_inb(sio_data, 0x1b);
+		int cr1c = superio_inb(sio_data, 0x1c);
+		int cr1d = superio_inb(sio_data, 0x1d);
+		int cr2a = superio_inb(sio_data, 0x2a);
+		int cr2b = superio_inb(sio_data, 0x2b);
+		int cr2d = superio_inb(sio_data, 0x2d);
+		int cr2f = superio_inb(sio_data, 0x2f);
 		bool dsw_en = cr2f & BIT(3);
 		bool ddr4_en = cr2f & BIT(4);
 		int cre0;
 		int creb;
 		int cred;
 
-		superio_select(sioreg, NCT6775_LD_12);
-		cre0 = superio_inb(sioreg, 0xe0);
-		creb = superio_inb(sioreg, 0xeb);
-		cred = superio_inb(sioreg, 0xed);
+		superio_select(sio_data, NCT6775_LD_12);
+		cre0 = superio_inb(sio_data, 0xe0);
+		creb = superio_inb(sio_data, 0xeb);
+		cred = superio_inb(sio_data, 0xed);
 
 		fan3pin = !(cr1c & BIT(5));
 		fan4pin = !(cr1c & BIT(6));
@@ -3793,7 +3804,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	struct nct6775_data *data;
-	struct resource *res;
+	struct resource *res = NULL;
 	int i, s, err = 0;
 	int src, mask, available;
 	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
@@ -3806,6 +3817,9 @@ static int nct6775_probe(struct platform_device *pdev)
 	int num_attr_groups = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res)
+		return -EBUSY;
+
 	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
 				 DRVNAME))
 		return -EBUSY;
@@ -4502,11 +4516,11 @@ static int nct6775_probe(struct platform_device *pdev)
 	/* Initialize the chip */
 	nct6775_init_device(data);
 
-	err = superio_enter(sio_data->sioreg);
+	err = superio_enter(sio_data);
 	if (err)
 		return err;
 
-	cr2a = superio_inb(sio_data->sioreg, 0x2a);
+	cr2a = superio_inb(sio_data, 0x2a);
 	switch (data->kind) {
 	case nct6775:
 		data->have_vid = (cr2a & 0x40);
@@ -4532,16 +4546,16 @@ static int nct6775_probe(struct platform_device *pdev)
 	 * We can get the VID input values directly at logical device D 0xe3.
 	 */
 	if (data->have_vid) {
-		superio_select(sio_data->sioreg, NCT6775_LD_VID);
-		data->vid = superio_inb(sio_data->sioreg, 0xe3);
+		superio_select(sio_data, NCT6775_LD_VID);
+		data->vid = superio_inb(sio_data, 0xe3);
 		data->vrm = vid_which_vrm();
 	}
 
 	if (fan_debounce) {
 		u8 tmp;
 
-		superio_select(sio_data->sioreg, NCT6775_LD_HWM);
-		tmp = superio_inb(sio_data->sioreg,
+		superio_select(sio_data, NCT6775_LD_HWM);
+		tmp = superio_inb(sio_data,
 				  NCT6775_REG_CR_FAN_DEBOUNCE);
 		switch (data->kind) {
 		case nct6106:
@@ -4565,15 +4579,15 @@ static int nct6775_probe(struct platform_device *pdev)
 			tmp |= 0x7e;
 			break;
 		}
-		superio_outb(sio_data->sioreg, NCT6775_REG_CR_FAN_DEBOUNCE,
+		superio_outb(sio_data, NCT6775_REG_CR_FAN_DEBOUNCE,
 			     tmp);
 		dev_info(&pdev->dev, "Enabled fan debounce for chip %s\n",
 			 data->name);
 	}
 
-	nct6775_check_fan_inputs(data);
+	nct6775_check_fan_inputs(data, sio_data);
 
-	superio_exit(sio_data->sioreg);
+	superio_exit(sio_data);
 
 	/* Read fan clock dividers immediately */
 	nct6775_init_fan_common(dev, data);
@@ -4613,14 +4627,14 @@ static int nct6775_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static void nct6791_enable_io_mapping(int sioaddr)
+static void nct6791_enable_io_mapping(struct nct6775_sio_data *sio_data)
 {
 	int val;
 
-	val = superio_inb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
+	val = superio_inb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
 	if (val & 0x10) {
 		pr_info("Enabling hardware monitor logical device mappings.\n");
-		superio_outb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
+		superio_outb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
 			     val & ~0x10);
 	}
 }
@@ -4643,29 +4657,29 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
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
+	err = superio_enter(sio_data);
 	if (err)
 		goto abort;
 
-	superio_select(sioreg, NCT6775_LD_HWM);
-	reg = superio_inb(sioreg, SIO_REG_ENABLE);
+	superio_select(sio_data, NCT6775_LD_HWM);
+	reg = superio_inb(sio_data, SIO_REG_ENABLE);
 	if (reg != data->sio_reg_enable)
-		superio_outb(sioreg, SIO_REG_ENABLE, data->sio_reg_enable);
+		superio_outb(sio_data, SIO_REG_ENABLE, data->sio_reg_enable);
 
 	if (data->kind == nct6791 || data->kind == nct6792 ||
 	    data->kind == nct6793 || data->kind == nct6795 ||
 	    data->kind == nct6796 || data->kind == nct6797 ||
 	    data->kind == nct6798)
-		nct6791_enable_io_mapping(sioreg);
+		nct6791_enable_io_mapping(sio_data);
 
-	superio_exit(sioreg);
+	superio_exit(sio_data);
 
 	/* Restore limits */
 	for (i = 0; i < data->in_num; i++) {
@@ -4728,12 +4742,14 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	int err;
 	int addr;
 
-	err = superio_enter(sioaddr);
+	sio_data->sioreg = sioaddr;
+
+	err = superio_enter(sio_data);
 	if (err)
 		return err;
 
-	val = (superio_inb(sioaddr, SIO_REG_DEVID) << 8) |
-		superio_inb(sioaddr, SIO_REG_DEVID + 1);
+	val = (superio_inb(sio_data, SIO_REG_DEVID) << 8) |
+		superio_inb(sio_data, SIO_REG_DEVID + 1);
 	if (force_id && val != 0xffff)
 		val = force_id;
 
@@ -4777,38 +4793,37 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
-		superio_exit(sioaddr);
+		superio_exit(sio_data);
 		return -ENODEV;
 	}
 
 	/* We have a known chip, find the HWM I/O address */
-	superio_select(sioaddr, NCT6775_LD_HWM);
-	val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
-	    | superio_inb(sioaddr, SIO_REG_ADDR + 1);
+	superio_select(sio_data, NCT6775_LD_HWM);
+	val = (superio_inb(sio_data, SIO_REG_ADDR) << 8)
+	    | superio_inb(sio_data, SIO_REG_ADDR + 1);
 	addr = val & IOREGION_ALIGNMENT;
 	if (addr == 0) {
 		pr_err("Refusing to enable a Super-I/O device with a base I/O port 0\n");
-		superio_exit(sioaddr);
+		superio_exit(sio_data);
 		return -ENODEV;
 	}
 
 	/* Activate logical device if needed */
-	val = superio_inb(sioaddr, SIO_REG_ENABLE);
+	val = superio_inb(sio_data, SIO_REG_ENABLE);
 	if (!(val & 0x01)) {
 		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
-		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
+		superio_outb(sio_data, SIO_REG_ENABLE, val | 0x01);
 	}
 
 	if (sio_data->kind == nct6791 || sio_data->kind == nct6792 ||
 	    sio_data->kind == nct6793 || sio_data->kind == nct6795 ||
 	    sio_data->kind == nct6796 || sio_data->kind == nct6797 ||
 	    sio_data->kind == nct6798)
-		nct6791_enable_io_mapping(sioaddr);
+		nct6791_enable_io_mapping(sio_data);
 
-	superio_exit(sioaddr);
+	superio_exit(sio_data);
 	pr_info("Found %s or compatible chip at %#x:%#x\n",
 		nct6775_sio_names[sio_data->kind], sioaddr, addr);
-	sio_data->sioreg = sioaddr;
 
 	return addr;
 }
-- 
2.33.0

