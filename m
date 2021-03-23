Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2963455A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCWCnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCWCna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:43:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA00C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:43:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x27so9762965qvd.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=o6fsDI+Eu3BcOTKNKsyQZCv8DTniOAR75zbdQTCvhpE=;
        b=I3P26Czz3fcfg+3RgROgOiwPSEukg6IzyxzFKvm0n8TwjG9p6N7h8wvlZ+82Bvhs4v
         4YgtWVqvX5ne+HD2pss7EArlUrxhptmQ7dm7FSUjJ6Ze/bP0nnQ9Uqu8USH+m8RCoiMM
         zTNrfsut4f4QdOkqdJqfpQZcRpbJKUOve9QP6OdQIdngH0+xiUD4xLRQHmuZjWBrAnAt
         anGYy8C9q8L/oTAZ8qaRYwL2STYAUBL8725a7NZ/Uzm3iB1Rj6ycJkBNYVR3n0G1zdT7
         p5UAWU1PoJjmPR8tVCe4o0gVV7Qn4MLaPkyOQ0YZ766eCpVHsV/I9iXeGu5Xm/g0N3TZ
         EcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=o6fsDI+Eu3BcOTKNKsyQZCv8DTniOAR75zbdQTCvhpE=;
        b=Q5VcnRzKOHqWe2z6cBf7UGxE6NSNSUiJerfwMPqj6vJ+XmYuUAqcNmBthMJldEQa4Z
         VxH9k0LLAkcDkCwm0OoEnKzcY0f5LS2FcmAUcq3LuZwQq7vZG28e81umzbmA7YEEwVR4
         n8OzjisUirxoYlaqwQcMXnE3ukXLAGaUTjb2N4g3lbce/hHPi16Hjpgbrtbc94kN9et+
         I/nO+wmajdLTZ5mGFn5L8jzV2ywIjLnF4rZC+PQE1RJl/XcwssMo+n+KcuybhYSWBsog
         hs6AnaJCmuZVYIuZmU8jf2FvTsK59OhYNpdHGAien0U4xiGPvV+prZrjxRgyAdj9cdpn
         z17w==
X-Gm-Message-State: AOAM530MGTs+6qK/9Aed+R99EX1d1yFgT5G01Mq8QW+ZXtdH+As00Cam
        cVJL/lx4wJ4rdRthGKXambU=
X-Google-Smtp-Source: ABdhPJxA3fmiDzbHxrEGCV0o5cITd1hjCc30S6bg9ZC7pAQHBCB59gQECmt9Of1Peuk1zL+hATxL0w==
X-Received: by 2002:a05:6214:1305:: with SMTP id a5mr3139428qvv.42.1616467408969;
        Mon, 22 Mar 2021 19:43:28 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:5155:3abd:5705:9236])
        by smtp.gmail.com with ESMTPSA id 18sm12736698qkr.77.2021.03.22.19.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:43:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:44:10 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     rikard.falkeborn@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] w1: ds2438: adding support for accessing page1 registers
Message-ID: <20210323024410.temxutbcfdswctz4@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ds2438 has a register in page1 called offset, which dictates
how the current measurement is done. If the offset register is not
calibrated well, pulling zero current from a battery shows a non-zero
current measurement.
Gives write access to the offset register. This way, a user following
the calibration steps explained in the datasheet can use this driver
to fully calibrate de current measurements.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 94 ++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 08f4b451c349..5d58986bb1a9 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -49,6 +49,15 @@
 #define DS2438_CURRENT_MSB		0x06
 #define DS2438_THRESHOLD		0x07
 
+/* Page #1 definitions */
+#define DS2438_ETM_0			0x00
+#define DS2438_ETM_1			0x01
+#define DS2438_ETM_2			0x02
+#define DS2438_ETM_3			0x03
+#define DS2438_ICA			0x04
+#define DS2438_OFFSET_LSB		0x05
+#define DS2438_OFFSET_MSB		0x06
+
 static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 {
 	unsigned int retries = W1_DS2438_RETRIES;
@@ -62,13 +71,13 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-		w1_buf[1] = pageno;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_READ_SCRATCH;
-		w1_buf[1] = pageno;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		count = w1_read_block(sl->master, buf, DS2438_PAGE_SIZE + 1);
@@ -182,6 +191,34 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 	return -1;
 }
 
+static int w1_ds2438_change_offset_register(struct w1_slave *sl, u8 *value)
+{
+	unsigned int retries = W1_DS2438_RETRIES;
+	u8 w1_buf[9];
+	u8 w1_page1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
+
+	if (w1_ds2438_get_page(sl, 1, w1_page1_buf) == 0) {
+		memcpy(&w1_buf[2], w1_page1_buf, DS2438_PAGE_SIZE - 1); /* last register is reserved */
+		w1_buf[7] = value[0]; /* change only offset register */
+		w1_buf[8] = value[1];
+		while (retries--) {
+			if (w1_reset_select_slave(sl))
+				continue;
+			w1_buf[0] = W1_DS2438_WRITE_SCRATCH;
+			w1_buf[1] = 0x01; /* write to page 1 */
+			w1_write_block(sl->master, w1_buf, 9);
+
+			if (w1_reset_select_slave(sl))
+				continue;
+			w1_buf[0] = W1_DS2438_COPY_SCRATCH;
+			w1_buf[1] = 0x01;
+			w1_write_block(sl->master, w1_buf, 2);
+				return 0;
+		}
+	}
+	return -1;
+}
+
 static int w1_ds2438_get_voltage(struct w1_slave *sl,
 				 int adc_input, uint16_t *voltage)
 {
@@ -323,6 +360,55 @@ static ssize_t page0_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
+static ssize_t page1_read(struct file *filp, struct kobject *kobj,
+			  struct bin_attribute *bin_attr, char *buf,
+			  loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int ret;
+	u8 w1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
+
+	if (off != 0)
+		return 0;
+	if (!buf)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	/* Read no more than page1 size */
+	if (count > DS2438_PAGE_SIZE)
+		count = DS2438_PAGE_SIZE;
+
+	if (w1_ds2438_get_page(sl, 1, w1_buf) == 0) {
+		memcpy(buf, &w1_buf, count);
+		ret = count;
+	} else
+		ret = -EIO;
+
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+static ssize_t offset_write(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *bin_attr, char *buf,
+			    loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int ret;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	if (w1_ds2438_change_offset_register(sl, buf) == 0)
+		ret = count;
+	else
+		ret = -EIO;
+
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
 static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
@@ -388,6 +474,8 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 
 static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
+static BIN_ATTR_RO(page1, DS2438_PAGE_SIZE);
+static BIN_ATTR_WO(offset, 2);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
 static BIN_ATTR_RO(vdd, 0/* real length varies */);
@@ -395,6 +483,8 @@ static BIN_ATTR_RO(vdd, 0/* real length varies */);
 static struct bin_attribute *w1_ds2438_bin_attrs[] = {
 	&bin_attr_iad,
 	&bin_attr_page0,
+	&bin_attr_page1,
+	&bin_attr_offset,
 	&bin_attr_temperature,
 	&bin_attr_vad,
 	&bin_attr_vdd,
-- 
2.30.1

