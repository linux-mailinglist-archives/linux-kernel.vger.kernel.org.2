Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8673539407F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhE1KAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhE1KAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:00:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:59:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lr4-20020a17090b4b84b02901600455effdso3041459pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ech7hfZaIojKnV9tsKoHv3q10Rzb8xemM/T7fTbZ3w=;
        b=h3nnJ2TG85AThjl5XXS5CDqZXd3R47WbPmkzF4mAzjDVO+pR5HCQcyIY50qjTPc54a
         CjrRl+tjwuJGWeNF0wlNkz7g11f3S6EJBctF3wRyXoX6SaRN/tdYsml6pm8VWpBRQdID
         jmbHNazDrxGQw5EDA9cIBU12IZua8UGIpWy64sGA/Sfgy5a8IZtPf3IWZ59Sb0TjDz6m
         DMKP7CevMUu9dw5Mo56F3kmlqrjiJzlRJ98Bv+EU+pQ4T7a1eBmvCKn5nvaE3PBVlg9L
         My31mC5+QLH0jLZ+TpdKpTJ2UbXUIGfBF0VqV+lSc4uvYdJGV8LedFDWC6hm1TRZpT+D
         YU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ech7hfZaIojKnV9tsKoHv3q10Rzb8xemM/T7fTbZ3w=;
        b=Y7GQG0+J2voGFKbBBME2URkppvznYPVKxSU+OW4Rfm9IPd+MkEZPv3+tqA+/5Elv2D
         EeFeLhbyCm2IGzUSdJKSO0KaoDpQ+P35sXconBBDQfGF04dBJPnYyTXxSQiqfF6epEcs
         HiGs7ZYVfexErWEr4jSK4a7kvlEWHCAJAyYgSjEm3iIsmflk+Eb6Dc8QB+oO6/ET5azA
         GgAPWoA1vCE8CyeWRAyWhGykucwP5HZlIaOwGDt7+iEz73RyWC7uvx2X35HCeCcMJrlm
         SbBjjDwW6YyY9PPTnrVySsvmvHtsxAABUSgcTiOp/3xgVkJIWq77Cy3wIpGc8lPFxhwz
         SEzw==
X-Gm-Message-State: AOAM530WxryKVJM5QIdqz0gCqRG+dgZyRP6Jw+GmDaYF6X4YNi6tJFN5
        G/L+RN5k03S0W1meqn4cbBA0CNDBO5Fnag==
X-Google-Smtp-Source: ABdhPJxdmO1vVI/LRhtLLPXfC0h08HZD2Ptya1c0R1+vCcBMUA45wbTr4cwJUtUObpvY8I7kLg5ZwQ==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id nu10mr3511661pjb.70.1622195947985;
        Fri, 28 May 2021 02:59:07 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id 185sm4123339pfb.184.2021.05.28.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:59:07 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, Morris Ku <saumah@gmail.com>
Subject: [PATCH] mfd:Add SUNIX mfd & PCIe driver
Date:   Fri, 28 May 2021 17:58:45 +0800
Message-Id: <20210528095845.6991-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add SUNIX mfd & PCIe driver

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 sdc_mfd.c | 513 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sdc_mfd.h |  61 +++++++
 sdc_pci.c |  92 ++++++++++
 3 files changed, 666 insertions(+)
 create mode 100644 sdc_mfd.c
 create mode 100644 sdc_mfd.h
 create mode 100644 sdc_pci.c

diff --git a/driver/mfd/sdc_mfd.c b/driver/mfd/sdc_mfd.c
new file mode 100644
index 0000000..d0acd54
--- /dev/null
+++ b/driver/mfd/sdc_mfd.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC mfd driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Based on Intel Sunrisepoint LPSS core driver written by
+ * - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ * - Mika Westerberg <mika.westerberg@linux.intel.com>
+ * - Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ * - Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Copyright (C) 2015, Intel Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/pci.h>
+#include <linux/property.h>
+#include <linux/debugfs.h>
+#include <linux/idr.h>
+#include <linux/mfd/core.h>
+#include "sdc_mfd.h"
+
+struct cib_config {
+	unsigned int mem_offset;
+	unsigned int mem_size;
+	unsigned char ic_brand;
+	unsigned char ic_model;
+};
+
+struct cib_uart {
+	unsigned int io_offset;
+	unsigned char io_size;
+	unsigned int mem_offset;
+	unsigned int mem_size;
+	unsigned short tx_fifo_size;
+	unsigned short rx_fifo_size;
+	unsigned int significand;
+	unsigned char exponent;
+	unsigned char rs232_cap;
+	unsigned char rs422_cap;
+	unsigned char rs485_cap;
+	unsigned char ahdc_cap;
+	unsigned char cs_cap;
+	unsigned char rs422_end_cap;
+	unsigned char rs485_end_cap;
+};
+
+struct cib_info {
+	unsigned char number;
+	unsigned char type;
+	unsigned char version;
+	unsigned char total_length;
+	unsigned char resource_cap;
+	unsigned char event_type;
+
+	struct cib_config *config;
+	struct cib_uart *uart;
+};
+
+struct sdc_channel {
+	struct cib_info info;
+
+	struct property_entry *property;
+	struct resource *resource;
+	struct mfd_cell *cell;
+};
+
+struct sdc_mfd {
+	struct sdc_platform_info info;
+
+	unsigned char major_version;
+	unsigned char minor_version;
+	unsigned char available_chls;
+	unsigned char total_length;
+	char model_name[18];
+
+	struct sdc_channel *channels;
+
+	struct device *dev;
+	int devid;
+
+	struct dentry *debugfs;
+	struct debugfs_blob_wrapper debugfs_blob_model_name;
+};
+
+static DEFINE_IDA(sdc_devid_ida);
+static struct dentry *sdc_mfd_debugfs;
+static int sdc_serial_id = 1;
+
+static void sdc_get_config_info(struct cib_info *info, void __iomem *membase,
+				unsigned short ptr)
+{
+	unsigned int temp;
+	unsigned int offsetDW = 0;
+
+	if (!info || !info->config)
+		return;
+
+	offsetDW = 2;
+	info->config->mem_offset = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 3;
+	info->config->mem_size = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 4;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->config->ic_brand = (unsigned char)((temp & 0x0000ff00) >> 8);
+	info->config->ic_model = (unsigned char)((temp & 0x00ff0000) >> 16);
+}
+
+static void sdc_get_uart_info(struct cib_info *info, void __iomem *membase,
+				unsigned short ptr)
+{
+	unsigned int temp;
+	unsigned int offsetDW = 0;
+
+	if (!info || !info->uart)
+		return;
+
+	offsetDW = 2;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->io_offset = (unsigned int)((temp & 0x00ffffff));
+	info->uart->io_size = (unsigned char)((temp & 0xff000000) >> 24);
+	offsetDW = 3;
+	info->uart->mem_offset = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 4;
+	info->uart->mem_size = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 5;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->tx_fifo_size = (unsigned short)((temp & 0x0000ffff));
+	info->uart->rx_fifo_size = (unsigned short)((temp & 0xff0000) >> 16);
+	offsetDW = 6;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->significand = temp & 0x00ffffff;
+	info->uart->exponent =
+		(unsigned char)((temp & 0xff000000) >> 24);
+	offsetDW = 7;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->rs232_cap = (temp & 0x00000001) ? 0x01 : 0x00;
+	info->uart->rs422_cap = (temp & 0x00000002) ? 0x01 : 0x00;
+	info->uart->rs485_cap = (temp & 0x00000004) ? 0x01 : 0x00;
+	info->uart->ahdc_cap = (temp & 0x00000008) ? 0x01 : 0x00;
+	info->uart->cs_cap = (temp & 0x00000010) ? 0x01 : 0x00;
+	info->uart->rs422_end_cap = (temp & 0x00000040) ? 0x01 : 0x00;
+	info->uart->rs485_end_cap = (temp & 0x00000080) ? 0x01 : 0x00;
+}
+
+static int sdc_debugfs_add(struct sdc_mfd *sdc)
+{
+	struct dentry *root_dir;
+	struct dentry *chl_dir;
+	char chl_name[20];
+	struct sdc_channel *chl = NULL;
+	int i;
+
+	root_dir = debugfs_create_dir(dev_name(sdc->dev), sdc_mfd_debugfs);
+	if (IS_ERR(root_dir))
+		return PTR_ERR(root_dir);
+
+	debugfs_create_u32("devid", 0644, root_dir, &sdc->devid);
+	debugfs_create_u32("bus_number", 0644, root_dir, &sdc->info.bus_number);
+	debugfs_create_u32("device_number", 0644, root_dir,
+		&sdc->info.device_number);
+	debugfs_create_u32("irq", 0644, root_dir, &sdc->info.irq);
+	debugfs_create_u8("major_version", 0644, root_dir, &sdc->major_version);
+	debugfs_create_u8("minor_version", 0644, root_dir,
+		&sdc->minor_version);
+	debugfs_create_u8("available_chls", 0644, root_dir,
+		&sdc->available_chls);
+	sdc->debugfs_blob_model_name.data = sdc->model_name;
+	sdc->debugfs_blob_model_name.size = strlen(sdc->model_name) + 1;
+	debugfs_create_blob("model_name", 0644, root_dir,
+		&sdc->debugfs_blob_model_name);
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+		memset(chl_name, 0, sizeof(char) * 20);
+		sprintf(chl_name, "chl%d", i);
+		chl_dir = debugfs_create_dir(chl_name, root_dir);
+
+		if (!chl_dir) {
+			dev_warn(sdc->dev, "create chl %d debugfs fail\n", i);
+			continue;
+		}
+		debugfs_create_x8("number", 0644, chl_dir, &chl->info.number);
+		debugfs_create_x8("type", 0644, chl_dir, &chl->info.type);
+		debugfs_create_x8("version", 0644, chl_dir, &chl->info.version);
+		debugfs_create_x8("total_length", 0644, chl_dir,
+			&chl->info.total_length);
+		debugfs_create_x8("resource_cap", 0644, chl_dir,
+			&chl->info.resource_cap);
+		debugfs_create_x8("event_type", 0644, chl_dir,
+			&chl->info.event_type);
+
+		switch (chl->info.type) {
+		case 0x00:
+			if (!chl->info.config)
+				break;
+			debugfs_create_x32("mem_offset", 0644, chl_dir,
+				&chl->info.config->mem_offset);
+			debugfs_create_x32("mem_size", 0644, chl_dir,
+				&chl->info.config->mem_size);
+			debugfs_create_x8("ic_brand", 0644, chl_dir,
+				&chl->info.config->ic_brand);
+			debugfs_create_x8("ic_model", 0644, chl_dir,
+				&chl->info.config->ic_model);
+			break;
+
+		case 0x01:
+			if (!chl->info.uart)
+				break;
+			debugfs_create_x32("io_offset", 0644, chl_dir,
+				&chl->info.uart->io_offset);
+			debugfs_create_x8("io_size", 0644, chl_dir,
+				&chl->info.uart->io_size);
+			debugfs_create_x32("mem_offset", 0644, chl_dir,
+				&chl->info.uart->mem_offset);
+			debugfs_create_x32("mem_size", 0644, chl_dir,
+				&chl->info.uart->mem_size);
+			debugfs_create_x16("tx_fifo_size", 0644, chl_dir,
+				&chl->info.uart->tx_fifo_size);
+			debugfs_create_x16("rx_fifo_size", 0644, chl_dir,
+				&chl->info.uart->rx_fifo_size);
+			debugfs_create_x32("significand", 0644, chl_dir,
+				&chl->info.uart->significand);
+			debugfs_create_x8("exponent", 0644, chl_dir,
+				&chl->info.uart->exponent);
+			debugfs_create_x8("rs232_cap", 0644, chl_dir,
+				&chl->info.uart->rs232_cap);
+			debugfs_create_x8("rs422_cap", 0644, chl_dir,
+				&chl->info.uart->rs422_cap);
+			debugfs_create_x8("rs485_cap", 0644, chl_dir,
+				&chl->info.uart->rs485_cap);
+			debugfs_create_x8("ahdc_cap", 0644, chl_dir,
+				&chl->info.uart->ahdc_cap);
+			debugfs_create_x8("cs_cap", 0644, chl_dir,
+				&chl->info.uart->cs_cap);
+			debugfs_create_x8("rs422_end_cap", 0644, chl_dir,
+				&chl->info.uart->rs422_end_cap);
+			debugfs_create_x8("rs485_end_cap", 0644, chl_dir,
+				&chl->info.uart->rs485_end_cap);
+			break;
+		}
+	}
+
+	sdc->debugfs = root_dir;
+	return 0;
+}
+
+static void sdc_debugfs_remove(struct sdc_mfd *sdc)
+{
+	debugfs_remove_recursive(sdc->debugfs);
+}
+
+int sdc_probe(struct device *dev, struct sdc_platform_info *info)
+{
+	int ret;
+	int i;
+	int j;
+	int prop_index;
+	struct sdc_mfd *sdc = NULL;
+	unsigned int temp;
+	struct sdc_channel *chl = NULL;
+	unsigned short next_cib_ptr = 0;
+	unsigned short next_cib_ptr_backup = 0;
+	unsigned long bar1_io;
+	void __iomem *bar2_mem;
+	unsigned long bar2_length;
+
+	if (!info || !info->pdev || info->irq <= 0)
+		return -EINVAL;
+
+	sdc = devm_kzalloc(dev, sizeof(*sdc), GFP_KERNEL);
+	if (!sdc)
+		return -ENOMEM;
+
+	sdc->info.pdev = info->pdev;
+	sdc->info.bus_number = info->bus_number;
+	sdc->info.device_number = info->device_number;
+	sdc->info.irq = info->irq;
+
+	bar1_io = pci_resource_start(info->pdev, 1);
+
+	bar2_length = pci_resource_len(info->pdev, 2);
+	bar2_mem = devm_ioremap(dev, pci_resource_start(info->pdev, 2),
+		bar2_length);
+	if (!bar2_mem)
+		return -ENOMEM;
+
+	temp = readl(bar2_mem);
+	sdc->major_version = (unsigned char)((temp & 0x000000ff));
+	sdc->minor_version = (unsigned char)((temp & 0x0000ff00) >> 8);
+	sdc->available_chls = (unsigned char)((temp & 0x00ff0000) >> 16);
+	sdc->total_length = (unsigned char)((temp & 0xff000000) >> 24);
+
+	temp = readl(bar2_mem + 4);
+	next_cib_ptr = next_cib_ptr_backup =
+		(unsigned short)((temp & 0x0000ffff));
+
+	j = 0;
+	for (i = 0; i < 4; i++) {
+		temp = readl(bar2_mem + 8 + (i * 4));
+		sdc->model_name[j++] = (char)((temp & 0x000000ff));
+		sdc->model_name[j++] = (char)((temp & 0x0000ff00) >> 8);
+		sdc->model_name[j++] = (char)((temp & 0x00ff0000) >> 16);
+		sdc->model_name[j++] = (char)((temp & 0xff000000) >> 24);
+	}
+	sdc->model_name[strlen(sdc->model_name)] = 0x0a;
+
+	sdc->channels = devm_kzalloc(dev, sizeof(struct sdc_channel) *
+		sdc->available_chls, GFP_KERNEL);
+	if (!sdc->channels)
+		return -ENOMEM;
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+
+		next_cib_ptr_backup = next_cib_ptr;
+
+		temp = readl(bar2_mem + next_cib_ptr);
+		chl->info.number = (unsigned char)((temp & 0x000000ff));
+		chl->info.type = (unsigned char)((temp & 0x0000ff00) >> 8);
+		chl->info.version = (unsigned char)((temp & 0x00ff0000) >> 16);
+		chl->info.total_length =
+			(unsigned char)((temp & 0xff000000) >> 24);
+
+		temp = readl(bar2_mem + next_cib_ptr + 4);
+		next_cib_ptr = temp & 0x0000ffff;
+		chl->info.resource_cap =
+			(unsigned char)((temp & 0x00ff0000) >> 16);
+		chl->info.event_type =
+			(unsigned char)((temp & 0xff000000) >> 24);
+
+		switch (chl->info.type) {
+		case 0x00:
+			chl->info.config = devm_kzalloc(dev,
+				sizeof(struct cib_config), GFP_KERNEL);
+			if (!chl->info.config)
+				return -ENOMEM;
+			sdc_get_config_info(&chl->info, bar2_mem,
+				next_cib_ptr_backup);
+			break;
+
+		case 0x01:
+			chl->info.uart = devm_kzalloc(dev,
+				sizeof(struct cib_uart), GFP_KERNEL);
+			if (!chl->info.uart)
+				return -ENOMEM;
+			sdc_get_uart_info(&chl->info, bar2_mem,
+				next_cib_ptr_backup);
+
+			chl->property = devm_kzalloc(dev,
+				sizeof(struct property_entry) * 18, GFP_KERNEL);
+			if (!chl->property)
+				return -ENOMEM;
+			prop_index = 0;
+			chl->property[prop_index++] = PROPERTY_ENTRY_U32(
+				"bus_number", sdc->info.bus_number);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U32(
+				"device_number", sdc->info.device_number);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U32(
+				"irq", sdc->info.irq);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"number", chl->info.number);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"version", chl->info.version);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"resource_cap", chl->info.resource_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"event_type", chl->info.event_type);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U16(
+				"tx_fifo_size", chl->info.uart->tx_fifo_size);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U16(
+				"rx_fifo_size", chl->info.uart->rx_fifo_size);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U32(
+				"significand", chl->info.uart->significand);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"exponent", chl->info.uart->exponent);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"rs232_cap", chl->info.uart->rs232_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"rs422_cap", chl->info.uart->rs422_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"rs485_cap", chl->info.uart->rs485_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"ahdc_cap", chl->info.uart->ahdc_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"cs_cap", chl->info.uart->cs_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"rs422_end_cap", chl->info.uart->rs422_end_cap);
+			chl->property[prop_index++] = PROPERTY_ENTRY_U8(
+				"rs485_end_cap", chl->info.uart->rs485_end_cap);
+
+			chl->resource = devm_kzalloc(dev,
+				sizeof(struct resource) * 2, GFP_KERNEL);
+			if (!chl->resource)
+				return -ENOMEM;
+			chl->resource[0].start =
+				bar1_io + chl->info.uart->io_offset;
+			chl->resource[0].end =
+				bar1_io + chl->info.uart->io_offset +
+				chl->info.uart->io_size - 1;
+			chl->resource[0].name = "iobase";
+			chl->resource[0].flags = IORESOURCE_IO;
+			chl->resource[0].desc = IORES_DESC_NONE;
+			chl->resource[1].start = 0;
+			chl->resource[1].end =  0;
+			chl->resource[1].name = "irq";
+			chl->resource[1].flags = IORESOURCE_IRQ;
+			chl->resource[1].desc = IORES_DESC_NONE;
+
+			chl->cell = devm_kzalloc(dev,
+				sizeof(struct mfd_cell), GFP_KERNEL);
+			if (!chl->cell)
+				return -ENOMEM;
+			chl->cell->name = "8250_sdc";
+			chl->cell->id = sdc_serial_id++;
+			chl->cell->properties = chl->property;
+			chl->cell->num_resources = 2;
+			chl->cell->resources = chl->resource;
+			break;
+		}
+	}
+
+	sdc->dev = dev;
+	dev_set_drvdata(dev, sdc);
+
+	ret = ida_simple_get(&sdc_devid_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	sdc->devid = ret;
+
+	ret = sdc_debugfs_add(sdc);
+	if (ret)
+		dev_warn(dev, "failed to create debugfs entries\n");
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+
+		if (chl->cell) {
+			ret = mfd_add_devices(dev, sdc->devid, chl->cell, 1,
+						NULL, sdc->info.irq, NULL);
+			if (ret)
+				goto err_remove_sdc;
+		}
+	}
+
+	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+	return 0;
+
+err_remove_sdc:
+	sdc_debugfs_remove(sdc);
+	ida_simple_remove(&sdc_devid_ida, sdc->devid);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdc_probe);
+
+void sdc_remove(struct device *dev)
+{
+	struct sdc_mfd *sdc = dev_get_drvdata(dev);
+
+	mfd_remove_devices(dev);
+	sdc_debugfs_remove(sdc);
+	ida_simple_remove(&sdc_devid_ida, sdc->devid);
+}
+EXPORT_SYMBOL_GPL(sdc_remove);
+
+static int resume_sdc_device(struct device *dev, void *data)
+{
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+		pm_runtime_resume(dev);
+
+	return 0;
+}
+
+int sdc_prepare(struct device *dev)
+{
+	device_for_each_child_reverse(dev, NULL, resume_sdc_device);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdc_prepare);
+
+int sdc_suspend(struct device *dev)
+{
+	// save context
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdc_suspend);
+
+int sdc_resume(struct device *dev)
+{
+	// restore context
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdc_resume);
+
+static int __init sdc_init(void)
+{
+	sdc_mfd_debugfs = debugfs_create_dir("sdc_mfd", NULL);
+	return 0;
+}
+module_init(sdc_init);
+
+static void __exit sdc_exit(void)
+{
+	ida_destroy(&sdc_devid_ida);
+	debugfs_remove(sdc_mfd_debugfs);
+}
+module_exit(sdc_exit);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC mfd driver");
+MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: 8250_sdc");
diff --git a/sdc_mfd.h b/sdc_mfd.h
new file mode 100644
index 0000000..099912f
--- /dev/null
+++ b/sdc_mfd.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SUNIX SDC mfd driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Based on Intel Sunrisepoint LPSS core driver written by
+ * - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ * - Mika Westerberg <mika.westerberg@linux.intel.com>
+ * - Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ * - Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Copyright (C) 2015, Intel Corporation
+ */
+
+#ifndef __SDC_MFD_H
+#define __SDC_MFD_H
+
+#include <linux/pm.h>
+
+struct device;
+struct resource;
+struct property_entry;
+
+struct sdc_platform_info {
+	struct pci_dev *pdev;
+	int bus_number;
+	int device_number;
+	int irq;
+};
+
+int sdc_probe(struct device *dev, struct sdc_platform_info *info);
+void sdc_remove(struct device *dev);
+
+#ifdef CONFIG_PM
+int sdc_prepare(struct device *dev);
+int sdc_suspend(struct device *dev);
+int sdc_resume(struct device *dev);
+
+#ifdef CONFIG_PM_SLEEP
+#define SDC_SLEEP_PM_OPS				\
+	.prepare = sdc_prepare,				\
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(sdc_suspend, sdc_resume)
+#else
+#define SDC_SLEEP_PM_OPS
+#endif // CONFIG_PM_SLEEP
+
+#define SDC_RUNTIME_PM_OPS				\
+	.runtime_suspend = sdc_suspend,		\
+	.runtime_resume = sdc_resume,
+#else // !CONFIG_PM
+#define SDC_SLEEP_PM_OPS
+#define SDC_RUNTIME_PM_OPS
+#endif // CONFIG_PM
+
+#define SDC_PM_OPS(name)				\
+const struct dev_pm_ops name = {		\
+	SDC_SLEEP_PM_OPS					\
+	SDC_RUNTIME_PM_OPS					\
+}
+
+#endif // __SDC_MFD_H
diff --git a/sdc_pci.c b/sdc_pci.c
new file mode 100644
index 0000000..6366d0e
--- /dev/null
+++ b/sdc_pci.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC PCIe driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Based on Intel Sunrisepoint LPSS PCI driver written by
+ * - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ * - Mika Westerberg <mika.westerberg@linux.intel.com>
+ * Copyright (C) 2015, Intel Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/pci.h>
+#include "sdc_mfd.h"
+
+static int sdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct sdc_platform_info info;
+	unsigned long flags;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	flags = pci_resource_flags(pdev, 0);
+	if (!(flags & IORESOURCE_MEM)) {
+		pr_err("bar0 resource flag x%lx invalid\n", flags);
+		return -ENODEV;
+	}
+
+	flags = pci_resource_flags(pdev, 1);
+	if (!(flags & IORESOURCE_IO)) {
+		pr_err("bar1 resource flag x%lx invalid\n", flags);
+		return -ENODEV;
+	}
+
+	flags = pci_resource_flags(pdev, 2);
+	if (!(flags & IORESOURCE_MEM)) {
+		pr_err("bar2 resource flag x%lx invalid\n", flags);
+		return -ENODEV;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.pdev = pdev;
+	info.bus_number = pdev->bus->number;
+	info.device_number = PCI_SLOT(pdev->devfn);
+	info.irq = pdev->irq;
+
+	ret = sdc_probe(&pdev->dev, &info);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
+	return 0;
+}
+
+static void sdc_pci_remove(struct pci_dev *pdev)
+{
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	sdc_remove(&pdev->dev);
+}
+
+static SDC_PM_OPS(sdc_pci_pm_ops);
+
+static const struct pci_device_id sdc_pci_ids[] = {
+	{ PCI_VDEVICE(SUNIX, 0x2000) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, sdc_pci_ids);
+
+static struct pci_driver sdc_pci_driver = {
+	.name = "sdc_pci",
+	.id_table = sdc_pci_ids,
+	.probe = sdc_pci_probe,
+	.remove = sdc_pci_remove,
+	.driver = {
+		.pm = &sdc_pci_pm_ops,
+	},
+};
+module_pci_driver(sdc_pci_driver);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC PCIe driver");
+MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: sdc_mfd");
-- 
2.20.1

