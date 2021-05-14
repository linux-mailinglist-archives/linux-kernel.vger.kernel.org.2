Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357663808EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhENLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhENLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:53:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AEAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:52:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m190so23982001pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plicCzmF1/i+xe/PHnT8eB23it/2tOT+7484O2VQpmg=;
        b=aJil7HcjD9JmY3KeTIF7Fx3sHUj25+3IruNN9es8rqi54wD/pv0zW5yu7xIDUXQPTY
         SLrBFsQM3ZQtl3+rlWyphW1i8dyQfa28ps4VyAvJY1KWNFo6+a9SgD3yw7zqNPa+K+gc
         GjwsRz9jl0Mbu3KGaq2Qq6AVsBsHxYveD86OfmHDfxzAOdoEPaYciAiQQjAR5BVGNL12
         9Ohe+lDgaUmHSTHlAJ1mdyfL2/jjJ6hV2yVlMLHjy7uFevB4JTlslu8rfK33qSnbe3IH
         PgS9FCo74GjeLyzv6OE4l12nWggEP10KWR3olxS7cIiKjfVoB0kxLcWWU++K+LzPcQkt
         qdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plicCzmF1/i+xe/PHnT8eB23it/2tOT+7484O2VQpmg=;
        b=Pby+OQBm/vP2Dr9sJERfRetvcIzJhGejJwI9qGk0qCVYaQ2HMnXu5cNrNxXN84kEj8
         +2mwO6C5/Yk4jWd3KdPzQeRe8CwQW678xU/PtTOE/x/lWNFPjNfsGhMy8So8nyrFzBqV
         1ur38eXDPhbMA6R74jXCfzrrn5isZSh7hYz/Ti6hVQPa94bH+MuAIcPGos4u4XEnwGT5
         GJDlhApiqkcWu3AvuDuqJNXDvL9XR4GU/NJT7AhmL2PlRL3txkCCZSiC3a4GcIgamnRe
         ZEaUneuJrO2VD67Z1NfuuHFKwfaqL7uD57KMoKCkSUE9pFUV9fkDE0Lnyv6zdlnmrzg0
         UQQQ==
X-Gm-Message-State: AOAM532VM/1sow7zSWKldiWJ0AxViKTCQ2P08jkFIojPOyFVsomKteRB
        cVFGpKRZztiHc5OtBZPjhb/BFmmMKPSwcw==
X-Google-Smtp-Source: ABdhPJx0MG4w8BcsqKSbFdNlKalihFeqwP1Vxq5s3yKc9zMS4rZRU73ruTyAyX9L5hXSrdmZ0GJCLw==
X-Received: by 2002:a63:5110:: with SMTP id f16mr45876181pgb.51.1620993121816;
        Fri, 14 May 2021 04:52:01 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id v15sm4284651pgc.57.2021.05.14.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:52:01 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH] 8250:Add SUNIX SDC series uart driver
Date:   Fri, 14 May 2021 19:51:48 +0800
Message-Id: <20210514115148.5562-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add SUNIX SDC series uart driver

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 8250_sdc.c | 459 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 8250_sdc.h |  45 ++++++
 2 files changed, 504 insertions(+)
 create mode 100644 8250_sdc.c
 create mode 100644 8250_sdc.h

diff --git 8250/8250_sdc.c 8250/8250_sdc.c
new file mode 100644
index 0000000..3a33169
--- /dev/null
+++ 8250/8250_sdc.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC serial port driver.
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
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include <linux/debugfs.h>
+#include "8250_sdc.h"
+
+struct sdc8250_data {
+	struct sdc8250_port_data data;
+	struct uart_8250_port uart;
+	struct device *device;
+	char device_name[50];
+	struct dentry *debugfs;
+	struct debugfs_blob_wrapper debugfs_blob_device_name;
+
+	int fifosize;
+	unsigned long long clk;
+	unsigned char umr;
+};
+
+static struct dentry *sdc_serial_debugfs;
+
+static inline struct sdc8250_data *to_sdc8250_data(struct sdc8250_port_data *data)
+{
+	return container_of(data, struct sdc8250_data, data);
+}
+
+static void sdc8250_do_pm(struct uart_port *p, unsigned int state, 
+					unsigned int old)
+{
+	if (!state)
+		pm_runtime_get_sync(p->dev);
+
+	serial8250_do_pm(p, state, old);
+
+	if (state)
+		pm_runtime_put_sync_suspend(p->dev);
+}
+
+static int sdc8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485) 
+{
+	struct sdc8250_data *data = to_sdc8250_data(p->private_data);
+	int ret = 0;
+	unsigned char umr = 0;
+	unsigned char umr_check = 0;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_RX_DURING_TX) {
+			// rs422
+			if (data->data.rs422_cap == 0x01) {
+				umr = 0x02;
+
+				if (rs485->flags & SER_RS485_TERMINATE_BUS) {
+					if (data->data.rs422_termination_cap == 0x01) {
+						umr |= 0x40;
+					} else {
+						dev_err(p->dev, "ttyS%d no RS422 termination cap.\n", data->data.line);
+						ret = -EINVAL;
+					}
+				}
+			} else {
+				dev_err(p->dev, "ttyS%d no RS422 cap.\n", data->data.line);
+				ret = -EINVAL;
+			}
+		} else {
+			// rs485
+			if (data->data.rs485_cap == 0x01) {
+				umr = 0x04;
+
+				if (data->data.ahdc_cap == 0x01)
+					umr |= 0x08;
+
+				if (data->data.cs_cap == 0x01)
+					umr |= 0x10;
+
+				if (rs485->flags & SER_RS485_TERMINATE_BUS) {
+					if (data->data.rs485_termination_cap == 0x01) {
+						umr |= 0x80;
+					} else {
+						dev_err(p->dev, "ttyS%d no RS485 termination cap.\n", data->data.line);
+						ret = -EINVAL;
+					}
+				}
+			} else {
+				dev_err(p->dev, "ttyS%d no RS485 cap.\n", data->data.line);
+				ret = -EINVAL;
+			}
+		}
+	} else {
+		// rs232
+		if (data->data.rs232_cap == 0x01) {
+			umr = 0x01;
+		} else {
+			dev_err(p->dev, "ttyS%d no rs232 cap.\n", data->data.line);
+			ret = -EINVAL;
+		}
+	}
+
+	if (ret == 0) {
+		do
+		{
+			outb(umr, p->iobase + UART_SDC_V0_UMER);
+			umr_check = inb(p->iobase + UART_SDC_V0_UMER);
+			if (umr != umr_check) {
+				ret = -EIO;
+				break;
+			}
+
+			data->umr = umr;
+			p->rs485 = *rs485;
+
+		} while (false);
+	}
+
+	return ret;
+}
+
+static int sdc8250_debugfs_add(struct sdc8250_data *data)
+{
+	struct dentry *root_dir;
+	char root_name[20];
+
+	memset(root_name, 0, sizeof(root_name));
+	sprintf(root_name, "ttyS%d", data->data.line);
+	root_dir = debugfs_create_dir(root_name, sdc_serial_debugfs);
+	if (IS_ERR(root_dir))
+		return PTR_ERR(root_dir);
+
+	debugfs_create_u32("bus_number", 0644, root_dir, &data->data.bus_number);
+	debugfs_create_u32("device_number", 0644, root_dir, &data->data.device_number);
+	debugfs_create_u32("irq", 0644, root_dir, &data->data.irq);
+	debugfs_create_u8("number", 0644, root_dir, &data->data.number);
+	debugfs_create_u8("version", 0644, root_dir, &data->data.version);
+	debugfs_create_u8("resource_cap", 0644, root_dir, &data->data.resource_cap);
+	debugfs_create_u8("event_header_type", 0644, root_dir, &data->data.event_header_type);
+	debugfs_create_u16("tx_fifo_size", 0644, root_dir, &data->data.tx_fifo_size);
+	debugfs_create_u16("rx_fifo_size", 0644, root_dir, &data->data.rx_fifo_size);
+	debugfs_create_u32("significand_of_ref_clk", 0644, root_dir, &data->data.significand_of_ref_clk);
+	debugfs_create_u8("exponent_of_ref_clk", 0644, root_dir, &data->data.exponent_of_ref_clk);
+	debugfs_create_u8("rs232_cap", 0644, root_dir, &data->data.rs232_cap);
+	debugfs_create_u8("rs422_cap", 0644, root_dir, &data->data.rs422_cap);
+	debugfs_create_u8("rs485_cap", 0644, root_dir, &data->data.rs485_cap);
+	debugfs_create_u8("ahdc_cap", 0644, root_dir, &data->data.ahdc_cap);
+	debugfs_create_u8("cs_cap", 0644, root_dir, &data->data.cs_cap);
+	debugfs_create_u8("rs422_termination_cap", 0644, root_dir, &data->data.rs422_termination_cap);
+	debugfs_create_u8("rs485_termination_cap", 0644, root_dir, &data->data.rs485_termination_cap);
+	debugfs_create_u32("line", 0644, root_dir, &data->data.line);
+
+	memset(data->device_name, 0, sizeof(data->device_name));
+	sprintf(data->device_name, "%s", dev_name(data->device));
+	data->device_name[strlen(data->device_name)] = 0x0a;
+	data->debugfs_blob_device_name.data = data->device_name;
+	data->debugfs_blob_device_name.size = strlen(data->device_name) + 1;
+	debugfs_create_blob("device_name", 0644, root_dir, &data->debugfs_blob_device_name);
+
+	data->debugfs = root_dir;
+	return 0;
+}
+
+static void sdc8250_debugfs_remove(struct sdc8250_data *data)
+{
+	debugfs_remove_recursive(data->debugfs);
+}
+
+static int sdc8250_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct uart_8250_port *up = NULL;
+	struct uart_port *p = NULL;
+	struct sdc8250_data *data;
+	struct device *dev = &pdev->dev;
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	int irq;
+	unsigned long long exponent;
+	struct serial_rs485 rs485_cfg;
+	unsigned char umr_check = 0;
+
+	if (!regs) {
+		dev_err(dev, "no registers defined\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = device_property_read_u32(dev, "bus_number", &data->data.bus_number);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u32(dev, "device_number", &data->data.device_number);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u32(dev, "irq", &data->data.irq);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "number", &data->data.number);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "version", &data->data.version);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "resource_cap", &data->data.resource_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "event_header_type", &data->data.event_header_type);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u16(dev, "tx_fifo_size", &data->data.tx_fifo_size);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u16(dev, "rx_fifo_size", &data->data.rx_fifo_size);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u32(dev, "significand_of_ref_clk", &data->data.significand_of_ref_clk);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "exponent_of_ref_clk", &data->data.exponent_of_ref_clk);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "rs232_cap", &data->data.rs232_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "rs422_cap", &data->data.rs422_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "rs485_cap", &data->data.rs485_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "ahdc_cap", &data->data.ahdc_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "cs_cap", &data->data.cs_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "rs422_termination_cap", &data->data.rs422_termination_cap);
+	if (ret < 0)
+		goto err_property;
+	ret = device_property_read_u8(dev, "rs485_termination_cap", &data->data.rs485_termination_cap);
+	if (ret < 0)
+		goto err_property;
+
+	data->fifosize = data->data.rx_fifo_size;
+	if (data->fifosize > data->data.tx_fifo_size) {
+		data->fifosize = data->data.tx_fifo_size;
+	}
+
+	exponent = 1;
+	for (i = 0; i < data->data.exponent_of_ref_clk; i++)
+		exponent *= 10;
+	data->clk = data->data.significand_of_ref_clk * exponent;
+
+	memset(&rs485_cfg, 0, sizeof(rs485_cfg));
+	if (data->data.version == 0x00) {
+		data->umr = inb(regs->start + UART_SDC_V0_UMER);
+		if ((data->umr & 0x07) == 0x01) {
+			// rs232 mode
+
+		} else if ((data->umr & 0x07) == 0x02) {
+			// rs422 mode
+			rs485_cfg.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
+
+			if (data->umr & 0x40)
+				rs485_cfg.flags |= SER_RS485_TERMINATE_BUS;
+
+		} else if ((data->umr & 0x07) == 0x04) {
+			// rs485 mode
+			rs485_cfg.flags = SER_RS485_ENABLED;
+
+			if (data->umr & 0x80)
+				rs485_cfg.flags |= SER_RS485_TERMINATE_BUS;
+
+			if (data->data.ahdc_cap == 0x01)
+				data->umr |= 0x08;
+
+			if (data->data.cs_cap == 0x01)
+				data->umr |= 0x10;
+
+			outb(data->umr, regs->start + UART_SDC_V0_UMER);
+			umr_check = inb(regs->start + UART_SDC_V0_UMER);
+
+			if (data->umr != umr_check) {
+				ret = -EIO;
+				goto err_unsupport;
+			}
+		} else {
+			ret = -EINVAL;
+			goto err_unsupport;
+		}
+	} else {
+		ret = -EINVAL;
+		goto err_unsupport;
+	}
+
+	data->device = dev;
+	up = &data->uart;
+	p = &up->port;
+
+	spin_lock_init(&p->lock);
+	p->iotype       = UPIO_PORT;
+	p->iobase       = regs->start;
+	p->mapbase      = 0;
+	p->membase      = NULL;
+	p->regshift     = 0;
+
+	p->irq          = irq;
+	p->type         = PORT_SUNIX;
+	p->flags        = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	p->fifosize     = data->fifosize;
+	p->dev          = dev;
+	p->uartclk      = data->clk;
+	p->private_data = &data->data;
+
+	p->pm           = sdc8250_do_pm;
+	p->rs485_config = sdc8250_rs485_config;
+	memcpy(&p->rs485, &rs485_cfg, sizeof(struct serial_rs485));
+	up->capabilities = UART_CAP_FIFO | UART_CAP_AFE;
+
+	data->data.line = serial8250_register_8250_port(up);
+	if (data->data.line < 0) {
+		ret = data->data.line;
+		goto err_register;
+	}
+
+	ret = sdc8250_debugfs_add(data);
+	if (ret)
+		dev_warn(dev, "failed to create debugfs entries\n");
+
+	platform_set_drvdata(pdev, data);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	return 0;
+
+err_register:
+
+err_unsupport:
+
+err_property:
+	pr_err("failed to register (chl:%d), error:%d\n", data->data.number, ret);
+	return ret;
+}
+
+static int sdc8250_remove(struct platform_device *pdev)
+{
+	struct sdc8250_data *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_get_sync(dev);
+
+	sdc8250_debugfs_remove(data);
+	serial8250_unregister_port(data->data.line);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdc8250_suspend(struct device *dev)
+{
+	struct sdc8250_data *data = dev_get_drvdata(dev);
+
+	// save umr
+	data->umr = inb(data->uart.port.iobase + UART_SDC_V0_UMER);
+
+	serial8250_suspend_port(data->data.line);
+	return 0;
+}
+
+static int sdc8250_resume(struct device *dev)
+{
+	struct sdc8250_data *data = dev_get_drvdata(dev);
+
+	// restore umr
+	outb(data->umr, data->uart.port.iobase + UART_SDC_V0_UMER);
+
+	serial8250_resume_port(data->data.line);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int sdc8250_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int sdc8250_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sdc8250_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdc8250_suspend, sdc8250_resume)
+	SET_RUNTIME_PM_OPS(sdc8250_runtime_suspend, sdc8250_runtime_resume, NULL)
+};
+
+static const struct of_device_id sdc8250_of_match[] = {
+	{ .compatible = "sunix,sdc_serial" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sdc8250_of_match);
+
+static struct platform_driver sdc8250_platform_driver = {
+	.driver = {
+		.name = "sdc_serial",
+		.pm = &sdc8250_pm_ops,
+		.of_match_table = sdc8250_of_match,
+	},
+	.probe = sdc8250_probe,
+	.remove = sdc8250_remove,
+};
+
+static int __init sdc8250_init(void)
+{
+	sdc_serial_debugfs = debugfs_create_dir("sdc_serial", NULL);
+	platform_driver_register(&sdc8250_platform_driver);
+	return 0;
+}
+module_init(sdc8250_init);
+
+static void __exit sdc8250_exit(void)
+{
+	platform_driver_unregister(&sdc8250_platform_driver);
+	debugfs_remove(sdc_serial_debugfs);
+}
+module_exit(sdc8250_exit);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC serial port driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("1.0.0.0");
+
+MODULE_ALIAS("platform:sdc_serial");
+
+
diff --git a/8250_sdc.h b/8250_sdc.h
new file mode 100644
index 0000000..4ec80ee
--- /dev/null
+++ b/8250_sdc.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC serial port driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ * Authors: Jason Lee <jason_lee@sunix.com>
+ */
+
+#ifndef __8250_SDC_H
+#define __8250_SDC_H
+
+#include <linux/types.h>
+#include "8250.h"
+
+struct sdc8250_port_data {
+	int bus_number;
+	int device_number;
+	int irq;
+
+	unsigned char number;
+	unsigned char version;
+	unsigned char resource_cap;
+	unsigned char event_header_type;
+
+	unsigned short tx_fifo_size;
+	unsigned short rx_fifo_size;
+	unsigned int significand_of_ref_clk;
+	unsigned char exponent_of_ref_clk;
+	unsigned char rs232_cap;
+	unsigned char rs422_cap;
+	unsigned char rs485_cap;
+	unsigned char ahdc_cap;
+	unsigned char cs_cap;
+	unsigned char rs422_termination_cap;
+	unsigned char rs485_termination_cap;
+
+	int line;
+};
+
+#define UART_SDC_V0_UMER				0x0e
+
+#endif // __8250_SDC_H
+
+
-- 
2.20.1

