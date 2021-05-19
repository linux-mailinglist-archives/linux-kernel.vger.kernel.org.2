Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A784389957
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhESWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhESWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:31:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DBC06175F;
        Wed, 19 May 2021 15:29:50 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k4so3291005qkd.0;
        Wed, 19 May 2021 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oLkd2BFmvyOKIIVIKSB47lAlzpITnkbcma+rS4i+f4=;
        b=M7/uMs4uOWPQGG6ys73fVHklBVvxYef5A4uyjv1faBK/y2DN1Brj/R7NXfO+zfWlnO
         I2/a4jS61+IXZyhdWvvb1MawlJJ5n2zb3YMshljbqaxg46ABfoovgVdY+hyrXxzkQEYW
         dGJ3njUH0hDxrGHtoFaz2tkCNHKnMitxerREaM0PatOc9Lzdv8BfaCXHvgJMSFx5a8ui
         OVW8Gd+oICZOvm6YK93p8rccxDZKPLa0sS/vdC+Cytm1c9qvUTDdaNvJVwhSZe5x3Owr
         WIwSIBk/BSUwNk85pf/4rsOwfa0WLHO6PSx9BoXTF6PX5YevEf7UGI8uUQR+Id4AnUfl
         dl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oLkd2BFmvyOKIIVIKSB47lAlzpITnkbcma+rS4i+f4=;
        b=hGw26CoKsw2swE9k+izRAG2/X5uBQZa/DN4iVqXKvX/wbx1N5n6qoxwnfm+RYKrUin
         jIKgVSArMlS1SO7cbtAOUttmUOENiu806dvs5EknKI5fCcSIEA0zvSpYrTqG5zQ/FoM6
         RLgspOctSy+mhk3Fmu/5P4wd7aPr5F+NNap84RBIvdNOwQkQHyM1iBtAqYBCcZ0w66GC
         t2Gtp055HFHpd5WE04MmT5UIQT2vLADlX7GSleApXdmi+r6VfgrDQmI4Tz/vuu7cExBI
         PazxufP51qsFSIj16MnMu+xBdJg8Ja2PXizNJqni/Ae7x4DbaNgzUZfPHzgs0ertfRZc
         WuOQ==
X-Gm-Message-State: AOAM532b7oPtD7x4SIv0SWJWBoFYTbLndPbJquVjrQSCZKpdKr6jd0Ko
        17xASq2U5wmv6lodh7RzjHc=
X-Google-Smtp-Source: ABdhPJwABm3nKfiB4f+H0r4INFR7J+pQ9Nqli+Q29VJEKNsKIc7LYQpMFqKkC4VO//qoMJTKlBbZsg==
X-Received: by 2002:a37:a4c1:: with SMTP id n184mr1716069qke.309.1621463390131;
        Wed, 19 May 2021 15:29:50 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8175:da27:c352:bf96:2102:fa64])
        by smtp.gmail.com with ESMTPSA id d18sm823716qkc.28.2021.05.19.15.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:29:49 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v8 5/6] w1: ds2438: adding support for reading page1
Date:   Wed, 19 May 2021 19:30:45 -0300
Message-Id: <20210519223046.13798-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210519223046.13798-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210519223046.13798-1-sampaio.ime@gmail.com>
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

