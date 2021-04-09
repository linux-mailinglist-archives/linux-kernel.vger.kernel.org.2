Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC63592E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhDIDPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhDIDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:15:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1CC061761;
        Thu,  8 Apr 2021 20:14:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g15so4555342qkl.4;
        Thu, 08 Apr 2021 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCEr/lMx7FsAiLfl2Pdo1+TelLDm1LXxs417pQtjTO4=;
        b=WCGU1vEc8rNC0hHMVK9W3z1ppOHE60a/heHMIzxpsY1We46a7Vru084NJ8uNvXg1+t
         aK08Pl0dL/rblQVymly0d0SBtXgbJkFUFRQulxIqfpZRb5h4TIdejsUf+Jcu0gBLNAYI
         vclAMKzlJt+u/dyGLcZCEcnesUDAbmTcdVxDKkix2ynhaUXV79caI7O7YBnSbUeD8W4t
         RPJw3butr2hijX7toFEnpH45IgC3DvvzEoAx/LgPr/n0FV0QTT6V91K4C3D5HEeB5UhT
         3urpVtPrcQEN/y/qPk9GiBPFeQby+FVlbrutOuROu7QcYhb7nlMTka7XBIUdLk9hh/5Z
         7UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCEr/lMx7FsAiLfl2Pdo1+TelLDm1LXxs417pQtjTO4=;
        b=hSg8Dv7coNNJj5Hl4/B/CY+3L4dMgDhv8Lid2MhoLN/mILHRSZH326VX5dU20lA6PR
         yZTNYgkWQYEKtctFosdkB55LREtUfhjJgP0vpkyrQYJPheurOJq//1C+cYGhRRGnayrX
         fs2MWj5E3EyEocGGp6Pj4j4QVElfs5B+uKb74cdvZ6eK6CpVBKHX6OaLY3wN6XNeB4vY
         8qp7QnS91e2zXwfR6mf1YLvuP1Yc22K8U/IMuhNW1sMlYvQdtrzcA0AI23LsT85asEd9
         sqVtI9DNttFsmrJSAUxLb4Q/h2nL7H4AYYqI1J2ChXhxk0DcTbg6BXN6LAcNamFCDDYl
         u2ZQ==
X-Gm-Message-State: AOAM532lV7/umFRL0fgU7mWtX5Lhs7PsBOyBsEQ32GMPjnKuraFJ3EP3
        6bLmnsvCEZU/KrzZxMgtsidrvyv0HyKjBj85
X-Google-Smtp-Source: ABdhPJzzW3ZRkKpzbugIUelOMpTzpLS2NYpMQE/1HuctrJgg5G8tcHz9CmGfsS9mQp79ydx9t+jsLw==
X-Received: by 2002:a37:a28e:: with SMTP id l136mr11916413qke.172.1617938098466;
        Thu, 08 Apr 2021 20:14:58 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id x1sm1003167qtr.97.2021.04.08.20.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:14:58 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v6 5/6] w1: ds2438: adding support for reading page1
Date:   Fri,  9 Apr 2021 00:15:32 -0300
Message-Id: <20210409031533.442123-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409030942.441830-1-sampaio.ime@gmail.com>
 <20210409031533.442123-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a sysfs entry to support reading the page1 registers. This registers
contain Elapsed Time Meter (ETM) data, which shows for how long the chip is
on, as well as an Offset Register data, which can be used to calibrate the
current measurement of the chip.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 .../ABI/stable/sysfs-driver-w1_ds2438         |  6 +++
 Documentation/w1/slaves/w1_ds2438.rst         |  8 ++++
 drivers/w1/slaves/w1_ds2438.c                 | 41 +++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-w1_ds2438

diff --git a/Documentation/ABI/stable/sysfs-driver-w1_ds2438 b/Documentation/ABI/stable/sysfs-driver-w1_ds2438
new file mode 100644
index 000000000000..fa47437c11d9
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-w1_ds2438
@@ -0,0 +1,6 @@
+What:		/sys/bus/w1/devices/.../page1
+Date:		April 2021
+Contact:	Luiz Sampaio <sampaio.ime@gmail.com>
+Description:	read the contents of the page1 of the DS2438
+		see Documentation/w1/slaves/w1_ds2438.rst for detailed information
+Users:		any user space application which wants to communicate with DS2438
diff --git a/Documentation/w1/slaves/w1_ds2438.rst b/Documentation/w1/slaves/w1_ds2438.rst
index a29309a3f8e5..ac8d0d4b0d0e 100644
--- a/Documentation/w1/slaves/w1_ds2438.rst
+++ b/Documentation/w1/slaves/w1_ds2438.rst
@@ -44,6 +44,14 @@ Internally when this file is read, the additional CRC byte is also obtained
 from the slave device. If it is correct, the 8 bytes page data are passed
 to userspace, otherwise an I/O error is returned.
 
+"page1"
+-------
+This file provides full 8 bytes of the chip Page 1 (01h).
+This page contains the ICA, elapsed time meter and current offset data of the DS2438.
+Internally when this file is read, the additional CRC byte is also obtained
+from the slave device. If it is correct, the 8 bytes page data are passed
+to userspace, otherwise an I/O error is returned.
+
 "temperature"
 -------------
 Opening and reading this file initiates the CONVERT_T (temperature conversion)
diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index ef6217ecb1cb..2cfdfedb584f 100644
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
@@ -325,6 +334,36 @@ static ssize_t page0_read(struct file *filp, struct kobject *kobj,
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
 static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
@@ -390,6 +429,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 
 static BIN_ATTR_RW(iad, 0664, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
+static BIN_ATTR_RO(page1, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
 static BIN_ATTR_RO(vdd, 0/* real length varies */);
@@ -397,6 +437,7 @@ static BIN_ATTR_RO(vdd, 0/* real length varies */);
 static struct bin_attribute *w1_ds2438_bin_attrs[] = {
 	&bin_attr_iad,
 	&bin_attr_page0,
+	&bin_attr_page1,
 	&bin_attr_temperature,
 	&bin_attr_vad,
 	&bin_attr_vdd,
-- 
2.30.1

