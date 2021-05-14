Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B642A380873
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhENL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:29:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4840CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:28:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c13so10992331pfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ga+9zhWUDsuMj4eimhjn2AQU2UwU8p/10QD/Vf4TqYs=;
        b=oGiC7Nl7Vjl2N6gL4b9j7vlz+47MmTZ2AaZKRJVAawRIvh5Yl/KvkvTNCzlDDqpBtD
         ZDDv9w1ZKGtmDyxRtQ/CPANvPxbBNcX7vLgtKTvCvBDOHQ31OEs7ag1S6HnZeepL8sTy
         Awuixow/iYXrgT3D7nmyMfJRshtVHlZ+g/GKqYIjlLhtWq8ZxC4Rit0VI24cOOpnVi01
         WRgRSL34hiFxbs5GNvOdGIetWn+vvMQSsDyeu6dDOUybdLUiVcfIdlJG6yyBx4UsKC/O
         92xDF6zy2ZhRB5qseMwjywKgmO+Nvb63pI/boXA1h+HHAPOHN3R8EL6TQoQ/d5KUc1qR
         Dxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ga+9zhWUDsuMj4eimhjn2AQU2UwU8p/10QD/Vf4TqYs=;
        b=hpyGW0Z70H9Q32eUebu3jTN+c2fUI1TDFJBE69x0oYR6RygmD7khc4onBpPcKjsk17
         T3QF6eLI6JvUaZGLTDeenxua795ou/M95GKkLABUl1A2RcQyU3DP9JjuBNsMiEYauFF7
         W9PE3joUzHoHAGbcIS4ERzqtAfrvFDJ51Myn2Yi3x87Jr2uS7Vxjda4S1x12JUe48YLT
         bzT1V3MsF11+r+Nfs1BE8c6JUV0NCrj3xH7N19O9cDvqGXEw14OGqrAbKcV47jrm+Dt+
         4Bm45AYAlBsH3DmGarwWaQj6V/LOBPzIFqa4azvRI1bD2Cen4gl085D5ZPuzzFjq8G6X
         lEyQ==
X-Gm-Message-State: AOAM532iedG9/z1t8x3MGPUjIY5tr2AxByrXwcLTvidQBuOi0u56HItV
        8e1idz8u0O/L+2jY44YPkra4V9JBF0PXiQ==
X-Google-Smtp-Source: ABdhPJzSZVxKtMcznWrpg0AIQwqAgjDqt3xFma8DK3M+H5qzj97uGw1FL4cUx6jGHZNoLw40ogB1Qw==
X-Received: by 2002:a63:4a44:: with SMTP id j4mr45861224pgl.283.1620991698638;
        Fri, 14 May 2021 04:28:18 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id 14sm3919025pfj.29.2021.05.14.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:28:17 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH] Add SUNIX SDC series mfd driver
Date:   Fri, 14 May 2021 19:27:43 +0800
Message-Id: <20210514112743.4813-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 sdc_mfd.c | 691 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sdc_mfd.h |  58 +++++
 sdc_pci.c | 100 ++++++++
 3 files changed, 849 insertions(+)
 create mode 100644 sdc_mfd.c
 create mode 100644 sdc_mfd.h
 create mode 100644 sdc_pci.c

diff --git a/sdc_mfd.c b/sdc_mfd.c
new file mode 100644
index 0000000..dc30f3b
--- /dev/null
+++ b/sdc_mfd.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC mfd driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Authors: Jason Lee <jason_lee@sunix.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
+#include <linux/ioport.h>
+#include <linux/property.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/idr.h>
+#include <linux/debugfs.h>
+#include <linux/mfd/core.h>
+#include "sdc_mfd.h"
+
+struct cib_config {
+	unsigned int mem_addr_offset;
+	unsigned int mem_space_size;
+	unsigned char ic_brand;
+	unsigned char ic_model;
+};
+
+struct cib_uart {
+	unsigned int io_addr_offset;
+	unsigned char io_space_size;
+	unsigned int mem_addr_offset;
+	unsigned int mem_space_size;
+	unsigned short tx_fifo_size;
+	unsigned short rx_fifo_size;
+	unsigned int significand_of_ref_clk;
+	unsigned char exponent_of_ref_clk;
+	unsigned char rs232_cap;
+	unsigned char rs422_cap;
+	unsigned char rs485_cap;
+	unsigned char ahdc_cap;
+	unsigned char cs_cap;
+	unsigned char auto_rs422485_cap;
+	unsigned char rs422_termination_cap;
+	unsigned char rs485_termination_cap;
+	unsigned char ri_power_io_5v_cap;
+	unsigned char ri_power_io_12v_cap;
+	unsigned char dcd_power_io_5v_cap;
+	unsigned char dcd_power_io_12v_cap;
+};
+
+struct cib_dio_bank {
+	unsigned char number_of_io;
+	unsigned char bank_support_input_cap;
+	unsigned char bank_support_output_cap;
+	unsigned char rising_edge_trigger_cap;
+	unsigned char falling_edge_trigger_cap;
+};
+
+struct cib_dio {
+	unsigned int mem_addr_offset;
+	unsigned int mem_space_size;
+	unsigned char number_of_bank;
+	unsigned char share_same_direction_ctrl_cap;
+	unsigned char writing_settings_to_flash_cap;
+
+	struct cib_dio_bank bank[16];
+};
+
+struct cib_spi_device {
+	unsigned char type;
+	unsigned char number_of_gpio_input;
+	unsigned char number_of_gpio_output;
+	char name[10];
+	struct debugfs_blob_wrapper debugfs_blob_device_name;
+};
+
+struct cib_spi {
+	unsigned int mem_addr_offset;
+	unsigned int mem_space_size;
+	unsigned int significand_of_ref_clk;
+	unsigned char exponent_of_ref_clk;
+	unsigned char number_of_device;
+
+	struct cib_spi_device device[16];
+};
+
+struct cib_info {
+	unsigned char number;
+	unsigned char type;
+	unsigned char version;
+	unsigned char total_length_DW;
+	unsigned char resource_cap;
+	unsigned char event_header_type;
+
+	struct cib_config *config;
+	struct cib_uart *uart;
+	struct cib_dio *dio;
+	struct cib_spi *spi;
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
+	void __iomem *bar0_membase;
+	unsigned long bar0_length;
+	unsigned long bar1_iobase;
+	unsigned long bar1_length;
+	void __iomem *bar2_membase;
+	unsigned long bar2_length;
+
+	unsigned char major_version;
+	unsigned char minor_version;
+	unsigned char available_chls;
+	unsigned char total_length_DW;
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
+//static int sdc_gpio_id = 1;
+//static int sdc_spi_id = 1;
+
+static void sdc_get_config_info(struct cib_info *info, void __iomem *membase,
+					unsigned short ptr)
+{
+	unsigned int temp;
+	unsigned int offsetDW = 0;
+
+	if (!info || !info->config)
+		return;
+
+	offsetDW = 2;
+	info->config->mem_addr_offset = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 3;
+	info->config->mem_space_size = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 4;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->config->ic_brand = (unsigned char)((temp & 0x0000ff00) >> 8);
+	info->config->ic_model = (unsigned char)((temp & 0x00ff0000) >> 16);
+}
+
+static void sdc_get_uart_info(struct cib_info *info, void __iomem *membase,
+					unsigned short ptr)
+{
+	unsigned int temp;
+	unsigned int offsetDW = 0;
+
+	if (!info || !info->uart)
+		return;
+
+	offsetDW = 2;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->io_addr_offset = (unsigned int)((temp & 0x00ffffff));
+	info->uart->io_space_size = (unsigned char)((temp & 0xff000000) >> 24);	
+	offsetDW = 3;
+	info->uart->mem_addr_offset = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 4;
+	info->uart->mem_space_size = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 5;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->tx_fifo_size = (unsigned short)((temp & 0x0000ffff));
+	info->uart->rx_fifo_size = (unsigned short)((temp & 0xff0000) >> 16);
+	offsetDW = 6;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->significand_of_ref_clk = temp & 0x00ffffff;
+	info->uart->exponent_of_ref_clk = (unsigned char)((temp & 0xff000000) >> 24);
+	offsetDW = 7;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->uart->rs232_cap             = (temp & 0x00000001) ? 0x01 : 0x00;
+	info->uart->rs422_cap             = (temp & 0x00000002) ? 0x01 : 0x00;
+	info->uart->rs485_cap             = (temp & 0x00000004) ? 0x01 : 0x00;
+	info->uart->ahdc_cap              = (temp & 0x00000008) ? 0x01 : 0x00;
+	info->uart->cs_cap                = (temp & 0x00000010) ? 0x01 : 0x00;
+	info->uart->auto_rs422485_cap     = (temp & 0x00000020) ? 0x01 : 0x00;
+	info->uart->rs422_termination_cap = (temp & 0x00000040) ? 0x01 : 0x00;
+	info->uart->rs485_termination_cap = (temp & 0x00000080) ? 0x01 : 0x00;
+	info->uart->ri_power_io_5v_cap    = (temp & 0x00000100) ? 0x01 : 0x00;
+	info->uart->ri_power_io_12v_cap   = (temp & 0x00000200) ? 0x01 : 0x00;
+	info->uart->dcd_power_io_5v_cap   = (temp & 0x00000400) ? 0x01 : 0x00;
+	info->uart->dcd_power_io_12v_cap  = (temp & 0x00000800) ? 0x01 : 0x00;
+}
+
+static void sdc_get_dio_info(struct cib_info *info, void __iomem *membase,
+					unsigned short ptr)
+{
+	unsigned int temp;
+	unsigned int offsetDW = 0;
+	unsigned char i;
+
+	if (!info || !info->dio)
+		return;
+
+	offsetDW = 2;
+	info->dio->mem_addr_offset = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 3;
+	info->dio->mem_space_size = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 4;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->dio->number_of_bank = (unsigned char)((temp & 0x000000ff));
+	info->dio->share_same_direction_ctrl_cap = (temp & 0x00000100) ? 0x01 : 0x00;
+	info->dio->writing_settings_to_flash_cap = (temp & 0x00000200) ? 0x01 : 0x00;
+
+	for (i = 0; i < info->dio->number_of_bank; i++) {
+		offsetDW++;
+		temp = readl(membase + ptr + (offsetDW * 4));
+		info->dio->bank[i].number_of_io = (unsigned char)((temp & 0x000000ff));
+		info->dio->bank[i].bank_support_input_cap = (temp & 0x00000100) ? 0x01 : 0x00;
+		info->dio->bank[i].bank_support_output_cap = (temp & 0x00000200) ? 0x01 : 0x00;
+		info->dio->bank[i].rising_edge_trigger_cap = (temp & 0x00000400) ? 0x01 : 0x00;
+		info->dio->bank[i].falling_edge_trigger_cap = (temp & 0x00000800) ? 0x01 : 0x00;
+	}
+}
+
+static void sdc_get_spi_info(struct cib_info *info, void __iomem *membase,
+					unsigned short ptr)
+{
+	unsigned int temp;
+	unsigned int offsetDW = 0;
+	unsigned char i;
+
+	if (!info || !info->spi)
+		return;
+
+	offsetDW = 2;
+	info->spi->mem_addr_offset = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 3;
+	info->spi->mem_space_size = readl(membase + ptr + (offsetDW * 4));
+	offsetDW = 4;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->spi->significand_of_ref_clk = temp & 0x00ffffff;
+	info->spi->exponent_of_ref_clk = (unsigned char)((temp & 0xff000000) >> 24);
+	offsetDW = 5;
+	temp = readl(membase + ptr + (offsetDW * 4));
+	info->spi->number_of_device = (unsigned char)((temp & 0x000000ff));
+
+	for (i = 0; i < info->spi->number_of_device; i++) {
+		offsetDW++;
+		temp = readl(membase + ptr + (offsetDW * 4));
+		info->spi->device[i].type = (unsigned char)((temp & 0x000000ff));
+		info->spi->device[i].number_of_gpio_input = (unsigned char)((temp & 0x00000f00) >> 8);
+		info->spi->device[i].number_of_gpio_output = (unsigned char)((temp & 0x0000f000) >> 12);
+
+		offsetDW++;
+		temp = readl(membase + ptr + (offsetDW * 4));
+		info->spi->device[i].name[0] = (unsigned char)((temp & 0x000000ff));
+		info->spi->device[i].name[1] = (unsigned char)((temp & 0x0000ff00) >> 8);
+		info->spi->device[i].name[2] = (unsigned char)((temp & 0x00ff0000) >> 16);
+		info->spi->device[i].name[3] = (unsigned char)((temp & 0xff000000) >> 24);
+
+		offsetDW++;
+		temp = readl(membase + ptr + (offsetDW * 4));
+		info->spi->device[i].name[4] = (unsigned char)((temp & 0x000000ff));
+		info->spi->device[i].name[5] = (unsigned char)((temp & 0x0000ff00) >> 8);
+		info->spi->device[i].name[6] = (unsigned char)((temp & 0x00ff0000) >> 16);
+		info->spi->device[i].name[7] = (unsigned char)((temp & 0xff000000) >> 24);
+
+		info->spi->device[i].name[8] = 0x0a;
+	}
+}
+
+static int sdc_debugfs_add(struct sdc_mfd *sdc)
+{
+	struct dentry *root_dir;
+	struct dentry *chl_dir;
+	char chl_name[20];
+	struct dentry *bank_dir;
+	char bank_name[20];
+	struct dentry *device_dir;
+	char device_name[20];
+	struct sdc_channel *chl = NULL;
+	int i;
+	int j;
+
+	root_dir = debugfs_create_dir(dev_name(sdc->dev), sdc_mfd_debugfs);
+	if (IS_ERR(root_dir))
+		return PTR_ERR(root_dir);
+
+	debugfs_create_u32("devid", 0644, root_dir, &sdc->devid);
+	debugfs_create_u32("bus_number", 0644, root_dir, &sdc->info.bus_number);
+	debugfs_create_u32("device_number", 0644, root_dir, &sdc->info.device_number);
+	debugfs_create_u32("irq", 0644, root_dir, &sdc->info.irq);
+	debugfs_create_u8("major_version", 0644, root_dir, &sdc->major_version);
+	debugfs_create_u8("minor_version", 0644, root_dir, &sdc->minor_version);
+	debugfs_create_u8("available_chls", 0644, root_dir, &sdc->available_chls);
+	sdc->debugfs_blob_model_name.data = sdc->model_name;
+	sdc->debugfs_blob_model_name.size = strlen(sdc->model_name) + 1;
+	debugfs_create_blob("model_name", 0644, root_dir, &sdc->debugfs_blob_model_name);
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+		if (chl) {
+			memset(chl_name, 0, sizeof(char) * 20);
+			sprintf(chl_name, "chl%d", i);
+			chl_dir = debugfs_create_dir(chl_name, root_dir);
+
+			if (chl_dir) {
+				debugfs_create_x8("number", 0644, chl_dir, &chl->info.number);
+				debugfs_create_x8("type", 0644, chl_dir, &chl->info.type);
+				debugfs_create_x8("version", 0644, chl_dir, &chl->info.version);
+				debugfs_create_x8("total_length_DW", 0644, chl_dir, &chl->info.total_length_DW);
+				debugfs_create_x8("resource_cap", 0644, chl_dir, &chl->info.resource_cap);
+				debugfs_create_x8("event_header_type", 0644, chl_dir, &chl->info.event_header_type);
+
+				switch (chl->info.type) {
+					case 0x00:
+						if (chl->info.config) {
+							debugfs_create_x32("mem_addr_offset", 0644, chl_dir, &chl->info.config->mem_addr_offset);
+							debugfs_create_x32("mem_space_size", 0644, chl_dir, &chl->info.config->mem_space_size);
+							debugfs_create_x8("ic_brand", 0644, chl_dir, &chl->info.config->ic_brand);
+							debugfs_create_x8("ic_model", 0644, chl_dir, &chl->info.config->ic_model);
+						}
+						break;
+
+					case 0x01:
+						if (chl->info.uart) {
+							debugfs_create_x32("io_addr_offset", 0644, chl_dir, &chl->info.uart->io_addr_offset);
+							debugfs_create_x8("io_space_size", 0644, chl_dir, &chl->info.uart->io_space_size);
+							debugfs_create_x32("mem_addr_offset", 0644, chl_dir, &chl->info.uart->mem_addr_offset);
+							debugfs_create_x32("mem_space_size", 0644, chl_dir, &chl->info.uart->mem_space_size);
+							debugfs_create_x16("tx_fifo_size", 0644, chl_dir, &chl->info.uart->tx_fifo_size);
+							debugfs_create_x16("rx_fifo_size", 0644, chl_dir, &chl->info.uart->rx_fifo_size);
+							debugfs_create_x32("significand_of_ref_clk", 0644, chl_dir, &chl->info.uart->significand_of_ref_clk);
+							debugfs_create_x8("exponent_of_ref_clk", 0644, chl_dir, &chl->info.uart->exponent_of_ref_clk);
+							debugfs_create_x8("rs232_cap", 0644, chl_dir, &chl->info.uart->rs232_cap);
+							debugfs_create_x8("rs422_cap", 0644, chl_dir, &chl->info.uart->rs422_cap);
+							debugfs_create_x8("rs485_cap", 0644, chl_dir, &chl->info.uart->rs485_cap);
+							debugfs_create_x8("ahdc_cap", 0644, chl_dir, &chl->info.uart->ahdc_cap);
+							debugfs_create_x8("cs_cap", 0644, chl_dir, &chl->info.uart->cs_cap);
+							debugfs_create_x8("auto_rs422485_cap", 0644, chl_dir, &chl->info.uart->auto_rs422485_cap);
+							debugfs_create_x8("rs422_termination_cap", 0644, chl_dir, &chl->info.uart->rs422_termination_cap);
+							debugfs_create_x8("rs485_termination_cap", 0644, chl_dir, &chl->info.uart->rs485_termination_cap);
+							debugfs_create_x8("ri_power_io_5v_cap", 0644, chl_dir, &chl->info.uart->ri_power_io_5v_cap);
+							debugfs_create_x8("ri_power_io_12v_cap", 0644, chl_dir, &chl->info.uart->ri_power_io_12v_cap);
+							debugfs_create_x8("dcd_power_io_5v_cap", 0644, chl_dir, &chl->info.uart->dcd_power_io_5v_cap);
+							debugfs_create_x8("dcd_power_io_12v_cap", 0644, chl_dir, &chl->info.uart->dcd_power_io_12v_cap);
+						}
+						break;
+
+					case 0x02:
+						if (chl->info.dio) {
+							debugfs_create_x32("mem_addr_offset", 0644, chl_dir, &chl->info.dio->mem_addr_offset);
+							debugfs_create_x32("mem_space_size", 0644, chl_dir, &chl->info.dio->mem_space_size);
+							debugfs_create_x8("number_of_bank", 0644, chl_dir, &chl->info.dio->number_of_bank);
+							debugfs_create_x8("share_same_direction_ctrl_cap", 0644, chl_dir, &chl->info.dio->share_same_direction_ctrl_cap);
+							debugfs_create_x8("writing_settings_to_flash_cap", 0644, chl_dir, &chl->info.dio->writing_settings_to_flash_cap);
+
+							for (j = 0; j < chl->info.dio->number_of_bank; j++) {
+								memset(bank_name, 0, sizeof(char) * 20);
+								sprintf(bank_name, "bank%d", j);
+								bank_dir = debugfs_create_dir(bank_name, chl_dir);
+
+								if (bank_dir) {
+									debugfs_create_x8("number_of_io", 0644, bank_dir, &chl->info.dio->bank[j].number_of_io);
+									debugfs_create_x8("bank_support_input_cap", 0644, bank_dir, &chl->info.dio->bank[j].bank_support_input_cap);
+									debugfs_create_x8("bank_support_output_cap", 0644, bank_dir, &chl->info.dio->bank[j].bank_support_output_cap);
+									debugfs_create_x8("rising_edge_trigger_cap", 0644, bank_dir, &chl->info.dio->bank[j].rising_edge_trigger_cap);
+									debugfs_create_x8("falling_edge_trigger_cap", 0644, bank_dir, &chl->info.dio->bank[j].falling_edge_trigger_cap);
+								} else {
+									dev_warn(sdc->dev, "create channel (%d) bank (%d) debugfs fail\n", i, j);
+								}
+							}
+						}
+						break;
+
+					case 0x03:
+						if (chl->info.spi) {
+							debugfs_create_x32("mem_addr_offset", 0644, chl_dir, &chl->info.spi->mem_addr_offset);
+							debugfs_create_x32("mem_space_size", 0644, chl_dir, &chl->info.spi->mem_space_size);
+							debugfs_create_x32("significand_of_ref_clk", 0644, chl_dir, &chl->info.spi->significand_of_ref_clk);
+							debugfs_create_x8("exponent_of_ref_clk", 0644, chl_dir, &chl->info.spi->exponent_of_ref_clk);
+							debugfs_create_x8("number_of_device", 0644, chl_dir, &chl->info.spi->number_of_device);
+
+							for (j = 0; j < chl->info.spi->number_of_device; j++) {
+								memset(device_name, 0, sizeof(char) * 20);
+								sprintf(device_name, "device%d", j);
+								device_dir = debugfs_create_dir(device_name, chl_dir);
+
+								if (device_dir) {
+									debugfs_create_x8("type", 0644, device_dir, &chl->info.spi->device[j].type);
+									debugfs_create_x8("number_of_gpio_input", 0644, device_dir, &chl->info.spi->device[j].number_of_gpio_input);
+									debugfs_create_x8("number_of_gpio_output", 0644, device_dir, &chl->info.spi->device[j].number_of_gpio_output);
+									
+									chl->info.spi->device[j].debugfs_blob_device_name.data = chl->info.spi->device[j].name;
+									chl->info.spi->device[j].debugfs_blob_device_name.size = strlen(chl->info.spi->device[j].name) + 1;	
+									debugfs_create_blob("name", 0644, device_dir, &chl->info.spi->device[j].debugfs_blob_device_name);
+								} else {
+									dev_warn(sdc->dev, "create channel (%d) device (%d) debugfs fail\n", i, j);
+								}
+							}
+						}
+						break;
+				}
+			} else {
+				dev_warn(sdc->dev, "create channel (%d) debugfs fail\n", i);
+			}
+		} else {
+			dev_warn(sdc->dev, "channel (%d) pointer invalid\n", i);
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
+	struct sdc_mfd *sdc = NULL;
+	unsigned int temp;
+	struct sdc_channel *chl = NULL;
+	unsigned short next_cib_ptr = 0;
+	unsigned short next_cib_ptr_backup = 0;
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
+	sdc->bar0_length = pci_resource_len(info->pdev, 0);
+	sdc->bar0_membase = devm_ioremap_uc(dev, pci_resource_start(info->pdev, 0), pci_resource_len(info->pdev, 0));
+	if (!sdc->bar0_membase)
+		return -ENOMEM;
+
+	sdc->bar1_length = pci_resource_len(info->pdev, 1);	
+	sdc->bar1_iobase = pci_resource_start(info->pdev, 1);
+
+	sdc->bar2_length = pci_resource_len(info->pdev, 2);
+	sdc->bar2_membase = devm_ioremap_uc(dev, pci_resource_start(info->pdev, 2), pci_resource_len(info->pdev, 2));
+	if (!sdc->bar2_membase)
+		return -ENOMEM;
+
+	temp = readl(sdc->bar2_membase);
+	sdc->major_version = (unsigned char)((temp & 0x000000ff));
+	sdc->minor_version = (unsigned char)((temp & 0x0000ff00) >> 8);
+	sdc->available_chls = (unsigned char)((temp & 0x00ff0000) >> 16);
+	sdc->total_length_DW = (unsigned char)((temp & 0xff000000) >> 24);
+
+	temp = readl(sdc->bar2_membase + 4);
+	next_cib_ptr = next_cib_ptr_backup = (unsigned short)((temp & 0x0000ffff));
+
+	j = 0;
+	for (i = 0; i < 4; i++) {
+		temp = readl(sdc->bar2_membase + 8 + (i * 4));
+		sdc->model_name[j++] = (char)((temp & 0x000000ff));
+		sdc->model_name[j++] = (char)((temp & 0x0000ff00) >> 8);
+		sdc->model_name[j++] = (char)((temp & 0x00ff0000) >> 16);
+		sdc->model_name[j++] = (char)((temp & 0xff000000) >> 24);
+	}
+	sdc->model_name[strlen(sdc->model_name)] = 0x0a;
+
+	sdc->channels = devm_kzalloc(dev, sizeof(struct sdc_channel) * sdc->available_chls, GFP_KERNEL);
+	if (!sdc->channels)
+		return -ENOMEM;
+
+	for (i = 0; i < sdc->available_chls; i++) {
+		chl = &sdc->channels[i];
+
+		next_cib_ptr_backup = next_cib_ptr;
+
+		temp = readl(sdc->bar2_membase + next_cib_ptr);
+		chl->info.number = (unsigned char)((temp & 0x000000ff));
+		chl->info.type = (unsigned char)((temp & 0x0000ff00) >> 8);
+		chl->info.version = (unsigned char)((temp & 0x00ff0000) >> 16);
+		chl->info.total_length_DW = (unsigned char)((temp & 0xff000000) >> 24);
+
+		temp = readl(sdc->bar2_membase + next_cib_ptr + 4);
+		next_cib_ptr = temp & 0x0000ffff;
+		chl->info.resource_cap = (unsigned char)((temp & 0x00ff0000) >> 16);
+		chl->info.event_header_type = (unsigned char)((temp & 0xff000000) >> 24);
+
+		switch (chl->info.type) {
+			case 0x00:
+				chl->info.config = devm_kzalloc(dev, sizeof(struct cib_config), GFP_KERNEL);
+				if (!chl->info.config)
+					goto err_alloc_channel;
+				sdc_get_config_info(&chl->info, sdc->bar2_membase, next_cib_ptr_backup);
+				break;
+
+			case 0x01:
+				chl->info.uart = devm_kzalloc(dev, sizeof(struct cib_uart), GFP_KERNEL);
+				if (!chl->info.uart) {
+					ret = -ENOMEM;
+					goto err_alloc_channel;
+				}
+				sdc_get_uart_info(&chl->info, sdc->bar2_membase, next_cib_ptr_backup);
+
+				chl->property = devm_kzalloc(dev, sizeof(struct property_entry) * 18, GFP_KERNEL);
+				if (!chl->property) {
+					ret = -ENOMEM;
+					goto err_alloc_channel;
+				}
+				chl->property[0] = PROPERTY_ENTRY_U32("bus_number", sdc->info.bus_number);
+				chl->property[1] = PROPERTY_ENTRY_U32("device_number", sdc->info.device_number);
+				chl->property[2] = PROPERTY_ENTRY_U32("irq", sdc->info.irq);
+				chl->property[3] = PROPERTY_ENTRY_U8("number", chl->info.number);
+				chl->property[4] = PROPERTY_ENTRY_U8("version", chl->info.version);
+				chl->property[5] = PROPERTY_ENTRY_U8("resource_cap", chl->info.resource_cap);
+				chl->property[6] = PROPERTY_ENTRY_U8("event_header_type", chl->info.event_header_type);
+				chl->property[7] = PROPERTY_ENTRY_U16("tx_fifo_size", chl->info.uart->tx_fifo_size);
+				chl->property[8] = PROPERTY_ENTRY_U16("rx_fifo_size", chl->info.uart->rx_fifo_size);
+				chl->property[9] = PROPERTY_ENTRY_U32("significand_of_ref_clk", chl->info.uart->significand_of_ref_clk);
+				chl->property[10] = PROPERTY_ENTRY_U8("exponent_of_ref_clk", chl->info.uart->exponent_of_ref_clk);
+				chl->property[11] = PROPERTY_ENTRY_U8("rs232_cap", chl->info.uart->rs232_cap);
+				chl->property[12] = PROPERTY_ENTRY_U8("rs422_cap", chl->info.uart->rs422_cap);
+				chl->property[13] = PROPERTY_ENTRY_U8("rs485_cap", chl->info.uart->rs485_cap);
+				chl->property[14] = PROPERTY_ENTRY_U8("ahdc_cap", chl->info.uart->ahdc_cap);
+				chl->property[15] = PROPERTY_ENTRY_U8("cs_cap", chl->info.uart->cs_cap);
+				chl->property[16] = PROPERTY_ENTRY_U8("rs422_termination_cap", chl->info.uart->rs422_termination_cap);
+				chl->property[17] = PROPERTY_ENTRY_U8("rs485_termination_cap", chl->info.uart->rs485_termination_cap);
+
+				chl->resource = devm_kzalloc(dev, sizeof(struct resource) * 2, GFP_KERNEL);
+				if (!chl->resource) {
+					ret = -ENOMEM;
+					goto err_alloc_channel;
+				}
+				chl->resource[0].start = sdc->bar1_iobase + chl->info.uart->io_addr_offset;
+				chl->resource[0].end = sdc->bar1_iobase + chl->info.uart->io_addr_offset + chl->info.uart->io_space_size - 1;
+				chl->resource[0].name = "iobase";
+				chl->resource[0].flags = IORESOURCE_IO;
+				chl->resource[0].desc = IORES_DESC_NONE;
+
+				chl->resource[1].start = 0;
+				chl->resource[1].end =  0;
+				chl->resource[1].name = "irq";
+				chl->resource[1].flags = IORESOURCE_IRQ;
+				chl->resource[1].desc = IORES_DESC_NONE;
+
+				chl->cell = devm_kzalloc(dev, sizeof(struct mfd_cell), GFP_KERNEL);
+				if (!chl->cell) {
+					ret = -ENOMEM;
+					goto err_alloc_channel;
+				}
+				chl->cell->name = "sdc_serial";
+				chl->cell->id = sdc_serial_id++;
+				chl->cell->properties = chl->property;
+				chl->cell->num_resources = 2;
+				chl->cell->resources = chl->resource;
+				break;
+
+			case 0x02:
+				chl->info.dio = devm_kzalloc(dev, sizeof(struct cib_dio), GFP_KERNEL);
+				if (!chl->info.dio) {
+					ret = -ENOMEM;
+					goto err_alloc_channel;
+				}
+				sdc_get_dio_info(&chl->info, sdc->bar2_membase, next_cib_ptr_backup);
+				break;
+
+			case 0x03:
+				chl->info.spi = devm_kzalloc(dev, sizeof(struct cib_spi), GFP_KERNEL);
+				if (!chl->info.spi) {
+					ret = -ENOMEM;
+					goto err_alloc_channel;
+				}
+				sdc_get_spi_info(&chl->info, sdc->bar2_membase, next_cib_ptr_backup);
+				break;
+		}
+	}
+
+	sdc->dev = dev;
+	dev_set_drvdata(dev, sdc);
+
+	ret = ida_simple_get(&sdc_devid_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto err_ida_simple_get;
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
+			ret = mfd_add_devices(dev, sdc->devid, chl->cell, 1, NULL, sdc->info.irq, NULL);
+			if (ret) 
+				goto err_mfd_add_device;
+		}
+	}
+
+	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+	return 0;
+
+err_mfd_add_device:
+	sdc_debugfs_remove(sdc);
+
+err_ida_simple_get:
+
+err_alloc_channel:
+
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
+MODULE_VERSION("1.0.0.0");
+
+MODULE_SOFTDEP("pre: 8250_sdc");
+
+
diff --git a/sdc_mfd.h b/sdc_mfd.h
new file mode 100644
index 0000000..7bfe490
--- /dev/null
+++ b/sdc_mfd.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC mfd driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Authors: Jason Lee <jason_lee@sunix.com>
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
+const struct dev_pm_ops name = 	{		\
+	SDC_SLEEP_PM_OPS					\
+	SDC_RUNTIME_PM_OPS					\
+}
+
+#endif // __SDC_MFD_H
+
+
diff --git a/sdc_pci.c b/sdc_pci.c
new file mode 100644
index 0000000..085a5ab
--- /dev/null
+++ b/sdc_pci.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC PCIe driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Authors: Jason Lee <jason_lee@sunix.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/ioport.h>
+#include <linux/property.h>
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
+		pr_err("bar0 resource flag (x%lx) invalid\n", flags);
+		return -ENODEV;
+	}
+
+	flags = pci_resource_flags(pdev, 1);
+	if (!(flags & IORESOURCE_IO)) {
+		pr_err("bar1 resource flag (x%lx) invalid\n", flags);
+		return -ENODEV;
+	}
+
+	flags = pci_resource_flags(pdev, 2);
+	if (!(flags & IORESOURCE_MEM)) {
+		pr_err("bar2 resource flag (x%lx) invalid\n", flags);
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
+		goto err_probe;
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
+err_probe:
+
+	return ret;
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
+MODULE_VERSION("1.0.0.0");
+
+MODULE_SOFTDEP("pre: sdc_mfd");
+
+
-- 
2.20.1

