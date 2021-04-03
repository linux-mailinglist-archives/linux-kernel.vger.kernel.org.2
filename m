Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB035329F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhDCEsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbhDCEr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:56 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA7C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:53 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y12so4936938qtx.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtQ+rBpGR8emFNv+2pInaqsN6Vcqx8BsiWr4G6jFMQs=;
        b=aIB2oKHudeRH1VkMxxcDesI2zS8ACQkMTK2QaUsH/4Q2nDT51LKq+JUzSo1MXd8rg7
         x/kG4DFZl++g2gPZ1QG6gScBjEjpX+ddKtWt1y5mwTNeyTn2fIZk8658vgbZy1R+SM1J
         j8j7V6cG5enYvFFmUUU5KuYQLQHLF8Rkp7HVZAjW9hihQF4Uxton8M633L/YHRiBMD/C
         1XJUYzk56u5gLeFW4IzQZn5+ZWI6ZM0gRsOTcVa+D3fSz2GJiD6mgyTIgRTX7QMJ5dOU
         Mf5w5RAhEjujhmHLb1P5F7JbIzGqyXBNSDNNOIptXoNrpz+DCOqWlZ7PcvpzJtANj7GC
         LReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtQ+rBpGR8emFNv+2pInaqsN6Vcqx8BsiWr4G6jFMQs=;
        b=AIo6I0Sd9YhJev7nBbY651r4oLk2dmRJkdc+QsKfvs9GoHdUHV/tnbWC8kHb75Pxvg
         CpWeB2pk//OpSsl6/yWUXJ18E2/nhEUJe7o7o1I8/MRJuX1lB6asxCJqUFfYBV4M622y
         Za6peP+CYAxzxyKVBPSj9Mc5sgyeIcyhQVE/bKTHnTRXPqp73Ur4Di6+gIzRuJtriEBQ
         VFQpz0IOIf1/J7Rw5pFGWoUlJlB3RWUoHNv8nbXDXSsTj6BlGFtHuK4xSi/U7sM1lr6Z
         lg5ve/k2d2PRrwByMsTKrbJ3v3E0Gd2pi4qRxQ0lRfwcaxgRv9SiUGsDbtnda/q3SphP
         L9+Q==
X-Gm-Message-State: AOAM531pUI+bKX6BD4yb/FJVsjMZT92W3mTq2EaPa7WtGYVGsNbHX4M4
        YHQqcdQuN8Sge+D/IjfopuU=
X-Google-Smtp-Source: ABdhPJzii66LLrKa4BZem2CGUnHOAKhEFtX/gBN8CSOe0+wzeQg8G6nAEANPZQi37IWDLcD8LQ32eA==
X-Received: by 2002:a05:622a:1342:: with SMTP id w2mr13882736qtk.163.1617425272935;
        Fri, 02 Apr 2021 21:47:52 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:52 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 8/9] w1: ds2438: adding support for reading page1
Date:   Sat,  3 Apr 2021 01:48:20 -0300
Message-Id: <20210403044821.390485-8-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
 <20210403044821.390485-1-sampaio.ime@gmail.com>
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
 Documentation/w1/slaves/w1_ds2438.rst |  8 ++++++
 drivers/w1/slaves/w1_ds2438.c         | 41 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

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
 
 static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
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

