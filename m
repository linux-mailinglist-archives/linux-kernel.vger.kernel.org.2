Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD793B3FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFYI54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhFYI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:57:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:55:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v7so7058160pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=juV4agwj12FGqRpB1w9EhwmEUtWdUETrfleiHej+q7g=;
        b=p+DRYt9zQZQuGZ6aPMNBrxoa6RXjWP7YAxeJwkTPLTcpoDDpLZqSHwJwSyZsj5u3TJ
         PcJR4EnHcPg0tInnVnZgYgJKvJIr8XQbF6UBBWrzjVUDDmpCsWnXljyiI3ymqejrhh4m
         uf/fRcW1X82H3dB/hDTOP/wAxUI5IJ4WSYfgw9ig9KS7rmdgdcJora7fx2cUqaS4/8Kj
         Ut7WAhp7TAxcGaSHMz1t6aT7LDjA69H+bcRbux5ZLWgy0+wxYVYNvKDNHJjSP+QaPptc
         GX4W9iIYnlJ+tBBdNPSC6ciemf4sENcIEKDViN3beUACv0nxgJL6wjVfLAy4WctMTRO4
         E5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=juV4agwj12FGqRpB1w9EhwmEUtWdUETrfleiHej+q7g=;
        b=iDnq0WkqPA5ks6XNoxYvHSHuK5Y8LOzVoZ6CePnYx7+Ao8l3D2k+PaKh5m5WNiZw83
         a4uzJGFx7wEec7a7r7deOU29ollmu0hnWA8FaTE203Aq1dZnIBQCmh4Ab4DF30hTomOe
         mk5NJSTmVXe9k8QnMkmwuTIlyWREHmUOku3v3ajc3C9+LrsM4ypzB2Pfdp8XPsI2fj7U
         6005e7bFpK5FmhmmAikslriahVD26DVPrBqEWXvxKoTXI3v+8Z1UJaog/fSLnituXN+0
         M3t2m5wjZQGR2R39jeEF9VApZGnl9QfbkTqAKLhm3DPwAb+q8FFs8lkdJ9Io8Xbtp/Jn
         IJrQ==
X-Gm-Message-State: AOAM533MFbdzS0DHKN1WrOqpe9tO6El9aG3en6UzmalaBN9x6Fq9W0bj
        IpiA8+FebNEDLIGFeHMo6ME=
X-Google-Smtp-Source: ABdhPJwkQS/FwwX8TNsO4cyRl81yVSgbfw1Lk8cOI1UP9ya4EfaD1F3Cmy6r+S3mMnHDov6iIsQF5A==
X-Received: by 2002:a63:5b51:: with SMTP id l17mr8629477pgm.408.1624611332137;
        Fri, 25 Jun 2021 01:55:32 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id g3sm10321448pjl.17.2021.06.25.01.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 01:55:31 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] SUNIX SDC PCIe multi-function card core driver
Date:   Fri, 25 Jun 2021 16:55:20 +0800
Message-Id: <20210625085520.10573-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC PCIe multi-function card

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 sunix-sdc.c | 606 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 606 insertions(+)
 create mode 100644 sunix-sdc.c

diff --git a/sunix-sdc.c b/sunix-sdc.c
new file mode 100644
index 0000000..5e724a3
--- /dev/null
+++ b/sunix-sdc.c
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC PCIe multi-function card core support.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/io.h>
+#include <linux/property.h>
+#include <linux/debugfs.h>
+#include <linux/idr.h>
+#include <linux/mfd/core.h>
+#include "sunix-sdc.h"
+
+#define DRIVER_NAME		"sunix-sdc"
+
+enum cib_type {
+	TYPE_CONFIG = 0,
+	TYPE_UART,
+	TYPE_DIO,
+	TYPE_CAN
+};
+
+struct cib_config {
+	u32 mem_offset;
+	u32 mem_size;
+	u8 ic_brand;
+	u8 ic_model;
+};
+
+struct cib_uart {
+	u32 io_offset;
+	u8 io_size;
+	u32 mem_offset;
+	u32 mem_size;
+	u16 tx_fifo_size;
+	u16 rx_fifo_size;
+	u32 significand;
+	u8 exponent;
+	u32 capability;
+};
+
+struct cib_dio_bank {
+	u8 number_of_io;
+	char number_of_io_name[32];
+	u8 capability;
+	char capability_name[32];
+};
+
+struct cib_dio {
+	u32 mem_offset;
+	u32 mem_size;
+	u8 number_of_bank;
+	u8 capability;
+
+	struct cib_dio_bank *banks;
+};
+
+struct cib_can {
+	u32 mem_offset;
+	u32 mem_size;
+	u32 significand;
+	u8 exponent;
+	u8 number_of_device;
+	u8 device_type;
+	u8 gpio_input;
+	u8 gpio_output;
+};
+
+struct cib_info {
+	u8 number;
+	enum cib_type type;
+	u8 version;
+	u8 total_length;
+	u8 resource_cap;
+	u8 event_type;
+
+	struct cib_config *config;
+	struct cib_uart *uart;
+	struct cib_dio *dio;
+	struct cib_can *can;
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
+struct sdc_board {
+	struct sunix_sdc_platform_info *info;
+
+	u8 major_version;
+	u8 minor_version;
+	u8 available_chls;
+	u8 total_length;
+	char model_name[16];
+
+	struct sdc_channel *channels;
+	struct device *dev;
+	int id;
+
+	struct debugfs_blob_wrapper debugfs_model_name;
+};
+
+static int sdc_board_id = 1;
+static int sdc_uart_id = 1;
+static int sdc_dio_id = 1;
+static int sdc_can_id = 1;
+
+static u32 sdc_readl(void __iomem *base, u16 chl_offset, int reg_offset)
+{
+	return readl(base + chl_offset + (reg_offset * 4));
+}
+
+static void sdc_get_config_info(struct cib_config *config, void __iomem *base,
+				u16 ptr)
+{
+	u32 temp;
+
+	if (!config)
+		return;
+
+	config->mem_offset = sdc_readl(base, ptr, 2);
+	config->mem_size = sdc_readl(base, ptr, 3);
+	temp = sdc_readl(base, ptr, 4);
+	config->ic_brand = (temp & GENMASK(15, 8)) >> 8;
+	config->ic_model = (temp & GENMASK(23, 16)) >> 16;
+}
+
+static void sdc_get_uart_info(struct cib_uart *uart, void __iomem *base,
+				u16 ptr)
+{
+	u32 temp;
+
+	if (!uart)
+		return;
+
+	temp = sdc_readl(base, ptr, 2);
+	uart->io_offset = temp & GENMASK(23, 0);
+	uart->io_size = (temp & GENMASK(31, 24)) >> 24;
+	uart->mem_offset = sdc_readl(base, ptr, 3);
+	uart->mem_size = sdc_readl(base, ptr, 4);
+	temp = sdc_readl(base, ptr, 5);
+	uart->tx_fifo_size = temp & GENMASK(15, 0);
+	uart->rx_fifo_size = (temp & GENMASK(31, 16)) >> 16;
+	temp = sdc_readl(base, ptr, 6);
+	uart->significand = temp & GENMASK(23, 0);
+	uart->exponent = (temp & GENMASK(31, 24)) >> 24;
+	uart->capability = sdc_readl(base, ptr, 7);
+}
+
+static void sdc_get_dio_info(struct cib_dio *dio, void __iomem *base,
+				u16 ptr)
+{
+	u32 temp;
+
+	if (!dio)
+		return;
+
+	dio->mem_offset = sdc_readl(base, ptr, 2);
+	dio->mem_size = sdc_readl(base, ptr, 3);
+	temp = sdc_readl(base, ptr, 4);
+	dio->number_of_bank = temp & GENMASK(7, 0);
+	dio->capability = (temp & GENMASK(9, 8)) >> 8;
+}
+
+static void sdc_get_dio_banks_info(struct cib_dio *dio, void __iomem *base,
+				u16 ptr)
+{
+	u32 temp;
+	int i;
+
+	if (!dio || !dio->banks)
+		return;
+
+	for (i = 0; i < dio->number_of_bank; i++) {
+		temp = sdc_readl(base, ptr, 5 + i);
+		dio->banks[i].number_of_io = temp & GENMASK(7, 0);
+		dio->banks[i].capability = (temp & GENMASK(11, 8)) >> 8;
+	}
+}
+
+static void sdc_get_can_info(struct cib_can *can, void __iomem *base,
+				u16 ptr)
+{
+	u32 temp;
+
+	if (!can)
+		return;
+
+	can->mem_offset = sdc_readl(base, ptr, 2);
+	can->mem_size = sdc_readl(base, ptr, 3);
+	temp = sdc_readl(base, ptr, 4);
+	can->significand = temp & GENMASK(23, 0);
+	can->exponent = (temp & GENMASK(31, 24)) >> 24;
+	temp = sdc_readl(base, ptr, 5);
+	can->number_of_device = temp & GENMASK(7, 0);
+	if (can->number_of_device != 1)
+		return;
+	temp = sdc_readl(base, ptr, 6);
+	can->device_type = temp & GENMASK(7, 0);
+	can->gpio_input = (temp & GENMASK(11, 8)) >> 8;
+	can->gpio_output = (temp & GENMASK(15, 12)) >> 12;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *sdc_debugfs;
+#define SDCMFD_DEBUGFS_FORMAT		"board%d"
+
+static void sdc_debugfs_add(struct sdc_board *sdc)
+{
+	struct dentry *dir;
+	char name[32];
+
+	snprintf(name, sizeof(name), SDCMFD_DEBUGFS_FORMAT, sdc->id);
+	dir = debugfs_create_dir(name, sdc_debugfs);
+
+	debugfs_create_u32("irq", 0444, dir, &sdc->info->irq);
+	debugfs_create_u8("major_version", 0444, dir, &sdc->major_version);
+	debugfs_create_u8("minor_version", 0444, dir, &sdc->minor_version);
+	sdc->debugfs_model_name.data = sdc->model_name;
+	sdc->debugfs_model_name.size = strlen(sdc->model_name) + 1;
+	debugfs_create_blob("model_name", 0444, dir,
+		&sdc->debugfs_model_name);
+}
+
+static void sdc_debugfs_remove(struct sdc_board *sdc)
+{
+	struct dentry *dir;
+	char name[32];
+
+	snprintf(name, sizeof(name), SDCMFD_DEBUGFS_FORMAT, sdc->id);
+	dir = debugfs_lookup(name, sdc_debugfs);
+	debugfs_remove_recursive(dir);
+}
+
+static void sdc_debugfs_init(void)
+{
+	sdc_debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
+}
+
+static void sdc_debugfs_exit(void)
+{
+	debugfs_remove(sdc_debugfs);
+}
+#else
+static void sdc_debugfs_add(struct sdc_board *sdc) {}
+static void sdc_debugfs_remove(struct sdc_board *sdc) {}
+static void sdc_debugfs_init(void) {}
+static void sdc_debugfs_exit(void) {}
+#endif
+
+int sunix_sdc_probe(struct device *dev, struct sunix_sdc_platform_info *info)
+{
+	struct sdc_channel *chl;
+	struct sdc_board *sdc;
+	struct cib_dio *dio;
+	struct cib_can *can;
+	void __iomem *mem_base;
+	u16 chl_offset_backup;
+	u16 chl_offset;
+	u32 temp;
+	u8 type;
+	int index;
+	int ret;
+	int i;
+	int j;
+
+	if (!info || !info->b1_io || !info->b2_mem || info->irq <= 0)
+		return -EINVAL;
+
+	sdc = devm_kzalloc(dev, sizeof(*sdc), GFP_KERNEL);
+	if (!sdc)
+		return -ENOMEM;
+
+	mem_base = devm_ioremap(dev, info->b2_mem->start, resource_size(info->b2_mem));
+	if (!mem_base)
+		return -ENOMEM;
+
+	sdc->info = info;
+	sdc->dev = dev;
+	sdc->id = sdc_board_id++;
+
+	temp = sdc_readl(mem_base, 0, 0);
+	sdc->major_version = temp & GENMASK(7, 0);
+	sdc->minor_version = (temp & GENMASK(15, 8)) >> 8;
+	sdc->available_chls = (temp & GENMASK(23, 16)) >> 16;
+	sdc->total_length = (temp & GENMASK(31, 24)) >> 24;
+
+	temp = sdc_readl(mem_base, 0, 1);
+	chl_offset = chl_offset_backup = temp & GENMASK(15, 0);
+
+	j = 0;
+	for (i = 0; i < 4; i++) {
+		temp = sdc_readl(mem_base, 0, 2 + i);
+		sdc->model_name[j++] = temp & GENMASK(7, 0);
+		sdc->model_name[j++] = (temp & GENMASK(15, 8)) >> 8;
+		sdc->model_name[j++] = (temp & GENMASK(23, 16)) >> 16;
+		sdc->model_name[j++] = (temp & GENMASK(31, 24)) >> 24;
+	}
+	sdc->model_name[strlen(sdc->model_name)] = '\n';
+
+	sdc->channels = devm_kcalloc(dev, sdc->available_chls,
+		sizeof(struct sdc_channel), GFP_KERNEL);
+	if (!sdc->channels)
+		return -ENOMEM;
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+		chl_offset_backup = chl_offset;
+
+		temp = sdc_readl(mem_base, chl_offset, 0);
+		chl->info.number = temp & GENMASK(7, 0);
+		type = (temp & GENMASK(15, 8)) >> 8;
+		switch (type) {
+		case 0x00:
+		case 0x01:
+		case 0x02:
+		case 0x03:
+			chl->info.type = (enum cib_type)type;
+			break;
+		default:
+			break;
+		}
+		chl->info.version = (temp & GENMASK(23, 16)) >> 16;
+		chl->info.total_length = (temp & GENMASK(31, 24)) >> 24;
+
+		temp = sdc_readl(mem_base, chl_offset, 1);
+		chl_offset = temp & GENMASK(15, 0);
+		chl->info.resource_cap = (temp & GENMASK(23, 16)) >> 16;
+		chl->info.event_type = (temp & GENMASK(31, 24)) >> 24;
+
+		switch (chl->info.type) {
+		case TYPE_CONFIG:
+			chl->info.config = devm_kzalloc(dev,
+				sizeof(*chl->info.config), GFP_KERNEL);
+			if (!chl->info.config)
+				return -ENOMEM;
+			sdc_get_config_info(chl->info.config, mem_base,
+				chl_offset_backup);
+			break;
+
+		case TYPE_UART:
+			chl->info.uart = devm_kzalloc(dev,
+				sizeof(*chl->info.uart), GFP_KERNEL);
+			if (!chl->info.uart)
+				return -ENOMEM;
+			sdc_get_uart_info(chl->info.uart, mem_base,
+				chl_offset_backup);
+
+			chl->property = devm_kcalloc(dev, 8,
+				sizeof(struct property_entry), GFP_KERNEL);
+			if (!chl->property)
+				return -ENOMEM;
+			index = 0;
+			chl->property[index++] = PROPERTY_ENTRY_U32(
+				"board_id", sdc->id);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"chl_number", chl->info.number);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"version", chl->info.version);
+			chl->property[index++] = PROPERTY_ENTRY_U16(
+				"tx_fifo_size", chl->info.uart->tx_fifo_size);
+			chl->property[index++] = PROPERTY_ENTRY_U16(
+				"rx_fifo_size", chl->info.uart->rx_fifo_size);
+			chl->property[index++] = PROPERTY_ENTRY_U32(
+				"significand", chl->info.uart->significand);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"exponent", chl->info.uart->exponent);
+			chl->property[index++] = PROPERTY_ENTRY_U32(
+				"capability", chl->info.uart->capability);
+
+			chl->resource = devm_kcalloc(dev, 2,
+				sizeof(struct resource), GFP_KERNEL);
+			if (!chl->resource)
+				return -ENOMEM;
+			chl->resource[0].start = info->b1_io->start +
+				chl->info.uart->io_offset;
+			chl->resource[0].end = chl->resource[0].start +
+				chl->info.uart->io_size - 1;
+			chl->resource[0].name = "8250_sdc";
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
+			chl->cell->id = sdc_uart_id++;
+			chl->cell->properties = chl->property;
+			chl->cell->num_resources = 2;
+			chl->cell->resources = chl->resource;
+			break;
+
+		case TYPE_DIO:
+			chl->info.dio = devm_kzalloc(dev,
+				sizeof(*chl->info.dio), GFP_KERNEL);
+			if (!chl->info.dio)
+				return -ENOMEM;
+			dio = chl->info.dio;
+			sdc_get_dio_info(dio, mem_base, chl_offset_backup);
+			if (dio->number_of_bank) {
+				dio->banks =
+					devm_kcalloc(dev, dio->number_of_bank,
+					sizeof(*dio->banks), GFP_KERNEL);
+				if (!dio->banks)
+					return -ENOMEM;
+
+				sdc_get_dio_banks_info(dio, mem_base,
+					chl_offset_backup);
+			}
+
+			chl->property = devm_kcalloc(dev, 5 + dio->number_of_bank * 2,
+				sizeof(struct property_entry), GFP_KERNEL);
+			if (!chl->property)
+				return -ENOMEM;
+			index = 0;
+			chl->property[index++] = PROPERTY_ENTRY_U32(
+				"board_id", sdc->id);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"chl_number", chl->info.number);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"version", chl->info.version);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"number_of_bank", dio->number_of_bank);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"capability", dio->capability);
+			for (j = 0; j < dio->number_of_bank; j++) {
+				snprintf(dio->banks[j].number_of_io_name,
+					sizeof(dio->banks[j].number_of_io_name),
+					"b%d_number_of_io", j);
+				chl->property[index++] = PROPERTY_ENTRY_U8(
+				dio->banks[j].number_of_io_name, dio->banks[j].number_of_io);
+				snprintf(dio->banks[j].capability_name,
+					sizeof(dio->banks[j].capability_name),
+					"b%d_capability", j);
+				chl->property[index++] = PROPERTY_ENTRY_U8(
+				dio->banks[j].capability_name, dio->banks[j].capability);
+			}
+
+			chl->resource = devm_kcalloc(dev, 4,
+				sizeof(struct resource), GFP_KERNEL);
+			if (!chl->resource)
+				return -ENOMEM;
+			chl->resource[0].start = info->b2_mem->start +
+				chl->info.dio->mem_offset;
+			chl->resource[0].end = chl->resource[0].start +
+				chl->info.dio->mem_size - 1;
+			chl->resource[0].name = "gpio_sdc";
+			chl->resource[0].flags = IORESOURCE_MEM;
+			chl->resource[0].desc = IORES_DESC_NONE;
+			chl->resource[1].start = 0;
+			chl->resource[1].end =  0;
+			chl->resource[1].name = "irq";
+			chl->resource[1].flags = IORESOURCE_IRQ;
+			chl->resource[1].desc = IORES_DESC_NONE;
+			chl->resource[2].start = info->b0_mem->start;
+			chl->resource[2].end = chl->resource[2].start + 32 - 1;
+			chl->resource[2].name = "sdc_irq_vector";
+			chl->resource[2].flags = IORESOURCE_MEM;
+			chl->resource[2].desc = IORES_DESC_NONE;
+			chl->resource[3].start = info->b0_mem->start + 32 +
+				(chl->info.number * 4);
+			chl->resource[3].end = chl->resource[3].start + 4 - 1;
+			chl->resource[3].name = "gpio_sdc_event_header";
+			chl->resource[3].flags = IORESOURCE_MEM;
+			chl->resource[3].desc = IORES_DESC_NONE;
+
+			chl->cell = devm_kzalloc(dev,
+				sizeof(struct mfd_cell), GFP_KERNEL);
+			if (!chl->cell)
+				return -ENOMEM;
+			chl->cell->name = "gpio_sdc";
+			chl->cell->id = sdc_dio_id++;
+			chl->cell->properties = chl->property;
+			chl->cell->num_resources = 4;
+			chl->cell->resources = chl->resource;
+			break;
+
+		case TYPE_CAN:
+			chl->info.can = devm_kzalloc(dev,
+				sizeof(*chl->info.can), GFP_KERNEL);
+			if (!chl->info.can)
+				return -ENOMEM;
+			can = chl->info.can;
+			sdc_get_can_info(can, mem_base,	chl_offset_backup);
+
+			if (can->number_of_device != 1 && can->device_type != 0x03)
+				break;
+
+			chl->property = devm_kcalloc(dev, 7,
+				sizeof(struct property_entry), GFP_KERNEL);
+			if (!chl->property)
+				return -ENOMEM;
+			index = 0;
+			chl->property[index++] = PROPERTY_ENTRY_U32(
+				"board_id", sdc->id);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"chl_number", chl->info.number);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"version", chl->info.version);
+			chl->property[index++] = PROPERTY_ENTRY_U32(
+				"significand", can->significand);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"exponent", can->exponent);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"gpio_input", can->gpio_input);
+			chl->property[index++] = PROPERTY_ENTRY_U8(
+				"gpio_output", can->gpio_output);
+
+			chl->resource = devm_kcalloc(dev, 2,
+				sizeof(struct resource), GFP_KERNEL);
+			if (!chl->resource)
+				return -ENOMEM;
+			chl->resource[0].start = info->b2_mem->start +
+				chl->info.can->mem_offset;
+			chl->resource[0].end = chl->resource[0].start +
+				chl->info.can->mem_size - 1;
+			chl->resource[0].name = "sx2010_can";
+			chl->resource[0].flags = IORESOURCE_MEM;
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
+			chl->cell->name = "sx2010_can";
+			chl->cell->id = sdc_can_id++;
+			chl->cell->properties = chl->property;
+			chl->cell->num_resources = 2;
+			chl->cell->resources = chl->resource;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	dev_set_drvdata(dev, sdc);
+	sdc_debugfs_add(sdc);
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+
+		if (chl->cell) {
+			ret = mfd_add_devices(dev, sdc->id, chl->cell, 1,
+						NULL, sdc->info->irq, NULL);
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sunix_sdc_probe);
+
+void sunix_sdc_remove(struct device *dev)
+{
+	struct sdc_board *sdc = dev_get_drvdata(dev);
+
+	mfd_remove_devices(dev);
+	sdc_debugfs_remove(sdc);
+}
+EXPORT_SYMBOL_GPL(sunix_sdc_remove);
+
+static int __init sunix_sdc_init(void)
+{
+	sdc_debugfs_init();
+	return 0;
+}
+module_init(sunix_sdc_init);
+
+static void __exit sunix_sdc_exit(void)
+{
+	sdc_debugfs_exit();
+}
+module_exit(sunix_sdc_exit);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC PCIe multi-function card core driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.20.1

