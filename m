Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563A4596B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhKVVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhKVVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:32:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FABC061574;
        Mon, 22 Nov 2021 13:29:07 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so35184493wrr.8;
        Mon, 22 Nov 2021 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OyRfbs6YgA6golfUWKkgai6qfvikGjcB7KkXypvLvM=;
        b=VbtqpR9UlYDmM2Ta9n0zQHcajHpuIZ+DP+N+yiyU3R1NeMLHH4TfajnOeoWP4MA363
         qY8R00wE8DeHKI5Op8+v/x0cBSYRtdgo23ugUHyAT2Di5A/3OkXIpsnd7U0+sSbyo3+x
         vBNruLyCxQPuwq4SSJy29uiWkJbspOVYqa/5S+N0sz19wEJONQ7MSnJYBGOVVqQMcvKc
         NDp9duDE+BDAcOIZr4P4R3z6mDLytgIBDDm4wA9s/xYFkV8ks3q/hYunq6KbUFQcFBM8
         zRsbAHByzfC/z8Sgpkbtdk8svnRvq+5cCwyH/WNOXV6SwzBSRYjO89PDoFOOS9xMWcQ0
         OGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OyRfbs6YgA6golfUWKkgai6qfvikGjcB7KkXypvLvM=;
        b=XM+BlEb1khRSF/Bn3pub939mA7fkLz+0uAURw77fa1ngGU3c6HBFxHF3hP7XKuA7Zn
         dD+Q09AXxVXHM5dzAj6hyYIPYrjDzlxAcRmWzAIvzySjIKdYJzbyqyAptfLWuqb9+7Jv
         7gjN/pPS6e1nm0balKCsF9ODwgLVuNTW+PtblkSQRjqkFyQdWi/nytMGHSjWi0Id4yHF
         /yKZx1G5LehLTu1IgZAGcM0nCp7WMTmssRVXT1V0BTf95v4dYKV3YXlS3ZLNQlQ0u7WH
         ievKcjau+UyK7FX75L9bDd8uH42BuJjZwyv2TCjL63ATUNtXWZMobPqMtkggsqgq21Vo
         mu9A==
X-Gm-Message-State: AOAM531v6yjsngmK1G9UxbPHChenin7ZsxqljiFCg3KEEua5TqFOl/wk
        mBYI9J2pReS7vUiH8BbTrJgksHIbegtckg==
X-Google-Smtp-Source: ABdhPJyr8N5E9wcPmup6E9EpPx5VpnD6vry3r3WVIB/rSGi4UcLA4EMvT6Syq+bLia3uH884bFG4oA==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr387118wri.309.1637616545880;
        Mon, 22 Nov 2021 13:29:05 -0800 (PST)
Received: from localhost.localdomain (149-45-179-94.pool.ukrtel.net. [94.179.45.149])
        by smtp.gmail.com with ESMTPSA id k8sm9767928wrn.91.2021.11.22.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:29:05 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (nct6775) Use nct6775_*() lock function pointers in nct6775_data.
Date:   Mon, 22 Nov 2021 23:28:48 +0200
Message-Id: <20211122212850.321542-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122212850.321542-1-pauk.denis@gmail.com>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for platform specific callbacks usage:
* Use nct6775 lock function pointers in struct nct6775_data instead
  direct calls.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775.c | 195 +++++++++++++++++++++++++++++-----------
 1 file changed, 143 insertions(+), 52 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 93dca471972e..049c42ea66bb 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1326,6 +1326,8 @@ struct nct6775_data {
 	/* nct6775_*() callbacks  */
 	u16 (*read_value)(struct nct6775_data *data, u16 reg);
 	int (*write_value)(struct nct6775_data *data, u16 reg, u16 value);
+	int (*lock)(struct nct6775_data *data);
+	void (*unlock)(struct nct6775_data *data, struct device *dev);
 };
 
 struct sensor_device_template {
@@ -1918,12 +1920,26 @@ static void nct6775_update_pwm_limits(struct device *dev)
 	}
 }
 
+static int nct6775_lock(struct nct6775_data *data)
+{
+	mutex_lock(&data->update_lock);
+
+	return 0;
+}
+
+static void nct6775_unlock(struct nct6775_data *data, struct device *dev)
+{
+	mutex_unlock(&data->update_lock);
+}
+
 static struct nct6775_data *nct6775_update_device(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int i, j;
+	int i, j, err;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return data;
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -2011,7 +2027,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 		data->valid = true;
 	}
 
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return data;
 }
 
@@ -2043,11 +2059,15 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
-	mutex_lock(&data->update_lock);
+
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->in[nr][index] = in_to_reg(val, nr);
 	data->write_value(data, data->REG_IN_MINMAX[index - 1][nr],
 			  data->in[nr][index]);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2127,14 +2147,17 @@ store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
 	if (val > 1)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	if (val)
 		data->beeps |= (1ULL << nr);
 	else
 		data->beeps &= ~(1ULL << nr);
 	data->write_value(data, data->REG_BEEP[regindex],
 			  (data->beeps >> (regindex << 3)) & 0xff);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2183,14 +2206,17 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
 	bit = data->BEEP_BITS[nr + TEMP_ALARM_BASE];
 	regindex = bit >> 3;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	if (val)
 		data->beeps |= (1ULL << bit);
 	else
 		data->beeps &= ~(1ULL << bit);
 	data->write_value(data, data->REG_BEEP[regindex],
 			  (data->beeps >> (regindex << 3)) & 0xff);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return count;
 }
@@ -2284,7 +2310,10 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	if (!data->has_fan_div) {
 		/* NCT6776F or NCT6779D; we know this is a 13 bit register */
 		if (!val) {
@@ -2357,7 +2386,7 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 
 write_min:
 	data->write_value(data, data->REG_FAN_MIN[nr], data->fan_min[nr]);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return count;
 }
@@ -2390,13 +2419,16 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 	if (val > 4)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->fan_pulses[nr] = val & 3;
 	reg = data->read_value(data, data->REG_FAN_PULSES[nr]);
 	reg &= ~(0x03 << data->FAN_PULSE_SHIFT[nr]);
 	reg |= (val & 3) << data->FAN_PULSE_SHIFT[nr];
 	data->write_value(data, data->REG_FAN_PULSES[nr], reg);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return count;
 }
@@ -2494,11 +2526,14 @@ store_temp(struct device *dev, struct device_attribute *attr, const char *buf,
 	if (err < 0)
 		return err;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->temp[index][nr] = LM75_TEMP_TO_REG(val);
 	nct6775_write_temp(data, data->reg_temp[index][nr],
 			   data->temp[index][nr]);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2527,10 +2562,13 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 
 	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->temp_offset[nr] = val;
 	data->write_value(data, data->REG_TEMP_OFFSET[nr], val);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return count;
 }
@@ -2563,7 +2601,9 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	if (val != 1 && val != 3 && val != 4)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
 
 	data->temp_type[nr] = val;
 	vbit = 0x02 << nr;
@@ -2584,7 +2624,7 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	data->write_value(data, data->REG_VBAT, vbat);
 	data->write_value(data, data->REG_DIODE, diode);
 
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2704,14 +2744,17 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 		return count;
 	}
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->pwm_mode[nr] = val;
 	reg = data->read_value(data, data->REG_PWM_MODE[nr]);
 	reg &= ~data->PWM_MODE_MASK[nr];
 	if (!val)
 		reg |= data->PWM_MODE_MASK[nr];
 	data->write_value(data, data->REG_PWM_MODE[nr], reg);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2756,7 +2799,10 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
 		return err;
 	val = clamp_val(val, minval[index], maxval[index]);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->pwm[index][nr] = val;
 	data->write_value(data, data->REG_PWM[index][nr], val);
 	if (index == 2)	{ /* floor: disable if val == 0 */
@@ -2766,7 +2812,7 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
 			reg |= 0x80;
 		data->write_value(data, data->REG_TEMP_SEL[nr], reg);
 	}
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2866,7 +2912,10 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->pwm_enable[nr] = val;
 	if (val == off) {
 		/*
@@ -2880,7 +2929,7 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 	reg &= 0x0f;
 	reg |= pwm_enable_to_reg(val) << 4;
 	data->write_value(data, data->REG_FAN_MODE[nr], reg);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -2929,14 +2978,17 @@ store_pwm_temp_sel(struct device *dev, struct device_attribute *attr,
 	if (!(data->have_temp & BIT(val - 1)) || !data->temp_src[val - 1])
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	src = data->temp_src[val - 1];
 	data->pwm_temp_sel[nr] = src;
 	reg = data->read_value(data, data->REG_TEMP_SEL[nr]);
 	reg &= 0xe0;
 	reg |= src;
 	data->write_value(data, data->REG_TEMP_SEL[nr], reg);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return count;
 }
@@ -2973,7 +3025,10 @@ store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
 		    !data->temp_src[val - 1]))
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	if (val) {
 		src = data->temp_src[val - 1];
 		data->pwm_weight_temp_sel[nr] = src;
@@ -2987,7 +3042,7 @@ store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
 		reg &= 0x7f;
 		data->write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
 	}
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return count;
 }
@@ -3018,10 +3073,13 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0,
 			data->target_temp_mask);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->target_temp[nr] = val;
 	pwm_update_registers(data, nr);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3055,10 +3113,13 @@ store_target_speed(struct device *dev, struct device_attribute *attr,
 	val = clamp_val(val, 0, 1350000U);
 	speed = fan_to_reg(val, data->fan_div[nr]);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->target_speed[nr] = speed;
 	pwm_update_registers(data, nr);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3092,7 +3153,10 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
 	/* Limit tolerance as needed */
 	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, data->tolerance_mask);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->temp_tolerance[index][nr] = val;
 	if (index)
 		pwm_update_registers(data, nr);
@@ -3100,7 +3164,7 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
 		data->write_value(data,
 				  data->REG_CRITICAL_TEMP_TOLERANCE[nr],
 				  val);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3169,10 +3233,13 @@ store_speed_tolerance(struct device *dev, struct device_attribute *attr,
 	/* Limit tolerance as needed */
 	val = clamp_val(val, 0, data->speed_tolerance_limit);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->target_speed_tolerance[nr] = val;
 	pwm_update_registers(data, nr);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3220,10 +3287,13 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
 
 	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->weight_temp[index][nr] = val;
 	data->write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3269,10 +3339,13 @@ store_fan_time(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	val = step_time_to_reg(val, data->pwm_mode[nr]);
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->fan_time[index][nr] = val;
 	data->write_value(data, data->REG_FAN_TIME[index][nr], val);
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3310,7 +3383,10 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 			val = 0xff;
 	}
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->auto_pwm[nr][point] = val;
 	if (point < data->auto_pwm_num) {
 		data->write_value(data,
@@ -3355,7 +3431,7 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 			break;
 		}
 	}
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3391,7 +3467,10 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
 	if (val > 255000)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->auto_temp[nr][point] = DIV_ROUND_CLOSEST(val, 1000);
 	if (point < data->auto_pwm_num) {
 		data->write_value(data,
@@ -3401,7 +3480,7 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
 		data->write_value(data, data->REG_CRITICAL_TEMP[nr],
 				    data->auto_temp[nr][point]);
 	}
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3570,7 +3649,9 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 10, &val) || val != 0)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
+	ret = data->lock(data);
+	if (ret)
+		return ret;
 
 	/*
 	 * Use CR registers to clear caseopen status.
@@ -3593,7 +3674,7 @@ clear_caseopen(struct device *dev, struct device_attribute *attr,
 
 	data->valid = false;	/* Force cache refresh */
 error:
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 	return count;
 }
 
@@ -3981,6 +4062,9 @@ static int nct6775_probe(struct platform_device *pdev)
 	}
 
 	mutex_init(&data->update_lock);
+	data->lock = nct6775_lock;
+	data->unlock = nct6775_unlock;
+
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
 	platform_set_drvdata(pdev, data);
@@ -4790,14 +4874,18 @@ static void nct6791_enable_io_mapping(struct nct6775_sio_data *sio_data)
 static int __maybe_unused nct6775_suspend(struct device *dev)
 {
 	struct nct6775_data *data = nct6775_update_device(dev);
+	int err;
+
+	err = data->lock(data);
+	if (err)
+		return err;
 
-	mutex_lock(&data->update_lock);
 	data->vbat = data->read_value(data, data->REG_VBAT);
 	if (data->kind == nct6775) {
 		data->fandiv1 = data->read_value(data, NCT6775_REG_FANDIV1);
 		data->fandiv2 = data->read_value(data, NCT6775_REG_FANDIV2);
 	}
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return 0;
 }
@@ -4806,10 +4894,13 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
-	int i, j, err = 0;
+	int i, j, err;
 	u8 reg;
 
-	mutex_lock(&data->update_lock);
+	err = data->lock(data);
+	if (err)
+		return err;
+
 	data->bank = 0xff;		/* Force initial bank selection */
 
 	err = sio_data->sio_enter(sio_data);
@@ -4868,7 +4959,7 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 abort:
 	/* Force re-reading all values */
 	data->valid = false;
-	mutex_unlock(&data->update_lock);
+	data->unlock(data, dev);
 
 	return err;
 }
-- 
2.33.0

