Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF973531EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhDCBYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbhDCBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:26 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D2C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x11so6655124qkp.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N394ltjrSYvOAjfcVhp6r3YR4QO8szbb0CJdODmZAFI=;
        b=SKxwoSHh7JgLGdXdFtneyU5rqsVrLT8JhbZvgd8aRs58CNoOVHjyncp4xkD8Zlzxe7
         gPs6FHb7rW2fdms/K7Exo3nFrRNWs/pCNxmpMIgLllZA1fMYVIJm3+zJ5U3VuBVeg+d2
         aqtMRZpu3Wa9bnmmMUFevsyf6ATn1UAgNIT64nWeWmXHaL5KHI2rGXcz2b6K0721AZ4y
         ot7BZBgUsPeFc9dQGyOzxdvA1S8BNxLYsokq2Fu52+LiFsiuDGM+U/qFhJ2UZXgfRRN1
         0hZ5q8qVBjiIjxJ/GVfDygjNW9fo9C5meSYxxZyUzAyLsmATydtkPxDh9LjZ4FYvGluq
         3svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N394ltjrSYvOAjfcVhp6r3YR4QO8szbb0CJdODmZAFI=;
        b=WDEg4Uq1L0GicEruLTzhlbovjfrvJoEGEpmx1T+E+bypSO8LPzdtBkggfZ5CmNDpqj
         s3RO52DLoqOlKnaq/Qkmytf4DbKKeaEqtHfnWABUCqrnEDYbJm+OaSoU/ia9rp6QKhxu
         MwZJZ0P0qw4Pm27smdnFaMkmpsJsLl3IbIh2Pcixn8Phpr+/nJ/7KRNfGvmNPZ7nYHi1
         ZPJ2Suc0yhNm0fpMuJgRzN8BHLa4+qBjUafJOhPzGif0UwWxziTQmfz+HjAc/zZ9K16x
         1M0KVmMHcesy/ideB6iQgNRN8ZRZ9EBbeZFbJmUG/dkbUST2HENW3ikmSV9+KmG2lqgR
         lANA==
X-Gm-Message-State: AOAM531wLXVh4UIXT9tkzvWMPjJ7/bcXBQvyt+tHgHTqL49EwkHMGVsB
        ekwtGooegKADVxvz51zbDok=
X-Google-Smtp-Source: ABdhPJwtuZ/WHAa691ocnSUzMwbQcy8cdo9/nExX88jkkOPKdAuJE68ANGCfV2JIvNUJjw5x8m026w==
X-Received: by 2002:a37:a785:: with SMTP id q127mr15171421qke.425.1617413063235;
        Fri, 02 Apr 2021 18:24:23 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:23 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 9/9] w1: ds2438: support for writing to offset register
Date:   Fri,  2 Apr 2021 22:24:46 -0300
Message-Id: <20210403012446.381516-10-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a sysfs entry to support writing to the offset register on page1.
This register is used to calibrate the chip canceling offset errors in the
current ADC. This means that, over time, reading the IAD register will not
return the correct current measurement, it will have an offset. Writing to
the offset register if the two's complement of the current register while
passing zero current to the load will calibrate the measurements. This
change was tested on real hardware and it was able to calibrate the chip
correctly.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 Documentation/w1/slaves/w1_ds2438.rst | 11 +++++-
 drivers/w1/slaves/w1_ds2438.c         | 49 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/w1/slaves/w1_ds2438.rst b/Documentation/w1/slaves/w1_ds2438.rst
index ac8d0d4b0d0e..5c5573991351 100644
--- a/Documentation/w1/slaves/w1_ds2438.rst
+++ b/Documentation/w1/slaves/w1_ds2438.rst
@@ -22,7 +22,7 @@ is also often used in weather stations and applications such as: rain gauge,
 wind speed/direction measuring, humidity sensing, etc.
 
 Current support is provided through the following sysfs files (all files
-except "iad" are readonly):
+except "iad" and "offset" are readonly):
 
 "iad"
 -----
@@ -52,6 +52,15 @@ Internally when this file is read, the additional CRC byte is also obtained
 from the slave device. If it is correct, the 8 bytes page data are passed
 to userspace, otherwise an I/O error is returned.
 
+"offset"
+-------
+This file controls the 2-byte Offset Register of the chip.
+Writing a 2-byte value will change the Offset Register, which changes the
+current measurement done by the chip. Changing this register to the two's complement
+of the current register while forcing zero current through the load will calibrate
+the chip, canceling offset errors in the current ADC.
+
+
 "temperature"
 -------------
 Opening and reading this file initiates the CONVERT_T (temperature conversion)
diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 2cfdfedb584f..223a9aae6e2d 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -193,6 +193,34 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 	return -1;
 }
 
+static int w1_ds2438_change_offset_register(struct w1_slave *sl, u8 *value)
+{
+	unsigned int retries = W1_DS2438_RETRIES;
+	u8 w1_buf[9];
+	u8 w1_page1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
+
+	if (w1_ds2438_get_page(sl, 1, w1_page1_buf) == 0) {
+		memcpy(&w1_buf[2], w1_page1_buf, DS2438_PAGE_SIZE - 1); /* register 7 is reserved */
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
@@ -364,6 +392,25 @@ static ssize_t page1_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
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
@@ -430,6 +477,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 static BIN_ATTR(iad, 0664, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(page1, DS2438_PAGE_SIZE);
+static BIN_ATTR_WO(offset, 2);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
 static BIN_ATTR_RO(vdd, 0/* real length varies */);
@@ -438,6 +486,7 @@ static struct bin_attribute *w1_ds2438_bin_attrs[] = {
 	&bin_attr_iad,
 	&bin_attr_page0,
 	&bin_attr_page1,
+	&bin_attr_offset,
 	&bin_attr_temperature,
 	&bin_attr_vad,
 	&bin_attr_vdd,
-- 
2.30.1

