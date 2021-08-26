Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB03E3F8097
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhHZCml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhHZCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:42:22 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:41:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A1EAE806CB;
        Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1629945684;
        bh=GzEVWb04q6+wvxNj6YYzux/khsF8Ee2K/V7mp/Oc0A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dtGVsUSjQ/1Klsrf8oC70/DpuFURQzjnS7kjBvm126yttl46o890oNaBEogPlLv4+
         SSj4l0OCk/pGqZjpKi+w3IcGG7orW4pHfBXwTqDuQuf4RtaIRHDm1iXoPw+B3w2e/p
         wGKDC/yL9ECeuBEP4jqGJ6FdOMcHmrMY6nJe747tZKZLpR4uR3mRbdsb5MlbcBXYFV
         AI0UNupD2icsxTyguYqQLhaOC3uDtlJWGNAwO6bDXh7gABBjhqrGxeRP7kKSiR/Ykz
         WnrV3G/MemkAXpw8jBydhiIGK6ig5ZnIH71LnbnQlKlsoyX9TqL66HyYmvmwaggKWy
         wzC365jiQjVkw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6126ff540001>; Thu, 26 Aug 2021 14:41:24 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 5001F13ED4A;
        Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4E5BE284585; Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/4] hwmon: (adt7470) Convert to use regmap
Date:   Thu, 26 Aug 2021 14:41:19 +1200
Message-Id: <20210826024121.15665-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=CdlaSGr7m4H035cohyUA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the adt7470 to using regmap which allows better error handling.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Change in v2:
- split regmap and devm_hwmon_device_register_with_info into separate
  patches to aid review

 drivers/hwmon/adt7470.c | 430 +++++++++++++++++++++++-----------------
 1 file changed, 249 insertions(+), 181 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 3358ec58b977..ad3e46667be8 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/kthread.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>
=20
@@ -35,7 +36,10 @@ static const unsigned short normal_i2c[] =3D { 0x2C, 0=
x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_REG_PWM_MAX_BASE_ADDR		0x38
 #define ADT7470_REG_PWM_MAX_MAX_ADDR		0x3B
 #define ADT7470_REG_CFG				0x40
+#define		ADT7470_STRT_MASK		0x01
+#define		ADT7470_TEST_MASK		0x02
 #define		ADT7470_FSPD_MASK		0x04
+#define		ADT7470_T05_STB_MASK		0x80
 #define ADT7470_REG_ALARM1			0x41
 #define		ADT7470_R1T_ALARM		0x01
 #define		ADT7470_R2T_ALARM		0x02
@@ -137,7 +141,7 @@ static const unsigned short normal_i2c[] =3D { 0x2C, =
0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_FREQ_SHIFT	4
=20
 struct adt7470_data {
-	struct i2c_client	*client;
+	struct regmap		*regmap;
 	struct mutex		lock;
 	char			sensors_valid;
 	char			limits_valid;
@@ -171,52 +175,76 @@ struct adt7470_data {
  * 16-bit registers on the ADT7470 are low-byte first.  The data sheet s=
ays
  * that the low byte must be read before the high byte.
  */
-static inline int adt7470_read_word_data(struct i2c_client *client, u8 r=
eg)
+static inline int adt7470_read_word_data(struct adt7470_data *data, unsi=
gned int reg,
+					 unsigned int *val)
 {
-	u16 foo;
+	u8 regval[2];
+	int err;
=20
-	foo =3D i2c_smbus_read_byte_data(client, reg);
-	foo |=3D ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
-	return foo;
+	err =3D regmap_bulk_read(data->regmap, reg, &regval, 2);
+	if (err < 0)
+		return err;
+
+	*val =3D regval[0] | (regval[1] << 8);
+
+	return 0;
 }
=20
-static inline int adt7470_write_word_data(struct i2c_client *client, u8 =
reg,
-					  u16 value)
+static inline int adt7470_write_word_data(struct adt7470_data *data, uns=
igned int reg,
+					  unsigned int val)
 {
-	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
-	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
+	u8 regval[2];
+
+	regval[0] =3D val & 0xFF;
+	regval[1] =3D val >> 8;
+
+	return regmap_bulk_write(data->regmap, reg, &regval, 2);
 }
=20
 /* Probe for temperature sensors.  Assumes lock is held */
-static int adt7470_read_temperatures(struct i2c_client *client,
-				     struct adt7470_data *data)
+static int adt7470_read_temperatures(struct adt7470_data *data)
 {
 	unsigned long res;
+	unsigned int pwm_cfg[2];
+	int err;
 	int i;
-	u8 cfg, pwm[4], pwm_cfg[2];
+	u8 pwm[ADT7470_FAN_COUNT];
=20
 	/* save pwm[1-4] config register */
-	pwm_cfg[0] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(0))=
;
-	pwm_cfg[1] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(2))=
;
+	err =3D regmap_read(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0]);
+	if (err < 0)
+		return err;
+	err =3D regmap_read(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[1]);
+	if (err < 0)
+		return err;
=20
 	/* set manual pwm to whatever it is set to now */
-	for (i =3D 0; i < ADT7470_FAN_COUNT; i++)
-		pwm[i] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
+	err =3D regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
+			       ADT7470_PWM_COUNT);
+	if (err < 0)
+		return err;
=20
 	/* put pwm in manual mode */
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0),
-		pwm_cfg[0] & ~(ADT7470_PWM_AUTO_MASK));
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2),
-		pwm_cfg[1] & ~(ADT7470_PWM_AUTO_MASK));
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(0),
+				 ADT7470_PWM_AUTO_MASK, 0);
+	if (err < 0)
+		return err;
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(2),
+				 ADT7470_PWM_AUTO_MASK, 0);
+	if (err < 0)
+		return err;
=20
 	/* write pwm control to whatever it was */
-	for (i =3D 0; i < ADT7470_FAN_COUNT; i++)
-		i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(i), pwm[i]);
+	err =3D regmap_bulk_write(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
+				ADT7470_PWM_COUNT);
+	if (err < 0)
+		return err;
=20
 	/* start reading temperature sensors */
-	cfg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	cfg |=3D 0x80;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_T05_STB_MASK, ADT7470_T05_STB_MASK);
+	if (err < 0)
+		return err;
=20
 	/* Delay is 200ms * number of temp sensors. */
 	res =3D msleep_interruptible((data->num_temp_sensors >=3D 0 ?
@@ -224,26 +252,31 @@ static int adt7470_read_temperatures(struct i2c_cli=
ent *client,
 				    TEMP_COLLECTION_TIME));
=20
 	/* done reading temperature sensors */
-	cfg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	cfg &=3D ~0x80;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_T05_STB_MASK, 0);
+	if (err < 0)
+		return err;
=20
 	/* restore pwm[1-4] config registers */
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	err =3D regmap_write(data->regmap, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
+	if (err < 0)
+		return err;
+	err =3D regmap_write(data->regmap, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	if (err < 0)
+		return err;
=20
-	if (res) {
-		pr_err("ha ha, interrupted\n");
+	if (res)
 		return -EAGAIN;
-	}
=20
 	/* Only count fans if we have to */
 	if (data->num_temp_sensors >=3D 0)
 		return 0;
=20
+	err =3D regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp=
[0],
+			       ADT7470_TEMP_COUNT);
+	if (err < 0)
+		return err;
 	for (i =3D 0; i < ADT7470_TEMP_COUNT; i++) {
-		data->temp[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_REG(i));
 		if (data->temp[i])
 			data->num_temp_sensors =3D i + 1;
 	}
@@ -258,7 +291,7 @@ static int adt7470_update_thread(void *p)
=20
 	while (!kthread_should_stop()) {
 		mutex_lock(&data->lock);
-		adt7470_read_temperatures(client, data);
+		adt7470_read_temperatures(data);
 		mutex_unlock(&data->lock);
=20
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -273,89 +306,116 @@ static int adt7470_update_thread(void *p)
=20
 static int adt7470_update_sensors(struct adt7470_data *data)
 {
-	struct i2c_client *client =3D data->client;
-	u8 cfg;
+	unsigned int val;
+	int err;
 	int i;
=20
 	if (!data->temperatures_probed)
-		adt7470_read_temperatures(client, data);
+		err =3D adt7470_read_temperatures(data);
 	else
-		for (i =3D 0; i < ADT7470_TEMP_COUNT; i++)
-			data->temp[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_REG(i));
+		err =3D regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->tem=
p[0],
+				       ADT7470_TEMP_COUNT);
+	if (err < 0)
+		return err;
=20
-	for (i =3D 0; i < ADT7470_FAN_COUNT; i++)
-		data->fan[i] =3D adt7470_read_word_data(client,
-						ADT7470_REG_FAN(i));
-
-	for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
-		int reg;
-		int reg_mask;
-
-		data->pwm[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM(i));
-
-		if (i % 2)
-			reg_mask =3D ADT7470_PWM2_AUTO_MASK;
-		else
-			reg_mask =3D ADT7470_PWM1_AUTO_MASK;
-
-		reg =3D ADT7470_REG_PWM_CFG(i);
-		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
-			data->pwm_automatic[i] =3D 1;
-		else
-			data->pwm_automatic[i] =3D 0;
-
-		reg =3D ADT7470_REG_PWM_AUTO_TEMP(i);
-		cfg =3D i2c_smbus_read_byte_data(client, reg);
-		if (!(i % 2))
-			data->pwm_auto_temp[i] =3D cfg >> 4;
-		else
-			data->pwm_auto_temp[i] =3D cfg & 0xF;
+	for (i =3D 0; i < ADT7470_FAN_COUNT; i++) {
+		err =3D adt7470_read_word_data(data, ADT7470_REG_FAN(i), &val);
+		if (err < 0)
+			return err;
+		data->fan[i] =3D	val;
 	}
=20
-	if (i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) &
-	    ADT7470_FSPD_MASK)
-		data->force_pwm_max =3D 1;
-	else
-		data->force_pwm_max =3D 0;
+	err =3D regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &data->pwm[0=
], ADT7470_PWM_COUNT);
+	if (err < 0)
+		return err;
=20
-	data->alarm =3D i2c_smbus_read_byte_data(client, ADT7470_REG_ALARM1);
-	if (data->alarm & ADT7470_OOL_ALARM)
-		data->alarm |=3D ALARM2(i2c_smbus_read_byte_data(client,
-							ADT7470_REG_ALARM2));
-	data->alarms_mask =3D adt7470_read_word_data(client,
-						   ADT7470_REG_ALARM1_MASK);
+	for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
+		unsigned int mask;
+
+		if (i % 2)
+			mask =3D ADT7470_PWM2_AUTO_MASK;
+		else
+			mask =3D ADT7470_PWM1_AUTO_MASK;
+
+		err =3D regmap_read(data->regmap, ADT7470_REG_PWM_CFG(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_automatic[i] =3D !!(val & mask);
+
+		err =3D regmap_read(data->regmap, ADT7470_REG_PWM_AUTO_TEMP(i), &val);
+		if (err < 0)
+			return err;
+		if (!(i % 2))
+			data->pwm_auto_temp[i] =3D val >> 4;
+		else
+			data->pwm_auto_temp[i] =3D val & 0xF;
+	}
+
+	err =3D regmap_read(data->regmap, ADT7470_REG_CFG, &val);
+	if (err < 0)
+		return err;
+	data->force_pwm_max =3D !!(val & ADT7470_FSPD_MASK);
+
+	err =3D regmap_read(data->regmap, ADT7470_REG_ALARM1, &val);
+	if (err < 0)
+		return err;
+	data->alarm =3D val;
+	if (data->alarm & ADT7470_OOL_ALARM) {
+		err =3D regmap_read(data->regmap, ADT7470_REG_ALARM2, &val);
+		if (err < 0)
+			return err;
+		data->alarm |=3D ALARM2(val);
+	}
+
+	err =3D adt7470_read_word_data(data, ADT7470_REG_ALARM1_MASK, &val);
+	if (err < 0)
+		return err;
+	data->alarms_mask =3D val;
=20
 	return 0;
 }
=20
 static int adt7470_update_limits(struct adt7470_data *data)
 {
-	struct i2c_client *client =3D data->client;
+	unsigned int val;
+	int err;
 	int i;
=20
 	for (i =3D 0; i < ADT7470_TEMP_COUNT; i++) {
-		data->temp_min[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MIN_REG(i));
-		data->temp_max[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MAX_REG(i));
+		err =3D regmap_read(data->regmap, ADT7470_TEMP_MIN_REG(i), &val);
+		if (err < 0)
+			return err;
+		data->temp_min[i] =3D (s8)val;
+		err =3D regmap_read(data->regmap, ADT7470_TEMP_MAX_REG(i), &val);
+		if (err < 0)
+			return err;
+		data->temp_max[i] =3D (s8)val;
 	}
=20
 	for (i =3D 0; i < ADT7470_FAN_COUNT; i++) {
-		data->fan_min[i] =3D adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MIN(i));
-		data->fan_max[i] =3D adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MAX(i));
+		err =3D adt7470_read_word_data(data, ADT7470_REG_FAN_MIN(i), &val);
+		if (err < 0)
+			return err;
+		data->fan_min[i] =3D val;
+		err =3D adt7470_read_word_data(data, ADT7470_REG_FAN_MAX(i), &val);
+		if (err < 0)
+			return err;
+		data->fan_max[i] =3D val;
 	}
=20
 	for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
-		data->pwm_max[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MAX(i));
-		data->pwm_min[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MIN(i));
-		data->pwm_tmin[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_TMIN(i));
+		err =3D regmap_read(data->regmap, ADT7470_REG_PWM_MAX(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_max[i] =3D val;
+		err =3D regmap_read(data->regmap, ADT7470_REG_PWM_MIN(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_min[i] =3D val;
+		err =3D regmap_read(data->regmap, ADT7470_REG_PWM_TMIN(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_tmin[i] =3D (s8)val;
 	}
=20
 	return 0;
@@ -491,8 +551,8 @@ static ssize_t temp_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -502,11 +562,11 @@ static ssize_t temp_min_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
+	err =3D regmap_write(data->regmap, ADT7470_TEMP_MIN_REG(attr->index),
 				  temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t temp_max_show(struct device *dev,
@@ -527,8 +587,8 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -538,11 +598,10 @@ static ssize_t temp_max_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
-				  temp);
+	err =3D regmap_write(data->regmap, ADT7470_TEMP_MAX_REG(attr->index), t=
emp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t temp_show(struct device *dev, struct device_attribute *de=
vattr,
@@ -575,6 +634,7 @@ static ssize_t alarm_mask_store(struct device *dev,
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
 	long mask;
+	int err;
=20
 	if (kstrtoul(buf, 0, &mask))
 		return -EINVAL;
@@ -584,10 +644,10 @@ static ssize_t alarm_mask_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->alarms_mask =3D mask;
-	adt7470_write_word_data(data->client, ADT7470_REG_ALARM1_MASK, mask);
+	err =3D adt7470_write_word_data(data, ADT7470_REG_ALARM1_MASK, mask);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t fan_max_show(struct device *dev,
@@ -612,8 +672,8 @@ static ssize_t fan_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
@@ -623,10 +683,10 @@ static ssize_t fan_max_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->fan_max[attr->index] =3D temp;
-	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp)=
;
+	err =3D adt7470_write_word_data(data, ADT7470_REG_FAN_MAX(attr->index),=
 temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t fan_min_show(struct device *dev,
@@ -651,8 +711,8 @@ static ssize_t fan_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
@@ -662,10 +722,10 @@ static ssize_t fan_min_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->fan_min[attr->index] =3D temp;
-	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp)=
;
+	err =3D adt7470_write_word_data(data, ADT7470_REG_FAN_MIN(attr->index),=
 temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t fan_show(struct device *dev, struct device_attribute *dev=
attr,
@@ -700,24 +760,20 @@ static ssize_t force_pwm_max_store(struct device *d=
ev,
 				   const char *buf, size_t count)
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
-	u8 reg;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
=20
 	mutex_lock(&data->lock);
 	data->force_pwm_max =3D temp;
-	reg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	if (temp)
-		reg |=3D ADT7470_FSPD_MASK;
-	else
-		reg &=3D ~ADT7470_FSPD_MASK;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_FSPD_MASK,
+				 temp ? ADT7470_FSPD_MASK : 0);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_show(struct device *dev, struct device_attribute *dev=
attr,
@@ -737,8 +793,8 @@ static ssize_t pwm_store(struct device *dev, struct d=
evice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -747,10 +803,10 @@ static ssize_t pwm_store(struct device *dev, struct=
 device_attribute *devattr,
=20
 	mutex_lock(&data->lock);
 	data->pwm[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
+	err =3D regmap_write(data->regmap, ADT7470_REG_PWM(attr->index), temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 /* These are the valid PWM frequencies to the nearest Hz */
@@ -762,13 +818,20 @@ static ssize_t pwm1_freq_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data =3D adt7470_update_device(dev);
-	unsigned char cfg_reg_1;
-	unsigned char cfg_reg_2;
+	unsigned int cfg_reg_1, cfg_reg_2;
 	int index;
+	int err;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
=20
 	mutex_lock(&data->lock);
-	cfg_reg_1 =3D i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG);
-	cfg_reg_2 =3D i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG_2)=
;
+	err =3D regmap_read(data->regmap, ADT7470_REG_CFG, &cfg_reg_1);
+	if (err < 0)
+		goto out;
+	err =3D regmap_read(data->regmap, ADT7470_REG_CFG_2, &cfg_reg_2);
+	if (err < 0)
+		goto out;
 	mutex_unlock(&data->lock);
=20
 	index =3D (cfg_reg_2 & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
@@ -778,6 +841,10 @@ static ssize_t pwm1_freq_show(struct device *dev,
 		index =3D ARRAY_SIZE(adt7470_freq_map) - 1;
=20
 	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
+
+out:
+	mutex_unlock(&data->lock);
+	return err;
 }
=20
 static ssize_t pwm1_freq_store(struct device *dev,
@@ -785,11 +852,10 @@ static ssize_t pwm1_freq_store(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long freq;
 	int index;
 	int low_freq =3D ADT7470_CFG_LF;
-	unsigned char val;
+	int err;
=20
 	if (kstrtol(buf, 10, &freq))
 		return -EINVAL;
@@ -805,16 +871,19 @@ static ssize_t pwm1_freq_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	/* Configuration Register 1 */
-	val =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG,
-				  (val & ~ADT7470_CFG_LF) | low_freq);
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_CFG_LF, low_freq);
+	if (err < 0)
+		goto out;
+
 	/* Configuration Register 2 */
-	val =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG_2);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG_2,
-		(val & ~ADT7470_FREQ_MASK) | (index << ADT7470_FREQ_SHIFT));
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_CFG_2,
+				 ADT7470_FREQ_MASK,
+				 index << ADT7470_FREQ_SHIFT);
+out:
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_max_show(struct device *dev,
@@ -835,8 +904,8 @@ static ssize_t pwm_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -845,11 +914,11 @@ static ssize_t pwm_max_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index),
-				  temp);
+	err =3D regmap_write(data->regmap, ADT7470_REG_PWM_MAX(attr->index),
+			   temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_min_show(struct device *dev,
@@ -870,8 +939,8 @@ static ssize_t pwm_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -880,11 +949,11 @@ static ssize_t pwm_min_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index),
-				  temp);
+	err =3D regmap_write(data->regmap, ADT7470_REG_PWM_MIN(attr->index),
+			   temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_tmax_show(struct device *dev,
@@ -918,8 +987,8 @@ static ssize_t pwm_tmin_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -929,11 +998,11 @@ static ssize_t pwm_tmin_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_tmin[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index),
-				  temp);
+	err =3D regmap_write(data->regmap, ADT7470_REG_PWM_TMIN(attr->index),
+			   temp);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_auto_show(struct device *dev,
@@ -954,11 +1023,9 @@ static ssize_t pwm_auto_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
-	int pwm_auto_reg =3D ADT7470_REG_PWM_CFG(attr->index);
 	int pwm_auto_reg_mask;
 	long temp;
-	u8 reg;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -974,15 +1041,12 @@ static ssize_t pwm_auto_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_automatic[attr->index] =3D temp;
-	reg =3D i2c_smbus_read_byte_data(client, pwm_auto_reg);
-	if (temp)
-		reg |=3D pwm_auto_reg_mask;
-	else
-		reg &=3D ~pwm_auto_reg_mask;
-	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(attr->inde=
x),
+				 pwm_auto_reg_mask,
+				 temp ? pwm_auto_reg_mask : 0);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_auto_temp_show(struct device *dev,
@@ -1017,10 +1081,10 @@ static ssize_t pwm_auto_temp_store(struct device =
*dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	int pwm_auto_reg =3D ADT7470_REG_PWM_AUTO_TEMP(attr->index);
+	unsigned int mask, val;
 	long temp;
-	u8 reg;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -1031,20 +1095,19 @@ static ssize_t pwm_auto_temp_store(struct device =
*dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_automatic[attr->index] =3D temp;
-	reg =3D i2c_smbus_read_byte_data(client, pwm_auto_reg);
=20
 	if (!(attr->index % 2)) {
-		reg &=3D 0xF;
-		reg |=3D (temp << 4) & 0xF0;
+		mask =3D 0xF0;
+		val =3D (temp << 4) & 0xF0;
 	} else {
-		reg &=3D 0xF0;
-		reg |=3D temp & 0xF;
+		mask =3D 0x0F;
+		val =3D temp & 0x0F;
 	}
=20
-	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	err =3D regmap_update_bits(data->regmap, pwm_auto_reg, mask, val);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t alarm_show(struct device *dev,
@@ -1053,6 +1116,9 @@ static ssize_t alarm_show(struct device *dev,
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
=20
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (data->alarm & attr->index)
 		return sprintf(buf, "1\n");
 	else
@@ -1288,23 +1354,19 @@ static int adt7470_detect(struct i2c_client *clie=
nt,
 	return 0;
 }
=20
-static void adt7470_init_client(struct i2c_client *client)
-{
-	int reg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-
-	if (reg < 0) {
-		dev_err(&client->dev, "cannot read configuration register\n");
-	} else {
-		/* start monitoring (and do a self-test) */
-		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
-	}
-}
+static const struct regmap_config adt7470_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.use_single_read =3D true,
+	.use_single_write =3D true,
+};
=20
 static int adt7470_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct adt7470_data *data;
 	struct device *hwmon_dev;
+	int err;
=20
 	data =3D devm_kzalloc(dev, sizeof(struct adt7470_data), GFP_KERNEL);
 	if (!data)
@@ -1312,15 +1374,21 @@ static int adt7470_probe(struct i2c_client *clien=
t)
=20
 	data->num_temp_sensors =3D -1;
 	data->auto_update_interval =3D AUTO_UPDATE_INTERVAL;
+	data->regmap =3D devm_regmap_init_i2c(client, &adt7470_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
=20
 	i2c_set_clientdata(client, data);
-	data->client =3D client;
 	mutex_init(&data->lock);
=20
 	dev_info(&client->dev, "%s chip found\n", client->name);
=20
 	/* Initialize the ADT7470 chip */
-	adt7470_init_client(client);
+	err =3D regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_STRT_MASK | ADT7470_TEST_MASK,
+				 ADT7470_STRT_MASK | ADT7470_TEST_MASK);
+	if (err < 0)
+		return err;
=20
 	/* Register sysfs hooks */
 	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, client->name,
--=20
2.32.0

