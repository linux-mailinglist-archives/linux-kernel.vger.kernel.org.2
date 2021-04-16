Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8940362AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhDPWRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhDPWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:17:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42204C061761;
        Fri, 16 Apr 2021 15:17:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y12so21948554qtx.11;
        Fri, 16 Apr 2021 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oLkd2BFmvyOKIIVIKSB47lAlzpITnkbcma+rS4i+f4=;
        b=M4lLvanfEbK6xSdJm5LNwUO+mluOUkVYtH5MIxBpo12ydYDWfRf6YMc6jPLm7jtLZ+
         6by6G5itEOcfkKojYM+SjnNh/WhP2HIbRViwAHZygotY1muPb2t++NJPVjt8TWyhH586
         R+Apn6dzZmf0T8kU++U1k0fncTAB5OIhVsUoEeQfEAlM0rFqcBAAEprGtYLEFGBzf2dk
         k+g3pehTLZVcrN81JudE5KVLJJBtAWAxDlDAy63P5jbDT3/JH8nGzaImjv4he6dtb2Wx
         YGFjhiu/1/fppxH7O9Z1swZmSj0vBzAs9OP869cqF5FPUVjvyR/TRrx08MPZm4w5PGC+
         v9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oLkd2BFmvyOKIIVIKSB47lAlzpITnkbcma+rS4i+f4=;
        b=s0wjozulmSH8XbP2zIK3x+6rfY0dhCV3EeK9Udh2A6b9AY5tJjhoFXimdTXRii2jcy
         vItyYmuHIeBGyVPje2OhCPLn+d96uRhpFQGcZdTqfJULuKcoD9KTErzIO6NkRXfeRuxt
         OquHL5DtVRFgd7Zza8f6XKrZkzN4i4b390DvwMmRFnCQBMZsevfNZE8bVFwD4xt5aESD
         2bTrj4BSzfSHBbAbvATpteukit7XbXqDR4JfuH6NzuB37zJKDyEk4oCgOH3KyFC/a4E2
         PVDHVSSliuJ5xRUCEEGO2XiPqhtvZqtZFXFm+VbpPyAzABxyC8C1Ffo7WPccT2ZYXxTA
         FjiQ==
X-Gm-Message-State: AOAM530DdtgjW63A9tcYn6iXE7qzT65LBdX310/oiUKNmWNL9SygP4T4
        zAFB7G8WIlwspWdtjGOLcTk=
X-Google-Smtp-Source: ABdhPJyfz8/ZvFzW9HfA6bow7fvWqeKvoy29lRUopcQdFM5h6mu79T12+auZtE3dbAr7/Tv9BacTtw==
X-Received: by 2002:ac8:7a6f:: with SMTP id w15mr915283qtt.153.1618611419536;
        Fri, 16 Apr 2021 15:16:59 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id y6sm5131166qkd.106.2021.04.16.15.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:16:59 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v7 5/6] w1: ds2438: adding support for reading page1
Date:   Fri, 16 Apr 2021 19:17:38 -0300
Message-Id: <20210416221739.501090-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210416221739.501090-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210416221739.501090-1-sampaio.ime@gmail.com>
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
index 1e95f3a256c7..42080ae779f0 100644
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
 
 static BIN_ATTR_RW(iad, 0);
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

