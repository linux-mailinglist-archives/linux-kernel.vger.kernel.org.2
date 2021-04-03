Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31123531EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhDCBYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhDCBYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F3C061797
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y5so6678075qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgJCJ7G9WsFRSEnwGQYG3Bq7W0RnA0TIITJ/rkubGEs=;
        b=SylagUkFGzSvNCwt42m46yHQhT9/Y56KfCklYbweuQihfoGxBSSgmGNIJJF2F4KAOb
         2FbxebrG7MuDapX8q/aDOBTxByhLPVrsHchQ677L/I9pB69DahkLKQPvrz6V8sJZf2jV
         /ANQOHurFnjIgngngSg+nZUiPBf9DFXm1XHyLW030YdK5biyP0j4GaLqU7vv82R3KK0s
         UXH+rStENkAY+Yay4sjawaCPtTtUEi5LV5LLqsn/VXljo9OkcFrs0VpIbwk0Dy9sobb6
         PyUuhtTBwZgQb7iMJ7qZ+/qkcasxUO4MeTDeFQuVyox0OturmjNDAzM65aOEaQGzTnhE
         NITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgJCJ7G9WsFRSEnwGQYG3Bq7W0RnA0TIITJ/rkubGEs=;
        b=oMESCWIZxdRxd59kbMvGwj52Iv54ueBxOe8Y20tZJXVYe8ZbAqahNbAsmSjltpZ1VM
         Z43N+LufYX8xDd7BJ5+w38edPAA3Lp8NomYTY5hhY86WgKu9j5mZe2jpxnlJsxy4+MQw
         EUsgaQRqAchHel2Bd+Oa0jMINJfxJ8jW0HlnPuuS0yuM3mPQ1KHz6mrP+bL8TV6ZEJyr
         K5UF2/2AwJWAs3gYNeONv9fgLOQ6xYWDFzn9wKOPYtRTqadgfY0ndDZGaLGVbX8b8Bos
         nUSojTMLvqa/MgXsBx9LxMM6oFHuAbugiazoeziPLkJdBULgRrIMR3I0JPa7fz1qoXYM
         mB/Q==
X-Gm-Message-State: AOAM533LvGUDu4hXxr+XhckLXdrSWTH0O5KF/XnpoSrhNn+PNgX9nffK
        Dyn1LgKSFZw0pb+Qczom/Kk=
X-Google-Smtp-Source: ABdhPJzP1CJheaowCEraspMWUSNZqLyqtR8OCzrSrl7UszWIryOMskFsimS9R++Bp1ViKtWwgCXUUg==
X-Received: by 2002:a37:94f:: with SMTP id 76mr16650598qkj.222.1617413061010;
        Fri, 02 Apr 2021 18:24:21 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:20 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 8/9] w1: ds2438: adding support for reading page1
Date:   Fri,  2 Apr 2021 22:24:45 -0300
Message-Id: <20210403012446.381516-9-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
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
 
 static BIN_ATTR(iad, 0664, iad_write, 0);
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

