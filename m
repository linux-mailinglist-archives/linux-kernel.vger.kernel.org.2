Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541C54081BE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 23:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhILVEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbhILVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 17:04:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49D6C061574;
        Sun, 12 Sep 2021 14:02:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t19so16436204ejr.8;
        Sun, 12 Sep 2021 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygnM6wQo5ARC0NiGydZXcLDMuGGpn12joUFMloSzpL8=;
        b=oxifrtik0GpTLneFBcjnvbrsa1QTrpU3sb4Sklwo/zHoaFKhs3QC+sKVuy7KJG1Jdo
         ni0Q4lKTZslTLdf4kbjanYFQYdWIzbh/Q3XW7EHQ6LMCDHcsskFASu8n7hPRVm0P/Cgq
         061sQtYVzpv2LNKYfIJZyzMvIBj0bnQEc/B4TFbvTeRYS3wdtTiN04HFBmPTmptfMUFc
         irjRoa4NhCIbToRO8swx8A66uLITH03JDtLdWbGiI9ZE9FfDFlh3RgHf5L173z3KoK9J
         iRO1Wbggxr7/z/Hrgwy0biBXLG3NUKFiYht0wD3FUs0HaXky6Z3/I+OmqsAh1IgsfoHd
         JpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygnM6wQo5ARC0NiGydZXcLDMuGGpn12joUFMloSzpL8=;
        b=jGnfvjZQRY4HneDpinBDM0uXqhxNFwJZN2Pl8qeB1L7z7VFyjk2sl2vTBd1LPuZ0V9
         0vnrfy8mYpJo3jyeeUccjOjXeZWzBENvXfEl07u6n0HMCMvaHVe8WyYdYxiN0ugeD4cr
         PuYDRhqrm+LR7iF+ZDrikywO7SgvcubgegJHOx5iG6Ek/7iD2Iyp6oawL0+uKl/3qkvm
         r4IRlr+L78ixTx46jsHkdHOuc+C8iKg7jCEykhjXniNZxs+qMarD0strJ84cJeWmU/AT
         dae7Gjf9keLRT93yvS1Jf/bokqtxpjEzMon63SHCGUpTDAysFcd96rGK8HzEenYvvZJO
         UVaw==
X-Gm-Message-State: AOAM531JO2ITRl349wh2oxC42ZNDzR8aXqBIb/yq3o2KBDxWDd7mRVsB
        JHu+tbiexuja1oE54bryYYBeegluD402dg==
X-Google-Smtp-Source: ABdhPJzg1+jwxSq6Ps080ADWPoqI4qy6rBrCm6+2Wv7CQhCx17fqtqOf0/tAEsMaiNPylhgKKNUmgw==
X-Received: by 2002:a17:906:660f:: with SMTP id b15mr9206280ejp.491.1631480577127;
        Sun, 12 Sep 2021 14:02:57 -0700 (PDT)
Received: from localhost.localdomain (146-25-94-178.pool.ukrtel.net. [178.94.25.146])
        by smtp.gmail.com with ESMTPSA id z97sm2821140ede.72.2021.09.12.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 14:02:56 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Bernhard Seibold <mail@bernhard-seibold.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] hwmon: (nct6775) Use sio_data in superio_*().
Date:   Mon, 13 Sep 2021 00:02:42 +0300
Message-Id: <20210912210244.184521-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210912210244.184521-1-pauk.denis@gmail.com>
References: <20210912210244.184521-1-pauk.denis@gmail.com>
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
* Use nct6775 function pointers in struct nct6775_data instead direct
  calls.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>

---
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
 drivers/hwmon/nct6775.c | 465 +++++++++++++++++++++-------------------
 1 file changed, 247 insertions(+), 218 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5bd15622a85f..d813a7478f59 100644
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
@@ -1215,11 +1232,10 @@ struct nct6775_data {
 	u8 fandiv1;
 	u8 fandiv2;
 	u8 sio_reg_enable;
-};
 
-struct nct6775_sio_data {
-	int sioreg;
-	enum kinds kind;
+	/* nct6775_*() callbacks  */
+	u16 (*read_value)(struct nct6775_data *data, u16 reg);
+	int (*write_value)(struct nct6775_data *data, u16 reg, u16 value);
 };
 
 struct sensor_device_template {
@@ -1459,7 +1475,7 @@ static u16 nct6775_read_temp(struct nct6775_data *data, u16 reg)
 {
 	u16 res;
 
-	res = nct6775_read_value(data, reg);
+	res = data->read_value(data, reg);
 	if (!is_word_sized(data, reg))
 		res <<= 8;
 
@@ -1470,7 +1486,7 @@ static int nct6775_write_temp(struct nct6775_data *data, u16 reg, u16 value)
 {
 	if (!is_word_sized(data, reg))
 		value >>= 8;
-	return nct6775_write_value(data, reg, value);
+	return data->write_value(data, reg, value);
 }
 
 /* This function assumes that the caller holds data->update_lock */
@@ -1480,24 +1496,24 @@ static void nct6775_write_fan_div(struct nct6775_data *data, int nr)
 
 	switch (nr) {
 	case 0:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV1) & 0x70)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV1) & 0x70)
 		    | (data->fan_div[0] & 0x7);
-		nct6775_write_value(data, NCT6775_REG_FANDIV1, reg);
+		data->write_value(data, NCT6775_REG_FANDIV1, reg);
 		break;
 	case 1:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV1) & 0x7)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV1) & 0x7)
 		    | ((data->fan_div[1] << 4) & 0x70);
-		nct6775_write_value(data, NCT6775_REG_FANDIV1, reg);
+		data->write_value(data, NCT6775_REG_FANDIV1, reg);
 		break;
 	case 2:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV2) & 0x70)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV2) & 0x70)
 		    | (data->fan_div[2] & 0x7);
-		nct6775_write_value(data, NCT6775_REG_FANDIV2, reg);
+		data->write_value(data, NCT6775_REG_FANDIV2, reg);
 		break;
 	case 3:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV2) & 0x7)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV2) & 0x7)
 		    | ((data->fan_div[3] << 4) & 0x70);
-		nct6775_write_value(data, NCT6775_REG_FANDIV2, reg);
+		data->write_value(data, NCT6775_REG_FANDIV2, reg);
 		break;
 	}
 }
@@ -1512,10 +1528,10 @@ static void nct6775_update_fan_div(struct nct6775_data *data)
 {
 	u8 i;
 
-	i = nct6775_read_value(data, NCT6775_REG_FANDIV1);
+	i = data->read_value(data, NCT6775_REG_FANDIV1);
 	data->fan_div[0] = i & 0x7;
 	data->fan_div[1] = (i & 0x70) >> 4;
-	i = nct6775_read_value(data, NCT6775_REG_FANDIV2);
+	i = data->read_value(data, NCT6775_REG_FANDIV2);
 	data->fan_div[2] = i & 0x7;
 	if (data->has_fan & BIT(3))
 		data->fan_div[3] = (i & 0x70) >> 4;
@@ -1563,11 +1579,11 @@ static void nct6775_init_fan_common(struct device *dev,
 	 */
 	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		if (data->has_fan_min & BIT(i)) {
-			reg = nct6775_read_value(data, data->REG_FAN_MIN[i]);
+			reg = data->read_value(data, data->REG_FAN_MIN[i]);
 			if (!reg)
-				nct6775_write_value(data, data->REG_FAN_MIN[i],
-						    data->has_fan_div ? 0xff
-								      : 0xff1f);
+				data->write_value(data, data->REG_FAN_MIN[i],
+						  data->has_fan_div ? 0xff
+								    : 0xff1f);
 		}
 	}
 }
@@ -1611,8 +1627,8 @@ static void nct6775_select_fan_div(struct device *dev,
 			}
 			if (fan_min != data->fan_min[nr]) {
 				data->fan_min[nr] = fan_min;
-				nct6775_write_value(data, data->REG_FAN_MIN[nr],
-						    fan_min);
+				data->write_value(data, data->REG_FAN_MIN[nr],
+						  fan_min);
 			}
 		}
 		data->fan_div[nr] = fan_div;
@@ -1632,15 +1648,15 @@ static void nct6775_update_pwm(struct device *dev)
 			continue;
 
 		duty_is_dc = data->REG_PWM_MODE[i] &&
-		  (nct6775_read_value(data, data->REG_PWM_MODE[i])
+		  (data->read_value(data, data->REG_PWM_MODE[i])
 		   & data->PWM_MODE_MASK[i]);
 		data->pwm_mode[i] = !duty_is_dc;
 
-		fanmodecfg = nct6775_read_value(data, data->REG_FAN_MODE[i]);
+		fanmodecfg = data->read_value(data, data->REG_FAN_MODE[i]);
 		for (j = 0; j < ARRAY_SIZE(data->REG_PWM); j++) {
 			if (data->REG_PWM[j] && data->REG_PWM[j][i]) {
 				data->pwm[j][i]
-				  = nct6775_read_value(data,
+				  = data->read_value(data,
 						       data->REG_PWM[j][i]);
 			}
 		}
@@ -1656,17 +1672,17 @@ static void nct6775_update_pwm(struct device *dev)
 			u8 t = fanmodecfg & 0x0f;
 
 			if (data->REG_TOLERANCE_H) {
-				t |= (nct6775_read_value(data,
+				t |= (data->read_value(data,
 				      data->REG_TOLERANCE_H[i]) & 0x70) >> 1;
 			}
 			data->target_speed_tolerance[i] = t;
 		}
 
 		data->temp_tolerance[1][i] =
-			nct6775_read_value(data,
-					data->REG_CRITICAL_TEMP_TOLERANCE[i]);
+			data->read_value(data,
+					 data->REG_CRITICAL_TEMP_TOLERANCE[i]);
 
-		reg = nct6775_read_value(data, data->REG_TEMP_SEL[i]);
+		reg = data->read_value(data, data->REG_TEMP_SEL[i]);
 		data->pwm_temp_sel[i] = reg & 0x1f;
 		/* If fan can stop, report floor as 0 */
 		if (reg & 0x80)
@@ -1675,7 +1691,7 @@ static void nct6775_update_pwm(struct device *dev)
 		if (!data->REG_WEIGHT_TEMP_SEL[i])
 			continue;
 
-		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
+		reg = data->read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
 		data->pwm_weight_temp_sel[i] = reg & 0x1f;
 		/* If weight is disabled, report weight source as 0 */
 		if (!(reg & 0x80))
@@ -1684,8 +1700,8 @@ static void nct6775_update_pwm(struct device *dev)
 		/* Weight temp data */
 		for (j = 0; j < ARRAY_SIZE(data->weight_temp); j++) {
 			data->weight_temp[j][i]
-			  = nct6775_read_value(data,
-					       data->REG_WEIGHT_TEMP[j][i]);
+			  = data->read_value(data,
+					     data->REG_WEIGHT_TEMP[j][i]);
 		}
 	}
 }
@@ -1703,10 +1719,10 @@ static void nct6775_update_pwm_limits(struct device *dev)
 
 		for (j = 0; j < ARRAY_SIZE(data->fan_time); j++) {
 			data->fan_time[j][i] =
-			  nct6775_read_value(data, data->REG_FAN_TIME[j][i]);
+			  data->read_value(data, data->REG_FAN_TIME[j][i]);
 		}
 
-		reg_t = nct6775_read_value(data, data->REG_TARGET[i]);
+		reg_t = data->read_value(data, data->REG_TARGET[i]);
 		/* Update only in matching mode or if never updated */
 		if (!data->target_temp[i] ||
 		    data->pwm_enable[i] == thermal_cruise)
@@ -1714,7 +1730,7 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		if (!data->target_speed[i] ||
 		    data->pwm_enable[i] == speed_cruise) {
 			if (data->REG_TOLERANCE_H) {
-				reg_t |= (nct6775_read_value(data,
+				reg_t |= (data->read_value(data,
 					data->REG_TOLERANCE_H[i]) & 0x0f) << 8;
 			}
 			data->target_speed[i] = reg_t;
@@ -1722,21 +1738,21 @@ static void nct6775_update_pwm_limits(struct device *dev)
 
 		for (j = 0; j < data->auto_pwm_num; j++) {
 			data->auto_pwm[i][j] =
-			  nct6775_read_value(data,
-					     NCT6775_AUTO_PWM(data, i, j));
+			  data->read_value(data,
+					   NCT6775_AUTO_PWM(data, i, j));
 			data->auto_temp[i][j] =
-			  nct6775_read_value(data,
-					     NCT6775_AUTO_TEMP(data, i, j));
+			  data->read_value(data,
+					   NCT6775_AUTO_TEMP(data, i, j));
 		}
 
 		/* critical auto_pwm temperature data */
 		data->auto_temp[i][data->auto_pwm_num] =
-			nct6775_read_value(data, data->REG_CRITICAL_TEMP[i]);
+			data->read_value(data, data->REG_CRITICAL_TEMP[i]);
 
 		switch (data->kind) {
 		case nct6775:
-			reg = nct6775_read_value(data,
-						 NCT6775_REG_CRITICAL_ENAB[i]);
+			reg = data->read_value(data,
+					       NCT6775_REG_CRITICAL_ENAB[i]);
 			data->auto_pwm[i][data->auto_pwm_num] =
 						(reg & 0x02) ? 0xff : 0x00;
 			break;
@@ -1753,10 +1769,10 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		case nct6796:
 		case nct6797:
 		case nct6798:
-			reg = nct6775_read_value(data,
+			reg = data->read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[i]);
 			if (reg & data->CRITICAL_PWM_ENABLE_MASK)
-				reg = nct6775_read_value(data,
+				reg = data->read_value(data,
 					data->REG_CRITICAL_PWM[i]);
 			else
 				reg = 0xff;
@@ -1783,11 +1799,11 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			if (!(data->have_in & BIT(i)))
 				continue;
 
-			data->in[i][0] = nct6775_read_value(data,
-							    data->REG_VIN[i]);
-			data->in[i][1] = nct6775_read_value(data,
+			data->in[i][0] = data->read_value(data,
+							  data->REG_VIN[i]);
+			data->in[i][1] = data->read_value(data,
 					  data->REG_IN_MINMAX[0][i]);
-			data->in[i][2] = nct6775_read_value(data,
+			data->in[i][2] = data->read_value(data,
 					  data->REG_IN_MINMAX[1][i]);
 		}
 
@@ -1798,18 +1814,18 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			if (!(data->has_fan & BIT(i)))
 				continue;
 
-			reg = nct6775_read_value(data, data->REG_FAN[i]);
+			reg = data->read_value(data, data->REG_FAN[i]);
 			data->rpm[i] = data->fan_from_reg(reg,
 							  data->fan_div[i]);
 
 			if (data->has_fan_min & BIT(i))
-				data->fan_min[i] = nct6775_read_value(data,
+				data->fan_min[i] = data->read_value(data,
 					   data->REG_FAN_MIN[i]);
 
 			if (data->REG_FAN_PULSES[i]) {
 				data->fan_pulses[i] =
-				  (nct6775_read_value(data,
-						      data->REG_FAN_PULSES[i])
+				  (data->read_value(data,
+						    data->REG_FAN_PULSES[i])
 				   >> data->FAN_PULSE_SHIFT[i]) & 0x03;
 			}
 
@@ -1833,7 +1849,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			    !(data->have_temp_fixed & BIT(i)))
 				continue;
 			data->temp_offset[i]
-			  = nct6775_read_value(data, data->REG_TEMP_OFFSET[i]);
+			  = data->read_value(data, data->REG_TEMP_OFFSET[i]);
 		}
 
 		data->alarms = 0;
@@ -1842,7 +1858,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 
 			if (!data->REG_ALARM[i])
 				continue;
-			alarm = nct6775_read_value(data, data->REG_ALARM[i]);
+			alarm = data->read_value(data, data->REG_ALARM[i]);
 			data->alarms |= ((u64)alarm) << (i << 3);
 		}
 
@@ -1852,7 +1868,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 
 			if (!data->REG_BEEP[i])
 				continue;
-			beep = nct6775_read_value(data, data->REG_BEEP[i]);
+			beep = data->read_value(data, data->REG_BEEP[i]);
 			data->beeps |= ((u64)beep) << (i << 3);
 		}
 
@@ -1894,8 +1910,8 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 		return err;
 	mutex_lock(&data->update_lock);
 	data->in[nr][index] = in_to_reg(val, nr);
-	nct6775_write_value(data, data->REG_IN_MINMAX[index - 1][nr],
-			    data->in[nr][index]);
+	data->write_value(data, data->REG_IN_MINMAX[index - 1][nr],
+			  data->in[nr][index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1919,8 +1935,8 @@ static int find_temp_source(struct nct6775_data *data, int index, int count)
 	for (nr = 0; nr < count; nr++) {
 		int src;
 
-		src = nct6775_read_value(data,
-					 data->REG_TEMP_SOURCE[nr]) & 0x1f;
+		src = data->read_value(data,
+				       data->REG_TEMP_SOURCE[nr]) & 0x1f;
 		if (src == source)
 			return nr;
 	}
@@ -1981,8 +1997,8 @@ store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
 		data->beeps |= (1ULL << nr);
 	else
 		data->beeps &= ~(1ULL << nr);
-	nct6775_write_value(data, data->REG_BEEP[regindex],
-			    (data->beeps >> (regindex << 3)) & 0xff);
+	data->write_value(data, data->REG_BEEP[regindex],
+			  (data->beeps >> (regindex << 3)) & 0xff);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2037,8 +2053,8 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
 		data->beeps |= (1ULL << bit);
 	else
 		data->beeps &= ~(1ULL << bit);
-	nct6775_write_value(data, data->REG_BEEP[regindex],
-			    (data->beeps >> (regindex << 3)) & 0xff);
+	data->write_value(data, data->REG_BEEP[regindex],
+			  (data->beeps >> (regindex << 3)) & 0xff);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2205,7 +2221,7 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	}
 
 write_min:
-	nct6775_write_value(data, data->REG_FAN_MIN[nr], data->fan_min[nr]);
+	data->write_value(data, data->REG_FAN_MIN[nr], data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2241,10 +2257,10 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->fan_pulses[nr] = val & 3;
-	reg = nct6775_read_value(data, data->REG_FAN_PULSES[nr]);
+	reg = data->read_value(data, data->REG_FAN_PULSES[nr]);
 	reg &= ~(0x03 << data->FAN_PULSE_SHIFT[nr]);
 	reg |= (val & 3) << data->FAN_PULSE_SHIFT[nr];
-	nct6775_write_value(data, data->REG_FAN_PULSES[nr], reg);
+	data->write_value(data, data->REG_FAN_PULSES[nr], reg);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2378,7 +2394,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
-	nct6775_write_value(data, data->REG_TEMP_OFFSET[nr], val);
+	data->write_value(data, data->REG_TEMP_OFFSET[nr], val);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2417,8 +2433,8 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	data->temp_type[nr] = val;
 	vbit = 0x02 << nr;
 	dbit = data->DIODE_MASK << nr;
-	vbat = nct6775_read_value(data, data->REG_VBAT) & ~vbit;
-	diode = nct6775_read_value(data, data->REG_DIODE) & ~dbit;
+	vbat = data->read_value(data, data->REG_VBAT) & ~vbit;
+	diode = data->read_value(data, data->REG_DIODE) & ~dbit;
 	switch (val) {
 	case 1:	/* CPU diode (diode, current mode) */
 		vbat |= vbit;
@@ -2430,8 +2446,8 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	case 4:	/* thermistor */
 		break;
 	}
-	nct6775_write_value(data, data->REG_VBAT, vbat);
-	nct6775_write_value(data, data->REG_DIODE, diode);
+	data->write_value(data, data->REG_VBAT, vbat);
+	data->write_value(data, data->REG_DIODE, diode);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -2555,11 +2571,11 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->pwm_mode[nr] = val;
-	reg = nct6775_read_value(data, data->REG_PWM_MODE[nr]);
+	reg = data->read_value(data, data->REG_PWM_MODE[nr]);
 	reg &= ~data->PWM_MODE_MASK[nr];
 	if (!val)
 		reg |= data->PWM_MODE_MASK[nr];
-	nct6775_write_value(data, data->REG_PWM_MODE[nr], reg);
+	data->write_value(data, data->REG_PWM_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2578,7 +2594,7 @@ show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 	 * Otherwise, show the configured value.
 	 */
 	if (index == 0 && data->pwm_enable[nr] > manual)
-		pwm = nct6775_read_value(data, data->REG_PWM_READ[nr]);
+		pwm = data->read_value(data, data->REG_PWM_READ[nr]);
 	else
 		pwm = data->pwm[index][nr];
 
@@ -2607,13 +2623,13 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
 
 	mutex_lock(&data->update_lock);
 	data->pwm[index][nr] = val;
-	nct6775_write_value(data, data->REG_PWM[index][nr], val);
+	data->write_value(data, data->REG_PWM[index][nr], val);
 	if (index == 2)	{ /* floor: disable if val == 0 */
-		reg = nct6775_read_value(data, data->REG_TEMP_SEL[nr]);
+		reg = data->read_value(data, data->REG_TEMP_SEL[nr]);
 		reg &= 0x7f;
 		if (val)
 			reg |= 0x80;
-		nct6775_write_value(data, data->REG_TEMP_SEL[nr], reg);
+		data->write_value(data, data->REG_TEMP_SEL[nr], reg);
 	}
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -2652,29 +2668,29 @@ static void pwm_update_registers(struct nct6775_data *data, int nr)
 	case manual:
 		break;
 	case speed_cruise:
-		reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+		reg = data->read_value(data, data->REG_FAN_MODE[nr]);
 		reg = (reg & ~data->tolerance_mask) |
 		  (data->target_speed_tolerance[nr] & data->tolerance_mask);
-		nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
-		nct6775_write_value(data, data->REG_TARGET[nr],
+		data->write_value(data, data->REG_FAN_MODE[nr], reg);
+		data->write_value(data, data->REG_TARGET[nr],
 				    data->target_speed[nr] & 0xff);
 		if (data->REG_TOLERANCE_H) {
 			reg = (data->target_speed[nr] >> 8) & 0x0f;
 			reg |= (data->target_speed_tolerance[nr] & 0x38) << 1;
-			nct6775_write_value(data,
-					    data->REG_TOLERANCE_H[nr],
-					    reg);
+			data->write_value(data,
+					  data->REG_TOLERANCE_H[nr],
+					  reg);
 		}
 		break;
 	case thermal_cruise:
-		nct6775_write_value(data, data->REG_TARGET[nr],
-				    data->target_temp[nr]);
+		data->write_value(data, data->REG_TARGET[nr],
+				  data->target_temp[nr]);
 		fallthrough;
 	default:
-		reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+		reg = data->read_value(data, data->REG_FAN_MODE[nr]);
 		reg = (reg & ~data->tolerance_mask) |
 		  data->temp_tolerance[0][nr];
-		nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
+		data->write_value(data, data->REG_FAN_MODE[nr], reg);
 		break;
 	}
 }
@@ -2722,13 +2738,13 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 		 * turn off pwm control: select manual mode, set pwm to maximum
 		 */
 		data->pwm[0][nr] = 255;
-		nct6775_write_value(data, data->REG_PWM[0][nr], 255);
+		data->write_value(data, data->REG_PWM[0][nr], 255);
 	}
 	pwm_update_registers(data, nr);
-	reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+	reg = data->read_value(data, data->REG_FAN_MODE[nr]);
 	reg &= 0x0f;
 	reg |= pwm_enable_to_reg(val) << 4;
-	nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
+	data->write_value(data, data->REG_FAN_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2781,10 +2797,10 @@ store_pwm_temp_sel(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	src = data->temp_src[val - 1];
 	data->pwm_temp_sel[nr] = src;
-	reg = nct6775_read_value(data, data->REG_TEMP_SEL[nr]);
+	reg = data->read_value(data, data->REG_TEMP_SEL[nr]);
 	reg &= 0xe0;
 	reg |= src;
-	nct6775_write_value(data, data->REG_TEMP_SEL[nr], reg);
+	data->write_value(data, data->REG_TEMP_SEL[nr], reg);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2826,15 +2842,15 @@ store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
 	if (val) {
 		src = data->temp_src[val - 1];
 		data->pwm_weight_temp_sel[nr] = src;
-		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
+		reg = data->read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
 		reg &= 0xe0;
 		reg |= (src | 0x80);
-		nct6775_write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
+		data->write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
 	} else {
 		data->pwm_weight_temp_sel[nr] = 0;
-		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
+		reg = data->read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
 		reg &= 0x7f;
-		nct6775_write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
+		data->write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
 	}
 	mutex_unlock(&data->update_lock);
 
@@ -2946,9 +2962,9 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
 	if (index)
 		pwm_update_registers(data, nr);
 	else
-		nct6775_write_value(data,
-				    data->REG_CRITICAL_TEMP_TOLERANCE[nr],
-				    val);
+		data->write_value(data,
+				  data->REG_CRITICAL_TEMP_TOLERANCE[nr],
+				  val);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -3071,7 +3087,7 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->weight_temp[index][nr] = val;
-	nct6775_write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
+	data->write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -3120,7 +3136,7 @@ store_fan_time(struct device *dev, struct device_attribute *attr,
 	val = step_time_to_reg(val, data->pwm_mode[nr]);
 	mutex_lock(&data->update_lock);
 	data->fan_time[index][nr] = val;
-	nct6775_write_value(data, data->REG_FAN_TIME[index][nr], val);
+	data->write_value(data, data->REG_FAN_TIME[index][nr], val);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -3162,21 +3178,21 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	data->auto_pwm[nr][point] = val;
 	if (point < data->auto_pwm_num) {
-		nct6775_write_value(data,
+		data->write_value(data,
 				    NCT6775_AUTO_PWM(data, nr, point),
 				    data->auto_pwm[nr][point]);
 	} else {
 		switch (data->kind) {
 		case nct6775:
 			/* disable if needed (pwm == 0) */
-			reg = nct6775_read_value(data,
-						 NCT6775_REG_CRITICAL_ENAB[nr]);
+			reg = data->read_value(data,
+					       NCT6775_REG_CRITICAL_ENAB[nr]);
 			if (val)
 				reg |= 0x02;
 			else
 				reg &= ~0x02;
-			nct6775_write_value(data, NCT6775_REG_CRITICAL_ENAB[nr],
-					    reg);
+			data->write_value(data, NCT6775_REG_CRITICAL_ENAB[nr],
+					  reg);
 			break;
 		case nct6776:
 			break; /* always enabled, nothing to do */
@@ -3190,17 +3206,17 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 		case nct6796:
 		case nct6797:
 		case nct6798:
-			nct6775_write_value(data, data->REG_CRITICAL_PWM[nr],
+			data->write_value(data, data->REG_CRITICAL_PWM[nr],
 					    val);
-			reg = nct6775_read_value(data,
+			reg = data->read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[nr]);
 			if (val == 255)
 				reg &= ~data->CRITICAL_PWM_ENABLE_MASK;
 			else
 				reg |= data->CRITICAL_PWM_ENABLE_MASK;
-			nct6775_write_value(data,
-					    data->REG_CRITICAL_PWM_ENABLE[nr],
-					    reg);
+			data->write_value(data,
+					  data->REG_CRITICAL_PWM_ENABLE[nr],
+					  reg);
 			break;
 		}
 	}
@@ -3243,11 +3259,11 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	data->auto_temp[nr][point] = DIV_ROUND_CLOSEST(val, 1000);
 	if (point < data->auto_pwm_num) {
-		nct6775_write_value(data,
+		data->write_value(data,
 				    NCT6775_AUTO_TEMP(data, nr, point),
 				    data->auto_temp[nr][point]);
 	} else {
-		nct6775_write_value(data, data->REG_CRITICAL_TEMP[nr],
+		data->write_value(data, data->REG_CRITICAL_TEMP[nr],
 				    data->auto_temp[nr][point]);
 	}
 	mutex_unlock(&data->update_lock);
@@ -3410,6 +3426,7 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
+	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	int nr = to_sensor_dev_attr(attr)->index - INTRUSION_ALARM_BASE;
 	unsigned long val;
 	u8 reg;
@@ -3425,19 +3442,19 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
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
@@ -3506,9 +3523,9 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 
 	/* Start monitoring if needed */
 	if (data->REG_CONFIG) {
-		tmp = nct6775_read_value(data, data->REG_CONFIG);
+		tmp = data->read_value(data, data->REG_CONFIG);
 		if (!(tmp & 0x01))
-			nct6775_write_value(data, data->REG_CONFIG, tmp | 0x01);
+			data->write_value(data, data->REG_CONFIG, tmp | 0x01);
 	}
 
 	/* Enable temperature sensors if needed */
@@ -3517,18 +3534,18 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 			continue;
 		if (!data->reg_temp_config[i])
 			continue;
-		tmp = nct6775_read_value(data, data->reg_temp_config[i]);
+		tmp = data->read_value(data, data->reg_temp_config[i]);
 		if (tmp & 0x01)
-			nct6775_write_value(data, data->reg_temp_config[i],
+			data->write_value(data, data->reg_temp_config[i],
 					    tmp & 0xfe);
 	}
 
 	/* Enable VBAT monitoring if needed */
-	tmp = nct6775_read_value(data, data->REG_VBAT);
+	tmp = data->read_value(data, data->REG_VBAT);
 	if (!(tmp & 0x01))
-		nct6775_write_value(data, data->REG_VBAT, tmp | 0x01);
+		data->write_value(data, data->REG_VBAT, tmp | 0x01);
 
-	diode = nct6775_read_value(data, data->REG_DIODE);
+	diode = data->read_value(data, data->REG_DIODE);
 
 	for (i = 0; i < data->temp_fixed_num; i++) {
 		if (!(data->have_temp_fixed & BIT(i)))
@@ -3542,29 +3559,29 @@ static inline void nct6775_init_device(struct nct6775_data *data)
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
@@ -3580,7 +3597,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 			if (!strcmp(board_name, "Z77 Pro4-M")) {
 				if ((data->sio_reg_enable & 0xe0) != 0xe0) {
 					data->sio_reg_enable |= 0xe0;
-					superio_outb(sioreg, SIO_REG_ENABLE,
+					sio_data->sio_outb(sio_data, SIO_REG_ENABLE,
 						     data->sio_reg_enable);
 				}
 			}
@@ -3589,32 +3606,32 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
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
@@ -3630,24 +3647,24 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
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
@@ -3774,7 +3791,7 @@ static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
 
 		if (!regp[i])
 			continue;
-		src = nct6775_read_value(data, regp[i]);
+		src = data->read_value(data, regp[i]);
 		src &= 0x1f;
 		if (!src || (*mask & BIT(src)))
 			continue;
@@ -3782,7 +3799,7 @@ static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
 			continue;
 
 		index = __ffs(*available);
-		nct6775_write_value(data, data->REG_TEMP_SOURCE[index], src);
+		data->write_value(data, data->REG_TEMP_SOURCE[index], src);
 		*available &= ~BIT(index);
 		*mask |= BIT(src);
 	}
@@ -3793,7 +3810,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	struct nct6775_data *data;
-	struct resource *res;
+	struct resource *res = NULL;
 	int i, s, err = 0;
 	int src, mask, available;
 	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
@@ -3806,6 +3823,9 @@ static int nct6775_probe(struct platform_device *pdev)
 	int num_attr_groups = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res)
+		return -EBUSY;
+
 	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
 				 DRVNAME))
 		return -EBUSY;
@@ -3818,6 +3838,8 @@ static int nct6775_probe(struct platform_device *pdev)
 	data->kind = sio_data->kind;
 	data->sioreg = sio_data->sioreg;
 	data->addr = res->start;
+	data->read_value = nct6775_read_value;
+	data->write_value = nct6775_write_value;
 	mutex_init(&data->update_lock);
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
@@ -4337,7 +4359,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		if (reg_temp[i] == 0)
 			continue;
 
-		src = nct6775_read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
+		src = data->read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
 		if (!src || (mask & BIT(src)))
 			available |= BIT(i);
 
@@ -4357,7 +4379,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		if (reg_temp[i] == 0)
 			continue;
 
-		src = nct6775_read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
+		src = data->read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
 		if (!src || (mask & BIT(src)))
 			continue;
 
@@ -4417,7 +4439,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		if (reg_temp_mon[i] == 0)
 			continue;
 
-		src = nct6775_read_value(data, data->REG_TEMP_SEL[i]) & 0x1f;
+		src = data->read_value(data, data->REG_TEMP_SEL[i]) & 0x1f;
 		if (!src)
 			continue;
 
@@ -4502,11 +4524,11 @@ static int nct6775_probe(struct platform_device *pdev)
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
@@ -4532,17 +4554,17 @@ static int nct6775_probe(struct platform_device *pdev)
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
@@ -4565,15 +4587,15 @@ static int nct6775_probe(struct platform_device *pdev)
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
@@ -4613,15 +4635,15 @@ static int nct6775_probe(struct platform_device *pdev)
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
 
@@ -4630,10 +4652,10 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
 	struct nct6775_data *data = nct6775_update_device(dev);
 
 	mutex_lock(&data->update_lock);
-	data->vbat = nct6775_read_value(data, data->REG_VBAT);
+	data->vbat = data->read_value(data, data->REG_VBAT);
 	if (data->kind == nct6775) {
-		data->fandiv1 = nct6775_read_value(data, NCT6775_REG_FANDIV1);
-		data->fandiv2 = nct6775_read_value(data, NCT6775_REG_FANDIV2);
+		data->fandiv1 = data->read_value(data, NCT6775_REG_FANDIV1);
+		data->fandiv2 = data->read_value(data, NCT6775_REG_FANDIV2);
 	}
 	mutex_unlock(&data->update_lock);
 
@@ -4643,47 +4665,47 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
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
 		if (!(data->have_in & BIT(i)))
 			continue;
 
-		nct6775_write_value(data, data->REG_IN_MINMAX[0][i],
-				    data->in[i][1]);
-		nct6775_write_value(data, data->REG_IN_MINMAX[1][i],
-				    data->in[i][2]);
+		data->write_value(data, data->REG_IN_MINMAX[0][i],
+				  data->in[i][1]);
+		data->write_value(data, data->REG_IN_MINMAX[1][i],
+				  data->in[i][2]);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		if (!(data->has_fan_min & BIT(i)))
 			continue;
 
-		nct6775_write_value(data, data->REG_FAN_MIN[i],
-				    data->fan_min[i]);
+		data->write_value(data, data->REG_FAN_MIN[i],
+				  data->fan_min[i]);
 	}
 
 	for (i = 0; i < NUM_TEMP; i++) {
@@ -4697,10 +4719,10 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 	}
 
 	/* Restore other settings */
-	nct6775_write_value(data, data->REG_VBAT, data->vbat);
+	data->write_value(data, data->REG_VBAT, data->vbat);
 	if (data->kind == nct6775) {
-		nct6775_write_value(data, NCT6775_REG_FANDIV1, data->fandiv1);
-		nct6775_write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
+		data->write_value(data, NCT6775_REG_FANDIV1, data->fandiv1);
+		data->write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
 	}
 
 abort:
@@ -4728,12 +4750,14 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
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
 
@@ -4777,38 +4801,37 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
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
@@ -4842,6 +4865,12 @@ static int __init sensors_nct6775_init(void)
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

