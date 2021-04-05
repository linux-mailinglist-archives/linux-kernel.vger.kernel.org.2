Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8821335414B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhDEKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhDEKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030EC061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:46 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i9so11037703qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ct0KqhECfaQPeqAmFu0by9DQtEz5Znm3fSMIKLGYhYE=;
        b=DkSguq++pTjCYht7EtcS+T+L2yRunJJ4vGhzTvEoXxoxlHj0vQ8SeNyU/25L3JZ/A4
         PWoSx0AoTd9MWqd2jLuiVpxmWfCkG6eSfnrMdjvemtKecec3kiHHLQDPE7WZN+0f8MSE
         oXZ2tBpV6Go1c1vvba8tEFm+Ux4x7AsR8wbehiJb4DGq+EOUakiRmAtyKpQIasNvec3B
         +UEMwPtE3E4gSauGJ4vofYpj+OxkEBxXbwyqoNZOZNSg5gpo+5hdGyz7ziN0ah95HD5S
         Id0co+unWo6OYHFQ9eERBh2VJ2CPg9Yt0Xn0BHDL9j+bWED307o5npJbM2wLfaTmPKNl
         aR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ct0KqhECfaQPeqAmFu0by9DQtEz5Znm3fSMIKLGYhYE=;
        b=BpIIKn6RtVamKHU8OMgvhntnlUYLcInOeV37uARj9Ij9xPtRJraWzSucQAAiTKuBT+
         lTnBXH90Hebs1qpbUJB+mszoJ71yRmjB2paN1Ybfjp+wDKO0Ec+bLFB0QVLsnxS87LTo
         WwnERf8TbXUndUYZHCu10WiVQwyvWI8QgMZX7qdW+MME3+KxRu8l15kUQ7tTtKeXeuGi
         dIZEbgWYYEIiF6kLLZwVbqEGAA9OZoT50lVx8AmF382F/mvTjIEu0vGVGI014hsKiBpu
         mqqD8mt0/uZ1vSDPe6ToOKpe3Ve4vy3bqkQaF3yXRpbXeDF46GIS3zwt1/lJ4/XDV5jX
         600A==
X-Gm-Message-State: AOAM5313iyuQFO3VFwms5wap7mHNHpy6v6cs7bjKE6tEQ71mTtuANiz/
        an/5sAVwI9B0fCbdZn0JS8Q=
X-Google-Smtp-Source: ABdhPJx515b121eIGEWMLuftmFc+FdgAqabKjk1CD/b7mn+DSXJbWD+vWogxSTRr52D3Wz3TqCZETg==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr23389902qkm.306.1617619786003;
        Mon, 05 Apr 2021 03:49:46 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:45 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 9/9] w1: ds2438: support for writing to offset register
Date:   Mon,  5 Apr 2021 07:50:09 -0300
Message-Id: <20210405105009.420924-10-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
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
 static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
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

