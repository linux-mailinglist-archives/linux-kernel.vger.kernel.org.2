Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD14359297
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhDIDJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhDIDJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C6C061760;
        Thu,  8 Apr 2021 20:09:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j7so3201634qtx.5;
        Thu, 08 Apr 2021 20:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6Wc89M3j0umVbjEkf3mvJkNF2N7fCde5VZ2Drv+qCI=;
        b=nBnWk2xi6gQu9OSzWyE75SRa8A+O7tCZOpcqWEKVIs6uqriPNlU7GBnVyI1zi1VUCI
         04umE7aSvXhBpmjelSL4AgW8iMJeDNi6ooXdQ18OvH8mBSoE3eiihm0RDbK698MBggZc
         7HC0KwYZQwDPpVCdSLdaBX5nzBUzMogoB+LBgf2ZrGchSxEsgu0RXv+LPhA0FjpKNEI/
         1zfR1fz91gH8aESx35m+nhXbR6F+OYUfEbFQRIzvommcyI2yLxGXVsjbkgfCab4YmB4R
         ywzhw/qvwXGAdnB3dIBkPEF/dHKNypLCkdyl/cA/ml+tR5u7Clce2WWoEKzGFMhhY7zE
         2ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6Wc89M3j0umVbjEkf3mvJkNF2N7fCde5VZ2Drv+qCI=;
        b=FzegYvedMEiHkHJtPJ7BUVH4uQWqpTLPB2XE4XYkjlGM+xo6lbiV0shcFOUP7qB8l/
         C9x4JeeH39to4Ra4p6ozVNfm/9dWDinN6zt/Tmaaw0o8yM7+oc3Tw6PHy4SlCo5ei1C8
         IuJs4gLufk2OPz4DJN5wGpoQSMwlczzWa7QxaSUKCR2qX31TOR9q8FoH6RM60RXwY9MH
         DxOmNoChjl/z0Vd/aBJiKY4rdmdeLa0OK8/eHjp/DjMXBm+Q7OlCjPhMiG36hH0QcYPd
         4+dNwNR8rn2ipnvdYRBDtZrHovARYNazzomd156MSDJ9FCRKHFIsWMwXYw8FmQ4Bnztw
         uugg==
X-Gm-Message-State: AOAM531o9FjAfjwypq1vmqb9rihZR9bwcjK3fcY4H6PJPWP7z6dCP1g/
        GviHIG8kiy1w/7ywVKCPO4I=
X-Google-Smtp-Source: ABdhPJwiCurRALTPU9K2pFrFESlQTzwa0OAYWrSd/KMsTDXm3BRbq0yn78iy16+sDBOZaesAdzZ84g==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr10638707qtw.173.1617937751451;
        Thu, 08 Apr 2021 20:09:11 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id c5sm925408qkl.21.2021.04.08.20.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:11 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v5 6/6] w1: ds2438: support for writing to offset register
Date:   Fri,  9 Apr 2021 00:09:42 -0300
Message-Id: <20210409030942.441830-7-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409030942.441830-1-sampaio.ime@gmail.com>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210409030942.441830-1-sampaio.ime@gmail.com>
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
 .../ABI/stable/sysfs-driver-w1_ds2438         |  7 +++
 Documentation/w1/slaves/w1_ds2438.rst         | 11 ++++-
 drivers/w1/slaves/w1_ds2438.c                 | 49 +++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-w1_ds2438 b/Documentation/ABI/stable/sysfs-driver-w1_ds2438
index fa47437c11d9..d2e7681cc287 100644
--- a/Documentation/ABI/stable/sysfs-driver-w1_ds2438
+++ b/Documentation/ABI/stable/sysfs-driver-w1_ds2438
@@ -4,3 +4,10 @@ Contact:	Luiz Sampaio <sampaio.ime@gmail.com>
 Description:	read the contents of the page1 of the DS2438
 		see Documentation/w1/slaves/w1_ds2438.rst for detailed information
 Users:		any user space application which wants to communicate with DS2438
+
+What:		/sys/bus/w1/devices/.../offset
+Date:		April 2021
+Contact:	Luiz Sampaio <sampaio.ime@gmail.com>
+Description:	write the contents to the offset register of the DS2438
+		see Documentation/w1/slaves/w1_ds2438.rst for detailed information
+Users:		any user space application which wants to communicate with DS2438
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
+		memcpy(&w1_buf[2], w1_page1_buf, DS2438_PAGE_SIZE - 1); /* last register reserved */
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

