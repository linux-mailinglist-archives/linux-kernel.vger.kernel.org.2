Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA363F8095
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhHZCmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbhHZCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:42:22 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160BC061796
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:41:33 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5D78B891B0;
        Thu, 26 Aug 2021 14:41:32 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1629945692;
        bh=FKUIf618/0Dsx0Yu/eMexmQN3G1FO6P7em4iAA4toFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UKjvXXoGfOelfvd3Sgrl7WQi3W5eywsf2IxVIuzV12iFKOPKZKt+ci3dBljHcl3gi
         FJh05oJ37XAHA05g2c8J9Ubyz0213ODqjhy2iDGm7F3xB4qkpFvOYZyoNuBg2FPskH
         FhnZk3xWoIHNLg4hOpP03st1HHj3w307Yap8LTf8I8AQ2tVxGTaCye94qMBez362r4
         BFn71rhZxLhfbu1Ae7ezQQqGaN8GLRdTH3Hr6R1SGrukrhcwnGv6n6QdLzGdNsP/TS
         njg+63xvbQYQTyOa6X0mHGXcFOnYlCcO6f5cuqlEvbiQA4xIMUkzNiIjPaDCA+yeT5
         /lQP/oQSDw50A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6126ff540003>; Thu, 26 Aug 2021 14:41:24 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id AB57113ED4A;
        Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A9C13284585; Thu, 26 Aug 2021 14:41:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 4/4] hwmon: (adt7470) Use standard update_interval property
Date:   Thu, 26 Aug 2021 14:41:21 +1200
Message-Id: <20210826024121.15665-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=IseJ_u6kMGNTh8ES06MA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the non-standard auto_update_interval make use of the
update_interval property that is supported by the hwmon core.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I kind of anticipate a NAK on this because it affects the ABI. But I =
figured
    I'd run it past the ML to see if moving towards the hwmon core is wor=
th the hit
    in ABI compatibility.
   =20
    Changes in v2:
    - none

 drivers/hwmon/adt7470.c | 64 +++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index db19a52b13de..7afbd1e4721e 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -469,35 +469,37 @@ static struct adt7470_data *adt7470_update_device(s=
truct device *dev)
 	return err < 0 ? ERR_PTR(err) : data;
 }
=20
-static ssize_t auto_update_interval_show(struct device *dev,
-					 struct device_attribute *devattr,
-					 char *buf)
-{
-	struct adt7470_data *data =3D adt7470_update_device(dev);
-
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	return sprintf(buf, "%d\n", data->auto_update_interval);
-}
-
-static ssize_t auto_update_interval_store(struct device *dev,
-					  struct device_attribute *devattr,
-					  const char *buf, size_t count)
+static int adt7470_chip_read(struct device *dev, u32 attr, long *val)
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	long temp;
=20
-	if (kstrtol(buf, 10, &temp))
-		return -EINVAL;
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		*val =3D data->auto_update_interval;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
=20
-	temp =3D clamp_val(temp, 0, 60000);
+	return 0;
+}
=20
-	mutex_lock(&data->lock);
-	data->auto_update_interval =3D temp;
-	mutex_unlock(&data->lock);
+static int adt7470_chip_write(struct device *dev, u32 attr, long val)
+{
+	struct adt7470_data *data =3D dev_get_drvdata(dev);
=20
-	return count;
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		val =3D clamp_val(val, 0, 60000);
+		mutex_lock(&data->lock);
+		data->auto_update_interval =3D val;
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
=20
 static ssize_t num_temp_sensors_show(struct device *dev,
@@ -1034,7 +1036,6 @@ static ssize_t pwm_auto_temp_store(struct device *d=
ev,
=20
 static DEVICE_ATTR_RW(alarm_mask);
 static DEVICE_ATTR_RW(num_temp_sensors);
-static DEVICE_ATTR_RW(auto_update_interval);
=20
 static SENSOR_DEVICE_ATTR_RW(force_pwm_max, force_pwm_max, 0);
=20
@@ -1066,7 +1067,6 @@ static SENSOR_DEVICE_ATTR_RW(pwm4_auto_channels_tem=
p, pwm_auto_temp, 3);
 static struct attribute *adt7470_attrs[] =3D {
 	&dev_attr_alarm_mask.attr,
 	&dev_attr_num_temp_sensors.attr,
-	&dev_attr_auto_update_interval.attr,
 	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
@@ -1097,6 +1097,8 @@ static int adt7470_read(struct device *dev, enum hw=
mon_sensor_types type, u32 at
 			int channel, long *val)
 {
 	switch (type) {
+	case hwmon_chip:
+		return adt7470_chip_read(dev, attr, val);
 	case hwmon_temp:
 		return adt7470_temp_read(dev, attr, channel, val);
 	case hwmon_fan:
@@ -1112,6 +1114,8 @@ static int adt7470_write(struct device *dev, enum h=
wmon_sensor_types type, u32 a
 			int channel, long val)
 {
 	switch (type) {
+	case hwmon_chip:
+		return adt7470_chip_write(dev, attr, val);
 	case hwmon_temp:
 		return adt7470_temp_write(dev, attr, channel, val);
 	case hwmon_fan:
@@ -1129,6 +1133,15 @@ static umode_t adt7470_is_visible(const void *_dat=
a, enum hwmon_sensor_types typ
 	umode_t mode =3D 0;
=20
 	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			mode =3D 0644;
+			break;
+		default:
+			break;
+		}
+		break;
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp:
@@ -1187,6 +1200,7 @@ static const struct hwmon_ops adt7470_hwmon_ops =3D=
 {
 };
=20
 static const struct hwmon_channel_info *adt7470_info[] =3D {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
 			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
 			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
--=20
2.32.0

