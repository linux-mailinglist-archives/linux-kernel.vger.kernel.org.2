Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C90F35414A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhDEKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhDEKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CAC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:44 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g20so11033802qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtQ+rBpGR8emFNv+2pInaqsN6Vcqx8BsiWr4G6jFMQs=;
        b=tkBlrCQeZH6CXg71kGRcNJk+XU8Qb0C8xs3rD3nOmsJE2C7ga2n5Qsg+xNK0Iog2Op
         KB3p34nmF7/pGRgQba+T5sDrZ4Ft1//eifXQMyEPx6/WBSx8pQrJ/yZ1+mIHnleEQU4h
         4QxVc7TBI5gqFx24TaCSEhg67IXC1enfWr/M8ybr+9i52BMuUGw+mjbaF8waEoqZTBi6
         db8xAr23pBk+yRaSYTlwxb/kd0Srz9K0V/MPHTSWVYmfCcSeDG1lRKpTmQ/Hh7pifLIg
         ZT+CvSiksHXueVQ0pcb5+SxTVdQHAYflSkhdJ/XyskzDyTcpuFaspNEWNjNgSnoSsmt7
         rtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtQ+rBpGR8emFNv+2pInaqsN6Vcqx8BsiWr4G6jFMQs=;
        b=LDCgEW455L+65H8pBBeaoA6w+iixoSMtSBEwmDCSyUb4vm5xfSyWIqLaCHdA99nz9x
         h489RWTKBrwIiLc7clXkKnZJo/h0nVFxMIdg+Cnr+K6o2b1gXkW8Cc3TNt+OdI5JVlJr
         g0GHySdZ/zdCbRx/QXoXu7sTv+jEISh+UCRr0LR1/dpOYxoi2zZvPa+MO35eDSBXaDXo
         ALfjFr92yMgjMbRFdG52rLpeFKb8IFuodMIFknfETcUmK1ASfzJJV08705rLF4g4AV5B
         sgBXwai6K3gaK7XP3gRotccn4bITenZxUJvhAxPG2shWiU5KzD7/RHvPx/tnJ4CLMoYq
         Vyjg==
X-Gm-Message-State: AOAM532gLhu2k1BHWdNSBP5YSrf6s6DOU75iRStlhYoXx22OKkSkXzsa
        2thLia4efez+GM79edfPFLC1aM6q8mTID4qa
X-Google-Smtp-Source: ABdhPJxoPh/mkZcpQWtajUVCjUnKd1/ZCo1kzcxKFPCczroPj7YIosQY9cvUA+z7ENde5MDCvmbuNg==
X-Received: by 2002:a37:6348:: with SMTP id x69mr23053833qkb.154.1617619783725;
        Mon, 05 Apr 2021 03:49:43 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:43 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 8/9] w1: ds2438: adding support for reading page1
Date:   Mon,  5 Apr 2021 07:50:08 -0300
Message-Id: <20210405105009.420924-9-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
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

