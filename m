Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94F394B38
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhE2JPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:15:32 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:56922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229620AbhE2JPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:15:31 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CCB57100E7B42;
        Sat, 29 May 2021 09:13:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id E675D18A604;
        Sat, 29 May 2021 09:13:53 +0000 (UTC)
Message-ID: <60eedce497137eb34448c0c77e01ec9d9c972ad7.camel@perches.com>
Subject: [PATCH] hwmon: sht4x: Fix sht4x_read_values return value
From:   Joe Perches <joe@perches.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 29 May 2021 02:13:52 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.66
X-Stat-Signature: 4wbf4s4ypcwrmhag7pj75ocoyqzuy1bu
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E675D18A604
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19kNQLzypCLG+19PoCGAAPXoLICf6Y7Sxo=
X-HE-Tag: 1622279633-450579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc for sht4x_read_values() shows 0 on success, 1 on failure but
the return value on success is actually always positive as it is set to
SHT4X_RESPONSE_LENGTH by a successful call to i2c_master_recv().

Miscellanea:

o Update the kernel doc for sht4x_read_values to 0 for success or -ERRNO
o Remove incorrectly used kernel doc /** header for other _read functions
o Typo fix succesfull->successful
o Reverse a test to unindent a block and use goto unlock
o Declare cmd[SHT4X_CMD_LEN] rather than cmd[]

At least for gcc 10.2, object size is reduced a tiny bit.

$ size drivers/hwmon/sht4x.o*
   text	   data	    bss	    dec	    hex	filename
   1752	    404	    256	   2412	    96c	drivers/hwmon/sht4x.o.new
   1825	    404	    256	   2485	    9b5	drivers/hwmon/sht4x.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---

compiled, untested, no hardware

 drivers/hwmon/sht4x.c | 95 ++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index 1dc51ee2a72ba..09c2a0b064444 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -67,7 +67,7 @@ struct sht4x_data {
 /**
  * sht4x_read_values() - read and parse the raw data from the SHT4X
  * @sht4x_data: the struct sht4x_data to use for the lock
- * Return: 0 if succesfull, 1 if not
+ * Return: 0 if successful, -ERRNO if not
  */
 static int sht4x_read_values(struct sht4x_data *data)
 {
@@ -75,51 +75,53 @@ static int sht4x_read_values(struct sht4x_data *data)
 	u16 t_ticks, rh_ticks;
 	unsigned long next_update;
 	struct i2c_client *client = data->client;
-	u8 crc, raw_data[SHT4X_RESPONSE_LENGTH],
-	cmd[] = {SHT4X_CMD_MEASURE_HPM};
+	u8 crc;
+	u8 cmd[SHT4X_CMD_LEN] = {SHT4X_CMD_MEASURE_HPM};
+	u8 raw_data[SHT4X_RESPONSE_LENGTH];
 
 	mutex_lock(&data->lock);
 	next_update = data->last_updated +
 		      msecs_to_jiffies(data->update_interval);
-	if (!data->valid || time_after(jiffies, next_update)) {
-		ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
-		if (ret < 0)
-			goto unlock;
-
-		usleep_range(SHT4X_MEAS_DELAY,
-			     SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
-
-		ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
-		if (ret != SHT4X_RESPONSE_LENGTH) {
-			if (ret >= 0)
-				ret = -ENODATA;
-
-			goto unlock;
-		}
-
-		t_ticks = raw_data[0] << 8 | raw_data[1];
-		rh_ticks = raw_data[3] << 8 | raw_data[4];
-
-		crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
-		if (crc != raw_data[2]) {
-			dev_err(&client->dev, "data integrity check failed\n");
-			ret = -EIO;
-			goto unlock;
-		}
-
-		crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
-		if (crc != raw_data[5]) {
-			dev_err(&client->dev, "data integrity check failed\n");
-			ret = -EIO;
-			goto unlock;
-		}
-
-		data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
-		data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
-		data->last_updated = jiffies;
-		data->valid = true;
+
+	if (data->valid && time_before_eq(jiffies, next_update))
+		goto unlock;
+
+	ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
+	if (ret < 0)
+		goto unlock;
+
+	usleep_range(SHT4X_MEAS_DELAY, SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
+
+	ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
+	if (ret != SHT4X_RESPONSE_LENGTH) {
+		if (ret >= 0)
+			ret = -ENODATA;
+		goto unlock;
+	}
+
+	t_ticks = raw_data[0] << 8 | raw_data[1];
+	rh_ticks = raw_data[3] << 8 | raw_data[4];
+
+	crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
+	if (crc != raw_data[2]) {
+		dev_err(&client->dev, "data integrity check failed\n");
+		ret = -EIO;
+		goto unlock;
 	}
 
+	crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
+	if (crc != raw_data[5]) {
+		dev_err(&client->dev, "data integrity check failed\n");
+		ret = -EIO;
+		goto unlock;
+	}
+
+	data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
+	data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
+	data->last_updated = jiffies;
+	data->valid = true;
+	ret = 0;
+
 unlock:
 	mutex_unlock(&data->lock);
 	return ret;
@@ -132,19 +134,14 @@ static ssize_t sht4x_interval_write(struct sht4x_data *data, long val)
 	return 0;
 }
 
-/**
- * sht4x_interval_read() - read the minimum poll interval
- *			   in milliseconds
- */
+/* sht4x_interval_read() - read the minimum poll interval in milliseconds */
 static size_t sht4x_interval_read(struct sht4x_data *data, long *val)
 {
 	*val = data->update_interval;
 	return 0;
 }
 
-/**
- * sht4x_temperature1_read() - read the temperature in millidegrees
- */
+/* sht4x_temperature1_read() - read the temperature in millidegrees */
 static int sht4x_temperature1_read(struct sht4x_data *data, long *val)
 {
 	int ret;
@@ -158,9 +155,7 @@ static int sht4x_temperature1_read(struct sht4x_data *data, long *val)
 	return 0;
 }
 
-/**
- * sht4x_humidity1_read() - read a relative humidity in millipercent
- */
+/* sht4x_humidity1_read() - read a relative humidity in millipercent */
 static int sht4x_humidity1_read(struct sht4x_data *data, long *val)
 {
 	int ret;

