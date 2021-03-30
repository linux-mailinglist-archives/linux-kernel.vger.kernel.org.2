Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16E934E14E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhC3Gid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC3Gh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:37:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14490C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:37:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so8931248pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sme3sEIQyqlRi3y8Oc7M91wtFhlY9sr/CST6SsNyGpc=;
        b=Ji6kkENbJdPe5TH/kTajkqsatitq2dBEKDMqXqT8mHjWtqQElQXYinPL+XWkc3r92M
         D+wmqcibWETX08hRMELivkdqB0q63hiSOZN5Yv2xRk1cXuwL1HmNcE5V9GjZ/GoNkg3U
         qYclykq04zJblEn7AtIrF/h9E5lW4V6Uzu8axCCQ5zBaSrlC9sl3W69z9bQ847iiuKzW
         MskNHpjXbNktpYndRJtMvnokjleX0hN6TtTomtP2OuPsEZ6JVBw3RAD05NBLtIlYqiut
         nLzty+OdQan3j/RtMZVF2F/ObaSuC6Mc1h0gCoind8BXQBfQV7KIKPL78ia943e9Pk59
         xeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sme3sEIQyqlRi3y8Oc7M91wtFhlY9sr/CST6SsNyGpc=;
        b=aLqI/mQ/8L4hUNa+3+m7iq2v+2e/kHignAD/EZ60Pek3fbDegDEJwKlTaBWksz+AOZ
         hHRhjGyrB8jOLVzil59hutcKVHTTh878Af9mDb36Ts13VtB+3GTMB60903HdgtR4Orhe
         igsvD4/5FjzfBsDYFvS1zEeCzxgTvxK9KBGml1gx1MZAfWYgeBHRQlxJ3DVBEbSOVAfW
         KBaAO2kTOC8cpm848Wp2dxwaodBAfdYaWTbbdUGwjbrYxzr6vo7dlgF0ASCdNlDs3Z4n
         WHKi3aECUHhIuVSx9MjMhiIgstvRIWki0xiM7P5syUaYCQ86GN3ixMfOAFExdEud0Tyg
         kl5w==
X-Gm-Message-State: AOAM5310C+jGdISkjU8OkSZNsLiBUNTtP1SiXklxtzSMxt35MYwY2k3D
        gMT+2FfaKo5eNnC4BD+tlQGthMH93jA=
X-Google-Smtp-Source: ABdhPJz9MjfZRlCth8+6yYqshZiKwurq6cec8rFFB5rtQXTDtMGzFqKGqvDlp8lx8iyI/CFuARpDVw==
X-Received: by 2002:a17:902:6541:b029:e6:27a4:80fb with SMTP id d1-20020a1709026541b02900e627a480fbmr31681048pln.15.1617086246651;
        Mon, 29 Mar 2021 23:37:26 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id g10sm18076408pgh.36.2021.03.29.23.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:37:25 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Morris <saumah@gmail.com>
Subject: [PATCH] Add Driver for SUNIX PCI(e) I/O expansion board
Date:   Tue, 30 Mar 2021 14:37:07 +0800
Message-Id: <20210330063707.4202-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris <saumah@gmail.com>

The board provide UART, DIO and CAN functions.

Signed-off-by: Morris <saumah@gmail.com>
---
 drivers/mfd/bus.c          | 1524 +++++++++++++++
 drivers/mfd/dio.c          |  529 +++++
 drivers/mfd/dio_pack.c     | 3126 +++++++++++++++++++++++++++++
 drivers/mfd/list.c         |   99 +
 drivers/mfd/mem.c          |   37 +
 drivers/mfd/sdc_define.h   |  668 +++++++
 drivers/mfd/sdc_function.h |   96 +
 drivers/mfd/sdc_include.h  |  108 +
 drivers/mfd/spi.c          |  420 ++++
 drivers/mfd/spi_pack.c     | 1506 ++++++++++++++
 drivers/mfd/uart.c         | 3796 ++++++++++++++++++++++++++++++++++++
 11 files changed, 11909 insertions(+)
 create mode 100644 drivers/mfd/bus.c
 create mode 100644 drivers/mfd/dio.c
 create mode 100644 drivers/mfd/dio_pack.c
 create mode 100644 drivers/mfd/list.c
 create mode 100644 drivers/mfd/mem.c
 create mode 100644 drivers/mfd/sdc_define.h
 create mode 100644 drivers/mfd/sdc_function.h
 create mode 100644 drivers/mfd/sdc_include.h
 create mode 100644 drivers/mfd/spi.c
 create mode 100644 drivers/mfd/spi_pack.c
 create mode 100644 drivers/mfd/uart.c

diff --git a/drivers/mfd/bus.c b/drivers/mfd/bus.c
new file mode 100644
index 000000000000..7820072e918f
--- /dev/null
+++ b/drivers/mfd/bus.c
@@ -0,0 +1,1524 @@
+/*
+ *	Driver for SUNIX PCI(e) expansion board
+ *	Based on drivers/tty/serial/8250/8250_pci.c
+ *	by Linus Torvalds, Theodore Ts'o.
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License.
+ */
+
+
+#include "sdc_include.h"
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+static  struct pci_device_id	sunix_pci_board_id[] = 
+{
+	{0x1fd4, 0x2000, 0x1fd4, 0x0001, 0, 0, 123},
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, sunix_pci_board_id);
+#else
+typedef struct
+{
+	unsigned short vendor;
+	unsigned short device;
+	unsigned short subvendor;
+	unsigned short subdevice;
+	unsigned short driver_data;
+	unsigned short part_number;
+} sunix_pciInfo;
+
+static sunix_pciInfo sunix_pci_board_id[] = 
+{
+	{0x1fd4, 0x2000, 0x1fd4, 0x0001, 123},
+	{0}
+};
+#endif
+
+
+struct sunix_sdc_board			sunix_sdc_board_table[SUNIX_SDC_BOARD_MAX];
+struct sunix_sdc_uart_channel	sunix_sdc_uart_table[SUNIX_SDC_UART_MAX + 1];
+struct sunix_sdc_dio_channel	sunix_sdc_dio_table[SUNIX_SDC_DIO_MAX];
+struct sunix_sdc_spi_channel	sunix_sdc_spi_table[SUNIX_SDC_SPI_MAX];
+
+struct kmem_cache *				sunix_sdc_dio_pack_cache;
+struct kmem_cache *				sunix_sdc_spi_pack_cache;
+
+unsigned int					sunix_sdc_board_amount;
+unsigned int					sunix_sdc_uart_amount;
+unsigned int					sunix_sdc_dio_amount;
+unsigned int					sunix_sdc_spi_amount;
+
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 18))
+static irqreturn_t sunix_interrupt(int irq, void *dev_id)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+static irqreturn_t sunix_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+#else
+static void sunix_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+#endif
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_uart_channel *uart_chl = NULL;
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int i, j, k;
+	int status = 0;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	int handled = IRQ_NONE;
+#endif
+	unsigned int vector[8];
+	unsigned int event_header;
+	unsigned char chl_num;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		if (dev_id == &(sunix_sdc_board_table[i]))
+		{
+			sb = dev_id;
+			break;
+		}
+	}
+
+	if (i == SUNIX_SDC_BOARD_MAX)
+		status = 1;
+
+	if (!sb)
+		status = 1;
+
+	if (sb->board_enum <= 0)
+		status = 1;
+
+	if (status != 0)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		return handled;
+#else
+		return;
+#endif
+	}
+
+	vector[0] = mem_rx32(sb->bar0_membase, 0, 0);
+	vector[1] = mem_rx32(sb->bar0_membase, 0, 1);
+	vector[2] = mem_rx32(sb->bar0_membase, 0, 2);
+	vector[3] = mem_rx32(sb->bar0_membase, 0, 3);
+	vector[4] = mem_rx32(sb->bar0_membase, 0, 4);
+	vector[5] = mem_rx32(sb->bar0_membase, 0, 5);
+	vector[6] = mem_rx32(sb->bar0_membase, 0, 6);
+	vector[7] = mem_rx32(sb->bar0_membase, 0, 7);
+
+	for (i = 0; i < 8; i++)
+	{
+		if (vector[i] & 0xffffffff)
+		{
+			for (j = 0; j < 32; j++)
+			{
+				if (vector[i] & (0x00000001 << j))
+				{
+					chl_num = (i * 8) + j;
+
+					event_header = mem_rx32(sb->bar0_membase, 0, 8 + chl_num);
+
+					for (k = 0; k < SUNIX_SDC_UART_MAX + 1; k++)
+					{
+						uart_chl = &sunix_sdc_uart_table[k];
+
+						// uart
+						if ((uart_chl->port.iobase != 0) && 
+							(uart_chl->port.bus_number == sb->bus_number) &&
+							(uart_chl->port.dev_number == sb->dev_number) &&
+							(uart_chl->port.cib_info.num == chl_num) &&
+							(uart_chl->port.cib_info.type == 0x01))
+						{
+							//printk("SUNIX: bus_num:%d, dev_num:%d, chl_num:%d, event:x%08x, ttySDC%d has interrupt\n", uart_chl->port.bus_number, uart_chl->port.dev_number, chl_num, event_header, uart_chl->port.line);
+							status = sb->uart_isr(uart_chl);
+						}
+					}
+
+					for (k = 0; k < SUNIX_SDC_DIO_MAX; k++)
+					{
+						dio_chl = &sunix_sdc_dio_table[k];
+
+						// dio
+						if ((dio_chl->info.memsize != 0) && 
+							(dio_chl->info.bus_number == sb->bus_number) &&
+							(dio_chl->info.dev_number == sb->dev_number) &&
+							(dio_chl->info.cib_info.num == chl_num) &&
+							(dio_chl->info.cib_info.type == 0x02))
+						{
+							//printk("SUNIX: bus_num:%d, dev_num:%d, chl_num:%d, event:x%08x, SDCDIO%d has interrupt\n", dio_chl->info.bus_number, dio_chl->info.dev_number, chl_num, event_header, dio_chl->info.line);
+							status = sb->dio_isr(dio_chl, event_header);
+						}
+					}
+
+					for (k = 0; k < SUNIX_SDC_SPI_MAX; k++)
+					{
+						spi_chl = &sunix_sdc_spi_table[k];
+
+						// spi
+						if ((spi_chl->info.memsize != 0) && 
+							(spi_chl->info.bus_number == sb->bus_number) &&
+							(spi_chl->info.dev_number == sb->dev_number) &&
+							(spi_chl->info.cib_info.num == chl_num) &&
+							(spi_chl->info.cib_info.type == 0x03))
+						{
+							//printk("SUNIX: bus_num:%d, dev_num:%d, chl_num:%d, event:x%08x, SDCSPI%d has interrupt\n", spi_chl->info.bus_number, spi_chl->info.dev_number, chl_num, event_header, spi_chl->info.line);
+							status = sb->spi_isr(spi_chl, event_header);
+						}
+					}
+				}
+			}
+		}
+	}
+
+	if (status != 0)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		return handled;
+#else
+		return;
+#endif
+	}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	handled = IRQ_HANDLED;
+	return handled;
+#endif
+}
+
+
+static int snx_pci_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	return 0;
+}
+
+
+static int snx_suspend_one(struct pci_dev *pdev, pm_message_t state)
+{
+	return  0;
+}
+
+
+static int snx_set_port_termios(struct snx_ser_state *state)
+{
+	struct tty_struct *tty = state->info->tty;
+	struct SNXTERMIOS *termios;
+	int retval = 0;
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	termios = &tty->termios;
+#else
+	termios = tty->termios;
+#endif
+
+	retval = snx_ser_startup(state, 0);
+
+	if (retval == 0)
+	{
+		snx_ser_update_termios(state);
+	}
+
+	return 0;
+}
+
+
+static int snx_resume_port_termios(struct snx_ser_info *info)
+{
+	struct snx_ser_state *state = NULL;
+	struct tty_struct *tty = info->tty ;
+
+
+	state = tty->driver_data;
+	snx_set_port_termios(state);
+
+	return 0;
+}
+
+
+static int snx_resume_port(struct sunix_sdc_uart_channel *uart_chl)
+{
+	struct snx_ser_port *port = &uart_chl->port;
+	struct snx_ser_info *info = port->info;
+
+
+	if (info)
+	{
+		snx_resume_port_termios(info);
+	}
+
+	return 0;
+}
+
+
+static int snx_resume_one(struct pci_dev *pdev)
+{
+	struct sunix_sdc_board *sb = pci_get_drvdata(pdev);
+	struct sunix_sdc_uart_channel *uart_chl = NULL;
+	int j;
+
+
+	if (sb == NULL)
+	{
+		return 0;
+	}
+
+	for (j = 0; j < sb->uart_amount; j++)
+	{
+		uart_chl = &sunix_sdc_uart_table[sb->uart_start_index + j];
+
+		if (uart_chl == NULL)
+		{
+			return 0;
+		}
+
+		if (uart_chl->port.suspended == 1)
+		{
+			snx_resume_port(uart_chl);
+		}
+	}
+
+	return 0;
+}
+
+
+static int sunix_pci_board_probe(void)
+{
+	struct sunix_sdc_board *sb;
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pdev_array[4] = {NULL, NULL, NULL, NULL};
+	int sunix_pci_board_id_cnt;
+	int tablecnt;
+	int board_amount = 0;
+	int i, j;
+	unsigned short int sub_device_id;
+	int status;
+	unsigned char data1B;
+	unsigned int data8B;
+
+
+	// clear and init some variable
+	memset(sunix_sdc_board_table, 0, SUNIX_SDC_BOARD_MAX * sizeof(struct sunix_sdc_board));
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sunix_sdc_board_table[i].board_enum = -1;
+		sunix_sdc_board_table[i].board_number = -1;
+		sunix_sdc_board_table[i].bar0_membase = NULL;
+		sunix_sdc_board_table[i].bar2_membase = NULL;
+	}
+	sunix_pci_board_id_cnt = (sizeof(sunix_pci_board_id) / sizeof(sunix_pci_board_id[0])) - 1;
+
+
+	// search 
+	pdev = NULL;
+	tablecnt = 0;
+	sub_device_id = 0;
+	status = 0;
+
+	while (tablecnt < sunix_pci_board_id_cnt)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		pdev = pci_get_device(0x1fd4, 0x2000, pdev);
+#else
+		pdev = pci_find_device(0x1fd4, 0x2000, pdev);
+#endif
+
+		if (pdev == NULL)
+		{
+			tablecnt++;
+			continue;
+		}
+
+		if ((tablecnt > 0) && ((pdev == pdev_array[0]) || (pdev == pdev_array[1]) || (pdev == pdev_array[2]) || (pdev == pdev_array[3])))
+		{
+			continue;
+		}
+
+		pci_read_config_word(pdev, 0x2e, &sub_device_id);
+
+		if (sub_device_id == 0)
+		{
+			printk("SUNIX: Board (bus:%d device:%d), in configuration space, subdevice id isn't vaild.\n", pdev->bus->number, PCI_SLOT(pdev->devfn));
+			status = -EIO;
+			return status;
+		}
+
+		if (sub_device_id != sunix_pci_board_id[tablecnt].subdevice)
+		{
+			continue;
+		}
+
+		if (pdev == NULL)
+		{
+			printk("SUNIX: PCI device object is an NULL pointer !\n");
+			status = -EIO;
+			return status;
+		}
+		else
+		{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+
+#elif (LINUX_VERSION_CODE > KERNEL_VERSION(2, 4, 3))
+			pci_disable_device(pdev);
+#endif
+			status = pci_enable_device(pdev);
+			if (status != 0)
+			{
+				printk("SUNIX: Board Enable Fail !\n");
+				status = -ENXIO;
+				return status;
+			}
+		}
+
+		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
+		{
+			printk("SUNIX: Incorrect BAR0 configuration.\n");
+			status = -ENODEV;
+			return status;
+		}
+		if (!(pci_resource_flags(pdev, 1) & IORESOURCE_IO))
+		{
+			printk("SUNIX: Incorrect BAR1 configuration.\n");
+			status = -ENODEV;
+			return status;
+		}
+		if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM))
+		{
+			printk("SUNIX: Incorrect BAR2 configuration.\n");
+			status = -ENODEV;
+			return status;
+		}
+
+
+		board_amount++;
+		if (board_amount > SUNIX_SDC_BOARD_MAX)
+		{
+			printk("SUNIX: Driver support 4 boards in maximum !\n");
+			status = -ENOSPC;
+			return status;
+		}
+
+		sb = &sunix_sdc_board_table[board_amount-1];
+		pdev_array[board_amount-1] = pdev;
+
+
+		sb->pdev = pdev;
+		sb->board_enum = (int)sunix_pci_board_id[tablecnt].driver_data;
+		sb->board_number = board_amount - 1;
+		sb->bus_number = pdev->bus->number;
+		sb->dev_number = PCI_SLOT(pdev->devfn);
+		sb->irq = pdev->irq;
+
+		sb->bar0_membase = mem_get_bar_ioremap(pdev, 0);
+		sb->bar1_iobase = pci_resource_start(pdev, 1);
+		sb->bar2_membase = mem_get_bar_ioremap(pdev, 2);
+		data8B = mem_rx32(sb->bar2_membase, 0, 0);
+		sb->major_version = data8B & 0x000000ff;
+		sb->minor_version = (data8B & 0x0000ff00) >> 8;
+		sb->aval_channels = (data8B & 0x00ff0000) >> 16;
+
+		j = 0;
+		memset(sb->model_name, 0, sizeof(sb->model_name));
+		for (i = 0; i < 4; i++)
+		{
+			data8B = mem_rx32(sb->bar2_membase, 0, 2 + i);
+
+			data1B = data8B & 0x000000ff;
+			if (data1B == 0x00)
+				break;
+			sb->model_name[j++] = data1B;
+
+			data1B = (data8B & 0x0000ff00) >> 8;
+			if (data1B == 0x00)
+				break;
+			sb->model_name[j++] = data1B;
+
+			data1B = (data8B & 0x00ff0000) >> 16;
+			if (data1B == 0x00)
+				break;
+			sb->model_name[j++] = data1B;
+
+			data1B = (data8B & 0xff000000) >> 24;
+			if (data1B == 0x00)
+				break;
+			sb->model_name[j++] = data1B;
+		}
+	}
+
+
+	if (board_amount == 0)
+	{
+		printk("SUNIX: No board found !\n");
+		status = -ENXIO;
+		return status;
+	}
+	else
+	{
+		for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+		{
+			sb = &sunix_sdc_board_table[i];
+
+			if (sb->board_enum > 0)
+			{
+				printk("SUNIX: Found %s board (bus_num:%d, dev_num:%d, maj_v:%d, min_vr:%d)\n", sb->model_name, sb->bus_number, sb->dev_number, sb->major_version, sb->minor_version);
+			}
+		}
+		sunix_sdc_board_amount  = board_amount;
+    }
+
+	return status;
+}
+
+
+static int sunix_get_pci_board_conf(void)
+{
+    struct sunix_sdc_board *sb = NULL;
+    int status = 0;
+    int i, j, k, l;
+	unsigned int data8B;
+	unsigned int cib_addr;
+	unsigned int cib_addr_offset;
+	unsigned short next_ptr;
+	int uart_amount;
+	int dio_amount;
+	int spi_amount;
+	unsigned int dio_io_mask = 0;
+	unsigned int dio_io_shift_bits = 0;
+	unsigned int dio_io_direction = 0;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb->board_enum > 0)
+		{
+			dio_io_shift_bits = 0;
+
+			data8B = mem_rx32(sb->bar2_membase, 0, 1);
+			next_ptr = data8B & 0x0000ffff;
+
+			uart_amount = 0;
+			dio_amount = 0;
+			spi_amount = 0;
+
+			cib_addr = 0;
+			for (j = 0; j < sb->aval_channels; j++)
+			{
+				cib_addr = next_ptr;
+				cib_addr_offset = 0;
+				data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+				sb->channel[j].num = data8B & 0x000000ff;
+				sb->channel[j].type = (data8B & 0x0000ff00) >> 8;
+				sb->channel[j].version = (data8B & 0x00ff0000) >> 16;
+				sb->channel[j].lengthInDW = (data8B & 0xff000000) >> 24;
+
+				data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+				next_ptr = data8B & 0x0000ffff;
+				sb->channel[j].capability = (data8B & 0x00ff0000) >> 16;
+				sb->channel[j].event_header_type = (data8B & 0xff000000) >> 24;
+
+				if ((sb->channel[j].capability & 0x03) == 0x03)
+				{
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].io_addr_offset = data8B & 0x00ffffff;
+					sb->channel[j].io_space_size = (data8B & 0xff000000) >> 24;
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].mem_addr_offset = data8B;
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].mem_space_size = data8B;
+				}
+				else if ((sb->channel[j].capability & 0x01) == 0x01)
+				{
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].io_addr_offset = data8B & 0x00ffffff;
+					sb->channel[j].io_space_size = (data8B & 0xff000000) >> 24;
+				}
+				else if ((sb->channel[j].capability & 0x02) == 0x02)
+				{
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].mem_addr_offset = data8B;
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].mem_space_size = data8B;
+				}
+
+				if (sb->channel[j].type == 0x00)
+				{
+					// configuration controller
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].cfg_ic_model = data8B & 0x000000ff;
+				}
+
+				if (sb->channel[j].type == 0x01)
+				{
+					uart_amount++;
+					// uart controller
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].uart_tx_fifo_size = data8B & 0x0000ffff;
+					sb->channel[j].uart_rx_fifo_size = (data8B & 0xffff0000) >> 16;
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].uart_significand_of_clock = data8B & 0x00ffffff;
+					sb->channel[j].uart_exponent_of_clock = (data8B & 0xff000000) >> 24;
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].uart_RS232_cap = data8B & 0x00000001;
+					sb->channel[j].uart_RS422_cap = (data8B & 0x00000002) >> 1;
+					sb->channel[j].uart_RS485_cap = (data8B & 0x00000004) >> 2;
+					sb->channel[j].uart_AHDC_cap = (data8B & 0x00000008) >> 3;
+					sb->channel[j].uart_CS_cap = (data8B & 0x00000010) >> 4;
+					sb->channel[j].uart_auto_RS422485_cap = (data8B & 0x00000020) >> 5;
+					sb->channel[j].uart_RS422_termination_cap = (data8B & 0x00000040) >> 6;
+					sb->channel[j].uart_RS485_termination_cap = (data8B & 0x00000080) >> 7;
+					sb->channel[j].uart_RI_5V_cap = (data8B & 0x00000100) >> 8;
+					sb->channel[j].uart_RI_12V_cap = (data8B & 0x00000200) >> 9;
+					sb->channel[j].uart_DCD_5V_cap = (data8B & 0x00000400) >> 10;
+					sb->channel[j].uart_DCD_12V_cap = (data8B & 0x00000800) >> 11;
+					// switch to rs422 if support rs422
+					if ((sb->channel[j].uart_RS232_cap == 0x00) && (sb->channel[j].uart_RS422_cap == 0x01))
+					{
+						outb(0x02, sb->bar1_iobase + sb->channel[j].io_addr_offset + 0x0e);
+					}
+				}
+
+				if (sb->channel[j].type == 0x02)
+				{
+					dio_amount++;
+					// dio controller
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].dio_number_of_banks = data8B & 0x000000ff;
+					sb->channel[j].dio_shares_same_direction_ctrl_cap = (data8B & 0x00000100) >> 8;
+					sb->channel[j].dio_writing_setting_to_flash_cap = (data8B & 0x00000200) >> 9;
+
+					for (k = 0; k < sb->channel[j].dio_number_of_banks; k++)
+					{
+						data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+						sb->channel[j].dio_bank_cap[k].number_of_io = data8B & 0x000000ff;
+						sb->channel[j].dio_bank_cap[k].support_inputs = (data8B & 0x00000100) >> 8;
+						sb->channel[j].dio_bank_cap[k].support_outputs = (data8B & 0x00000200) >> 9;
+						sb->channel[j].dio_bank_cap[k].rising_edge_trigger_cap = (data8B & 0x00000400) >> 10;
+						sb->channel[j].dio_bank_cap[k].falling_edge_trigger_cap = (data8B & 0x00000800) >> 11;
+					}
+
+					dio_io_direction = mem_rx32(sb->bar2_membase, sb->channel[j].mem_addr_offset, 12);
+					for (k = 0; k < sb->channel[j].dio_number_of_banks; k++)
+					{
+						dio_io_mask = 0;
+						for (l = 0; l < sb->channel[j].dio_bank_cap[k].number_of_io; l++)
+						{
+							dio_io_mask |= 0x00000001;
+							if (l < (sb->channel[j].dio_bank_cap[k].number_of_io - 1))
+								dio_io_mask = dio_io_mask <<1;
+						}
+
+						if (k > 0)
+						{
+							dio_io_shift_bits += sb->channel[j].dio_bank_cap[k-1].number_of_io;
+							dio_io_mask = dio_io_mask << dio_io_shift_bits;
+						}
+
+						sb->channel[j].dio_bank_cap[k].io_mask = dio_io_mask;
+						sb->channel[j].dio_bank_cap[k].io_shift_bits = dio_io_shift_bits;
+					}
+				}
+
+				if (sb->channel[j].type == 0x03)
+				{
+					spi_amount++;
+					// spi controller
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].spi_significand_of_clock = data8B & 0x00ffffff;
+					sb->channel[j].spi_exponent_of_clock = (data8B & 0xff000000) >> 24;
+					data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+					sb->channel[j].spi_number_of_device = data8B & 0x000000ff;
+
+					for (k = 0; k < sb->channel[j].spi_number_of_device; k++)
+					{
+						data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+						sb->channel[j].spi_device_cap[k].type = data8B & 0x00000001;
+						sb->channel[j].spi_device_cap[k].number_of_gpio_input = (data8B & 0x00000f00) >> 8;
+						sb->channel[j].spi_device_cap[k].number_of_gpio_output = (data8B & 0x0000f000) >> 12;
+
+						memset(sb->channel[j].spi_device_cap[k].name, 0, 32);
+						data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+						sb->channel[j].spi_device_cap[k].name[0] = data8B & 0x000000ff;
+						sb->channel[j].spi_device_cap[k].name[1] = (data8B & 0x0000ff00) >> 8;
+						sb->channel[j].spi_device_cap[k].name[2] = (data8B & 0x00ff0000) >> 16;
+						sb->channel[j].spi_device_cap[k].name[3] = (data8B & 0xff000000) >> 24;
+						data8B = mem_rx32(sb->bar2_membase, cib_addr, cib_addr_offset++);
+						sb->channel[j].spi_device_cap[k].name[4] = data8B & 0x000000ff;
+						sb->channel[j].spi_device_cap[k].name[5] = (data8B & 0x0000ff00) >> 8;
+						sb->channel[j].spi_device_cap[k].name[6] = (data8B & 0x00ff0000) >> 16;
+						sb->channel[j].spi_device_cap[k].name[7] = (data8B & 0xff000000) >> 24;
+					}
+				}
+			}
+
+			sb->uart_amount = uart_amount;
+			sunix_sdc_uart_amount = sunix_sdc_uart_amount + sb->uart_amount;
+
+			if (sunix_sdc_uart_amount > SUNIX_SDC_UART_MAX)
+			{
+				printk("SUNIX: Too much UART channel, maximum %d channels can be supported !\n", SUNIX_SDC_UART_MAX);
+				status = -EIO;
+				return status;
+			}
+
+			sb->dio_amount = dio_amount;
+			sunix_sdc_dio_amount = sunix_sdc_dio_amount + sb->dio_amount;
+
+			if (sunix_sdc_dio_amount > SUNIX_SDC_DIO_MAX)
+			{
+				printk("SUNIX: Too much DIO channel, maximum %d channels can be supported !\n", SUNIX_SDC_DIO_MAX);
+				status = -EIO;
+				return status;
+			}
+
+			sb->spi_amount = spi_amount;
+			sunix_sdc_spi_amount = sunix_sdc_spi_amount + sb->spi_amount;
+
+			if (sunix_sdc_spi_amount > SUNIX_SDC_SPI_MAX)
+			{
+				printk("SUNIX: Too much SPI channel, maximum %d channels can be supported !\n", SUNIX_SDC_SPI_MAX);
+				status = -EIO;
+				return status;
+			}
+		}
+	}
+
+
+
+
+#if (ENABLE_DEBUG_SDC_BUS == 1)
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb->board_enum > 0)
+ 		{
+			printk("=================================\n");
+			printk("board_enum         : %d\n", sb->board_enum);
+			printk("board_number       : %d\n", sb->board_number);
+			printk("bus_number         : %d\n", sb->bus_number);
+			printk("dev_number         : %d\n", sb->dev_number);
+			printk("irq                : %d\n", sb->irq);
+			printk("bar0_membase       : %p\n", sb->bar0_membase);
+			printk("bar1_iobase        : x%08x\n", sb->bar1_iobase);
+			printk("bar2_membase       : %p\n", sb->bar2_membase);
+			printk("major_version      : %d\n", sb->major_version);
+			printk("minor_version      : %d\n", sb->minor_version);
+			printk("aval_channels      : %d\n", sb->aval_channels);
+			printk("model_name         : %s\n", sb->model_name);
+			printk("uart_amount        : %d\n", sb->uart_amount);
+			printk("dio_amount         : %d\n", sb->dio_amount);
+			printk("spi_amount         : %d\n", sb->spi_amount);
+			for (j = 0; j < sb->aval_channels; j++)
+			{
+				//
+				if (sb->channel[j].type == 0x00)
+				{
+					printk("------------------------------, CONFIG\n");
+					printk("num                : %d\n", sb->channel[j].num);
+					printk("type               : %d\n", sb->channel[j].type);
+					printk("version            : %d\n", sb->channel[j].version);
+					printk("lengthInDW         : %d\n", sb->channel[j].lengthInDW);
+					printk("capability         : x%02x\n", sb->channel[j].capability);
+					printk("event_header_type  : x%02d\n", sb->channel[j].event_header_type);
+					printk("mem_addr_offset    : x%08x\n", sb->channel[j].mem_addr_offset);
+					printk("mem_space_size     : %d\n", sb->channel[j].mem_space_size);
+					printk("cfg_ic_model       : x%02x\n", sb->channel[j].cfg_ic_model);
+					printk("------------------------------\n");
+				}
+				//
+				//
+				if (sb->channel[j].type == 0x01)
+				{
+					printk("------------------------------, UART\n");
+					printk("num                : %d\n", sb->channel[j].num);
+					printk("type               : %d\n", sb->channel[j].type);
+					printk("version            : %d\n", sb->channel[j].version);
+					printk("lengthInDW         : %d\n", sb->channel[j].lengthInDW);
+					printk("capability         : x%02x\n", sb->channel[j].capability);
+					printk("event_header_type  : x%02d\n", sb->channel[j].event_header_type);
+					printk("io_addr_offset     : x%08x\n", sb->channel[j].io_addr_offset);
+					printk("io_space_size      : %d\n", sb->channel[j].io_space_size);
+					printk("mem_addr_offset    : x%08x\n", sb->channel[j].mem_addr_offset);
+					printk("mem_space_size     : %d\n", sb->channel[j].mem_space_size);
+					printk("uart_tx_fifo_size  : %d\n", sb->channel[j].uart_tx_fifo_size);
+					printk("uart_rx_fifo_size  : %d\n", sb->channel[j].uart_rx_fifo_size);
+					printk("significand_clock  : %d\n", sb->channel[j].uart_significand_of_clock);
+					printk("exponent_clock     : %d\n", sb->channel[j].uart_exponent_of_clock);
+					printk("uart_RS232_cap     : %d\n", sb->channel[j].uart_RS232_cap);
+					printk("uart_RS422_cap     : %d\n", sb->channel[j].uart_RS422_cap);
+					printk("uart_RS485_cap     : %d\n", sb->channel[j].uart_RS485_cap);
+					printk("uart_AHDC_cap      : %d\n", sb->channel[j].uart_AHDC_cap);
+					printk("uart_CS_cap        : %d\n", sb->channel[j].uart_CS_cap);
+					printk("uart_auto_RS422485 : %d\n", sb->channel[j].uart_auto_RS422485_cap);
+					printk("uart_RS422_termin  : %d\n", sb->channel[j].uart_RS422_termination_cap);
+					printk("uart_RS485_termin  : %d\n", sb->channel[j].uart_RS485_termination_cap);
+					printk("uart_RI_5V_cap     : %d\n", sb->channel[j].uart_RI_5V_cap);
+					printk("uart_RI_12V_cap    : %d\n", sb->channel[j].uart_RI_12V_cap);
+					printk("uart_DCD_5V_cap    : %d\n", sb->channel[j].uart_DCD_5V_cap);
+					printk("uart_DCD_12V_cap   : %d\n", sb->channel[j].uart_DCD_12V_cap);
+					printk("------------------------------\n");
+				}
+				//
+				//
+				if (sb->channel[j].type == 0x02)
+				{
+					printk("------------------------------, DIO\n");
+					printk("num                : %d\n", sb->channel[j].num);
+					printk("type               : %d\n", sb->channel[j].type);
+					printk("version            : %d\n", sb->channel[j].version);
+					printk("lengthInDW         : %d\n", sb->channel[j].lengthInDW);
+					printk("capability         : x%02x\n", sb->channel[j].capability);
+					printk("event_header_type  : x%02d\n", sb->channel[j].event_header_type);
+					printk("mem_addr_offset    : x%08x\n", sb->channel[j].mem_addr_offset);
+					printk("mem_space_size     : %d\n", sb->channel[j].mem_space_size);
+					printk("dio_number_of_banks: %d\n", sb->channel[j].dio_number_of_banks);
+					printk("shares_same_direct : %d\n", sb->channel[j].dio_shares_same_direction_ctrl_cap);
+					printk("writing_setting    : %d\n", sb->channel[j].dio_writing_setting_to_flash_cap);
+					for (k = 0; k < sb->channel[j].dio_number_of_banks; k++)
+					{
+						printk("++++++++++++++++++++++++++++\n");
+						printk("number_of_io       : %d\n", sb->channel[j].dio_bank_cap[k].number_of_io);
+						printk("support_inputs     : %d\n", sb->channel[j].dio_bank_cap[k].support_inputs);
+						printk("support_outputs    : %d\n", sb->channel[j].dio_bank_cap[k].support_outputs);
+						printk("rising_trigger     : %d\n", sb->channel[j].dio_bank_cap[k].rising_edge_trigger_cap);
+						printk("falling_trigger    : %d\n", sb->channel[j].dio_bank_cap[k].falling_edge_trigger_cap);
+						printk("++++++++++++++++++++++++++++\n");
+					}
+					printk("------------------------------\n");
+				}
+				//
+				//
+				if (sb->channel[j].type == 0x03)
+				{
+					printk("------------------------------, SPI\n");
+					printk("num                : %d\n", sb->channel[j].num);
+					printk("type               : %d\n", sb->channel[j].type);
+					printk("version            : %d\n", sb->channel[j].version);
+					printk("lengthInDW         : %d\n", sb->channel[j].lengthInDW);
+					printk("capability         : x%02x\n", sb->channel[j].capability);
+					printk("event_header_type  : x%02d\n", sb->channel[j].event_header_type);
+					printk("io_addr_offset     : x%08x\n", sb->channel[j].io_addr_offset);
+					printk("io_space_size      : %d\n", sb->channel[j].io_space_size);
+					printk("mem_addr_offset    : x%08x\n", sb->channel[j].mem_addr_offset);
+					printk("mem_space_size     : %d\n", sb->channel[j].mem_space_size);
+					printk("significand_clock  : %d\n", sb->channel[j].spi_significand_of_clock);
+					printk("exponent_clock     : %d\n", sb->channel[j].spi_exponent_of_clock);
+					printk("spi_number_device  : %d\n", sb->channel[j].spi_number_of_device);
+					for (k = 0; k < sb->channel[j].spi_number_of_device; k++)
+					{
+						printk("++++++++++++++++++++++++++++\n");
+						printk("type               : %d\n", sb->channel[j].spi_device_cap[k].type);
+						printk("number_gpio_input  : %d\n", sb->channel[j].spi_device_cap[k].number_of_gpio_input);
+						printk("number_gpio_output : %d\n", sb->channel[j].spi_device_cap[k].number_of_gpio_output);
+						printk("name               : %s\n", sb->channel[j].spi_device_cap[k].name);
+						printk("++++++++++++++++++++++++++++\n");
+					}
+					printk("------------------------------\n");
+				}
+				//
+			}
+			printk("=================================\n");
+		}
+	}
+#endif
+	return status;
+}
+
+
+static int sunix_assign_resource(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_uart_channel *uart_chl = NULL;
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+	int i;
+	int j;
+	int uart_index = 0;
+	int dio_index = 0;
+	int spi_index = 0;
+
+
+	memset(sunix_sdc_uart_table, 0, (SUNIX_SDC_UART_MAX + 1) * sizeof(struct sunix_sdc_uart_channel));
+	memset(sunix_sdc_dio_table, 0, SUNIX_SDC_DIO_MAX * sizeof(struct sunix_sdc_dio_channel));
+	memset(sunix_sdc_spi_table, 0, SUNIX_SDC_SPI_MAX * sizeof(struct sunix_sdc_spi_channel));
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb->board_enum > 0)
+		{
+			if (sb->uart_amount > 0)
+			{
+				sb->uart_start_index = uart_index;
+
+				for (j = 0; j < sb->aval_channels; j++)
+				{
+					if (sb->channel[j].type == 0x01)
+					{
+						uart_chl = &sunix_sdc_uart_table[uart_index];
+
+						uart_chl->port.iobase = sb->bar1_iobase + sb->channel[j].io_addr_offset;
+						uart_chl->port.iosize = sb->channel[j].io_space_size;
+						memcpy(&uart_chl->port.cib_info, &sb->channel[j], sizeof(struct sdc_cib));
+						memcpy(uart_chl->port.model_name, sb->model_name, sizeof(sb->model_name));
+
+						uart_index++;
+					}
+				}
+			}
+
+			if (sb->dio_amount > 0)
+			{
+				sb->dio_start_index = dio_index;
+
+				for (j = 0; j < sb->aval_channels; j++)
+				{
+					if (sb->channel[j].type == 0x02)
+					{
+						dio_chl = &sunix_sdc_dio_table[dio_index];
+
+						dio_chl->info.phy2_base_start = pci_resource_start(sb->pdev, 2);
+						dio_chl->info.membase = sb->bar2_membase;
+						dio_chl->info.memoffset = sb->channel[j].mem_addr_offset;
+						dio_chl->info.memsize = sb->channel[j].mem_space_size;
+						memcpy(&dio_chl->info.cib_info, &sb->channel[j], sizeof(struct sdc_cib));
+						memcpy(dio_chl->info.model_name, sb->model_name, sizeof(sb->model_name));
+
+						dio_index++;
+					}
+				}
+			}
+
+			if (sb->spi_amount > 0)
+			{
+				sb->spi_start_index = spi_index;
+
+				for (j = 0; j < sb->aval_channels; j++)
+				{
+					if (sb->channel[j].type == 0x03)
+					{
+						spi_chl = &sunix_sdc_spi_table[spi_index];
+
+						spi_chl->info.phy2_base_start = pci_resource_start(sb->pdev, 2);
+						spi_chl->info.membase = sb->bar2_membase;
+						spi_chl->info.memoffset = sb->channel[j].mem_addr_offset;
+						spi_chl->info.memsize = sb->channel[j].mem_space_size;
+						memcpy(&spi_chl->info.cib_info, &sb->channel[j], sizeof(struct sdc_cib));
+						memcpy(spi_chl->info.model_name, sb->model_name, sizeof(sb->model_name));
+
+						spi_index++;
+					}
+				}
+			}
+		}
+	}
+
+	return status;
+}
+
+
+static int sunix_uart_channel_table_init(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_uart_channel *uart_chl = NULL;
+	int status = 0;
+	int i;
+	int j;
+	int n;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb == NULL)
+		{
+			status = -ENXIO;
+			printk("SUNIX: Board table pointer error !\n");
+			return status;
+		}
+
+		if ((sb->board_enum > 0) && (sb->uart_amount > 0))
+		{
+			n = sb->uart_start_index;
+
+			uart_chl = &sunix_sdc_uart_table[n];
+
+			if (uart_chl == NULL)
+			{
+				status = -ENXIO;
+				printk("SUNIX: UART port table pointer error !\n");
+				return status;
+			}
+
+			for (j = 0; j < sb->uart_amount; j++, n++, uart_chl++)
+			{
+				uart_chl->port.board_enum	= sb->board_enum;
+				uart_chl->port.bus_number	= sb->bus_number;
+				uart_chl->port.dev_number	= sb->dev_number;
+				uart_chl->port.baud_base = 921600;
+
+				uart_chl->port.irq = sb->irq;
+				uart_chl->port.line = n;
+				uart_chl->port.uartclk = uart_chl->port.baud_base * 16;
+				uart_chl->port.iotype = SNX_UPIO_PORT;
+				uart_chl->port.flags = ASYNC_SHARE_IRQ;
+				uart_chl->port.ldisc_stop_rx = 0;
+
+				spin_lock_init(&uart_chl->port.lock);
+
+				uart_chl->port.type = PORT_SER_16750;
+				uart_chl->port.fifosize = uart_chl->port.cib_info.uart_rx_fifo_size - 8;
+				uart_chl->port.rx_trigger = uart_chl->port.cib_info.uart_rx_fifo_size / 2;
+
+				uart_chl->port.setserial_flag = SNX_SER_BAUD_NOTSETSER;
+			}
+
+			sb->uart_isr = sunix_ser_interrupt;
+		}
+		else
+		{
+			sb->uart_isr = NULL;
+		}
+	}
+
+    return status;
+}
+
+
+static int sunix_dio_channel_table_init(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int status = 0;
+	int i;
+	int j;
+	int n;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+		if ((sb->board_enum > 0) && (sb->dio_amount > 0))
+		{
+			n = sb->dio_start_index;
+
+			dio_chl = &sunix_sdc_dio_table[n];
+			for (j = 0; j < sb->dio_amount; j++, n++, dio_chl++)
+			{
+				dio_chl->info.bus_number	= sb->bus_number;
+				dio_chl->info.dev_number	= sb->dev_number;
+				dio_chl->info.irq = sb->irq;
+				dio_chl->info.line = n;
+
+				spin_lock_init(&dio_chl->packLock);
+				SxxListInit(&dio_chl->packList);
+				init_waitqueue_head(&dio_chl->readWQ);
+				sema_init(&dio_chl->sem, 1);
+
+				dio_chl->isOpened = false;
+
+				dio_chl->incomeBuff = NULL;
+				dio_chl->outcomeBuff = NULL;
+				dio_chl->translateBuff = NULL;
+
+				do
+				{
+					dio_chl->incomeBuff = (unsigned char *)kmalloc(SUNIX_SDC_DIO_BUFF, GFP_KERNEL);
+					if (dio_chl->incomeBuff == NULL)
+					{
+						status = -ENOMEM;
+						break;
+					}
+					memset(dio_chl->incomeBuff, 0, SUNIX_SDC_DIO_BUFF);
+
+					dio_chl->outcomeBuff = (unsigned char *)kmalloc(SUNIX_SDC_DIO_BUFF, GFP_KERNEL);
+					if (dio_chl->outcomeBuff == NULL)
+					{
+						status = -ENOMEM;
+						break;
+					}
+					memset(dio_chl->outcomeBuff, 0, SUNIX_SDC_DIO_BUFF);
+
+					dio_chl->translateBuff = (unsigned char *)kmalloc(SUNIX_SDC_DIO_BUFF, GFP_KERNEL);
+					if (dio_chl->translateBuff == NULL)
+					{
+						status = -ENOMEM;
+						break;
+					}
+					memset(dio_chl->translateBuff, 0, SUNIX_SDC_DIO_BUFF);
+
+				} while (false);
+
+				if (status != 0)
+				{
+					if (dio_chl->incomeBuff != NULL)
+					{
+						kfree(dio_chl->incomeBuff);
+						dio_chl->incomeBuff = NULL;
+					}
+
+					if (dio_chl->outcomeBuff != NULL)
+					{
+						kfree(dio_chl->outcomeBuff);
+						dio_chl->outcomeBuff = NULL;
+					}
+
+					if (dio_chl->translateBuff != NULL)
+					{
+						kfree(dio_chl->translateBuff);
+						dio_chl->translateBuff = NULL;
+					}
+					break;
+				}
+			}
+
+			sb->dio_isr = sunix_dio_interrupt;
+		}
+		else
+		{
+			sb->dio_isr = NULL;
+		}
+
+		if (status != 0)
+		{
+			break;
+		}
+	}
+
+    return status;
+}
+
+
+static void sunix_dio_channel_table_deinit(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int i;
+	int j;
+	int n;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+		if ((sb->board_enum > 0) && (sb->dio_amount > 0))
+		{
+			n = sb->dio_start_index;
+
+			dio_chl = &sunix_sdc_dio_table[n];
+			for (j = 0; j < sb->dio_amount; j++, n++, dio_chl++)
+			{
+				if (dio_chl->incomeBuff != NULL)
+				{
+					kfree(dio_chl->incomeBuff);
+					dio_chl->incomeBuff = NULL;
+				}
+
+				if (dio_chl->outcomeBuff != NULL)
+				{
+					kfree(dio_chl->outcomeBuff);
+					dio_chl->outcomeBuff = NULL;
+				}
+
+				if (dio_chl->translateBuff != NULL)
+				{
+					kfree(dio_chl->translateBuff);
+					dio_chl->translateBuff = NULL;
+				}
+			}
+		}
+	}
+}
+
+
+static int sunix_spi_channel_table_init(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+	int i;
+	int j;
+	int n;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+		if ((sb->board_enum > 0) && (sb->spi_amount > 0))
+		{
+			n = sb->spi_start_index;
+
+			spi_chl = &sunix_sdc_spi_table[n];
+			for (j = 0; j < sb->spi_amount; j++, n++, spi_chl++)
+			{
+				spi_chl->info.bus_number	= sb->bus_number;
+				spi_chl->info.dev_number	= sb->dev_number;
+				spi_chl->info.irq = sb->irq;
+				spi_chl->info.line = n;
+
+				spin_lock_init(&spi_chl->packLock);
+				SxxListInit(&spi_chl->packList);
+				init_waitqueue_head(&spi_chl->readWQ);
+				sema_init(&spi_chl->sem, 1);
+
+				spi_chl->isOpened = false;
+
+				spi_chl->incomeBuff = NULL;
+				spi_chl->outcomeBuff = NULL;
+				spi_chl->translateBuff = NULL;
+
+				do
+				{
+					spi_chl->incomeBuff = (unsigned char *)kmalloc(SUNIX_SDC_SPI_BUFF, GFP_KERNEL);
+					if (spi_chl->incomeBuff == NULL)
+					{
+						status = -ENOMEM;
+						break;
+					}
+					memset(spi_chl->incomeBuff, 0, SUNIX_SDC_SPI_BUFF);
+
+					spi_chl->outcomeBuff = (unsigned char *)kmalloc(SUNIX_SDC_SPI_BUFF, GFP_KERNEL);
+					if (spi_chl->outcomeBuff == NULL)
+					{
+						status = -ENOMEM;
+						break;
+					}
+					memset(spi_chl->outcomeBuff, 0, SUNIX_SDC_SPI_BUFF);
+
+					spi_chl->translateBuff = (unsigned char *)kmalloc(SUNIX_SDC_SPI_BUFF, GFP_KERNEL);
+					if (spi_chl->translateBuff == NULL)
+					{
+						status = -ENOMEM;
+						break;
+					}
+					memset(spi_chl->translateBuff, 0, SUNIX_SDC_SPI_BUFF);
+
+				} while (false);
+
+				if (status != 0)
+				{
+					if (spi_chl->incomeBuff != NULL)
+					{
+						kfree(spi_chl->incomeBuff);
+						spi_chl->incomeBuff = NULL;
+					}
+
+					if (spi_chl->outcomeBuff != NULL)
+					{
+						kfree(spi_chl->outcomeBuff);
+						spi_chl->outcomeBuff = NULL;
+					}
+
+					if (spi_chl->translateBuff != NULL)
+					{
+						kfree(spi_chl->translateBuff);
+						spi_chl->translateBuff = NULL;
+					}
+					break;
+				}
+			}
+
+			sb->spi_isr = sunix_spi_interrupt;
+		}
+		else
+		{
+			sb->spi_isr = NULL;
+		}
+
+		if (status != 0)
+		{
+			break;
+		}
+	}
+
+    return status;
+}
+
+
+static void sunix_spi_channel_table_deinit(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int i;
+	int j;
+	int n;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+		if ((sb->board_enum > 0) && (sb->spi_amount > 0))
+		{
+			n = sb->spi_start_index;
+
+			spi_chl = &sunix_sdc_spi_table[n];
+			for (j = 0; j < sb->spi_amount; j++, n++, spi_chl++)
+			{
+				if (spi_chl->incomeBuff != NULL)
+				{
+					kfree(spi_chl->incomeBuff);
+					spi_chl->incomeBuff = NULL;
+				}
+
+				if (spi_chl->outcomeBuff != NULL)
+				{
+					kfree(spi_chl->outcomeBuff);
+					spi_chl->outcomeBuff = NULL;
+				}
+
+				if (spi_chl->translateBuff != NULL)
+				{
+					kfree(spi_chl->translateBuff);
+					spi_chl->translateBuff = NULL;
+				}
+			}
+		}
+	}
+}
+
+
+int sunix_register_irq(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	int status = 0;
+	int i;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb == NULL)
+		{
+			status = -ENXIO;
+			printk("SUNIX: Board table pointer error !\n");
+			return status;
+		}
+
+		if (sb->board_enum > 0)
+		{
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 18))
+			status = request_irq(sb->irq, sunix_interrupt, IRQF_SHARED, "sunix_sdc", sb);
+#else
+			status = request_irq(sb->irq, sunix_interrupt, SA_SHIRQ, "sunix_sdc", sb);
+#endif
+			if (status)
+			{
+				printk("SUNIX: %s board (bus_num:%d dev_num:%d), request\n", sb->model_name, sb->bus_number, sb->dev_number);
+				printk("       IRQ %d fail, IRQ %d may be conflit with another device.\n", sb->irq, sb->irq);
+				return status;
+			}
+		}
+	}
+
+	return status;
+}
+
+
+void sunix_release_irq(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	int i;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb->board_enum > 0)
+		{
+			free_irq(sb->irq, sb);
+		}
+	}
+}
+
+
+void sunix_release_iomap(void)
+{
+	struct sunix_sdc_board *sb = NULL;
+	int i;
+
+
+	for (i = 0; i < SUNIX_SDC_BOARD_MAX; i++)
+	{
+		sb = &sunix_sdc_board_table[i];
+
+		if (sb->board_enum > 0)
+		{
+			if (sb->bar0_membase != NULL)
+			{
+				iounmap(sb->bar0_membase);
+				sb->bar0_membase = NULL;
+			}
+
+			if (sb->bar2_membase != NULL)
+			{
+				iounmap(sb->bar2_membase);
+				sb->bar2_membase = NULL;
+			}
+		}
+	}
+}
+
+
+static struct pci_driver snx_pci_driver =
+{
+	.name			= "sunix_sdc",
+	.probe			= snx_pci_probe_one,
+	.suspend		= snx_suspend_one,
+	.resume			= snx_resume_one,
+	.id_table		= sunix_pci_board_id,
+};
+
+
+static int __init sunix_sdc_init(void)
+{
+	int status = 0;
+
+
+	sunix_sdc_board_amount = 0;
+	sunix_sdc_uart_amount = 0;
+	sunix_sdc_dio_amount = 0;
+	sunix_sdc_spi_amount = 0;
+
+
+	sunix_sdc_dio_pack_cache = kmem_cache_create("sunix_sdc_dio", sizeof(DIO_PACKAGE), 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (sunix_sdc_dio_pack_cache == NULL)
+		goto step1_fail;
+
+	sunix_sdc_spi_pack_cache = kmem_cache_create("sunix_sdc_spi", sizeof(DIO_PACKAGE), 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (sunix_sdc_spi_pack_cache == NULL)
+		goto step2_fail;
+
+	status = pci_register_driver(&snx_pci_driver);
+	if (status != 0)
+		goto step3_fail;
+
+	status = sunix_pci_board_probe();
+	if (status != 0)	
+		goto step4_fail;
+
+	status = sunix_get_pci_board_conf();
+	if (status != 0)
+		goto step5_fail;
+
+	status = sunix_assign_resource();
+	if (status != 0)
+		goto step5_fail;
+
+	status = sunix_uart_channel_table_init();
+	if (status != 0)
+		goto step5_fail;
+
+	status = sunix_dio_channel_table_init();
+	if (status != 0)
+		goto step5_fail;
+
+	status = sunix_spi_channel_table_init();
+	if (status != 0)
+		goto step6_fail;
+
+	status = sunix_register_irq();
+	if (status != 0)
+		goto step7_fail;
+
+	status = sunix_ser_register_driver();
+	if (status != 0)
+		goto step8_fail;
+
+	status = sunix_ser_register_ports();
+	if (status != 0)
+		goto step9_fail;
+
+	status = sunix_dio_register_channel();
+	if (status != 0)
+		goto step10_fail;
+
+	status = sunix_spi_register_channel();
+	if (status != 0)
+		goto step11_fail;
+
+
+	return status;
+
+
+step11_fail:
+	sunix_dio_unregister_channel();
+
+step10_fail:
+	sunix_ser_unregister_ports();
+
+step9_fail:
+	sunix_ser_unregister_driver();
+
+step8_fail:
+	sunix_release_irq();
+
+step7_fail:
+	sunix_spi_channel_table_deinit();
+
+step6_fail:
+	sunix_dio_channel_table_deinit();
+
+step5_fail:
+	sunix_release_iomap();
+
+step4_fail:
+	pci_unregister_driver(&snx_pci_driver);
+
+step3_fail:
+	kmem_cache_destroy(sunix_sdc_spi_pack_cache);
+
+step2_fail:
+	kmem_cache_destroy(sunix_sdc_dio_pack_cache);
+
+step1_fail:
+
+	return status;
+}
+
+
+static void __exit sunix_sdc_exit(void)
+{
+	sunix_spi_unregister_channel();
+
+	sunix_dio_unregister_channel();
+
+	sunix_ser_unregister_ports();
+
+	sunix_ser_unregister_driver();
+
+	sunix_release_irq();
+
+	sunix_spi_channel_table_deinit();
+
+	sunix_dio_channel_table_deinit();
+
+	sunix_release_iomap();
+
+	pci_unregister_driver(&snx_pci_driver);
+
+	kmem_cache_destroy(sunix_sdc_spi_pack_cache);
+
+	kmem_cache_destroy(sunix_sdc_dio_pack_cache);
+}
+
+
+module_init(sunix_sdc_init);
+module_exit(sunix_sdc_exit);
+
+
+MODULE_AUTHOR("SUNIX Co., Ltd.<info@sunix.com.tw>");
+MODULE_DESCRIPTION("SUNIX PCI(e) expansion board bus driver");
+MODULE_LICENSE("GPL");
+
+
diff --git a/drivers/mfd/dio.c b/drivers/mfd/dio.c
new file mode 100644
index 000000000000..216280194d1b
--- /dev/null
+++ b/drivers/mfd/dio.c
@@ -0,0 +1,529 @@
+
+
+#include "sdc_include.h"
+
+
+static int sunix_dio_open(struct inode *inode, struct file *file)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int status = 0;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_DIO_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		dio_chl = &sunix_sdc_dio_table[line];
+		if (dio_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (dio_chl->isOpened == true)
+		{
+			status = -EBUSY;
+			break;
+		}
+
+
+		dio_chl->InputInvertEnableReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 2);
+		dio_chl->InputLatchRegPositiveEdgeR = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 3);
+		dio_chl->InputLatchRegNegativeEdgeR = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 4);
+		dio_chl->InputCounterIncrementCtrlRegPositiveEdge = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 6);
+		dio_chl->InputCounterIncrementCtrlRegNegativeEdge = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 7);
+		dio_chl->InputRisingEventCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 8);
+		dio_chl->InputFallingEventCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 9);
+		dio_chl->DirectionCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 12);
+		dio_chl->OutputInitialValueReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 13);
+
+		dio_chl->readDataReady = 0;
+		dio_chl->isOpened = true;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		try_module_get(THIS_MODULE);
+#else
+		MOD_INC_USE_COUNT;
+#endif
+
+	} while (false);
+
+	return status;
+}
+
+
+static int sunix_dio_release(struct inode *inode, struct file *file)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int status = 0;
+	DLIST * pListHead = NULL;
+	DLIST * e = NULL;
+	unsigned long Flags;
+	PDIO_PACKAGE pPack = NULL;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_DIO_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		dio_chl = &sunix_sdc_dio_table[line];
+		if (dio_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (dio_chl->isOpened == false)
+		{
+			status = -ENODEV;
+			break;
+		}
+
+		pListHead = &dio_chl->packList;
+		spin_lock_irqsave(&dio_chl->packLock, Flags);
+		while (!SxxListEmpty(pListHead))
+		{
+			e = SxxListGetNext(pListHead);
+			pPack = SUNIX_SDC_DIO_PACK_PTR(e);
+			if (pPack != NULL)
+			{
+				printk("SUNIX: DIO FREE pack, line:%d, pack:x%p, DataPtrx%p\n", dio_chl->info.line, pPack, pPack->DataPtr);
+				SxxListRemoveEntry(e);
+				if (pPack->DataPtr != NULL)
+				{
+					kfree(pPack->DataPtr);
+					pPack->DataPtr = NULL;
+				}
+				kmem_cache_free(sunix_sdc_dio_pack_cache, pPack);
+				pPack = NULL;
+			}
+		}
+		spin_unlock_irqrestore(&dio_chl->packLock, Flags);
+
+		dio_chl->isOpened = false;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		module_put(THIS_MODULE);
+#else
+		MOD_DEC_USE_COUNT;
+#endif
+
+	} while (false);
+
+	return status;
+}
+
+
+static long sunix_dio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int status = 0;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_DIO_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		dio_chl = &sunix_sdc_dio_table[line];
+		if (dio_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (dio_chl->isOpened == false)
+		{
+			status = -ENODEV;
+			break;
+		}
+
+	} while (false);
+
+	return status;
+}
+
+
+static ssize_t sunix_dio_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int status = 0;
+	unsigned int outcomeLength = 0;
+
+
+	if (line > SUNIX_SDC_DIO_MAX)
+	{
+		return -ENODEV;
+	}
+	dio_chl = &sunix_sdc_dio_table[line];
+	if (dio_chl->info.memsize == 0)
+	{
+		return -ENODEV;
+	}
+	if (dio_chl->isOpened == false)
+	{
+		return -ENODEV;
+	}
+
+	if (count < sizeof(DIO_HEADER))
+	{
+		return -ENOMEM;
+	}
+
+
+	if (down_interruptible(&dio_chl->sem))
+	{
+		return -ERESTARTSYS;
+	}
+
+	if (dio_chl->readDataReady == 0)
+	{
+		up(&dio_chl->sem);
+
+		if ((file->f_flags & O_NONBLOCK))
+		{
+			return -EAGAIN;
+		}
+
+		wait_event_interruptible(dio_chl->readWQ, dio_chl->readDataReady == 1);
+
+		if (down_interruptible(&dio_chl->sem))
+		{
+			return -ERESTARTSYS;
+		}
+	}
+
+
+	do
+	{
+		status = sunix_dio_handle_outcome(dio_chl, count, &outcomeLength);
+		if (status != 0)
+		{
+			break;
+		}
+		if (count < outcomeLength)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		if (outcomeLength <= 0)
+		{
+			status = 0;
+			break;
+		}
+
+		if (copy_to_user((void *)buf, dio_chl->outcomeBuff, outcomeLength))
+		{
+			status = -EFAULT;
+			break;
+		}
+
+		status = outcomeLength;
+
+	} while (false);
+
+
+	dio_chl->readDataReady = 0;
+	up(&dio_chl->sem);
+
+	return status;
+}
+
+
+static ssize_t sunix_dio_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	int status = 0;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_DIO_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		dio_chl = &sunix_sdc_dio_table[line];
+		if (dio_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (dio_chl->isOpened == false)
+		{
+			status = -ENODEV;
+			break;
+		}
+
+		if (count < sizeof(DIO_HEADER))
+		{
+			status = -EFAULT;
+			break;
+		}
+
+		if (count > (sizeof(DIO_HEADER) + DIO_MAX_DATA_LENGTH))
+		{
+			status = -ENOMEM;
+			break;
+		}
+
+		if (copy_from_user(dio_chl->incomeBuff, (void *)buf, count))
+		{
+			status = -EFAULT;
+			break;
+		}
+
+		status = sunix_dio_handle_income(dio_chl, count);
+		if (status == 0)
+		{
+			status = count;
+		}
+
+	} while (false);
+
+	return status;
+}
+
+
+unsigned int sunix_dio_poll(struct file *file, poll_table *wait)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+	unsigned int mask = POLLOUT | POLLWRNORM;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_DIO_MAX)
+		{
+			mask = -ENODEV;
+			break;
+		}
+		dio_chl = &sunix_sdc_dio_table[line];
+		if (dio_chl->info.memsize == 0)
+		{
+			mask = -ENODEV;
+			break;
+		}
+		if (dio_chl->isOpened == false)
+		{
+			mask = -ENODEV;
+			break;
+		}
+
+
+		down(&dio_chl->sem);
+
+		poll_wait(file, &dio_chl->readWQ, wait);
+
+		if (dio_chl->readDataReady == 1)
+		{
+			mask |= (POLLIN | POLLRDNORM);
+		}
+
+		up(&dio_chl->sem);
+
+	} while (false);
+
+	return mask;
+}
+
+
+static int sunix_dio_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	add_uevent_var(env, "DEVMODE=%#o", 0666);
+	return 0;
+}
+
+
+static const struct file_operations sunix_sdc_dio_fops =
+{
+	.owner				= THIS_MODULE,
+	.open				= sunix_dio_open,
+	.release			= sunix_dio_release,
+	.unlocked_ioctl		= sunix_dio_ioctl,
+	.read				= sunix_dio_read,
+	.write 				= sunix_dio_write,
+	.poll				= sunix_dio_poll
+};
+
+
+static int sunix_sdc_dio_dev_major = 0;
+static struct class *sunix_sdc_dio_dev_class = NULL;
+
+
+int sunix_dio_register_channel(void)
+{
+	int err, i;
+	dev_t dev;
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+
+
+	err = alloc_chrdev_region(&dev, 0, sunix_sdc_dio_amount, "sunix_sdc_dio");
+	if (err != 0)
+	{
+		return err;
+	}
+
+	sunix_sdc_dio_dev_major = MAJOR(dev);
+
+	sunix_sdc_dio_dev_class = class_create(THIS_MODULE, "sunix_sdc_dio");
+	sunix_sdc_dio_dev_class->dev_uevent = sunix_dio_uevent;
+
+	for (i = 0; i < sunix_sdc_dio_amount; i++)
+	{
+		dio_chl = &sunix_sdc_dio_table[i];
+		if ((dio_chl != NULL) && (dio_chl->info.membase != NULL))
+		{
+			request_mem_region(dio_chl->info.phy2_base_start + dio_chl->info.memoffset, dio_chl->info.memsize, "sunix_sdc_dio");
+
+			cdev_init(&dio_chl->cdev, &sunix_sdc_dio_fops);
+			dio_chl->cdev.owner = THIS_MODULE;
+
+			cdev_add(&dio_chl->cdev, MKDEV(sunix_sdc_dio_dev_major, i), 1);
+
+			device_create(sunix_sdc_dio_dev_class, NULL, MKDEV(sunix_sdc_dio_dev_major, i), NULL, "SDCDIO%d", i);
+		}
+	}
+
+	return 0;
+}
+
+
+void sunix_dio_unregister_channel(void)
+{
+	int i;
+	struct sunix_sdc_dio_channel *dio_chl = NULL;
+
+
+	for (i = 0; i < sunix_sdc_dio_amount; i++)
+	{
+		dio_chl = &sunix_sdc_dio_table[i];
+		if ((dio_chl != NULL) && (dio_chl->info.membase != NULL))
+		{
+			device_destroy(sunix_sdc_dio_dev_class, MKDEV(sunix_sdc_dio_dev_major, i));
+
+			release_mem_region(dio_chl->info.phy2_base_start + dio_chl->info.memoffset, dio_chl->info.memsize);
+		}
+	}
+
+	class_unregister(sunix_sdc_dio_dev_class);
+	class_destroy(sunix_sdc_dio_dev_class);
+
+	unregister_chrdev_region(MKDEV(sunix_sdc_dio_dev_major, 0), MINORMASK);
+}
+
+
+int sunix_dio_interrupt(struct sunix_sdc_dio_channel *dio_chl, unsigned int event_header)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	unsigned int InputValue = 0;
+	unsigned int BankInputValue = 0;
+	unsigned int BankInputDelta = 0;
+	int i = 0;
+	unsigned char TxBuff[256];
+	unsigned int TxLength = 0;
+	PDIO_HEADER pTxHeader = (PDIO_HEADER)TxBuff;
+	PDIO_PACKAGE pPack = NULL;
+	bool bCreatePackSuccess = false;
+	unsigned long Flags;
+
+
+	InputValue = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 0);
+
+	for (i = 0; i < cib_info->dio_number_of_banks; i++)
+	{
+		if ((cib_info->dio_bank_cap[i].io_mask & event_header) && (cib_info->dio_bank_cap[i].support_inputs == 0x01))
+		{
+			BankInputValue = ((InputValue & cib_info->dio_bank_cap[i].io_mask) >> cib_info->dio_bank_cap[i].io_shift_bits);
+			BankInputDelta = ((event_header & cib_info->dio_bank_cap[i].io_mask) >> cib_info->dio_bank_cap[i].io_shift_bits);
+
+
+			memset(TxBuff, 0, sizeof(TxBuff));
+			TxLength = 0;
+
+			pTxHeader->Version = 0x01;
+			pTxHeader->CmdResponseEventData = SDCDIO_EVENT;
+			pTxHeader->ResponseStatus = SDCDIO_STATUS_SUCCESS;
+			pTxHeader->Length = 9;
+			TxLength = sizeof(DIO_HEADER);
+
+			TxBuff[TxLength++] = i;
+
+			TxBuff[TxLength++] = (unsigned char)((BankInputDelta & 0xff000000) >> 24);
+			TxBuff[TxLength++] = (unsigned char)((BankInputDelta & 0x00ff0000) >> 16);
+			TxBuff[TxLength++] = (unsigned char)((BankInputDelta & 0x0000ff00) >> 8);
+			TxBuff[TxLength++] = (unsigned char)((BankInputDelta & 0x000000ff));
+
+			TxBuff[TxLength++] = (unsigned char)((BankInputValue & 0xff000000) >> 24);
+			TxBuff[TxLength++] = (unsigned char)((BankInputValue & 0x00ff0000) >> 16);
+			TxBuff[TxLength++] = (unsigned char)((BankInputValue & 0x0000ff00) >> 8);
+			TxBuff[TxLength++] = (unsigned char)((BankInputValue & 0x000000ff));
+
+
+			do
+			{
+				pPack = NULL;
+				bCreatePackSuccess = false;
+
+				pPack = kmem_cache_alloc(sunix_sdc_dio_pack_cache, GFP_ATOMIC);
+				if (pPack == NULL)
+				{
+					break;
+				}
+				memset(pPack, 0, sizeof(DIO_PACKAGE));
+
+				pPack->DataPtr = (unsigned char *)kmalloc(DIO_MAX_DATA_LENGTH, GFP_KERNEL);
+				if (pPack->DataPtr == NULL)
+				{
+					break;
+				}
+				memset(pPack->DataPtr, 0, DIO_MAX_DATA_LENGTH);
+
+				SxxListInit(&pPack->Entry);
+				memcpy(&pPack->Header, pTxHeader, sizeof(DIO_HEADER));
+				memcpy(pPack->DataPtr, TxBuff + sizeof(DIO_HEADER), pTxHeader->Length);
+
+				spin_lock_irqsave(&dio_chl->packLock, Flags);
+				//printk("SUNIX: DIO ALOC pack, line:%d, pack:x%p, DataPtrx%p\n", dio_chl->info.line, pPack, pPack->DataPtr);
+				SxxListInsertTail(&dio_chl->packList, &pPack->Entry);
+
+				dio_chl->readDataReady = 1;
+				wake_up_interruptible(&dio_chl->readWQ);
+				spin_unlock_irqrestore(&dio_chl->packLock, Flags);
+
+				bCreatePackSuccess = true;
+
+			} while (false);
+
+			if (bCreatePackSuccess == false)
+			{
+				if (pPack != NULL)
+				{
+					if (pPack->DataPtr != NULL)
+					{
+						kfree(pPack->DataPtr);
+						pPack->DataPtr = NULL;
+					}
+
+					kmem_cache_free(sunix_sdc_dio_pack_cache, pPack);
+					pPack = NULL;
+				}
+			}
+		}
+	}
+
+    return 0;
+}
+
+
diff --git a/drivers/mfd/dio_pack.c b/drivers/mfd/dio_pack.c
new file mode 100644
index 000000000000..29e623918a45
--- /dev/null
+++ b/drivers/mfd/dio_pack.c
@@ -0,0 +1,3126 @@
+
+
+#include "sdc_include.h"
+
+
+static void get_info(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int Address = 0;
+	int i = 0;
+	unsigned int BankDirection = 0;
+
+
+	do
+	{
+		Address = dio_chl->info.phy2_base_start + dio_chl->info.memoffset;
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?(28 + (cib_info->dio_number_of_banks * 18)):0;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		memcpy(&TrBuff[TrLength], dio_chl->info.model_name, 16);
+		TrLength += 16;
+		TrBuff[TrLength++] = dio_chl->info.bus_number;
+		TrBuff[TrLength++] = dio_chl->info.dev_number;
+		TrBuff[TrLength++] = dio_chl->info.line;
+		TrBuff[TrLength++] = (unsigned char)((Address & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((Address & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((Address & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((Address & 0x000000ff));
+		TrBuff[TrLength++] = (unsigned char)(dio_chl->info.irq);
+
+		TrBuff[TrLength++] = cib_info->version;
+		TrBuff[TrLength++] = cib_info->dio_number_of_banks;
+		TrBuff[TrLength++] = cib_info->dio_shares_same_direction_ctrl_cap;
+		TrBuff[TrLength++] = cib_info->dio_writing_setting_to_flash_cap;
+
+		for (i = 0; i < cib_info->dio_number_of_banks; i++)
+		{
+			BankDirection = (dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[i].io_mask) >>cib_info->dio_bank_cap[i].io_shift_bits;
+
+			TrBuff[TrLength++] = i;
+			TrBuff[TrLength++] = cib_info->dio_bank_cap[i].number_of_io;
+			TrBuff[TrLength++] = cib_info->dio_bank_cap[i].support_inputs;
+			TrBuff[TrLength++] = cib_info->dio_bank_cap[i].support_outputs;
+			TrBuff[TrLength++] = cib_info->dio_bank_cap[i].rising_edge_trigger_cap;
+			TrBuff[TrLength++] = cib_info->dio_bank_cap[i].falling_edge_trigger_cap;
+
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_mask & 0xff000000) >> 24);
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_mask & 0x00ff0000) >> 16);
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_mask & 0x0000ff00) >> 8);
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_mask & 0x000000ff));
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_shift_bits & 0xff000000) >> 24);
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_shift_bits & 0x00ff0000) >> 16);
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_shift_bits & 0x0000ff00) >> 8);
+			TrBuff[TrLength++] = (unsigned char)((cib_info->dio_bank_cap[i].io_shift_bits & 0x000000ff));
+			TrBuff[TrLength++] = (unsigned char)((BankDirection & 0xff000000) >> 24);
+			TrBuff[TrLength++] = (unsigned char)((BankDirection & 0x00ff0000) >> 16);
+			TrBuff[TrLength++] = (unsigned char)((BankDirection & 0x0000ff00) >> 8);
+			TrBuff[TrLength++] = (unsigned char)((BankDirection & 0x000000ff));
+		}
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_state(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankState = 0;
+	unsigned int InputReg = 0;
+	unsigned int OutputReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			InputReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 0);
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL (input), 1, InputReg:x%08x\n", dio_chl->info.line, InputReg);
+			InputReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL (input), 2, InputReg:x%08x\n", dio_chl->info.line, InputReg);
+			InputReg &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL (input), 3, InputReg:x%08x\n", dio_chl->info.line, InputReg);
+
+			OutputReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 11);
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL (output), 4, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+			OutputReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL (output), 5, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+			OutputReg &= dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL (output), 6, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+
+			BankState = (InputReg | OutputReg) & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL, 7, BankState:x%08x\n", dio_chl->info.line, BankState);
+			BankState = BankState >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank state, INDIVIDUAL, 8, BankState:x%08x\n", dio_chl->info.line, BankState);
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 0);
+			//printk("SUNIX: DIO (%d), get bank state, WHOLE (input), 1, InputReg:x%08x\n", dio_chl->info.line, InputReg);
+			BankState = InputReg & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank state, WHOLE (input), 2, BankState:x%08x\n", dio_chl->info.line, BankState);
+			BankState = BankState >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank state, WHOLE (input), 3, BankState:x%08x\n", dio_chl->info.line, BankState);
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			OutputReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 11);
+			//printk("SUNIX: DIO (%d), get bank state, WHOLE (output), 1, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+			BankState = OutputReg & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank state, WHOLE (output), 2, BankState:x%08x\n", dio_chl->info.line, BankState);
+			BankState = BankState >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank state, WHOLE (output), 3, BankState:x%08x\n", dio_chl->info.line, BankState);
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankState & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankState & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankState & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankState & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_delta_state(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankDeltaState = 0;
+	unsigned int InputDeltaReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputDeltaReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 1);
+			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 1, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);
+			InputDeltaReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 2, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);
+			InputDeltaReg &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 3, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);
+			BankDeltaState = InputDeltaReg >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input delta state, INDIVIDUAL, 4, BankDeltaState:x%08x\n", dio_chl->info.line, BankDeltaState);
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputDeltaReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 1);
+			//printk("SUNIX: DIO (%d), get bank input delta state, WHOLE (input), 1, InputDeltaReg:x%08x\n", dio_chl->info.line, InputDeltaReg);
+			BankDeltaState = InputDeltaReg & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input delta state, WHOLE (input), 2, BankDeltaState:x%08x\n", dio_chl->info.line, BankDeltaState);
+			BankDeltaState = BankDeltaState >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input delta state, WHOLE (input), 3, BankDeltaState:x%08x\n", dio_chl->info.line, BankDeltaState);
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankDeltaState & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankDeltaState & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankDeltaState & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankDeltaState & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_invert_enable(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputInvertEnable = 0;
+	unsigned int InputInvertEnableReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input inver enable, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputInvertEnableReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 2);
+			BankInputInvertEnable = InputInvertEnableReg;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, INDIVIDUAL, 1, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+			BankInputInvertEnable &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, INDIVIDUAL, 2, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+			BankInputInvertEnable &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, INDIVIDUAL, 3, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+			BankInputInvertEnable = BankInputInvertEnable >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, INDIVIDUAL, 4, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+
+			dio_chl->InputInvertEnableReg = InputInvertEnableReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputInvertEnableReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 2);
+			BankInputInvertEnable = InputInvertEnableReg;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, WHOLE (input), 1, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+			BankInputInvertEnable &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, WHOLE (input), 2, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+			BankInputInvertEnable = BankInputInvertEnable >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input inver enable, WHOLE (input), 3, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+
+			dio_chl->InputInvertEnableReg = InputInvertEnableReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputInvertEnable & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputInvertEnable & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputInvertEnable & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputInvertEnable & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_invert_enable(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputInvertEnable = 0;
+	unsigned int InputInvertEnableRegByBank = 0;
+	unsigned int InputInvertEnableReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputInvertEnable  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputInvertEnable |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputInvertEnable |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputInvertEnable |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input inver enable, BankIndex:x%02x, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankIndex, BankInputInvertEnable);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input inver enable, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			BankInputInvertEnable &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, INDIVIDUAL, 1, BankInputInvertEnable:x%08x\n", dio_chl->info.line, BankInputInvertEnable);
+			InputInvertEnableRegByBank = BankInputInvertEnable << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, INDIVIDUAL, 2, InputInvertEnableRegByBank:x%08x\n", dio_chl->info.line, InputInvertEnableRegByBank);
+			InputInvertEnableRegByBank &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, INDIVIDUAL, 3, InputInvertEnableRegByBank:x%08x\n", dio_chl->info.line, InputInvertEnableRegByBank);
+			InputInvertEnableReg = dio_chl->InputInvertEnableReg & ~cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, INDIVIDUAL, 4, InputInvertEnableReg:x%08x\n", dio_chl->info.line, InputInvertEnableReg);
+			InputInvertEnableReg |= InputInvertEnableRegByBank;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, INDIVIDUAL, 5, InputInvertEnableReg:x%08x\n", dio_chl->info.line, InputInvertEnableReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 2, InputInvertEnableReg);
+			dio_chl->InputInvertEnableReg = InputInvertEnableReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputInvertEnableRegByBank = BankInputInvertEnable << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, WHOLE (input), 1, InputInvertEnableRegByBank:x%08x\n", dio_chl->info.line, InputInvertEnableRegByBank);
+			InputInvertEnableRegByBank &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, WHOLE (input), 2, InputInvertEnableRegByBank:x%08x\n", dio_chl->info.line, InputInvertEnableRegByBank);
+			InputInvertEnableReg = dio_chl->InputInvertEnableReg & ~cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, WHOLE (input), 3, InputInvertEnableReg:x%08x\n", dio_chl->info.line, InputInvertEnableReg);
+			InputInvertEnableReg |= InputInvertEnableRegByBank;
+			//printk("SUNIX: DIO (%d), set bank input inver enable, WHOLE (input), 4, InputInvertEnableReg:x%08x\n", dio_chl->info.line, InputInvertEnableReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 2, InputInvertEnableReg);
+			dio_chl->InputInvertEnableReg = InputInvertEnableReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_latch_rising_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputLatch = 0;
+	unsigned int InputLatchRegPositiveEdgeR = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].rising_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input latch rising edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputLatchRegPositiveEdgeR = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 3);
+			BankInputLatch = InputLatchRegPositiveEdgeR;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, INDIVIDUAL, 1, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, INDIVIDUAL, 2, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, INDIVIDUAL, 3, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch = BankInputLatch >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, INDIVIDUAL, 4, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+
+			dio_chl->InputLatchRegPositiveEdgeR = InputLatchRegPositiveEdgeR;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputLatchRegPositiveEdgeR = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 3);
+			BankInputLatch = InputLatchRegPositiveEdgeR;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, WHOLE (input), 1, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, WHOLE (input), 2, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch = BankInputLatch >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input latch rising edge, WHOLE (input), 3, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+
+			dio_chl->InputLatchRegPositiveEdgeR = InputLatchRegPositiveEdgeR;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_latch_rising_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputLatch = 0;
+	unsigned int InputLatchRegPositiveEdgeW = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputLatch  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputLatch |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputLatch |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputLatch |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input latch rising edge, BankIndex:x%02x, BankInputLatch:x%08x\n", dio_chl->info.line, BankIndex, BankInputLatch);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].rising_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input latch rising edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputLatchRegPositiveEdgeW = BankInputLatch << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, INDIVIDUAL, 1, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+			InputLatchRegPositiveEdgeW &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, INDIVIDUAL, 2, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+			InputLatchRegPositiveEdgeW &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, INDIVIDUAL, 3, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+			InputLatchRegPositiveEdgeW |= (dio_chl->InputLatchRegPositiveEdgeW & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, INDIVIDUAL, 4, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 3, InputLatchRegPositiveEdgeW);
+			dio_chl->InputLatchRegPositiveEdgeW = InputLatchRegPositiveEdgeW;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputLatchRegPositiveEdgeW = BankInputLatch << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, WHOLE (input), 1, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+			InputLatchRegPositiveEdgeW &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, WHOLE (input), 2, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+			InputLatchRegPositiveEdgeW |= (dio_chl->InputLatchRegPositiveEdgeW & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input latch rising edge, WHOLE (input), 3, InputLatchRegPositiveEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegPositiveEdgeW);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 3, InputLatchRegPositiveEdgeW);
+			dio_chl->InputLatchRegPositiveEdgeW = InputLatchRegPositiveEdgeW;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_latch_falling_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputLatch = 0;
+	unsigned int InputLatchRegNegativeEdgeR = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].falling_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input latch falling edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputLatchRegNegativeEdgeR = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 4);
+			BankInputLatch = InputLatchRegNegativeEdgeR;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, INDIVIDUAL, 1, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, INDIVIDUAL, 2, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, INDIVIDUAL, 3, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch = BankInputLatch >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, INDIVIDUAL, 4, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+
+			dio_chl->InputLatchRegNegativeEdgeR = InputLatchRegNegativeEdgeR;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputLatchRegNegativeEdgeR = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 4);
+			BankInputLatch = InputLatchRegNegativeEdgeR;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, WHOLE (input), 1, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, WHOLE (input), 2, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+			BankInputLatch = BankInputLatch >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input latch falling edge, WHOLE (input), 3, BankInputLatch:x%08x\n", dio_chl->info.line, BankInputLatch);
+
+			dio_chl->InputLatchRegNegativeEdgeR = InputLatchRegNegativeEdgeR;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputLatch & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_latch_falling_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputLatch = 0;
+	unsigned int InputLatchRegNegativeEdgeW = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputLatch  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputLatch |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputLatch |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputLatch |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input latch falling edge, BankIndex:x%02x, BankInputLatch:x%08x\n", dio_chl->info.line, BankIndex, BankInputLatch);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].falling_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input latch falling edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputLatchRegNegativeEdgeW = BankInputLatch << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, INDIVIDUAL, 1, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+			InputLatchRegNegativeEdgeW &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, INDIVIDUAL, 2, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+			InputLatchRegNegativeEdgeW &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, INDIVIDUAL, 3, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+			InputLatchRegNegativeEdgeW |= (dio_chl->InputLatchRegNegativeEdgeW & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, INDIVIDUAL, 4, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 4, InputLatchRegNegativeEdgeW);
+			dio_chl->InputLatchRegNegativeEdgeW = InputLatchRegNegativeEdgeW;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputLatchRegNegativeEdgeW = BankInputLatch << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, WHOLE (input), 1, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+			InputLatchRegNegativeEdgeW &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, WHOLE (input), 2, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+			InputLatchRegNegativeEdgeW |= (dio_chl->InputLatchRegNegativeEdgeW & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input latch falling edge, WHOLE (input), 3, InputLatchRegNegativeEdgeW:x%08x\n", dio_chl->info.line, InputLatchRegNegativeEdgeW);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 4, InputLatchRegNegativeEdgeW);
+			dio_chl->InputLatchRegNegativeEdgeW = InputLatchRegNegativeEdgeW;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_counter_reset(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputCounterReset = 0;
+	unsigned int InputCounterResetReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputCounterReset  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputCounterReset |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputCounterReset |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputCounterReset |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input counter reset, BankIndex:x%02x, BankInputCounterReset:x%08x\n", dio_chl->info.line, BankIndex, BankInputCounterReset);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input counter reset, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputCounterResetReg = BankInputCounterReset << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input counter reset, INDIVIDUAL, 1, InputCounterResetReg:x%08x\n", dio_chl->info.line, InputCounterResetReg);
+			InputCounterResetReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input counter reset, INDIVIDUAL, 2, InputCounterResetReg:x%08x\n", dio_chl->info.line, InputCounterResetReg);
+			InputCounterResetReg &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input counter reset, INDIVIDUAL, 3, InputCounterResetReg:x%08x\n", dio_chl->info.line, InputCounterResetReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 5, InputCounterResetReg);
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputCounterResetReg = BankInputCounterReset << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input counter reset, WHOLE (input), 1, InputCounterResetReg:x%08x\n", dio_chl->info.line, InputCounterResetReg);
+			InputCounterResetReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input counter reset, WHOLE (input), 2, InputCounterResetReg:x%08x\n", dio_chl->info.line, InputCounterResetReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 5, InputCounterResetReg);
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_counter_increment_rising_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputCounterInc = 0;
+	unsigned int InputCounterIncrementCtrlRegPositiveEdge = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].rising_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputCounterIncrementCtrlRegPositiveEdge = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 6);
+			BankInputCounterInc = InputCounterIncrementCtrlRegPositiveEdge;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, INDIVIDUAL, 1, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, INDIVIDUAL, 2, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, INDIVIDUAL, 3, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc = BankInputCounterInc >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, INDIVIDUAL, 4, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+
+			dio_chl->InputCounterIncrementCtrlRegPositiveEdge = InputCounterIncrementCtrlRegPositiveEdge;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputCounterIncrementCtrlRegPositiveEdge = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 6);
+			BankInputCounterInc = InputCounterIncrementCtrlRegPositiveEdge;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, WHOLE (input), 1, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, WHOLE (input), 2, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc = BankInputCounterInc >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input counter increment rising edge, WHOLE (input), 3, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+
+			dio_chl->InputCounterIncrementCtrlRegPositiveEdge = InputCounterIncrementCtrlRegPositiveEdge;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_counter_increment_rising_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputCounterInc = 0;
+	unsigned int InputCounterIncrementCtrlRegPositiveEdge = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputCounterInc  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputCounterInc |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputCounterInc |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputCounterInc |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, BankIndex:x%02x, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankIndex, BankInputCounterInc);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].rising_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputCounterIncrementCtrlRegPositiveEdge = BankInputCounterInc << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, INDIVIDUAL, 1, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+			InputCounterIncrementCtrlRegPositiveEdge &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, INDIVIDUAL, 2, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+			InputCounterIncrementCtrlRegPositiveEdge &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, INDIVIDUAL, 3, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+			InputCounterIncrementCtrlRegPositiveEdge |= (dio_chl->InputCounterIncrementCtrlRegPositiveEdge & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, INDIVIDUAL, 4, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 6, InputCounterIncrementCtrlRegPositiveEdge);
+			dio_chl->InputCounterIncrementCtrlRegPositiveEdge = InputCounterIncrementCtrlRegPositiveEdge;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputCounterIncrementCtrlRegPositiveEdge = BankInputCounterInc << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, WHOLE (input), 1, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+			InputCounterIncrementCtrlRegPositiveEdge &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, WHOLE (input), 2, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+			InputCounterIncrementCtrlRegPositiveEdge |= (dio_chl->InputCounterIncrementCtrlRegPositiveEdge & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input counter increment rising edge, WHOLE (input), 3, InputCounterIncrementCtrlRegPositiveEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegPositiveEdge);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 6, InputCounterIncrementCtrlRegPositiveEdge);
+			dio_chl->InputCounterIncrementCtrlRegPositiveEdge = InputCounterIncrementCtrlRegPositiveEdge;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_counter_increment_falling_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputCounterInc = 0;
+	unsigned int InputCounterIncrementCtrlRegNegativeEdge = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].falling_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputCounterIncrementCtrlRegNegativeEdge = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 7);
+			BankInputCounterInc = InputCounterIncrementCtrlRegNegativeEdge;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, INDIVIDUAL, 1, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, INDIVIDUAL, 2, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, INDIVIDUAL, 3, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc = BankInputCounterInc >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, INDIVIDUAL, 4, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+
+			dio_chl->InputCounterIncrementCtrlRegNegativeEdge = InputCounterIncrementCtrlRegNegativeEdge;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputCounterIncrementCtrlRegNegativeEdge = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 7);
+			BankInputCounterInc = InputCounterIncrementCtrlRegNegativeEdge;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, WHOLE (input), 1, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, WHOLE (input), 2, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+			BankInputCounterInc = BankInputCounterInc >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input counter increment falling edge, WHOLE (input), 3, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankInputCounterInc);
+
+			dio_chl->InputCounterIncrementCtrlRegNegativeEdge = InputCounterIncrementCtrlRegNegativeEdge;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputCounterInc & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_counter_increment_falling_edge(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputCounterInc = 0;
+	unsigned int InputCounterIncrementCtrlRegNegativeEdge = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputCounterInc  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputCounterInc |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputCounterInc |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputCounterInc |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, BankIndex:x%02x, BankInputCounterInc:x%08x\n", dio_chl->info.line, BankIndex, BankInputCounterInc);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].falling_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputCounterIncrementCtrlRegNegativeEdge = BankInputCounterInc << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, INDIVIDUAL, 1, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+			InputCounterIncrementCtrlRegNegativeEdge &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, INDIVIDUAL, 2, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+			InputCounterIncrementCtrlRegNegativeEdge &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, INDIVIDUAL, 3, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+			InputCounterIncrementCtrlRegNegativeEdge |= (dio_chl->InputCounterIncrementCtrlRegNegativeEdge & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, INDIVIDUAL, 4, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 7, InputCounterIncrementCtrlRegNegativeEdge);
+			dio_chl->InputCounterIncrementCtrlRegNegativeEdge = InputCounterIncrementCtrlRegNegativeEdge;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputCounterIncrementCtrlRegNegativeEdge = BankInputCounterInc << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, WHOLE (input), 1, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+			InputCounterIncrementCtrlRegNegativeEdge &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, WHOLE (input), 2, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+			InputCounterIncrementCtrlRegNegativeEdge |= (dio_chl->InputCounterIncrementCtrlRegNegativeEdge & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input counter increment falling edge, WHOLE (input), 3, InputCounterIncrementCtrlRegNegativeEdge:x%08x\n", dio_chl->info.line, InputCounterIncrementCtrlRegNegativeEdge);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 7, InputCounterIncrementCtrlRegNegativeEdge);
+			dio_chl->InputCounterIncrementCtrlRegNegativeEdge = InputCounterIncrementCtrlRegNegativeEdge;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_rising_event_ctrl(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputEventCtrl = 0;
+	unsigned int InputRisingEventCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].rising_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input rising event ctrl, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputRisingEventCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 8);
+			BankInputEventCtrl = InputRisingEventCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, INDIVIDUAL, 1, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, INDIVIDUAL, 2, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, INDIVIDUAL, 3, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl = BankInputEventCtrl >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, INDIVIDUAL, 4, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+
+			dio_chl->InputRisingEventCtrlReg = InputRisingEventCtrlReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputRisingEventCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 8);
+			BankInputEventCtrl = InputRisingEventCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, WHOLE (input), 1, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, WHOLE (input), 2, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl = BankInputEventCtrl >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input rising event ctrl, WHOLE (input), 3, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+
+			dio_chl->InputRisingEventCtrlReg = InputRisingEventCtrlReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_rising_event_ctrl(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputEventCtrl = 0;
+	unsigned int InputRisingEventCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputEventCtrl  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputEventCtrl |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputEventCtrl |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputEventCtrl |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input rising event ctrl, BankIndex:x%02x, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankIndex, BankInputEventCtrl);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].rising_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input rising event ctrl, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputRisingEventCtrlReg = BankInputEventCtrl << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, INDIVIDUAL, 1, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+			InputRisingEventCtrlReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, INDIVIDUAL, 2, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+			InputRisingEventCtrlReg &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, INDIVIDUAL, 3, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+			InputRisingEventCtrlReg |= (dio_chl->InputRisingEventCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, INDIVIDUAL, 4, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 8, InputRisingEventCtrlReg);
+			dio_chl->InputRisingEventCtrlReg = InputRisingEventCtrlReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputRisingEventCtrlReg = BankInputEventCtrl << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, WHOLE (input), 1, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+			InputRisingEventCtrlReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, WHOLE (input), 2, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+			InputRisingEventCtrlReg |= (dio_chl->InputRisingEventCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input rising event ctrl, WHOLE (input), 3, InputRisingEventCtrlReg:x%08x\n", dio_chl->info.line, InputRisingEventCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 8, InputRisingEventCtrlReg);
+			dio_chl->InputRisingEventCtrlReg = InputRisingEventCtrlReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_falling_event_ctrl(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputEventCtrl = 0;
+	unsigned int InputFallingEventCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].falling_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input falling event ctrl, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputFallingEventCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 9);
+			BankInputEventCtrl = InputFallingEventCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, INDIVIDUAL, 1, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, INDIVIDUAL, 2, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, INDIVIDUAL, 3, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl = BankInputEventCtrl >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, INDIVIDUAL, 4, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+
+			dio_chl->InputFallingEventCtrlReg = InputFallingEventCtrlReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputFallingEventCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 9);
+			BankInputEventCtrl = InputFallingEventCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, WHOLE (input), 1, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, WHOLE (input), 2, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+			BankInputEventCtrl = BankInputEventCtrl >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank input falling event ctrl, WHOLE (input), 3, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankInputEventCtrl);
+
+			dio_chl->InputFallingEventCtrlReg = InputFallingEventCtrlReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankInputEventCtrl & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_input_falling_event_ctrl(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankInputEventCtrl = 0;
+	unsigned int InputFallingEventCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankInputEventCtrl  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankInputEventCtrl |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankInputEventCtrl |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankInputEventCtrl |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank input falling event ctrl, BankIndex:x%02x, BankInputEventCtrl:x%08x\n", dio_chl->info.line, BankIndex, BankInputEventCtrl);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].falling_edge_trigger_cap != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank input falling event ctrl, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			InputFallingEventCtrlReg = BankInputEventCtrl << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, INDIVIDUAL, 1, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+			InputFallingEventCtrlReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, INDIVIDUAL, 2, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+			InputFallingEventCtrlReg &= ~dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, INDIVIDUAL, 3, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+			InputFallingEventCtrlReg |= (dio_chl->InputFallingEventCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, INDIVIDUAL, 4, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 9, InputFallingEventCtrlReg);
+			dio_chl->InputFallingEventCtrlReg = InputFallingEventCtrlReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			InputFallingEventCtrlReg = BankInputEventCtrl << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, WHOLE (input), 1, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+			InputFallingEventCtrlReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, WHOLE (input), 2, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+			InputFallingEventCtrlReg |= (dio_chl->InputFallingEventCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank input falling event ctrl, WHOLE (input), 3, InputFallingEventCtrlReg:x%08x\n", dio_chl->info.line, InputFallingEventCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 9, InputFallingEventCtrlReg);
+			dio_chl->InputFallingEventCtrlReg = InputFallingEventCtrlReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_state(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankState = 0;
+	unsigned int OutputWriteEnableReg = 0;
+	unsigned int OutputReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankState  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankState |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankState |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankState |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank state, BankIndex:x%02x, BankState:x%08x\n", dio_chl->info.line, BankIndex, BankState);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_outputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_OUTPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank state, INDIVIDUAL, no output\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_OUTPUT_IO;
+				break;
+			}
+
+			OutputWriteEnableReg = dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank state, INDIVIDUAL, 1, OutputWriteEnableReg:x%08x\n", dio_chl->info.line, OutputWriteEnableReg);
+			OutputReg = BankState << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank state, INDIVIDUAL, 2, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+			OutputReg &= OutputWriteEnableReg;
+			//printk("SUNIX: DIO (%d), set bank state, INDIVIDUAL, 3, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 10, OutputWriteEnableReg);
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 11, OutputReg);
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			nStatus = SDCDIO_NO_OUTPUT_IO;
+			break;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			OutputWriteEnableReg = cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank state, WHILE (output), 1, OutputWriteEnableReg:x%08x\n", dio_chl->info.line, OutputWriteEnableReg);
+			OutputReg = BankState << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank state, WHILE (output), 2, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+			OutputReg &= OutputWriteEnableReg;
+			//printk("SUNIX: DIO (%d), set bank state, WHILE (output), 3, OutputReg:x%08x\n", dio_chl->info.line, OutputReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 10, OutputWriteEnableReg);
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 11, OutputReg);
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_direction(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankDirection = 0;
+	unsigned int DirectionCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank direction, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+
+			DirectionCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 12);
+			BankDirection = DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank direction, INDIVIDUAL, 1, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+			BankDirection &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank direction, INDIVIDUAL, 2, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+			BankDirection = BankDirection >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank direction, INDIVIDUAL, 3, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+
+			dio_chl->DirectionCtrlReg = DirectionCtrlReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			DirectionCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 12);
+			BankDirection = DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank direction, WHOLE (input), 1, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+			BankDirection &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank direction, WHOLE (input), 2, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+			BankDirection = BankDirection >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank direction, WHOLE (input), 3, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+
+			dio_chl->DirectionCtrlReg = DirectionCtrlReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			DirectionCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 12);
+			BankDirection = DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank direction, WHOLE (output), 1, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+			BankDirection &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank direction, WHOLE (output), 2, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+			BankDirection = BankDirection >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank direction, WHOLE (output), 3, BankDirection:x%08x\n", dio_chl->info.line, BankDirection);
+
+			dio_chl->DirectionCtrlReg = DirectionCtrlReg;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankDirection & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankDirection & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankDirection & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankDirection & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_direction(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankDirection = 0;
+	unsigned int DirectionCtrlReg = 0;
+	unsigned int DirectionCtrlRegByBank = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankDirection  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankDirection |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankDirection |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankDirection |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank direction, BankIndex:x%02x, BankDirection:x%08x\n", dio_chl->info.line, BankIndex, BankDirection);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			DirectionCtrlRegByBank = (BankDirection << cib_info->dio_bank_cap[BankIndex].io_shift_bits) & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank direction, INDIVIDUAL, 1, DirectionCtrlRegByBank:x%08x\n", dio_chl->info.line, DirectionCtrlRegByBank);
+			DirectionCtrlReg = dio_chl->DirectionCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank direction, INDIVIDUAL, 2, DirectionCtrlReg:x%08x\n", dio_chl->info.line, DirectionCtrlReg);
+			DirectionCtrlReg |= DirectionCtrlRegByBank;
+			//printk("SUNIX: DIO (%d), set bank direction, INDIVIDUAL, 3, DirectionCtrlReg:x%08x\n", dio_chl->info.line, DirectionCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 12, DirectionCtrlReg);
+			dio_chl->DirectionCtrlReg = DirectionCtrlReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			if ((BankDirection & (cib_info->dio_bank_cap[BankIndex].io_mask >> cib_info->dio_bank_cap[BankIndex].io_shift_bits)) != 0x00000000)
+			{
+				nStatus = SDCDIO_UNSUPPORT_OUTPUT_CAP;
+				break;
+			}
+
+			DirectionCtrlRegByBank = (BankDirection << cib_info->dio_bank_cap[BankIndex].io_shift_bits) & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank direction, WHOLE (input), 1, DirectionCtrlRegByBank:x%08x\n", dio_chl->info.line, DirectionCtrlRegByBank);
+			DirectionCtrlReg = dio_chl->DirectionCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank direction, WHOLE (input), 2, DirectionCtrlReg:x%08x\n", dio_chl->info.line, DirectionCtrlReg);
+			DirectionCtrlReg |= DirectionCtrlRegByBank;
+			//printk("SUNIX: DIO (%d), set bank direction, WHOLE (input), 3, DirectionCtrlReg:x%08x\n", dio_chl->info.line, DirectionCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 12, DirectionCtrlReg);
+			dio_chl->DirectionCtrlReg = DirectionCtrlReg;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			if ((BankDirection & (cib_info->dio_bank_cap[BankIndex].io_mask >> cib_info->dio_bank_cap[BankIndex].io_shift_bits)) != 
+				(0xffffffff & (cib_info->dio_bank_cap[BankIndex].io_mask >> cib_info->dio_bank_cap[BankIndex].io_shift_bits)))
+			{
+				nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+				break;
+			}
+
+			DirectionCtrlRegByBank = (BankDirection << cib_info->dio_bank_cap[BankIndex].io_shift_bits) & cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank direction, WHOLE (output), 1, DirectionCtrlRegByBank:x%08x\n", dio_chl->info.line, DirectionCtrlRegByBank);
+			DirectionCtrlReg = dio_chl->DirectionCtrlReg & ~cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank direction, WHOLE (output), 2, DirectionCtrlReg:x%08x\n", dio_chl->info.line, DirectionCtrlReg);
+			DirectionCtrlReg |= DirectionCtrlRegByBank;
+			//printk("SUNIX: DIO (%d), set bank direction, WHOLE (output), 3, DirectionCtrlReg:x%08x\n", dio_chl->info.line, DirectionCtrlReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 12, DirectionCtrlReg);
+			dio_chl->DirectionCtrlReg = DirectionCtrlReg;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_output_initial_value(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankOutputInitialValue = 0;
+	unsigned int OutputInitialValueReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_outputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_OUTPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank output initial value, INDIVIDUAL, no output\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_OUTPUT_IO;
+				break;
+			}
+
+			OutputInitialValueReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 13);
+			BankOutputInitialValue = OutputInitialValueReg;
+			//printk("SUNIX: DIO (%d), get bank output initial value, INDIVIDUAL, 1, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+			BankOutputInitialValue &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank output initial value, INDIVIDUAL, 2, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+			BankOutputInitialValue &= dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), get bank output initial value, INDIVIDUAL, 3, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+			BankOutputInitialValue = BankOutputInitialValue >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank output initial value, INDIVIDUAL, 4, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+
+			dio_chl->OutputInitialValueReg = OutputInitialValueReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			nStatus = SDCDIO_NO_OUTPUT_IO;
+			break;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			OutputInitialValueReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 13);
+			BankOutputInitialValue = OutputInitialValueReg;
+			//printk("SUNIX: DIO (%d), get bank output initial value, WHOLE (output), 1, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+			BankOutputInitialValue &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), get bank output initial value, WHOLE (output), 2, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+			BankOutputInitialValue = BankOutputInitialValue >> cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), get bank output initial value, WHOLE (output), 3, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankOutputInitialValue);
+
+			dio_chl->OutputInitialValueReg = OutputInitialValueReg;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankOutputInitialValue & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankOutputInitialValue & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankOutputInitialValue & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankOutputInitialValue & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_output_initial_value(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankOutputInitialValue = 0;
+	unsigned int OutputInitialValueReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankOutputInitialValue  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankOutputInitialValue |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankOutputInitialValue |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankOutputInitialValue |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank output initial value, BankIndex:x%02x, BankOutputInitialValue:x%08x\n", dio_chl->info.line, BankIndex, BankOutputInitialValue);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_outputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_OUTPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), set bank output initial value, INDIVIDUAL, no output\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_OUTPUT_IO;
+				break;
+			}
+
+			OutputInitialValueReg = BankOutputInitialValue << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank output initial value, INDIVIDUAL, 1, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+			OutputInitialValueReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank output initial value, INDIVIDUAL, 2, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+			OutputInitialValueReg &= dio_chl->DirectionCtrlReg;
+			//printk("SUNIX: DIO (%d), set bank output initial value, INDIVIDUAL, 3, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+			OutputInitialValueReg |= (dio_chl->OutputInitialValueReg & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank output initial value, INDIVIDUAL, 4, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 13, OutputInitialValueReg);
+			dio_chl->OutputInitialValueReg = OutputInitialValueReg;
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			nStatus = SDCDIO_NO_OUTPUT_IO;
+			break;
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			OutputInitialValueReg = BankOutputInitialValue << cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			//printk("SUNIX: DIO (%d), set bank output initial value, WHOLE (output), 1, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+			OutputInitialValueReg &= cib_info->dio_bank_cap[BankIndex].io_mask;
+			//printk("SUNIX: DIO (%d), set bank output initial value, WHOLE (output), 2, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+			OutputInitialValueReg |= (dio_chl->OutputInitialValueReg & ~cib_info->dio_bank_cap[BankIndex].io_mask);
+			//printk("SUNIX: DIO (%d), set bank output initial value, WHOLE (output), 3, OutputInitialValueReg:x%08x\n", dio_chl->info.line, OutputInitialValueReg);
+
+			mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 13, OutputInitialValueReg);
+			dio_chl->OutputInitialValueReg = OutputInitialValueReg;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_ctrl_register(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+
+		BankCtrlReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 16 + BankIndex);
+		//printk("SUNIX: DIO (%d), get bank ctrl register, BankCtrlReg:x%08x\n", dio_chl->info.line, BankCtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?5:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankCtrlReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankCtrlReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankCtrlReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankCtrlReg & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_bank_ctrl_register(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned int BankCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 5)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankCtrlReg  =  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 1) << 24);
+		BankCtrlReg |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 2) << 16);
+		BankCtrlReg |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 3) << 8);
+		BankCtrlReg |=  (unsigned int)(*(RxBuff + sizeof(DIO_HEADER) + 4));
+		//printk("SUNIX: DIO (%d), set bank ctrl register, BankIndex:x%02x, BankCtrlReg:x%08x\n", dio_chl->info.line, BankIndex, BankCtrlReg);
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+
+		mem_tx32(dio_chl->info.membase, dio_chl->info.memoffset, 16 + BankIndex, BankCtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?1:1;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_bank_input_port_counter(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &dio_chl->info.cib_info;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	unsigned char * RxBuff = dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BankIndex = 0;
+	unsigned char BankPortIndex = 0;
+	unsigned int BankPortInputCounterValue = 0;
+	unsigned char PortIndex = 0x00;
+	unsigned int PortInputCounterValueReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 2)
+		{
+			nStatus = SDCDIO_LENGTH_INVALID;
+			break;
+		}
+		BankIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 0);
+		BankPortIndex = (unsigned char)*(RxBuff + sizeof(DIO_HEADER) + 1);
+
+		if (!(BankIndex < cib_info->dio_number_of_banks))
+		{
+			nStatus = SDCDIO_BANK_NOT_FOUND;
+			break;
+		}
+
+		if (!(BankPortIndex < cib_info->dio_bank_cap[BankIndex].number_of_io))
+		{
+			nStatus = SDCDIO_BANK_IO_NOT_FOUND;
+			break;
+		}
+
+		if (cib_info->dio_bank_cap[BankIndex].support_inputs != 0x01)
+		{
+			nStatus = SDCDIO_UNSUPPORT_INPUT_CAP;
+			break;
+		}
+
+
+		if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is individual input/output
+			if ((~dio_chl->DirectionCtrlReg & cib_info->dio_bank_cap[BankIndex].io_mask) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input port counter, INDIVIDUAL, no input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+			PortIndex = BankPortIndex;
+			if (cib_info->dio_bank_cap[BankIndex].io_shift_bits > 0)
+			{
+				PortIndex += cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			}
+			if (PortIndex > 32)
+			{
+				//printk("SUNIX: DIO (%d), get bank input port counter, INDIVIDUAL, PortIndex:%d invalid\n", dio_chl->info.line, PortIndex);
+				nStatus = SDCDIO_BANK_IO_NOT_FOUND;
+				break;
+			}
+			if ((~dio_chl->DirectionCtrlReg & (0x00000001 << PortIndex)) == 0x00000000)
+			{
+				//printk("SUNIX: DIO (%d), get bank input port counter, INDIVIDUAL, not input\n", dio_chl->info.line);
+				nStatus = SDCDIO_NO_INPUT_IO;
+				break;
+			}
+			PortInputCounterValueReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 32 + PortIndex);
+			BankPortInputCounterValue = PortInputCounterValueReg;
+			//printk("SUNIX: DIO (%d), get bank input port counter, INDIVIDUAL, 1, PortIndex:x%02x\n", dio_chl->info.line, PortIndex);
+			//printk("SUNIX: DIO (%d), get bank input port counter, INDIVIDUAL, 2, BankPortInputCounterValue:x%08x\n", dio_chl->info.line, BankPortInputCounterValue);
+		}
+		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x01) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x00))
+		{
+			// bank is whole input
+			PortIndex = BankPortIndex;
+			if (cib_info->dio_bank_cap[BankIndex].io_shift_bits > 0)
+			{
+				PortIndex += cib_info->dio_bank_cap[BankIndex].io_shift_bits;
+			}
+			if (PortIndex > 32)
+			{
+				//printk("SUNIX: DIO (%d), get bank input port counter, WHOLE (input), PortIndex:%d invalid\n", dio_chl->info.line, PortIndex);
+				nStatus = SDCDIO_BANK_IO_NOT_FOUND;
+				break;
+			}
+			PortInputCounterValueReg = mem_rx32(dio_chl->info.membase, dio_chl->info.memoffset, 32 + PortIndex);
+			BankPortInputCounterValue = PortInputCounterValueReg;
+			//printk("SUNIX: DIO (%d), get bank input port counter, WHOLE (input), 1, PortIndex:x%02x\n", dio_chl->info.line, PortIndex);
+			//printk("SUNIX: DIO (%d), get bank input port counter, WHOLE (input), 2, BankPortInputCounterValue:x%08x\n", dio_chl->info.line, BankPortInputCounterValue);
+		}
+ 		else if ((cib_info->dio_bank_cap[BankIndex].support_inputs == 0x00) && (cib_info->dio_bank_cap[BankIndex].support_outputs == 0x01))
+		{
+			// bank is whole output
+			nStatus = SDCDIO_NO_INPUT_IO;
+			break;
+		}
+		else
+		{
+			nStatus = SDCDIO_UNDEFINE_ERROR;
+			break;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCDIO_STATUS_SUCCESS)?6:2;
+	TrLength = sizeof(DIO_HEADER);
+	if (pTrHeader->ResponseStatus == SDCDIO_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = BankPortIndex;
+		TrBuff[TrLength++] = (unsigned char)((BankPortInputCounterValue & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((BankPortInputCounterValue & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((BankPortInputCounterValue & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((BankPortInputCounterValue & 0x000000ff));
+	}
+	else
+	{
+		TrBuff[TrLength++] = BankIndex;
+		TrBuff[TrLength++] = BankPortIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void unsupport(struct sunix_sdc_dio_channel *dio_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	unsigned int nStatus = SDCDIO_UNSUPPORT_COMMAND;
+	unsigned int TrLength = 0;
+
+
+	memset(TrBuff, 0, SUNIX_SDC_DIO_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = 0;
+	TrLength = sizeof(DIO_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+int sunix_dio_handle_outcome(struct sunix_sdc_dio_channel *dio_chl, size_t count, unsigned int * outcomeLength)
+{
+	int status = 0;
+	PDIO_PACKAGE pPack = NULL;
+	DLIST *	pListHead = &dio_chl->packList;
+	DLIST * e = NULL;
+	unsigned char * TxBuff = dio_chl->outcomeBuff;
+	unsigned int TrLength = 0;
+
+
+	do
+	{
+		do
+		{
+			if (!SxxListEmpty(pListHead))
+			{
+				e = pListHead->Flink;
+			}
+			else
+			{
+				break;
+			}
+
+			while ((e != NULL) && (e != pListHead))
+			{
+				if (e != NULL)
+				{
+					pPack = SUNIX_SDC_DIO_PACK_PTR(e);
+					if (pPack != NULL)
+					{
+						break;
+					}
+
+					e = e->Flink;
+				}
+			}
+
+		} while (false);
+
+		if (pPack == NULL)
+		{
+			*outcomeLength = 0;
+			break;
+		}
+
+
+		SxxListRemoveEntry(&pPack->Entry);
+
+
+		memset(TxBuff, 0, SUNIX_SDC_DIO_BUFF);
+		memcpy(TxBuff, &pPack->Header, sizeof(DIO_HEADER));
+		TrLength = sizeof(DIO_HEADER);
+		if (pPack->DataPtr != NULL)
+		{
+			memcpy(TxBuff + sizeof(DIO_HEADER), pPack->DataPtr, pPack->Header.Length);
+			TrLength += pPack->Header.Length;
+		}
+
+		*outcomeLength = TrLength;
+
+		//printk("SUNIX: DIO FREE pack, line:%d, pack:x%p, DataPtrx%p\n", dio_chl->info.line, pPack, pPack->DataPtr);
+		if (pPack->DataPtr != NULL)
+		{
+			kfree(pPack->DataPtr);
+			pPack->DataPtr = NULL;
+		}
+		kmem_cache_free(sunix_sdc_dio_pack_cache, pPack);
+		pPack = NULL;
+			
+	} while (false);
+
+	return status;
+}
+
+
+int sunix_dio_handle_income(struct sunix_sdc_dio_channel *dio_chl, size_t count)
+{
+	int status = 0;
+	PDIO_HEADER pRxHeader = (PDIO_HEADER)dio_chl->incomeBuff;
+	PDIO_HEADER pTrHeader = (PDIO_HEADER)dio_chl->translateBuff;
+	unsigned char * TrBuff = dio_chl->translateBuff;
+	PDIO_PACKAGE pPack = NULL;
+	unsigned int translateLength = 0;
+	unsigned long Flags;
+
+
+	do
+	{
+		// debug
+		/*
+		printk("++++++++++++++++++++++++++++++++++++++++++++++\n");
+		printk("SUNIX: DIO_RX, Version              :x%02x\n", pRxHeader->Version);
+		printk("SUNIX: DIO_RX, CmdResponseEventData :x%04x\n", pRxHeader->CmdResponseEventData);
+		printk("SUNIX: DIO_RX, Length               :x%08x\n", pRxHeader->Length);
+		printk("++++++++++++++++++++++++++++++++++++++++++++++\n");
+		*/
+
+
+		switch (pRxHeader->CmdResponseEventData)
+		{
+			case SDCDIO_CMD_GET_INFO :
+				get_info(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_STATE :
+				get_bank_state(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_DELTA_STATE :
+				get_bank_input_delta_state(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_INVERT_ENABLE :
+				get_bank_input_invert_enable(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_INVERT_ENABLE :
+				set_bank_input_invert_enable(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_LATCH_RISING_EDGE :
+				get_bank_input_latch_rising_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_LATCH_RISING_EDGE :
+				set_bank_input_latch_rising_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_LATCH_FALLING_EDGE :
+				get_bank_input_latch_falling_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_LATCH_FALLING_EDGE :
+				set_bank_input_latch_falling_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_COUNTER_RESET :
+				set_bank_input_counter_reset(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_COUNTER_INCREMENT_RISING_EDGE :
+				get_bank_input_counter_increment_rising_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_COUNTER_INCREMENT_RISING_EDGE :
+				set_bank_input_counter_increment_rising_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_COUNTER_INCREMENT_FALLING_EDGE :
+				get_bank_input_counter_increment_falling_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_COUNTER_INCREMENT_FALLING_EDGE :
+				set_bank_input_counter_increment_falling_edge(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_RISING_EVENT_CTRL :
+				get_bank_input_rising_event_ctrl(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_RISING_EVENT_CTRL :
+				set_bank_input_rising_event_ctrl(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_FALLING_EVENT_CTRL :
+				get_bank_input_falling_event_ctrl(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_INPUT_FALLING_EVENT_CTRL :
+				set_bank_input_falling_event_ctrl(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_STATE :
+				set_bank_state(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_DIRECTION :
+				get_bank_direction(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_DIRECTION :
+				set_bank_direction(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_OUTPUT_INITIAL_VALUE :
+				get_bank_output_initial_value(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_OUTPUT_INITIAL_VALUE :
+				set_bank_output_initial_value(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_CTRL_REGISTER :
+				get_bank_ctrl_register(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_SET_BANK_CTRL_REGISTER :
+				set_bank_ctrl_register(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCDIO_CMD_GET_BANK_INPUT_PORT_COUNTER :
+				get_bank_input_port_counter(dio_chl, (unsigned int)count, &translateLength);
+				break;
+
+			default :
+				unsupport(dio_chl, (unsigned int)count, &translateLength);
+				break;
+		}
+
+
+		// debug
+		/*
+		printk("----------------------------------------------\n");
+		printk("SUNIX: DIO_TR, translateLength      :%d\n", translateLength);
+		printk("SUNIX: DIO_TR, Version              :x%02x\n", pTrHeader->Version);
+		printk("SUNIX: DIO_TR, CmdResponseEventData :x%04x\n", pTrHeader->CmdResponseEventData);
+		printk("SUNIX: DIO_TR, ResponseStatus       :x%04x\n", pTrHeader->ResponseStatus);
+		printk("SUNIX: DIO_TR, Length               :x%08x\n", pTrHeader->Length);
+		{
+			int i;
+			for (i = 0; i < pTrHeader->Length; i++)
+				printk("x%02x ", (unsigned char)*(TrBuff + sizeof(DIO_HEADER) + i));
+		}
+		printk("----------------------------------------------\n");
+		*/
+
+
+		if (pTrHeader->Length > DIO_MAX_DATA_LENGTH)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		if (translateLength > (DIO_MAX_DATA_LENGTH + sizeof(DIO_HEADER)))
+		{
+			status = -ENOMEM;
+			break;
+		}
+
+		pPack = kmem_cache_alloc(sunix_sdc_dio_pack_cache, GFP_ATOMIC);
+		if (pPack == NULL)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		memset(pPack, 0, sizeof(DIO_PACKAGE));
+		pPack->DataPtr = (unsigned char *)kmalloc(DIO_MAX_DATA_LENGTH, GFP_KERNEL);
+		if (pPack->DataPtr == NULL)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		memset(pPack->DataPtr, 0, DIO_MAX_DATA_LENGTH);
+
+
+		SxxListInit(&pPack->Entry);
+		memcpy(&pPack->Header, pTrHeader, sizeof(DIO_HEADER));
+		memcpy(pPack->DataPtr, TrBuff + sizeof(DIO_HEADER), pTrHeader->Length);
+
+		spin_lock_irqsave(&dio_chl->packLock, Flags);
+		//printk("SUNIX: DIO ALOC pack, line:%d, pack:x%p, DataPtrx%p\n", dio_chl->info.line, pPack, pPack->DataPtr);
+		SxxListInsertTail(&dio_chl->packList, &pPack->Entry);
+
+		dio_chl->readDataReady = 1;
+		wake_up_interruptible(&dio_chl->readWQ);
+		spin_unlock_irqrestore(&dio_chl->packLock, Flags);
+
+	} while (false);
+
+	if (status != 0)
+	{
+		if (pPack != NULL)
+		{
+			if (pPack->DataPtr != NULL)
+			{
+				kfree(pPack->DataPtr);
+				pPack->DataPtr = NULL;
+			}
+
+			kmem_cache_free(sunix_sdc_dio_pack_cache, pPack);
+		}
+	}
+
+	return status;
+}
+
+
diff --git a/drivers/mfd/list.c b/drivers/mfd/list.c
new file mode 100644
index 000000000000..8126eaed9671
--- /dev/null
+++ b/drivers/mfd/list.c
@@ -0,0 +1,99 @@
+
+
+#include "sdc_include.h"
+
+
+void
+SxxListInit(
+	DLIST *					pListHead
+	)
+{
+	pListHead->Flink = pListHead->Blink = pListHead;
+}
+
+
+bool
+SxxListEmpty(
+	DLIST *					pListHead
+	)
+{
+	if (pListHead->Flink == pListHead)
+	{
+		return true;
+	}
+	else
+	{
+		return false;
+	}
+}
+
+
+DLIST *
+SxxListGetNext(
+	DLIST *					pListHead
+	)
+{
+	return pListHead->Flink;
+}
+
+
+DLIST *
+SxxListGetPrev(
+	DLIST *					pListHead
+	)
+{
+	return pListHead->Blink;
+}
+
+
+void
+SxxListRemoveEntry(
+	DLIST *					pEntry
+	)
+{
+	DLIST *					_DlistMEntry = pEntry;
+
+
+	_DlistMEntry->Blink->Flink = _DlistMEntry->Flink;
+	_DlistMEntry->Flink->Blink = _DlistMEntry->Blink;
+	_DlistMEntry->Flink = _DlistMEntry->Blink = _DlistMEntry;
+}
+
+
+void
+SxxListInsertEntry(
+	DLIST *					pEntry,
+	DLIST * 				pNewEntry
+	)
+{
+	DLIST *					_DlistMEntry = pEntry;
+	DLIST *					_DlistMNewEntry = pNewEntry;
+
+
+	_DlistMNewEntry->Flink = _DlistMEntry->Flink;
+	_DlistMNewEntry->Blink = _DlistMEntry;
+	_DlistMEntry->Flink->Blink = _DlistMNewEntry;
+	_DlistMEntry->Flink = _DlistMNewEntry;
+}
+
+
+void
+SxxListInsertHead(
+	DLIST *					pListHead,
+	DLIST *					pEntry
+	)
+{
+	SxxListInsertEntry(pListHead, pEntry);
+}
+
+
+void
+SxxListInsertTail(
+	DLIST *					pListHead,
+	DLIST *					pEntry
+	)
+{
+	SxxListInsertEntry(pListHead->Blink, pEntry);
+}
+
+
diff --git a/drivers/mfd/mem.c b/drivers/mfd/mem.c
new file mode 100644
index 000000000000..1158439d0aef
--- /dev/null
+++ b/drivers/mfd/mem.c
@@ -0,0 +1,37 @@
+
+
+#include "sdc_include.h"
+
+
+void __iomem * mem_get_bar_ioremap(struct pci_dev *pdev, unsigned int bar_num)
+{
+	void __iomem * membase;
+	unsigned long phy_base_start;
+	unsigned long phy_base_end;
+	unsigned long phy_base_len;
+
+
+	phy_base_start = pci_resource_start(pdev, bar_num);
+	phy_base_end = pci_resource_end(pdev, bar_num);
+	phy_base_len = (phy_base_end - phy_base_start) + 1;
+	membase = ioremap(phy_base_start, phy_base_len);
+	return membase;
+}
+
+
+unsigned int mem_rx32(void __iomem *membase, unsigned int base_offset, unsigned int reg_offset)
+{
+	unsigned int data;
+
+
+	data = readl(membase + base_offset + (reg_offset * 4));
+	return data;
+}
+
+
+void mem_tx32(void __iomem *membase, unsigned int base_offset, unsigned int reg_offset, unsigned int data)
+{
+	writel(data, membase + base_offset + (reg_offset * 4));
+}
+
+
diff --git a/drivers/mfd/sdc_define.h b/drivers/mfd/sdc_define.h
new file mode 100644
index 000000000000..365a52809da5
--- /dev/null
+++ b/drivers/mfd/sdc_define.h
@@ -0,0 +1,668 @@
+
+
+#ifndef _SDC_DRVR_DEFINE_H_
+#define _SDC_DRVR_DEFINE_H_
+
+
+/*******************************************************
+	
+*******************************************************/
+
+#define ENABLE_DEBUG_SDC_BUS					0
+#define ENABLE_DEBUG_SDC_DIO					0
+
+
+/*******************************************************
+	bus
+*******************************************************/
+
+#define SUNIX_SDC_BOARD_MAX  					4
+
+struct dio_bank
+{
+	unsigned char			number_of_io;
+	unsigned char			support_inputs;
+	unsigned char			support_outputs;
+	unsigned char			rising_edge_trigger_cap;
+	unsigned char			falling_edge_trigger_cap;
+
+	unsigned int			io_mask;
+	unsigned int			io_shift_bits;
+};
+
+struct spi_device
+{
+	unsigned char			type;
+	unsigned char			number_of_gpio_input;
+	unsigned char			number_of_gpio_output;
+	unsigned char			name[32];
+};
+
+struct sdc_cib
+{
+	// cib
+	unsigned char			num;
+	unsigned char			type;
+	unsigned char			version;
+	unsigned char			lengthInDW;
+	unsigned char			capability;
+	unsigned char			event_header_type;
+	unsigned int			io_addr_offset;
+	unsigned char			io_space_size;
+	unsigned int			mem_addr_offset;
+	unsigned int			mem_space_size;
+	// configuration controller
+	unsigned char			cfg_ic_model;
+	// uart controller
+	unsigned short			uart_tx_fifo_size;
+	unsigned short			uart_rx_fifo_size;
+	unsigned int			uart_significand_of_clock;
+	unsigned char			uart_exponent_of_clock;
+	unsigned char			uart_RS232_cap;
+	unsigned char			uart_RS422_cap;
+	unsigned char			uart_RS485_cap;
+	unsigned char			uart_AHDC_cap;
+	unsigned char			uart_CS_cap;
+	unsigned char			uart_auto_RS422485_cap;
+	unsigned char			uart_RS422_termination_cap;
+	unsigned char			uart_RS485_termination_cap;
+	unsigned char			uart_RI_5V_cap;
+	unsigned char			uart_RI_12V_cap;
+	unsigned char			uart_DCD_5V_cap;
+	unsigned char			uart_DCD_12V_cap;
+	// dio controller
+	unsigned char			dio_number_of_banks;
+	unsigned char			dio_shares_same_direction_ctrl_cap;
+	unsigned char			dio_writing_setting_to_flash_cap;
+	struct dio_bank			dio_bank_cap[32];
+	// spi controller
+	unsigned int			spi_significand_of_clock;
+	unsigned char			spi_exponent_of_clock;
+	unsigned char			spi_number_of_device;
+	struct spi_device		spi_device_cap[16];
+};
+
+struct sunix_sdc_uart_channel;
+struct sunix_sdc_dio_channel;
+struct sunix_sdc_spi_channel;
+
+struct sunix_sdc_board
+{
+	struct pci_dev			*pdev;
+	int						board_enum;
+	int						board_number;
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+	unsigned int			irq;
+
+	void __iomem *			bar0_membase;
+	unsigned int			bar1_iobase;
+	void __iomem *			bar2_membase;
+
+	unsigned char 			major_version;
+	unsigned char 			minor_version;
+	unsigned char 			aval_channels;
+	unsigned char 			model_name[32];
+	struct sdc_cib			channel[32];
+
+	unsigned int			uart_amount;
+	unsigned int			uart_start_index;
+	int						(*uart_isr)(struct sunix_sdc_uart_channel *);
+
+	unsigned int			dio_amount;
+	unsigned int			dio_start_index;
+	int						(*dio_isr)(struct sunix_sdc_dio_channel *, unsigned int);
+
+	unsigned int			spi_amount;
+	unsigned int			spi_start_index;
+	int						(*spi_isr)(struct sunix_sdc_spi_channel *, unsigned int);
+};
+
+
+/*******************************************************
+
+*******************************************************/
+
+typedef struct _DLIST
+{
+	struct _DLIST *			Flink;
+	struct _DLIST *			Blink;
+
+} DLIST;
+
+
+#define STRUCT_BASE_POINTER(Fieldptr, Type, Field) \
+	((Type *)(((char *)(Fieldptr)) - ((char *)(&(((Type *)0)->Field)))))
+
+
+/*******************************************************
+	uart
+*******************************************************/
+
+#define SUNIX_SDC_UART_MAX					32
+
+#define SNX_SDC_UART_IOCTL					0xa00
+#define SNX_SDC_UART_GET_INFO				(SNX_SDC_UART_IOCTL + 50)
+#define SNX_SDC_UART_GET_ADDITIONAL_REG_0E	(SNX_SDC_UART_IOCTL + 51)
+#define SNX_SDC_UART_SET_ADDITIONAL_REG_0E	(SNX_SDC_UART_IOCTL + 52)
+
+struct snx_sdc_uart_info 
+{
+	unsigned char			model_name[32];
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+	unsigned int			line;
+	unsigned int			iobase;
+	unsigned int			irq;
+	unsigned char			version;
+	unsigned short			tx_fifo_size;
+	unsigned short			rx_fifo_size;
+	unsigned int			significand_of_clock;
+	unsigned char			exponent_of_clock;
+	unsigned char			RS232_cap;
+	unsigned char			RS422_cap;
+	unsigned char			RS485_cap;
+	unsigned char			AHDC_cap;
+	unsigned char			CS_cap;
+	unsigned char			auto_RS422485_cap;
+	unsigned char			RS422_termination_cap;
+	unsigned char			RS485_termination_cap;
+	unsigned char			RI_5V_cap;
+	unsigned char			RI_12V_cap;
+	unsigned char			DCD_5V_cap;
+	unsigned char			DCD_12V_cap;
+};
+
+
+
+
+#define UART_LSR_ERR_IN_RFIFO  				0x80
+#define UART_MCR_AFE  						0x20
+#define UART_IIR_CTO  						0x0C
+
+#define INTERRUPT_COUNT						128
+#define WAKEUP_CHARS						256
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 19))
+#define SNXTERMIOS  ktermios
+#else
+#define SNXTERMIOS  termios
+#endif
+
+#define SNX_SER_BAUD_SETSERIAL				1
+#define SNX_SER_BAUD_NOTSETSER				0
+
+#define PORT_SER_UNKNOWN		0
+#define PORT_SER_8250			1
+#define PORT_SER_16450			2
+#define PORT_SER_16550			3
+#define PORT_SER_16550A			4
+#define PORT_SER_CIRRUS         5
+#define PORT_SER_16650			6
+#define PORT_SER_16650V2		7
+#define PORT_SER_16750			8
+#define PORT_SER_MAX_UART		8	/* max serial port ID */
+
+#define SNX_USF_CLOSING_WAIT_INF			(0)
+#define SNX_USF_CLOSING_WAIT_NONE			(65535)
+#define SNX_UART_CONFIG_TYPE				(1 << 0)
+#define SNX_UART_CONFIG_IRQ					(1 << 1)
+
+#define SNX_UART_XMIT_SIZE 					4096
+
+#define snx_ser_circ_empty(circ)		   	((circ)->head == (circ)->tail)
+#define snx_ser_circ_clear(circ)		    ((circ)->head = (circ)->tail = 0)
+#define snx_ser_circ_chars_pending(circ)    (CIRC_CNT((circ)->head, (circ)->tail, SNX_UART_XMIT_SIZE))
+#define snx_ser_circ_chars_free(circ)       (CIRC_SPACE((circ)->head, (circ)->tail, SNX_UART_XMIT_SIZE))
+#define snx_ser_tx_stopped(port)            ((port)->info->tty->stopped || (port)->info->tty->hw_stopped)
+
+#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
+#define SNX_SERIAL_INLINE
+#endif
+
+#ifdef SNX_SERIAL_INLINE
+#define _INLINE_ inline
+#else
+#define _INLINE_
+#endif
+
+#define SNX_UPIO_PORT				(0)
+#define SNX_UPIO_MEM				(1)
+
+#define SNX_UPF_SAK					(1 << 2)
+#define SNX_UPF_SPD_MASK			(0x1030)
+#define SNX_UPF_SPD_HI				(0x0010)
+#define SNX_UPF_SPD_VHI				(0x0020)
+#define SNX_UPF_SPD_CUST			(0x0030)
+#define SNX_UPF_SPD_SHI				(0x1000)
+#define SNX_UPF_SPD_WARP			(0x1010)
+#define SNX_UPF_SKIP_TEST			(1 << 6)
+#define SNX_UPF_HARDPPS_CD			(1 << 11)
+#define SNX_UPF_LOW_LATENCY			(1 << 13)
+#define SNX_UPF_BUGGY_UART			(1 << 14)
+#define SNX_UPF_MAGIC_MULTIPLIER	(1 << 16)
+
+#define SNX_UPF_CHANGE_MASK			(0x17fff)
+#define SNX_UPF_USR_MASK			(SNX_UPF_SPD_MASK | SNX_UPF_LOW_LATENCY)
+
+#define SNX_UIF_CHECK_CD			(1 << 25)
+#define SNX_UIF_CTS_FLOW			(1 << 26)
+
+#define SNX_UIF_NORMAL_ACTIVE		(1 << 29)
+#define SNX_UIF_INITIALIZED			(1 << 31)
+
+#define SNX_ENABLE_MS(port, cflag)    ((port)->flags & SNX_UPF_HARDPPS_CD || (cflag) & CRTSCTS || !((cflag) & CLOCAL))
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+#define SNX_SER_DEVNUM(x)   ((x)->index)
+#else
+#define SNX_SER_DEVNUM(x)   (MINOR((x)->device) - (x)->driver.minor_start)
+#endif
+
+struct snx_ser_info;
+struct snx_ser_port;
+
+struct snx_ser_icount
+{
+	__u32	cts;
+	__u32	dsr;
+	__u32	rng;
+	__u32	dcd;
+	__u32	rx;
+	__u32	tx;
+	__u32	frame;
+	__u32	overrun;
+	__u32	parity;
+	__u32	brk;
+	__u32	buf_overrun;
+};
+
+struct snx_ser_info
+{
+	struct tty_struct		*tty;
+	struct circ_buf			xmit;
+	unsigned int			flags;
+	unsigned char			*tmpbuf;
+	struct semaphore		tmpbuf_sem;
+	int						blocked_open;
+	struct tasklet_struct	tlet;
+
+	wait_queue_head_t		open_wait;
+	wait_queue_head_t		delta_msr_wait;
+};
+
+struct snx_ser_driver
+{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	struct module			*owner;
+	const char 				*driver_name;
+#endif
+
+	const char				*dev_name;
+	int			 			major;
+	int			 			minor;
+	int			 			nr;
+	struct snx_ser_state	*state;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	struct tty_driver		*tty_driver;
+#else
+	struct tty_driver  		tty_driver;
+#endif
+};
+
+struct snx_ser_port
+{
+	spinlock_t				lock;
+	unsigned int			iobase;
+	unsigned int			iosize;
+	unsigned int			irq;
+	unsigned int			uartclk;
+	unsigned char			fifosize;
+	unsigned char			x_char;
+	unsigned char			iotype;
+
+	unsigned int			read_status_mask;
+	unsigned int			ignore_status_mask;
+	struct snx_ser_info		*info;
+	struct snx_ser_icount	icount;
+
+	unsigned int			flags;
+	unsigned int			mctrl;
+	unsigned int			timeout;
+
+	unsigned int			type;
+	unsigned int			custom_divisor;
+	unsigned int			line;
+
+	int						board_enum;
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+	unsigned char 			model_name[32];
+
+	unsigned int			baud_base;
+	int						rx_trigger;
+	unsigned char			ldisc_stop_rx;
+	unsigned int			setserial_flag;
+    unsigned char			suspended;
+	struct device			*dev;
+
+	struct sdc_cib			cib_info;
+};
+
+struct snx_ser_state
+{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	struct tty_port			tport;
+#endif
+
+	unsigned int			close_delay;
+	unsigned int			closing_wait;
+	int						count;
+	struct snx_ser_info	    *info;
+	struct snx_ser_port		*port;
+	struct semaphore		sem;
+};
+
+static inline int snx_ser_handle_break(struct snx_ser_port *port)
+{
+	struct snx_ser_info *info = port->info;
+
+	if (info->flags & SNX_UPF_SAK)
+	{
+		do_SAK(info->tty);
+	}
+	return 0;
+}
+
+static inline void snx_ser_handle_dcd_change(struct snx_ser_port *port, unsigned int status)
+{
+	struct snx_ser_info *info = port->info;
+
+	port->icount.dcd++;
+
+	if (info->flags & SNX_UIF_CHECK_CD)
+	{
+		if (status)
+		{
+			wake_up_interruptible(&info->open_wait);
+		}
+		else if (info->tty)
+		{
+			tty_hangup(info->tty);
+		}
+	}
+}
+
+struct sunix_sdc_uart_channel
+{
+	struct snx_ser_port port;
+	struct timer_list	timer;
+	struct list_head	list;
+
+	unsigned int		capabilities;
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		mcr_mask;
+	unsigned char		mcr_force;
+	unsigned char		lsr_break_flag;
+};
+
+
+/*******************************************************
+	dio
+*******************************************************/
+
+#define SUNIX_SDC_DIO_MAX					32
+#define SUNIX_SDC_DIO_BUFF					1024
+
+struct snx_dio_info 
+{
+ 	unsigned char			model_name[32];
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+	unsigned int			line;
+	unsigned long			phy2_base_start;
+	void __iomem *			membase;
+	unsigned int			memoffset;
+	unsigned int			memsize;
+	unsigned int			irq;
+
+	struct sdc_cib			cib_info;
+};
+
+struct sunix_sdc_dio_channel 
+{
+	struct snx_dio_info		info;
+	struct cdev				cdev;
+
+	DLIST					packList;
+	spinlock_t				packLock;
+	wait_queue_head_t		readWQ;
+	unsigned int			readDataReady;
+	struct semaphore		sem;
+
+	bool					isOpened;
+
+	unsigned char *			incomeBuff;
+	unsigned char *			outcomeBuff;
+	unsigned char *			translateBuff;
+
+	unsigned int			InputInvertEnableReg;
+	unsigned int			InputLatchRegPositiveEdgeR;
+	unsigned int			InputLatchRegPositiveEdgeW;
+	unsigned int			InputLatchRegNegativeEdgeR;
+	unsigned int			InputLatchRegNegativeEdgeW;
+	unsigned int			InputCounterIncrementCtrlRegPositiveEdge;
+	unsigned int			InputCounterIncrementCtrlRegNegativeEdge;
+	unsigned int			InputRisingEventCtrlReg;
+	unsigned int			InputFallingEventCtrlReg;
+	unsigned int			DirectionCtrlReg;
+	unsigned int			OutputInitialValueReg;
+};
+
+#define DIO_MAX_DATA_LENGTH		128
+
+typedef struct _DIO_HEADER
+{
+	unsigned char		Version;
+	unsigned char		Reserved;
+	unsigned short		CmdResponseEventData;
+	unsigned short		ResponseStatus;
+	unsigned int		Length;
+
+} DIO_HEADER, *PDIO_HEADER;
+
+typedef struct _DIO_PACKAGE
+{
+	DLIST				Entry;
+	DIO_HEADER			Header;
+	unsigned char * 	DataPtr;
+
+} DIO_PACKAGE, *PDIO_PACKAGE;
+
+#define SDCDIO_CMD_GET_INFO											0x0001
+#define SDCDIO_CMD_GET_BANK_STATE									0x0002
+#define SDCDIO_CMD_GET_BANK_INPUT_DELTA_STATE						0x0003
+#define SDCDIO_CMD_GET_BANK_INPUT_INVERT_ENABLE						0x0004
+#define SDCDIO_CMD_SET_BANK_INPUT_INVERT_ENABLE						0x0005
+#define SDCDIO_CMD_GET_BANK_INPUT_LATCH_RISING_EDGE					0x0006
+#define SDCDIO_CMD_SET_BANK_INPUT_LATCH_RISING_EDGE					0x0007
+#define SDCDIO_CMD_GET_BANK_INPUT_LATCH_FALLING_EDGE				0x0008
+#define SDCDIO_CMD_SET_BANK_INPUT_LATCH_FALLING_EDGE				0x0009
+#define SDCDIO_CMD_SET_BANK_INPUT_COUNTER_RESET						0x000a
+#define SDCDIO_CMD_GET_BANK_INPUT_COUNTER_INCREMENT_RISING_EDGE		0x000b
+#define SDCDIO_CMD_SET_BANK_INPUT_COUNTER_INCREMENT_RISING_EDGE		0x000c
+#define SDCDIO_CMD_GET_BANK_INPUT_COUNTER_INCREMENT_FALLING_EDGE	0x000d
+#define SDCDIO_CMD_SET_BANK_INPUT_COUNTER_INCREMENT_FALLING_EDGE	0x000e
+#define SDCDIO_CMD_GET_BANK_INPUT_RISING_EVENT_CTRL					0x000f
+#define SDCDIO_CMD_SET_BANK_INPUT_RISING_EVENT_CTRL					0x0010
+#define SDCDIO_CMD_GET_BANK_INPUT_FALLING_EVENT_CTRL				0x0011
+#define SDCDIO_CMD_SET_BANK_INPUT_FALLING_EVENT_CTRL				0x0012
+#define SDCDIO_CMD_SET_BANK_STATE									0x0013
+#define SDCDIO_CMD_GET_BANK_DIRECTION								0x0014
+#define SDCDIO_CMD_SET_BANK_DIRECTION								0x0015
+#define SDCDIO_CMD_GET_BANK_OUTPUT_INITIAL_VALUE					0x0016
+#define SDCDIO_CMD_SET_BANK_OUTPUT_INITIAL_VALUE					0x0017
+#define SDCDIO_CMD_GET_BANK_CTRL_REGISTER							0x0018
+#define SDCDIO_CMD_SET_BANK_CTRL_REGISTER							0x0019
+#define SDCDIO_CMD_GET_BANK_INPUT_PORT_COUNTER						0x001a
+#define SDCDIO_EVENT												0x1001
+
+
+
+
+#define SDCDIO_STATUS_SUCCESS										0x0000
+#define SDCDIO_LENGTH_INVALID										0x0001
+#define SDCDIO_DATA_INVALID											0x0002
+#define SDCDIO_CONTROLLER_VERSION_UNSUPPORT							0x0003
+#define SDCDIO_UNSUPPORT_COMMAND									0x0004
+#define SDCDIO_ALLOC_MEMORY_FAIL									0x0005
+
+#define SDCDIO_BANK_NOT_FOUND										0x0010
+#define SDCDIO_BANK_IO_NOT_FOUND									0x0011
+#define SDCDIO_UNSUPPORT_INPUT_CAP									0x0012
+#define SDCDIO_UNSUPPORT_OUTPUT_CAP									0x0013
+#define SDCDIO_NO_INPUT_IO											0x0014
+#define SDCDIO_NO_OUTPUT_IO											0x0015
+#define SDCDIO_UNSUPPORT_RISING_EDGE_TRIGGER_CAP					0x0016
+#define SDCDIO_UNSUPPORT_FALLING_EDGE_TRIGGER_CAP					0x0017
+
+#define SDCDIO_UNDEFINE_ERROR										0xffff
+
+#define SUNIX_SDC_DIO_PACK_PTR(ListEntry) \
+	STRUCT_BASE_POINTER(ListEntry, DIO_PACKAGE, Entry)
+
+
+/*******************************************************
+	spi
+*******************************************************/
+
+#define SUNIX_SDC_SPI_MAX					32
+#define SUNIX_SDC_SPI_BUFF					1024
+
+struct snx_spi_info 
+{
+ 	unsigned char			model_name[32];
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+	unsigned int			line;
+	unsigned long			phy2_base_start;
+	void __iomem *			membase;
+	unsigned int			memoffset;
+	unsigned int			memsize;
+	unsigned int			irq;
+
+	struct sdc_cib			cib_info;
+};
+
+struct sunix_sdc_spi_channel 
+{
+	struct snx_spi_info		info;
+	struct cdev				cdev;
+
+	DLIST					packList;
+	spinlock_t				packLock;
+	wait_queue_head_t		readWQ;
+	unsigned int			readDataReady;
+	struct semaphore		sem;
+
+	bool					isOpened;
+
+	unsigned char *			incomeBuff;
+	unsigned char *			outcomeBuff;
+	unsigned char *			translateBuff;
+};
+
+#define SPI_MAX_DATA_LENGTH		512
+
+typedef struct _SPI_HEADER
+{
+	unsigned char		Version;
+	unsigned char		Reserved;
+	unsigned short		CmdResponseEventData;
+	unsigned short		ResponseStatus;
+	unsigned int		Length;
+
+} SPI_HEADER, *PSPI_HEADER;
+
+typedef struct _SPI_PACKAGE
+{
+	DLIST				Entry;
+	SPI_HEADER			Header;
+	unsigned char * 	DataPtr;
+
+} SPI_PACKAGE, *PSPI_PACKAGE;
+
+#define SDCSPI_CMD_GET_INFO											0x0001
+#define SDCSPI_CMD_GET_BASIC_CTRL									0x0002
+#define SDCSPI_CMD_SET_BASIC_CTRL									0x0003
+#define SDCSPI_CMD_GET_MODE_CTRL									0x0004
+#define SDCSPI_CMD_SET_MODE_CTRL									0x0005
+#define SDCSPI_CMD_GET_DIVISOR										0x0006
+#define SDCSPI_CMD_SET_DIVISOR										0x0007
+#define SDCSPI_CMD_GET_STATUS										0x0008
+#define SDCSPI_CMD_GET_CS_SCLK_SETUP_DELAY_TIME_UNIT				0x0009
+#define SDCSPI_CMD_SET_CS_SCLK_SETUP_DELAY_TIME_UNIT				0x000a
+#define SDCSPI_CMD_GET_CS_SCLK_HOLD_DELAY_TIME_UNIT					0x000b
+#define SDCSPI_CMD_SET_CS_SCLK_HOLD_DELAY_TIME_UNIT					0x000c
+#define SDCSPI_CMD_GET_QUIET_DELAY_TIME_UNIT						0x000d
+#define SDCSPI_CMD_SET_QUIET_DELAY_TIME_UNIT						0x000e
+#define SDCSPI_CMD_GET_PORT_IRQ_ENABLE_REG							0x000f
+#define SDCSPI_CMD_SET_PORT_IRQ_ENABLE_REG							0x0010
+#define SDCSPI_CMD_GET_PORT_IRQ_STATUS_REG							0x0011
+#define SDCSPI_CMD_GET_GPIO_OUTPUT_WRITE_ENABLE_REG					0x0012
+#define SDCSPI_CMD_SET_GPIO_OUTPUT_WRITE_ENABLE_REG					0x0013
+#define SDCSPI_CMD_GET_GPIO_OUTPUT_REG								0x0014
+#define SDCSPI_CMD_SET_GPIO_OUTPUT_REG								0x0015
+#define SDCSPI_CMD_GET_TRANSCATION_CTRL_REG0						0x0016
+#define SDCSPI_CMD_SET_TRANSCATION_CTRL_REG0						0x0017
+#define SDCSPI_CMD_GET_TRANSCATION_CTRL_REG1						0x0018
+#define SDCSPI_CMD_SET_TRANSCATION_CTRL_REG1						0x0019
+#define SDCSPI_CMD_GET_PORT_EXTEND_CTRL_REG0						0x001a
+#define SDCSPI_CMD_SET_PORT_EXTEND_CTRL_REG0						0x001b
+#define SDCSPI_CMD_GET_PORT_EXTEND_CTRL_REG1						0x001c
+#define SDCSPI_CMD_SET_PORT_EXTEND_CTRL_REG1						0x001d
+#define SDCSPI_CMD_GET_RAM											0x001e
+#define SDCSPI_CMD_SET_RAM											0x001f
+
+
+
+
+#define SDCSPI_STATUS_SUCCESS										0x0000
+#define SDCSPI_LENGTH_INVALID										0x0001
+#define SDCSPI_DATA_INVALID											0x0002
+#define SDCSPI_CONTROLLER_VERSION_UNSUPPORT							0x0003
+#define SDCSPI_UNSUPPORT_COMMAND									0x0004
+#define SDCSPI_ALLOC_MEMORY_FAIL									0x0005
+
+#define SDCSPI_UNDEFINE_ERROR										0xffff
+
+#define SUNIX_SDC_SPI_PACK_PTR(ListEntry) \
+	STRUCT_BASE_POINTER(ListEntry, SPI_PACKAGE, Entry)
+
+
+/*******************************************************
+
+*******************************************************/
+
+
+extern struct sunix_sdc_board			sunix_sdc_board_table[SUNIX_SDC_BOARD_MAX];
+extern struct sunix_sdc_uart_channel	sunix_sdc_uart_table[SUNIX_SDC_UART_MAX + 1];
+extern struct sunix_sdc_dio_channel		sunix_sdc_dio_table[SUNIX_SDC_DIO_MAX];
+extern struct sunix_sdc_spi_channel		sunix_sdc_spi_table[SUNIX_SDC_SPI_MAX];
+
+extern struct kmem_cache *				sunix_sdc_dio_pack_cache;
+extern struct kmem_cache *				sunix_sdc_spi_pack_cache;
+
+extern unsigned int						sunix_sdc_board_amount;
+extern unsigned int						sunix_sdc_board_amount;
+extern unsigned int						sunix_sdc_uart_amount;
+extern unsigned int						sunix_sdc_dio_amount;
+extern unsigned int						sunix_sdc_spi_amount;
+
+
+#endif
+
+
diff --git a/drivers/mfd/sdc_function.h b/drivers/mfd/sdc_function.h
new file mode 100644
index 000000000000..0a56348123d8
--- /dev/null
+++ b/drivers/mfd/sdc_function.h
@@ -0,0 +1,96 @@
+
+
+#ifndef _SDC_DRVR_FUNCTION_H_
+#define _SDC_DRVR_FUNCTION_H_
+
+
+// bus.c
+
+
+// mem.c
+void __iomem * mem_get_bar_ioremap(struct pci_dev *pdev, unsigned int bar_num);
+void __iomem * mem_get_chl_ioremap(struct pci_dev *pdev, unsigned int bar_num, unsigned int offset, unsigned int size);
+unsigned int mem_rx32(void __iomem *membase, unsigned int base_offset, unsigned int reg_offset);
+void mem_tx32(void __iomem *membase, unsigned int base_offset, unsigned int reg_offset, unsigned int data);
+
+
+// list.c
+void
+SxxListInit(
+	DLIST *					pListHead
+	);
+
+bool
+SxxListEmpty(
+	DLIST *					pListHead
+	);
+
+DLIST *
+SxxListGetNext(
+	DLIST *					pListHead
+	);
+
+DLIST *
+SxxListGetPrev(
+	DLIST *					pListHead
+	);
+
+void
+SxxListRemoveEntry(
+	DLIST *					pEntry
+	);
+
+void
+SxxListInsertEntry(
+	DLIST *					pEntry,
+	DLIST * 				pNewEntry
+	);
+
+void
+SxxListInsertHead(
+	DLIST *					pListHead,
+	DLIST *					pEntry
+	);
+
+void
+SxxListInsertTail(
+	DLIST *					pListHead,
+	DLIST *					pEntry
+	);
+
+
+// uart.c
+int snx_ser_startup(struct snx_ser_state *, int);
+void snx_ser_update_termios(struct snx_ser_state *);
+int sunix_ser_register_ports(void);
+void sunix_ser_unregister_ports(void);
+int sunix_ser_register_driver(void);
+void sunix_ser_unregister_driver(void);
+int sunix_ser_interrupt(struct sunix_sdc_uart_channel *);
+
+
+// dio.c
+int sunix_dio_register_channel(void);
+void sunix_dio_unregister_channel(void);
+int sunix_dio_interrupt(struct sunix_sdc_dio_channel *dio_chl, unsigned int event_header);
+
+
+// dio_pack.c
+int sunix_dio_handle_outcome(struct sunix_sdc_dio_channel *dio_chl, size_t count, unsigned int * outcomeLength);
+int sunix_dio_handle_income(struct sunix_sdc_dio_channel *dio_chl, size_t count);
+
+
+// spi.c
+int sunix_spi_register_channel(void);
+void sunix_spi_unregister_channel(void);
+int sunix_spi_interrupt(struct sunix_sdc_spi_channel *spi_chl, unsigned int event_header);
+
+
+// spi_pack.c
+int sunix_spi_handle_outcome(struct sunix_sdc_spi_channel *spi_chl, size_t count, unsigned int * outcomeLength);
+int sunix_spi_handle_income(struct sunix_sdc_spi_channel *spi_chl, size_t count);
+
+
+#endif
+
+
diff --git a/drivers/mfd/sdc_include.h b/drivers/mfd/sdc_include.h
new file mode 100644
index 000000000000..de342b8a363a
--- /dev/null
+++ b/drivers/mfd/sdc_include.h
@@ -0,0 +1,108 @@
+﻿#ifdef	MODVERSIONS
+#ifndef MODULE
+#define	MODULE
+#endif
+#endif
+
+
+#include <linux/version.h>
+#ifndef KERNEL_VERSION
+#define KERNEL_VERSION(ver, rel, seq)	((ver << 16) | (rel << 8) | seq)
+#endif
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0))
+#ifdef MODULE
+#include <linux/config.h>
+#ifdef MODVERSIONS
+#include <linux/modversions.h>
+#endif
+#include <linux/module.h>
+#else
+#define	MOD_INC_USE_COUNT
+#define MOD_DEC_USE_COUNT
+#endif
+
+
+#include <linux/autoconf.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/fcntl.h>
+#include <linux/ptrace.h>
+#include <linux/delay.h>
+#include <linux/tty_flip.h>
+#include <asm/bitops.h>
+
+#ifndef PCI_ANY_ID
+#define PCI_ANY_ID (~0)
+#endif
+#endif
+
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39))
+#include <linux/smp_lock.h>
+#endif
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/tty_driver.h>
+#include <linux/pci.h>
+#include <linux/circ_buf.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/segment.h>
+#include <asm/serial.h>
+#include <linux/interrupt.h>
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+#include <linux/module.h>
+#include <linux/workqueue.h>
+#include <linux/moduleparam.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#endif
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 28))
+#include <linux/kref.h>
+#endif
+
+#include <linux/parport.h>
+#include <linux/ctype.h>
+#include <linux/poll.h>
+
+
+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 17))
+#include <linux/devfs_fs_kernel.h>
+#endif
+
+
+#include <linux/sched.h>
+#include <linux/serial_8250.h>
+#include <linux/cdev.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 11, 0))
+#include <linux/sched/signal.h>
+#endif
+
+#include <linux/fs.h>
+
+#include "sdc_define.h"
+#include "sdc_function.h"
+
+
diff --git a/drivers/mfd/spi.c b/drivers/mfd/spi.c
new file mode 100644
index 000000000000..4c7c1c494255
--- /dev/null
+++ b/drivers/mfd/spi.c
@@ -0,0 +1,420 @@
+
+
+#include "sdc_include.h"
+
+
+static int sunix_spi_open(struct inode *inode, struct file *file)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_SPI_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		spi_chl = &sunix_sdc_spi_table[line];
+		if (spi_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (spi_chl->isOpened == true)
+		{
+			status = -EBUSY;
+			break;
+		}
+
+
+		spi_chl->readDataReady = 0;
+		spi_chl->isOpened = true;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		try_module_get(THIS_MODULE);
+#else
+		MOD_INC_USE_COUNT;
+#endif
+
+	} while (false);
+
+	return status;
+}
+
+
+static int sunix_spi_release(struct inode *inode, struct file *file)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+	DLIST * pListHead = NULL;
+	DLIST * e = NULL;
+	unsigned long Flags;
+	PSPI_PACKAGE pPack = NULL;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_SPI_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		spi_chl = &sunix_sdc_spi_table[line];
+		if (spi_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (spi_chl->isOpened == false)
+		{
+			status = -ENODEV;
+			break;
+		}
+
+		pListHead = &spi_chl->packList;
+		spin_lock_irqsave(&spi_chl->packLock, Flags);
+		while (!SxxListEmpty(pListHead))
+		{
+			e = SxxListGetNext(pListHead);
+			pPack = SUNIX_SDC_SPI_PACK_PTR(e);
+			if (pPack != NULL)
+			{
+				printk("SUNIX: SPI FREE pack, line:%d, pack:x%p, DataPtrx%p\n", spi_chl->info.line, pPack, pPack->DataPtr);
+				SxxListRemoveEntry(e);
+				if (pPack->DataPtr != NULL)
+				{
+					kfree(pPack->DataPtr);
+					pPack->DataPtr = NULL;
+				}
+				kmem_cache_free(sunix_sdc_spi_pack_cache, pPack);
+				pPack = NULL;
+			}
+		}
+		spin_unlock_irqrestore(&spi_chl->packLock, Flags);
+
+		spi_chl->isOpened = false;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		module_put(THIS_MODULE);
+#else
+		MOD_DEC_USE_COUNT;
+#endif
+
+	} while (false);
+
+	return status;
+}
+
+
+static long sunix_spi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_SPI_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		spi_chl = &sunix_sdc_spi_table[line];
+		if (spi_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (spi_chl->isOpened == false)
+		{
+			status = -ENODEV;
+			break;
+		}
+
+	} while (false);
+
+	return status;
+}
+
+
+static ssize_t sunix_spi_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+	unsigned int outcomeLength = 0;
+
+
+	if (line > SUNIX_SDC_SPI_MAX)
+	{
+		return -ENODEV;
+	}
+	spi_chl = &sunix_sdc_spi_table[line];
+	if (spi_chl->info.memsize == 0)
+	{
+		return -ENODEV;
+	}
+	if (spi_chl->isOpened == false)
+	{
+		return -ENODEV;
+	}
+
+	if (count < sizeof(SPI_HEADER))
+	{
+		return -ENOMEM;
+	}
+
+
+	if (down_interruptible(&spi_chl->sem))
+	{
+		return -ERESTARTSYS;
+	}
+
+	if (spi_chl->readDataReady == 0)
+	{
+		up(&spi_chl->sem);
+
+		if ((file->f_flags & O_NONBLOCK))
+		{
+			return -EAGAIN;
+		}
+
+		wait_event_interruptible(spi_chl->readWQ, spi_chl->readDataReady == 1);
+
+		if (down_interruptible(&spi_chl->sem))
+		{
+			return -ERESTARTSYS;
+		}
+	}
+
+
+	do
+	{
+		status = sunix_spi_handle_outcome(spi_chl, count, &outcomeLength);
+		if (status != 0)
+		{
+			break;
+		}
+		if (count < outcomeLength)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		if (outcomeLength <= 0)
+		{
+			status = 0;
+			break;
+		}
+
+		if (copy_to_user((void *)buf, spi_chl->outcomeBuff, outcomeLength))
+		{
+			status = -EFAULT;
+			break;
+		}
+
+		status = outcomeLength;
+
+	} while (false);
+
+
+	spi_chl->readDataReady = 0;
+	up(&spi_chl->sem);
+
+	return status;
+}
+
+
+static ssize_t sunix_spi_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	int status = 0;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_SPI_MAX)
+		{
+			status = -ENODEV;
+			break;
+		}
+		spi_chl = &sunix_sdc_spi_table[line];
+		if (spi_chl->info.memsize == 0)
+		{
+			status = -ENODEV;
+			break;
+		}
+		if (spi_chl->isOpened == false)
+		{
+			status = -ENODEV;
+			break;
+		}
+
+		if (count < sizeof(SPI_HEADER))
+		{
+			status = -EFAULT;
+			break;
+		}
+
+		if (count > (sizeof(SPI_HEADER) + SPI_MAX_DATA_LENGTH))
+		{
+			status = -ENOMEM;
+			break;
+		}
+
+		if (copy_from_user(spi_chl->incomeBuff, (void *)buf, count))
+		{
+			status = -EFAULT;
+			break;
+		}
+
+		status = sunix_spi_handle_income(spi_chl, count);
+		if (status == 0)
+		{
+			status = count;
+		}
+
+	} while (false);
+
+	return status;
+}
+
+
+unsigned int sunix_spi_poll(struct file *file, poll_table *wait)
+{
+	int line = MINOR(file->f_path.dentry->d_inode->i_rdev);
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+	unsigned int mask = POLLOUT | POLLWRNORM;
+
+
+	do
+	{
+		if (line > SUNIX_SDC_SPI_MAX)
+		{
+			mask = -ENODEV;
+			break;
+		}
+		spi_chl = &sunix_sdc_spi_table[line];
+		if (spi_chl->info.memsize == 0)
+		{
+			mask = -ENODEV;
+			break;
+		}
+		if (spi_chl->isOpened == false)
+		{
+			mask = -ENODEV;
+			break;
+		}
+
+
+		down(&spi_chl->sem);
+
+		poll_wait(file, &spi_chl->readWQ, wait);
+
+		if (spi_chl->readDataReady == 1)
+		{
+			mask |= (POLLIN | POLLRDNORM);
+		}
+
+		up(&spi_chl->sem);
+
+	} while (false);
+
+	return mask;
+}
+
+
+static int sunix_spi_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	add_uevent_var(env, "DEVMODE=%#o", 0666);
+	return 0;
+}
+
+
+static const struct file_operations sunix_sdc_spi_fops =
+{
+	.owner				= THIS_MODULE,
+	.open				= sunix_spi_open,
+	.release			= sunix_spi_release,
+	.unlocked_ioctl		= sunix_spi_ioctl,
+	.read				= sunix_spi_read,
+	.write 				= sunix_spi_write,
+	.poll				= sunix_spi_poll
+};
+
+
+static int sunix_sdc_spi_dev_major = 0;
+static struct class *sunix_sdc_spi_dev_class = NULL;
+
+
+int sunix_spi_register_channel(void)
+{
+	int err, i;
+	dev_t dev;
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+
+
+	err = alloc_chrdev_region(&dev, 0, sunix_sdc_spi_amount, "sunix_sdc_spi");
+	if (err != 0)
+	{
+		return err;
+	}
+
+	sunix_sdc_spi_dev_major = MAJOR(dev);
+
+	sunix_sdc_spi_dev_class = class_create(THIS_MODULE, "sunix_sdc_spi");
+	sunix_sdc_spi_dev_class->dev_uevent = sunix_spi_uevent;
+
+	for (i = 0; i < sunix_sdc_spi_amount; i++)
+	{
+		spi_chl = &sunix_sdc_spi_table[i];
+		if ((spi_chl != NULL) && (spi_chl->info.membase != NULL))
+		{
+			request_mem_region(spi_chl->info.phy2_base_start + spi_chl->info.memoffset, spi_chl->info.memsize, "sunix_sdc_spi");
+
+			cdev_init(&spi_chl->cdev, &sunix_sdc_spi_fops);
+			spi_chl->cdev.owner = THIS_MODULE;
+
+			cdev_add(&spi_chl->cdev, MKDEV(sunix_sdc_spi_dev_major, i), 1);
+
+			device_create(sunix_sdc_spi_dev_class, NULL, MKDEV(sunix_sdc_spi_dev_major, i), NULL, "SDCSPI%d", i);
+		}
+	}
+
+	return 0;
+}
+
+
+void sunix_spi_unregister_channel(void)
+{
+	int i;
+	struct sunix_sdc_spi_channel *spi_chl = NULL;
+
+
+	for (i = 0; i < sunix_sdc_spi_amount; i++)
+	{
+		spi_chl = &sunix_sdc_spi_table[i];
+		if ((spi_chl != NULL) && (spi_chl->info.membase != NULL))
+		{
+			device_destroy(sunix_sdc_spi_dev_class, MKDEV(sunix_sdc_spi_dev_major, i));
+
+			release_mem_region(spi_chl->info.phy2_base_start + spi_chl->info.memoffset, spi_chl->info.memsize);
+		}
+	}
+
+	class_unregister(sunix_sdc_spi_dev_class);
+	class_destroy(sunix_sdc_spi_dev_class);
+
+	unregister_chrdev_region(MKDEV(sunix_sdc_spi_dev_major, 0), MINORMASK);
+}
+
+
+int sunix_spi_interrupt(struct sunix_sdc_spi_channel *spi_chl, unsigned int event_header)
+{
+    return 0;
+}
diff --git a/drivers/mfd/spi_pack.c b/drivers/mfd/spi_pack.c
new file mode 100644
index 000000000000..ff49e0ae94ac
--- /dev/null
+++ b/drivers/mfd/spi_pack.c
@@ -0,0 +1,1506 @@
+
+
+#include "sdc_include.h"
+
+
+static void get_info(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	struct sdc_cib * cib_info = &spi_chl->info.cib_info;
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int Address = 0;
+	int i = 0;
+
+
+	do
+	{
+		Address = spi_chl->info.phy2_base_start + spi_chl->info.memoffset;
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?(31 + (cib_info->spi_number_of_device * 12)):0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		memcpy(&TrBuff[TrLength], spi_chl->info.model_name, 16);
+		TrLength += 16;
+		TrBuff[TrLength++] = spi_chl->info.bus_number;
+		TrBuff[TrLength++] = spi_chl->info.dev_number;
+		TrBuff[TrLength++] = spi_chl->info.line;
+		TrBuff[TrLength++] = (unsigned char)((Address & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((Address & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((Address & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((Address & 0x000000ff));
+		TrBuff[TrLength++] = (unsigned char)(spi_chl->info.irq);
+
+		TrBuff[TrLength++] = cib_info->version;
+		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0x000000ff));
+		TrBuff[TrLength++] = cib_info->spi_exponent_of_clock;
+		TrBuff[TrLength++] = cib_info->spi_number_of_device;
+
+		for (i = 0; i < cib_info->spi_number_of_device; i++)
+		{
+			TrBuff[TrLength++] = i;
+			TrBuff[TrLength++] = cib_info->spi_device_cap[i].type;
+			TrBuff[TrLength++] = cib_info->spi_device_cap[i].number_of_gpio_input;
+			TrBuff[TrLength++] = cib_info->spi_device_cap[i].number_of_gpio_output;
+			memcpy(&TrBuff[TrLength], cib_info->spi_device_cap[i].name, 8);
+			TrLength += 8;
+		}
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_basic_ctrl(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BasicCtrl = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 0);
+		//printk("SUNIX: SPI (%d), get basic ctrl, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		BasicCtrl = (CtrlReg & 0x000000ff);
+		//printk("SUNIX: SPI (%d), get basic ctrl, 2, BasicCtrl:x%02x\n", spi_chl->info.line, BasicCtrl);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?1:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = BasicCtrl;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_basic_ctrl(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char BasicCtrl = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		BasicCtrl = (unsigned char)*(RxBuff + sizeof(SPI_HEADER) + 0);
+		//printk("SUNIX: SPI (%d), set basic ctrl, BasicCtrl:x%02x\n", spi_chl->info.line, BasicCtrl);
+
+
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 0);
+		//printk("SUNIX: SPI (%d), set basic ctrl, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg &= 0xffffff00;
+		//printk("SUNIX: SPI (%d), set basic ctrl, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg |= BasicCtrl;
+		//printk("SUNIX: SPI (%d), set basic ctrl, 3, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 0, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_mode_ctrl(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char ModeCtrl = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 0);
+		//printk("SUNIX: SPI (%d), get mode ctrl, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		ModeCtrl = ((CtrlReg & 0x0000ff00) >> 8);
+		//printk("SUNIX: SPI (%d), get mode ctrl, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?1:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = ModeCtrl;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_mode_ctrl(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char ModeCtrl = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		ModeCtrl = (unsigned char)*(RxBuff + sizeof(SPI_HEADER) + 0);
+		//printk("SUNIX: SPI (%d), set mode ctrl, ModeCtrl:x%02x\n", spi_chl->info.line, ModeCtrl);
+
+
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 0);
+		//printk("SUNIX: SPI (%d), set mode ctrl, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg &= 0xffff00ff;
+		//printk("SUNIX: SPI (%d), set mode ctrl, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg |= (ModeCtrl << 8);
+		//printk("SUNIX: SPI (%d), set mode ctrl, 3, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 0, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_divisor(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned short Divisor = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 0);
+		//printk("SUNIX: SPI (%d), get divisor, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		Divisor = ((CtrlReg & 0xffff0000) >> 16);
+		//printk("SUNIX: SPI (%d), get divisor, 2, Divisor:x%04x\n", spi_chl->info.line, Divisor);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?2:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((Divisor & 0xff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((Divisor & 0x00ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_divisor(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned short Divisor = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 2)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		Divisor  = (unsigned short)(*(RxBuff + sizeof(SPI_HEADER) + 0) << 8);
+		Divisor |= (unsigned short)(*(RxBuff + sizeof(SPI_HEADER) + 1));
+		//printk("SUNIX: SPI (%d), set divisor, Divisor:x%04x\n", spi_chl->info.line, Divisor);
+
+
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 0);
+		//printk("SUNIX: SPI (%d), set divisor, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg &= 0x0000ffff;
+		//printk("SUNIX: SPI (%d), set divisor, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg |= (Divisor << 16);
+		//printk("SUNIX: SPI (%d), set divisor, 3, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 0, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_status(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char Status = 0;
+	unsigned int StatusReg = 0;
+
+
+	do
+	{
+		StatusReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 1);
+		//printk("SUNIX: SPI (%d), get status, 1, StatusReg:x%08x\n", spi_chl->info.line, StatusReg);
+		Status = (StatusReg & 0x000000ff);
+		//printk("SUNIX: SPI (%d), get status, 2, Status:x%02x\n", spi_chl->info.line, Status);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?1:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = Status;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_CS_SCLK_setup_delay_time_unit(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char TimeUnit = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 2);
+		//printk("SUNIX: SPI (%d), get CS/SCLK setup delay time unit, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		TimeUnit = (CtrlReg & 0x000000ff);
+		//printk("SUNIX: SPI (%d), get CS/SCLK setup delay time unit, 2, TimeUnit:x%02x\n", spi_chl->info.line, TimeUnit);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?1:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = TimeUnit;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_CS_SCLK_setup_delay_time_unit(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char TimeUnit = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		TimeUnit = (unsigned char)*(RxBuff + sizeof(SPI_HEADER) + 0);
+		//printk("SUNIX: SPI (%d), set CS/SCLK setup delay time unit, TimeUnit:x%02x\n", spi_chl->info.line, TimeUnit);
+
+
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 2);
+		//printk("SUNIX: SPI (%d), set CS/SCLK setup delay time unit, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg &= 0xffffff00;
+		//printk("SUNIX: SPI (%d), set CS/SCLK setup delay time unit, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg |= TimeUnit;
+		//printk("SUNIX: SPI (%d), set CS/SCLK setup delay time unit, 3, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 2, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_CS_SCLK_hold_delay_time_unit(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char TimeUnit = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 2);
+		//printk("SUNIX: SPI (%d), get CS/SCLK hold delay time unit, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		TimeUnit = ((CtrlReg & 0x0000ff00) >> 8);
+		//printk("SUNIX: SPI (%d), get CS/SCLK hold delay time unit, 2, TimeUnit:x%02x\n", spi_chl->info.line, TimeUnit);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?1:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = TimeUnit;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_CS_SCLK_hold_delay_time_unit(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char TimeUnit = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		TimeUnit = (unsigned char)*(RxBuff + sizeof(SPI_HEADER) + 0);
+		//printk("SUNIX: SPI (%d), set CS/SCLK hold delay time unit, TimeUnit:x%02x\n", spi_chl->info.line, TimeUnit);
+
+
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 2);
+		//printk("SUNIX: SPI (%d), set CS/SCLK hold delay time unit, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg &= 0xffff00ff;
+		//printk("SUNIX: SPI (%d), set CS/SCLK hold delay time unit, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg |= (TimeUnit << 8);
+		//printk("SUNIX: SPI (%d), set CS/SCLK hold delay time unit, 3, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 2, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_quiet_delay_time_unit(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char TimeUnit = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 2);
+		//printk("SUNIX: SPI (%d), get quiet delay time unit, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		TimeUnit = ((CtrlReg & 0x00ff0000) >> 16);
+		//printk("SUNIX: SPI (%d), get quiet delay time unit, 2, TimeUnit:x%02x\n", spi_chl->info.line, TimeUnit);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?1:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = TimeUnit;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_quiet_delay_time_unit(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned char TimeUnit = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 1)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		TimeUnit = (unsigned char)*(RxBuff + sizeof(SPI_HEADER) + 0);
+		//printk("SUNIX: SPI (%d), set quiet delay time unit, TimeUnit:x%02x\n", spi_chl->info.line, TimeUnit);
+
+
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 2);
+		//printk("SUNIX: SPI (%d), set quiet delay time unit, 1, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg &= 0xff00ffff;
+		//printk("SUNIX: SPI (%d), set quiet delay time unit, 2, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+		CtrlReg |= (TimeUnit << 16);
+		//printk("SUNIX: SPI (%d), set quiet delay time unit, 3, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 2, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_port_irq_enable_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 3);
+		//printk("SUNIX: SPI (%d), get port irq enable reg, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?4:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x000000ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_port_irq_enable_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 4)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		CtrlReg  =  (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 0) << 24);
+		CtrlReg |=  (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 1) << 16);
+		CtrlReg |=  (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 2) << 8);
+		CtrlReg |=  (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 3));
+		//printk("SUNIX: SPI (%d), set port irq enable reg, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 3, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_port_irq_status_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int StatusReg = 0;
+
+
+	do
+	{
+		StatusReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 4);
+		//printk("SUNIX: SPI (%d), get port irq status reg, StatusReg:x%08x\n", spi_chl->info.line, StatusReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?4:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((StatusReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((StatusReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((StatusReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((StatusReg & 0x000000ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void get_gpio_output_write_enable_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 5);
+		//printk("SUNIX: SPI (%d), get gpio output write enable reg, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?4:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x000000ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_gpio_output_write_enable_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 4)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		CtrlReg  = (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 0) << 24);
+		CtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 1) << 16);
+		CtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 2) << 8);
+		CtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 3));
+		//printk("SUNIX: SPI (%d), set gpio output write enable reg, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 5, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_gpio_output_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		CtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 6);
+		//printk("SUNIX: SPI (%d), get gpio output reg, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?4:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((CtrlReg & 0x000000ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_gpio_output_reg(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int CtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 4)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		CtrlReg  = (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 0) << 24);
+		CtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 1) << 16);
+		CtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 2) << 8);
+		CtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 3));
+		//printk("SUNIX: SPI (%d), set gpio output reg, CtrlReg:x%08x\n", spi_chl->info.line, CtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 6, CtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_transcation_ctrl_reg0(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int TransCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 0)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+
+
+		TransCtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 7);
+		//printk("SUNIX: SPI (%d), get transcation ctrl reg0, TransCtrlReg:x%08x\n", spi_chl->info.line, TransCtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?4:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0x000000ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_transcation_ctrl_reg0(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int TransCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 4)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		TransCtrlReg  = (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 0) << 24);
+		TransCtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 1) << 16);
+		TransCtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 2) << 8);
+		TransCtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 3));
+		//printk("SUNIX: SPI (%d), set transcation ctrl reg0, TransCtrlReg:x%08x\n", spi_chl->info.line, TransCtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 7, TransCtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_transcation_ctrl_reg1(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int TransCtrlReg = 0;
+
+
+	do
+	{
+		TransCtrlReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, 8);
+		//printk("SUNIX: SPI (%d), get transcation ctrl reg1, TransCtrlReg:x%08x\n", spi_chl->info.line, TransCtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?4:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0xff000000) >> 24);
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0x00ff0000) >> 16);
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0x0000ff00) >> 8);
+		TrBuff[TrLength++] = (unsigned char)((TransCtrlReg & 0x000000ff));
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_transcation_ctrl_reg1(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int TransCtrlReg = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length != 4)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+		TransCtrlReg  = (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 0) << 24);
+		TransCtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 1) << 16);
+		TransCtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 2) << 8);
+		TransCtrlReg |= (unsigned int)(*(RxBuff + sizeof(SPI_HEADER) + 3));
+		//printk("SUNIX: SPI (%d), set transcation ctrl reg1, TransCtrlReg:x%08x\n", spi_chl->info.line, TransCtrlReg);
+
+		mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, 8, TransCtrlReg);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void get_ram(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int RamReg = 0;
+	unsigned int RamRegIndex = 0;
+	unsigned char Data[SPI_MAX_DATA_LENGTH] = {0};
+	int DataIndex = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length > SPI_MAX_DATA_LENGTH)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+
+
+		for (RamRegIndex = 128; RamRegIndex <= 255; RamRegIndex++)
+		{
+			RamReg = mem_rx32(spi_chl->info.membase, spi_chl->info.memoffset, RamRegIndex);
+			//printk("SUNIX: SPI (%d), get ram, RamRegIndex:%d, RamReg:x%08x\n", spi_chl->info.line, RamRegIndex, RamReg);
+			Data[DataIndex++] = (RamReg & 0x000000ff);
+			if (DataIndex >= pRxHeader->Length)
+			{
+				break;
+			}
+			Data[DataIndex++] = ((RamReg & 0x0000ff00) >> 8);
+			if (DataIndex >= pRxHeader->Length)
+			{
+				break;
+			}
+			Data[DataIndex++] = ((RamReg & 0x00ff0000) >> 16);
+			if (DataIndex >= pRxHeader->Length)
+			{
+				break;
+			}
+			Data[DataIndex++] = ((RamReg & 0xff000000) >> 24);
+			if (DataIndex >= pRxHeader->Length)
+			{
+				break;
+			}
+		}
+		//printk("SUNIX: SPI (%d), get ram, DataIndex:%d\n", spi_chl->info.line, DataIndex);
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?DataIndex:0;
+	TrLength = sizeof(SPI_HEADER);
+	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)
+	{
+		memcpy(&TrBuff[TrLength], Data, DataIndex);
+		TrLength += DataIndex;
+	}
+
+	*translateLength = TrLength;
+}
+
+
+static void set_ram(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	unsigned char * RxBuff = spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_STATUS_SUCCESS;
+	unsigned int TrLength = 0;
+	unsigned int RamReg = 0;
+	unsigned int RamRegIndex = 0;
+	unsigned char Data[SPI_MAX_DATA_LENGTH] = {0};
+	int DataIndex = 0, i = 0;
+	unsigned int LengthInDw = 0;
+
+
+	do
+	{
+		if (pRxHeader->Length > SPI_MAX_DATA_LENGTH)
+		{
+			nStatus = SDCSPI_LENGTH_INVALID;
+			break;
+		}
+
+
+		memcpy(Data, RxBuff + sizeof(SPI_HEADER), pRxHeader->Length);
+
+		if ((pRxHeader->Length % 4) != 0)
+		{
+			LengthInDw = (pRxHeader->Length / 4) + 1;
+		}
+		else
+		{
+			LengthInDw = (pRxHeader->Length / 4);
+		}
+		//printk("SUNIX: SPI (%d), set ram, Length:%d, LengthInDw:%d\n", spi_chl->info.line, pRxHeader->Length, LengthInDw);
+
+		DataIndex = 0;
+		RamRegIndex = 128;
+		for (i = 0; i < LengthInDw; i++)
+		{
+			RamReg  = Data[DataIndex++];
+			RamReg |= (Data[DataIndex++] << 8);
+			RamReg |= (Data[DataIndex++] << 16);
+			RamReg |= (Data[DataIndex++] << 24);
+
+			//printk("SUNIX: SPI (%d), set ram, RamRegIndex:%d, RamReg:x%08x\n", spi_chl->info.line, RamRegIndex, RamReg);
+			mem_tx32(spi_chl->info.membase, spi_chl->info.memoffset, RamRegIndex, RamReg);
+			RamRegIndex++;
+		}
+
+	} while (false);
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?0:0;
+	TrLength = sizeof(SPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+static void unsupport(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
+{
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	unsigned int nStatus = SDCSPI_UNSUPPORT_COMMAND;
+	unsigned int TrLength = 0;
+
+
+	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
+	TrLength = 0;
+
+	pTrHeader->Version = 0x01;
+	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
+	pTrHeader->ResponseStatus = nStatus;
+	pTrHeader->Length = 0;
+	TrLength = sizeof(PSPI_HEADER);
+
+	*translateLength = TrLength;
+}
+
+
+int sunix_spi_handle_outcome(struct sunix_sdc_spi_channel *spi_chl, size_t count, unsigned int * outcomeLength)
+{
+	int status = 0;
+	PSPI_PACKAGE pPack = NULL;
+	DLIST *	pListHead = &spi_chl->packList;
+	DLIST * e = NULL;
+	unsigned char * TxBuff = spi_chl->outcomeBuff;
+	unsigned int TrLength = 0;
+
+
+	do
+	{
+		do
+		{
+			if (!SxxListEmpty(pListHead))
+			{
+				e = pListHead->Flink;
+			}
+			else
+			{
+				break;
+			}
+
+			while ((e != NULL) && (e != pListHead))
+			{
+				if (e != NULL)
+				{
+					pPack = SUNIX_SDC_SPI_PACK_PTR(e);
+					if (pPack != NULL)
+					{
+						break;
+					}
+
+					e = e->Flink;
+				}
+			}
+
+		} while (false);
+
+		if (pPack == NULL)
+		{
+			*outcomeLength = 0;
+			break;
+		}
+
+
+		SxxListRemoveEntry(&pPack->Entry);
+
+
+		memset(TxBuff, 0, SUNIX_SDC_SPI_BUFF);
+		memcpy(TxBuff, &pPack->Header, sizeof(SPI_HEADER));
+		TrLength = sizeof(SPI_HEADER);
+		if (pPack->DataPtr != NULL)
+		{
+			memcpy(TxBuff + sizeof(SPI_HEADER), pPack->DataPtr, pPack->Header.Length);
+			TrLength += pPack->Header.Length;
+		}
+
+		*outcomeLength = TrLength;
+
+		//printk("SUNIX: SPI FREE pack, line:%d, pack:x%p, DataPtrx%p\n", spi_chl->info.line, pPack, pPack->DataPtr);
+		if (pPack->DataPtr != NULL)
+		{
+			kfree(pPack->DataPtr);
+			pPack->DataPtr = NULL;
+		}
+		kmem_cache_free(sunix_sdc_spi_pack_cache, pPack);
+		pPack = NULL;
+			
+	} while (false);
+
+	return status;
+}
+
+
+int sunix_spi_handle_income(struct sunix_sdc_spi_channel *spi_chl, size_t count)
+{
+	int status = 0;
+	PSPI_HEADER pRxHeader = (PSPI_HEADER)spi_chl->incomeBuff;
+	PSPI_HEADER pTrHeader = (PSPI_HEADER)spi_chl->translateBuff;
+	unsigned char * TrBuff = spi_chl->translateBuff;
+	PSPI_PACKAGE pPack = NULL;
+	unsigned int translateLength = 0;
+	unsigned long Flags;
+
+
+	do
+	{
+		// debug
+		/*
+		printk("++++++++++++++++++++++++++++++++++++++++++++++\n");
+		printk("SUNIX: SPI_RX, Version              :x%02x\n", pRxHeader->Version);
+		printk("SUNIX: SPI_RX, CmdResponseEventData :x%04x\n", pRxHeader->CmdResponseEventData);
+		printk("SUNIX: SPI_RX, Length               :x%08x\n", pRxHeader->Length);
+		printk("++++++++++++++++++++++++++++++++++++++++++++++\n");
+		*/
+
+
+		switch (pRxHeader->CmdResponseEventData)
+		{
+			case SDCSPI_CMD_GET_INFO :
+				get_info(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_BASIC_CTRL :
+				get_basic_ctrl(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_BASIC_CTRL :
+				set_basic_ctrl(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_MODE_CTRL :
+				get_mode_ctrl(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_MODE_CTRL :
+				set_mode_ctrl(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_DIVISOR :
+				get_divisor(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_DIVISOR :
+				set_divisor(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_STATUS :
+				get_status(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_CS_SCLK_SETUP_DELAY_TIME_UNIT :
+				get_CS_SCLK_setup_delay_time_unit(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_CS_SCLK_SETUP_DELAY_TIME_UNIT :
+				set_CS_SCLK_setup_delay_time_unit(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_CS_SCLK_HOLD_DELAY_TIME_UNIT :
+				get_CS_SCLK_hold_delay_time_unit(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_CS_SCLK_HOLD_DELAY_TIME_UNIT :
+				set_CS_SCLK_hold_delay_time_unit(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_QUIET_DELAY_TIME_UNIT :
+				get_quiet_delay_time_unit(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_QUIET_DELAY_TIME_UNIT :
+				set_quiet_delay_time_unit(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_PORT_IRQ_ENABLE_REG :
+				get_port_irq_enable_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_PORT_IRQ_ENABLE_REG :
+				set_port_irq_enable_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_PORT_IRQ_STATUS_REG :
+				get_port_irq_status_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_GPIO_OUTPUT_WRITE_ENABLE_REG :
+				get_gpio_output_write_enable_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_GPIO_OUTPUT_WRITE_ENABLE_REG :
+				set_gpio_output_write_enable_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_GPIO_OUTPUT_REG :
+				get_gpio_output_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_GPIO_OUTPUT_REG :
+				set_gpio_output_reg(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_TRANSCATION_CTRL_REG0 :
+				get_transcation_ctrl_reg0(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_TRANSCATION_CTRL_REG0 :
+				set_transcation_ctrl_reg0(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_TRANSCATION_CTRL_REG1 :
+				get_transcation_ctrl_reg1(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_TRANSCATION_CTRL_REG1 :
+				set_transcation_ctrl_reg1(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_PORT_EXTEND_CTRL_REG0 :
+				unsupport(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_PORT_EXTEND_CTRL_REG0 :
+				unsupport(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_PORT_EXTEND_CTRL_REG1 :
+				unsupport(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_PORT_EXTEND_CTRL_REG1 :
+				unsupport(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_GET_RAM :
+				get_ram(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			case SDCSPI_CMD_SET_RAM :
+				set_ram(spi_chl, (unsigned int)count, &translateLength);
+				break;
+
+			default :
+				unsupport(spi_chl, (unsigned int)count, &translateLength);
+				break;
+		}
+
+
+		// debug
+		/*
+		printk("----------------------------------------------\n");
+		printk("SUNIX: SPI_TR, translateLength      :%d\n", translateLength);
+		printk("SUNIX: SPI_TR, Version              :x%02x\n", pTrHeader->Version);
+		printk("SUNIX: SPI_TR, CmdResponseEventData :x%04x\n", pTrHeader->CmdResponseEventData);
+		printk("SUNIX: SPI_TR, ResponseStatus       :x%04x\n", pTrHeader->ResponseStatus);
+		printk("SUNIX: SPI_TR, Length               :x%08x\n", pTrHeader->Length);
+		{
+			int i;
+			for (i = 0; i < pTrHeader->Length; i++)
+				printk("x%02x ", (unsigned char)*(TrBuff + sizeof(SPI_HEADER) + i));
+		}
+		printk("----------------------------------------------\n");
+		*/
+
+
+		if (pTrHeader->Length > SPI_MAX_DATA_LENGTH)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		if (translateLength > (SPI_MAX_DATA_LENGTH + sizeof(SPI_HEADER)))
+		{
+			status = -ENOMEM;
+			break;
+		}
+
+		pPack = kmem_cache_alloc(sunix_sdc_spi_pack_cache, GFP_ATOMIC);
+		if (pPack == NULL)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		memset(pPack, 0, sizeof(SPI_PACKAGE));
+		pPack->DataPtr = (unsigned char *)kmalloc(SPI_MAX_DATA_LENGTH, GFP_KERNEL);
+		if (pPack->DataPtr == NULL)
+		{
+			status = -ENOMEM;
+			break;
+		}
+		memset(pPack->DataPtr, 0, SPI_MAX_DATA_LENGTH);
+
+
+		SxxListInit(&pPack->Entry);
+		memcpy(&pPack->Header, pTrHeader, sizeof(SPI_HEADER));
+		memcpy(pPack->DataPtr, TrBuff + sizeof(SPI_HEADER), pTrHeader->Length);
+
+		spin_lock_irqsave(&spi_chl->packLock, Flags);
+		//printk("SUNIX: SPI ALOC pack, line:%d, pack:x%p, DataPtrx%p\n", spi_chl->info.line, pPack, pPack->DataPtr);
+		SxxListInsertTail(&spi_chl->packList, &pPack->Entry);
+
+		spi_chl->readDataReady = 1;
+		wake_up_interruptible(&spi_chl->readWQ);
+		spin_unlock_irqrestore(&spi_chl->packLock, Flags);
+
+	} while (false);
+
+	if (status != 0)
+	{
+		if (pPack != NULL)
+		{
+			if (pPack->DataPtr != NULL)
+			{
+				kfree(pPack->DataPtr);
+				pPack->DataPtr = NULL;
+			}
+
+			kmem_cache_free(sunix_sdc_spi_pack_cache, pPack);
+		}
+	}
+
+	return status;
+}
+
+
diff --git a/drivers/mfd/uart.c b/drivers/mfd/uart.c
new file mode 100644
index 000000000000..bb88630fdca1
--- /dev/null
+++ b/drivers/mfd/uart.c
@@ -0,0 +1,3796 @@
+
+
+#include "sdc_include.h"
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37))
+static DEFINE_SEMAPHORE(ser_port_sem);
+#else
+static DECLARE_MUTEX(ser_port_sem);
+#endif
+
+
+#define SNX_HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
+#define sunix_ser_users(state)	((state)->count + ((state)->info ? (state)->info->blocked_open : 0))
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+static struct tty_port snx_service_port;
+#endif
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+struct serial_uart_config
+{
+	char	*name;
+	int		dfl_xmit_fifo_size;
+	int		flags;
+};
+#endif
+
+
+static const struct serial_uart_config snx_uart_config[PORT_SER_MAX_UART + 1] =
+{
+	{ "unknown",    1,      0 },
+	{ "8250",       1,      0 },
+	{ "16450",      1,      0 },
+	{ "16550",      1,      0 },
+	{ "16550A",     16,     UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "Cirrus",     1,    	0 },
+	{ "ST16650",    1,    	0 },
+	{ "ST16650V2",  32,    	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "TI16750",    64,    	UART_CLEAR_FIFO | UART_USE_FIFO },
+};
+
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0))
+static int		sunix_ser_refcount;
+static struct tty_struct			*sunix_ser_tty[SUNIX_SDC_UART_MAX + 1];
+static struct termios				*sunix_ser_termios[SUNIX_SDC_UART_MAX + 1];
+static struct termios				*sunix_ser_termios_locked[SUNIX_SDC_UART_MAX + 1];
+#endif
+
+
+static _INLINE_ void snx_ser_handle_cts_change(struct snx_ser_port *, unsigned int);
+static _INLINE_ void snx_ser_update_mctrl(struct snx_ser_port *, unsigned int, unsigned int);
+static void     snx_ser_write_wakeup(struct snx_ser_port *);
+static void     snx_ser_stop(struct tty_struct *);
+static void     __snx_ser_start(struct tty_struct *);
+static void     snx_ser_start(struct tty_struct *);
+static void     snx_ser_tasklet_action(unsigned long);
+
+
+static void     snx_ser_shutdown(struct snx_ser_state *);
+static _INLINE_ void __snx_ser_put_char(struct snx_ser_port *, struct circ_buf *, unsigned char);
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 26))
+static int      snx_ser_put_char(struct tty_struct *, unsigned char);
+#else
+static void     snx_ser_put_char(struct tty_struct *, unsigned char);
+#endif
+static void     snx_ser_flush_chars(struct tty_struct *);
+static int      snx_ser_chars_in_buffer(struct tty_struct *);
+static void     snx_ser_flush_buffer(struct tty_struct *);
+static void     snx_ser_send_xchar(struct tty_struct *, char);
+static void     snx_ser_throttle(struct tty_struct *);
+static void     snx_ser_unthrottle(struct tty_struct *);
+static int      snx_ser_get_info(struct snx_ser_state *, struct serial_struct *);
+static int      snx_ser_set_info(struct snx_ser_state *, struct serial_struct *);
+static int      snx_ser_write_room(struct tty_struct *);
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10))
+static int      snx_ser_write(struct tty_struct *, const unsigned char *, int);
+#else
+static int      snx_ser_write(struct tty_struct *, int, const unsigned char *, int);
+#endif
+static int      snx_ser_get_lsr_info(struct snx_ser_state *, unsigned int *);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 39))
+static int      snx_ser_tiocmget(struct tty_struct *);
+static int      snx_ser_tiocmset(struct tty_struct *, unsigned int, unsigned int);
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+static int      snx_ser_tiocmget(struct tty_struct *, struct file *);
+static int      snx_ser_tiocmset(struct tty_struct *, struct file *, unsigned int, unsigned int);
+#else
+static int      snx_ser_get_modem_info(struct snx_ser_state *, unsigned int *);
+static int      snx_ser_set_modem_info(struct snx_ser_state *, unsigned int, unsigned int *);
+#endif
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27))
+static int      snx_ser_break_ctl(struct tty_struct *, int);
+#else
+static void     snx_ser_break_ctl(struct tty_struct *, int);
+#endif
+static int      snx_ser_wait_modem_status(struct snx_ser_state *, unsigned long);
+static int      snx_ser_get_count(struct snx_ser_state *, struct serial_icounter_struct *);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 39))
+static int      snx_ser_ioctl(struct tty_struct *, unsigned int, unsigned long);
+#else
+static int      snx_ser_ioctl(struct tty_struct *, struct file *, unsigned int, unsigned long);
+#endif
+
+static void     snx_ser_hangup(struct tty_struct *);
+unsigned int    snx_ser_get_divisor(struct snx_ser_port *, unsigned int);
+extern void     snx_ser_change_speed(struct snx_ser_state *, struct SNXTERMIOS *);
+static void     snx_ser_set_termios(struct tty_struct *, struct SNXTERMIOS *);
+
+static void     snx_ser_update_timeout(struct snx_ser_port *, unsigned int, unsigned int);
+static struct   snx_ser_state *snx_ser_get(struct snx_ser_driver *, int);
+static int      snx_ser_block_til_ready(struct file *, struct snx_ser_state *);
+static void     snx_ser_wait_until_sent(struct tty_struct *, int);
+static int      snx_ser_open(struct tty_struct *, struct file *);
+static void     snx_ser_close(struct tty_struct *, struct file *);
+
+
+static void         sunix_ser_set_mctrl(struct snx_ser_port *, unsigned int);
+static unsigned int sunix_ser_tx_empty(struct snx_ser_port *);
+static unsigned int sunix_ser_get_mctrl(struct snx_ser_port *);
+static void         sunix_ser_stop_tx(struct snx_ser_port *, unsigned int);
+static void         sunix_ser_start_tx(struct snx_ser_port *, unsigned int);
+static void         sunix_ser_stop_rx(struct snx_ser_port *);
+static void         sunix_ser_enable_ms(struct snx_ser_port *);
+static void         sunix_ser_break_ctl(struct snx_ser_port *, int);
+static int          sunix_ser_startup(struct snx_ser_port *);
+static void         sunix_ser_shutdown(struct snx_ser_port *);
+static unsigned int sunix_ser_get_divisor(struct snx_ser_port *, unsigned int);
+static void         sunix_ser_set_termios(struct snx_ser_port *, struct SNXTERMIOS *, struct SNXTERMIOS *);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0))
+	static void sunix_ser_timeout(struct timer_list *t);
+#else
+	static void sunix_ser_timeout(unsigned long data);
+#endif
+
+
+static _INLINE_ void sunix_ser_receive_chars(struct sunix_sdc_uart_channel *, unsigned char *);
+static _INLINE_ void sunix_ser_transmit_chars(struct sunix_sdc_uart_channel *);
+static _INLINE_ void sunix_ser_check_modem_status(struct sunix_sdc_uart_channel *, unsigned char);
+static _INLINE_ void sunix_ser_handle_port(struct sunix_sdc_uart_channel *, unsigned char);
+
+
+static void     sunix_ser_release_io(struct snx_ser_port *);
+static void     sunix_ser_request_io(struct snx_ser_port *);
+static void     sunix_ser_configure_port(struct snx_ser_driver *, struct snx_ser_state *, struct snx_ser_port *);
+static void     sunix_ser_unconfigure_port(struct snx_ser_driver *, struct snx_ser_state *);
+static int      sunix_ser_add_one_port(struct snx_ser_driver *, struct snx_ser_port *);
+static int      sunix_ser_remove_one_port(struct snx_ser_driver *, struct snx_ser_port *);
+
+
+static unsigned char READ_UART_RX(struct sunix_sdc_uart_channel *);
+static unsigned char READ_UART_IIR(struct sunix_sdc_uart_channel *);
+static unsigned char READ_UART_LCR(struct sunix_sdc_uart_channel *);
+static unsigned char READ_UART_LSR(struct sunix_sdc_uart_channel *);
+static unsigned char READ_UART_MSR(struct sunix_sdc_uart_channel *);
+static void WRITE_UART_TX(struct sunix_sdc_uart_channel *, unsigned char);
+static void WRITE_UART_IER(struct sunix_sdc_uart_channel *, unsigned char);
+static void WRITE_UART_FCR(struct sunix_sdc_uart_channel *, unsigned char);
+static void WRITE_UART_LCR(struct sunix_sdc_uart_channel *, unsigned char);
+static void WRITE_UART_MCR(struct sunix_sdc_uart_channel *, unsigned char);
+static void WRITE_UART_DLL(struct sunix_sdc_uart_channel *, int);
+static void WRITE_UART_DLM(struct sunix_sdc_uart_channel *, int);
+
+
+static void snx_ser_insert_char(struct snx_ser_port *port, unsigned int status, unsigned int overrun, unsigned int ch, unsigned int flag)
+{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+	struct snx_ser_info *info = port->info;
+    struct tty_struct *tty = info->tty;
+    struct snx_ser_state *state = NULL;
+    struct tty_port *tport = NULL;
+
+
+	state = tty->driver_data;
+	tport = &state->tport;
+#else
+	struct tty_struct *tty = port->info->tty;
+#endif
+
+	if ((status & port->ignore_status_mask & ~overrun) == 0)
+	{
+#if	(LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+		if (tty_insert_flip_char(tport, ch, flag) == 0)
+		{
+				++port->icount.buf_overrun;			
+		}		
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 6, 0))
+		if (tty_insert_flip_char(tty, ch, flag) == 0)
+			++port->icount.buf_overrun;
+#else
+		tty_insert_flip_char(tty, ch, flag);	
+#endif
+    }
+
+
+	if (status & ~port->ignore_status_mask & overrun)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+		if (tty_insert_flip_char(tport, 0, TTY_OVERRUN) == 0)
+		{
+			++port->icount.buf_overrun;
+		}		
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 6, 0))
+		if (tty_insert_flip_char(tty, 0, TTY_OVERRUN) == 0)
+			++port->icount.buf_overrun;
+#else
+		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+#endif
+    }
+}
+
+
+static unsigned char READ_UART_RX(struct sunix_sdc_uart_channel *sp)
+{
+	unsigned char data;
+
+
+	if (sp->port.iobase)
+	{
+		data = inb(sp->port.iobase + UART_RX);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_TX(struct sunix_sdc_uart_channel *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_TX);
+	}
+}
+
+
+static void WRITE_UART_IER(struct sunix_sdc_uart_channel *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_IER);
+	}
+}
+
+
+static unsigned char READ_UART_IIR(struct sunix_sdc_uart_channel *sp)
+{
+	unsigned char data;
+
+
+	if (sp->port.iobase)
+	{
+		data = inb(sp->port.iobase + UART_IIR);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_FCR(struct sunix_sdc_uart_channel *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_FCR);
+	}
+}
+
+
+static unsigned char READ_UART_LCR(struct sunix_sdc_uart_channel *sp)
+{
+	unsigned char data;
+
+
+	if (sp->port.iobase)
+	{
+		data = inb(sp->port.iobase + UART_LCR);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_LCR(struct sunix_sdc_uart_channel *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_LCR);
+	}
+}
+
+
+static void WRITE_UART_MCR(struct sunix_sdc_uart_channel *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_MCR);
+	}
+}
+
+
+static unsigned char READ_UART_LSR(struct sunix_sdc_uart_channel *sp)
+{
+	unsigned char data;
+
+
+	if (sp->port.iobase)
+	{
+		data = inb(sp->port.iobase + UART_LSR);
+		return data;
+	}
+	return 0;
+}
+
+
+static unsigned char READ_UART_MSR(struct sunix_sdc_uart_channel *sp)
+{
+	unsigned char data;
+
+
+	if (sp->port.iobase)
+	{
+		data = inb(sp->port.iobase + UART_MSR);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_DLL(struct sunix_sdc_uart_channel *sp, int data)
+{
+    if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_DLL);
+    }
+}
+
+
+static void WRITE_UART_DLM(struct sunix_sdc_uart_channel *sp, int data)
+{
+	if (sp->port.iobase)
+	{
+		outb(data, sp->port.iobase + UART_DLM);
+	}
+}
+
+
+static _INLINE_ void snx_ser_handle_cts_change(struct snx_ser_port *port, unsigned int status)
+{
+	struct snx_ser_info *info = port->info;
+	struct tty_struct *tty = info->tty;
+
+
+	port->icount.cts++;
+
+	if (info->flags & SNX_UIF_CTS_FLOW)
+	{
+		if (tty->hw_stopped)
+		{
+			if (status)
+			{
+				tty->hw_stopped = 0;
+				sunix_ser_start_tx(port, 0);
+				snx_ser_write_wakeup(port);
+			}
+		}
+		else
+		{
+			if (!status)
+			{
+				tty->hw_stopped = 1;
+				sunix_ser_stop_tx(port, 0);
+			}
+		}
+	}
+}
+
+
+static _INLINE_ void snx_ser_update_mctrl(struct snx_ser_port *port, unsigned int set, unsigned int clear)
+{
+	unsigned long flags;
+	unsigned int old;
+
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	old = port->mctrl;
+	port->mctrl = (old & ~clear) | set;
+
+	if (old != port->mctrl)
+	{
+		sunix_ser_set_mctrl(port, port->mctrl);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+
+#define snx_set_mctrl(port, set)		snx_ser_update_mctrl(port, set, 0)
+#define snx_clear_mctrl(port, clear)	snx_ser_update_mctrl(port, 0, clear)
+
+
+static void snx_ser_write_wakeup(struct snx_ser_port *port)
+{
+	struct snx_ser_info *info = port->info;
+	tasklet_schedule(&info->tlet);
+}
+
+
+static void snx_ser_stop(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long flags;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	spin_lock_irqsave(&port->lock, flags);
+	sunix_ser_stop_tx(port, 1);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+
+static void __snx_ser_start(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = tty->driver_data;
+	struct snx_ser_port *port = state->port;
+
+
+	if (!snx_ser_circ_empty(&state->info->xmit) && state->info->xmit.buf && !tty->stopped && !tty->hw_stopped)
+	{
+		sunix_ser_start_tx(port, 1);
+	}
+}
+
+
+static void snx_ser_start(struct tty_struct *tty)
+{
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	__snx_ser_start(tty);
+}
+
+
+static void snx_ser_tasklet_action(unsigned long data)
+{
+	struct snx_ser_state *state = (struct snx_ser_state *)data;
+	struct tty_struct *tty = NULL;
+
+
+	tty = state->info->tty;
+	if (tty)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 31))
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc->ops->write_wakeup)
+		{
+			tty->ldisc->ops->write_wakeup(tty);
+		}
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27) && LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 30))
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.ops->write_wakeup)
+		{
+			tty->ldisc.ops->write_wakeup(tty);
+		}
+#else
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
+		{
+			tty->ldisc.write_wakeup(tty);
+		}
+#endif
+		wake_up_interruptible(&tty->write_wait);
+    }
+}
+
+
+int snx_ser_startup(struct snx_ser_state *state, int init_hw)
+{
+	struct snx_ser_info *info = state->info;
+	struct snx_ser_port *port = state->port;
+	unsigned long page;
+	int retval = 0;
+
+
+	if (info->flags & SNX_UIF_INITIALIZED)
+	{
+		return 0;
+	}
+
+
+	if (info->tty)
+	{
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+    }
+
+
+	if (port->type == PORT_UNKNOWN)
+	{
+		return 0;
+	}
+
+
+	if (!info->xmit.buf)
+	{
+		page = get_zeroed_page(GFP_KERNEL);
+
+		if (!page)
+		{
+			return -ENOMEM;
+		}
+
+		info->xmit.buf = (unsigned char *) page;
+
+		info->tmpbuf = info->xmit.buf + SNX_UART_XMIT_SIZE;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37))
+		sema_init(&info->tmpbuf_sem, 1);
+#else
+		init_MUTEX(&info->tmpbuf_sem);
+#endif
+		snx_ser_circ_clear(&info->xmit);
+    }
+
+	retval = sunix_ser_startup(port);
+
+	if (retval == 0)
+	{
+		if (init_hw)
+		{
+			snx_ser_change_speed(state, NULL);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+			if (info->tty->termios.c_cflag & CBAUD)
+			{
+				snx_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+			}
+#else
+			if (info->tty->termios->c_cflag & CBAUD)
+			{
+				snx_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+			}
+#endif
+		}
+
+
+		info->flags |= SNX_UIF_INITIALIZED;
+
+		clear_bit(TTY_IO_ERROR, &info->tty->flags);
+	}
+
+
+    if (retval && capable(CAP_SYS_ADMIN))
+	{
+		retval = 0;
+	}
+
+	return retval;
+}
+
+
+static void snx_ser_shutdown(struct snx_ser_state *state)
+{
+	struct snx_ser_info *info = state->info;
+	struct snx_ser_port *port = state->port;
+
+
+	if (!(info->flags & SNX_UIF_INITIALIZED))
+	{
+		return;
+	}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+    if (!info->tty || (info->tty->termios.c_cflag & HUPCL))
+	{
+		snx_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+	}
+#else
+	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
+	{
+		snx_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+	}
+#endif
+
+	wake_up_interruptible(&info->delta_msr_wait);
+
+	sunix_ser_shutdown(port);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	synchronize_irq(port->irq);
+#endif
+	if (info->xmit.buf)
+	{
+		free_page((unsigned long)info->xmit.buf);
+		info->xmit.buf = NULL;
+		info->tmpbuf = NULL;
+	}
+
+	tasklet_kill(&info->tlet);
+
+	if (info->tty)
+	{
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+	}
+
+	info->flags &= ~SNX_UIF_INITIALIZED;
+}
+
+
+static _INLINE_ void __snx_ser_put_char(struct snx_ser_port *port, struct circ_buf *circ, unsigned char c)
+{
+	unsigned long flags;
+
+
+	if (!circ->buf)
+	{
+		return;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (snx_ser_circ_chars_free(circ) != 0)
+	{
+		circ->buf[circ->head] = c;
+		circ->head = (circ->head + 1) & (SNX_UART_XMIT_SIZE - 1);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 26))
+static int  snx_ser_put_char(struct tty_struct *tty, unsigned char ch)
+#else
+static void snx_ser_put_char(struct tty_struct *tty, unsigned char ch)
+#endif
+{
+	struct snx_ser_state *state = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 26))
+		return 0;
+#else
+		return;
+#endif
+	}
+
+	state = tty->driver_data;
+	__snx_ser_put_char(state->port, &state->info->xmit, ch);
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 26))
+	return 0;
+#endif
+}
+
+
+static void snx_ser_flush_chars(struct tty_struct *tty)
+{
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	snx_ser_start(tty);
+}
+
+
+static int snx_ser_chars_in_buffer(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return 0;
+	}
+
+	state = tty->driver_data;
+
+	return snx_ser_circ_chars_pending(&state->info->xmit);
+}
+
+
+static void snx_ser_flush_buffer(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long flags;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	if (!state || !state->info)
+	{
+		return;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+	snx_ser_circ_clear(&state->info->xmit);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	wake_up_interruptible(&tty->write_wait);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 31))
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc->ops->write_wakeup)
+	{
+		(tty->ldisc->ops->write_wakeup)(tty);
+	}
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27) && LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 30))
+
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.ops->write_wakeup)
+	{
+		(tty->ldisc.ops->write_wakeup)(tty);
+	}
+
+#else
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
+	{
+		(tty->ldisc.write_wakeup)(tty);
+	}
+#endif
+}
+
+
+static void snx_ser_send_xchar(struct tty_struct *tty, char ch)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long flags;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+	port->x_char = ch;
+
+	if (ch)
+	{
+		spin_lock_irqsave(&port->lock, flags);
+		sunix_ser_start_tx(port, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+
+static void snx_ser_throttle(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	port->ldisc_stop_rx = 1;
+
+	if (I_IXOFF(tty))
+	{
+		snx_ser_send_xchar(tty, STOP_CHAR(tty));
+	}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	if (tty->termios.c_cflag & CRTSCTS)
+	{
+		snx_clear_mctrl(state->port, TIOCM_RTS);
+	}
+#else
+	if (tty->termios->c_cflag & CRTSCTS)
+	{
+		snx_clear_mctrl(state->port, TIOCM_RTS);
+	}
+#endif
+}
+
+
+static void snx_ser_unthrottle(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	port->ldisc_stop_rx = 0;
+
+	if (I_IXOFF(tty))
+	{
+		if (port->x_char)
+		{
+			port->x_char = 0;
+		}
+		else
+		{
+			snx_ser_send_xchar(tty, START_CHAR(tty));
+		}
+	}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	if (tty->termios.c_cflag & CRTSCTS)
+	{
+		snx_set_mctrl(port, TIOCM_RTS);
+	}
+#else
+	if (tty->termios->c_cflag & CRTSCTS)
+	{
+		snx_set_mctrl(port, TIOCM_RTS);
+	}
+#endif
+}
+
+
+static int snx_ser_get_info(struct snx_ser_state *state, struct serial_struct *retinfo)
+{
+	struct snx_ser_port *port = state->port;
+	struct serial_struct tmp;
+
+
+	memset(&tmp, 0, sizeof(tmp));
+	tmp.type            = port->type;
+	tmp.line            = port->line;
+	tmp.port            = port->iobase;
+
+    if (SNX_HIGH_BITS_OFFSET)
+	{
+		tmp.port_high = (long) port->iobase >> SNX_HIGH_BITS_OFFSET;
+	}
+
+	tmp.irq             = port->irq;
+	tmp.flags           = port->flags;
+	tmp.xmit_fifo_size  = port->fifosize;
+	tmp.baud_base       = port->uartclk / 16;
+	tmp.close_delay     = state->close_delay;
+	tmp.closing_wait    = state->closing_wait;
+
+	tmp.custom_divisor  = port->custom_divisor;
+	tmp.io_type         = port->iotype;
+
+	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
+	{
+		return -EFAULT;
+	}
+	return 0;
+}
+
+
+static int snx_ser_set_info(struct snx_ser_state *state, struct serial_struct *newinfo)
+{
+	struct serial_struct new_serial;
+	struct snx_ser_port *port = state->port;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+	struct tty_port		*tport = &state->tport;
+#endif
+	unsigned long new_port;
+	unsigned int change_irq;
+	unsigned int change_port;
+	unsigned int old_custom_divisor;
+	unsigned int closing_wait;
+	unsigned int close_delay;
+	unsigned int old_flags;
+	unsigned int new_flags;
+	int retval = 0;
+
+
+	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
+	{
+		return -EFAULT;
+	}
+
+	new_port = new_serial.port;
+
+	if (SNX_HIGH_BITS_OFFSET)
+	{
+		new_port += (unsigned long) new_serial.port_high << SNX_HIGH_BITS_OFFSET;
+    }
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	new_serial.irq = irq_canonicalize(new_serial.irq);
+#endif
+
+	close_delay = new_serial.close_delay;
+	closing_wait = new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE ?	SNX_USF_CLOSING_WAIT_NONE : new_serial.closing_wait;
+
+	down(&state->sem);
+
+	change_irq  = new_serial.irq != port->irq;
+
+	change_port =   new_port != port->iobase ||
+					new_serial.io_type != port->iotype ||
+					new_serial.type != port->type;
+
+	old_flags = port->flags;
+	new_flags = new_serial.flags;
+	old_custom_divisor = port->custom_divisor;
+
+	if (!capable(CAP_SYS_ADMIN))
+	{
+		retval = -EPERM;
+		if (change_irq ||
+			change_port ||
+			(new_serial.baud_base != port->uartclk / 16) ||
+			(close_delay != state->close_delay) ||
+			(closing_wait != state->closing_wait) ||
+			(new_serial.xmit_fifo_size != port->fifosize) ||
+			(((new_flags ^ old_flags) & ~SNX_UPF_USR_MASK) != 0))
+		{
+			goto exit;
+		}
+
+		port->flags = ((port->flags & ~SNX_UPF_USR_MASK) | (new_flags & SNX_UPF_USR_MASK));
+		port->custom_divisor = new_serial.custom_divisor;
+		goto check_and_exit;
+	}
+
+	if (change_port || change_irq)
+	{
+		retval = -EBUSY;
+
+		if (sunix_ser_users(state) > 1)
+		{
+			goto exit;
+		}
+
+		snx_ser_shutdown(state);
+	}
+
+	if (change_port)
+	{
+		unsigned int old_type;
+		old_type = port->type;
+
+		if (old_type != PORT_UNKNOWN)
+		{
+			sunix_ser_release_io(port);
+		}
+
+		port->iobase = new_port;
+		port->type = new_serial.type;
+		port->iotype = new_serial.io_type;
+
+		retval = 0;
+	}
+
+	port->irq              = new_serial.irq;
+	port->uartclk          = new_serial.baud_base * 16;
+	port->flags            = ((port->flags & ~SNX_UPF_CHANGE_MASK) | (new_flags & SNX_UPF_CHANGE_MASK));
+	port->custom_divisor   = new_serial.custom_divisor;
+	state->close_delay     = close_delay;
+	state->closing_wait    = closing_wait;
+	port->fifosize         = new_serial.xmit_fifo_size;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+	tport->low_latency = (port->flags & SNX_UPF_LOW_LATENCY) ? 1 : 0;
+#else
+	if (state->info->tty)
+	{
+		state->info->tty->low_latency = (port->flags & SNX_UPF_LOW_LATENCY) ? 1 : 0;
+	}
+#endif
+
+
+check_and_exit:
+	retval = 0;
+	if (port->type == PORT_UNKNOWN)
+	{
+		goto exit;
+	}
+
+	if (state->info->flags & SNX_UIF_INITIALIZED)
+	{
+		if (((old_flags ^ port->flags) & SNX_UPF_SPD_MASK) || old_custom_divisor != port->custom_divisor)
+		{
+			if (port->flags & SNX_UPF_SPD_MASK)
+			{
+				printk("SUNIX: %s sets custom speed on ttySDC%d. This is deprecated.\n", current->comm, port->line);
+			}
+			snx_ser_change_speed(state, NULL);
+		}
+	}
+	else
+	{
+		retval = snx_ser_startup(state, 1);
+	}
+exit:
+
+	up(&state->sem);
+
+	return retval;
+}
+
+
+static int snx_ser_write_room(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+	int status = 0;
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return 0;
+	}
+
+    state = tty->driver_data;
+
+    status = snx_ser_circ_chars_free(&state->info->xmit);
+
+    return status;
+}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10))
+static int snx_ser_write(struct tty_struct *tty, const unsigned char *buf, int count)
+#else
+static int snx_ser_write(struct tty_struct *tty, int from_user, const unsigned char *buf, int count)
+#endif
+{
+	struct snx_ser_state *state = tty->driver_data;
+	struct circ_buf *circ = NULL;
+	struct snx_ser_port *port = state->port;
+	unsigned long flags;
+	int c;
+	int ret = 0;
+
+
+	if (!state || !state->info)
+	{
+		return -EL3HLT;
+	}
+
+	circ = &state->info->xmit;
+
+	if (!circ->buf)
+	{
+		return 0;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (1)
+	{
+		c = CIRC_SPACE_TO_END(circ->head, circ->tail, SNX_UART_XMIT_SIZE);
+		if (count < c)
+		{
+			c = count;
+		}
+
+		if (c <= 0)
+		{
+			break;
+		}
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 9))
+	memcpy(circ->buf + circ->head, buf, c);
+#else
+		if (from_user)
+		{
+			if (copy_from_user((circ->buf + circ->head), buf, c) == c)
+			{
+				ret = -EFAULT;
+				break;
+			}
+		}
+		else
+		{
+			memcpy(circ->buf + circ->head, buf, c);
+		}
+#endif
+
+
+		circ->head = (circ->head + c) & (SNX_UART_XMIT_SIZE - 1);
+		buf += c;
+		count -= c;
+		ret += c;
+    }
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	snx_ser_start(tty);
+
+	return ret;
+}
+
+
+static int snx_ser_get_lsr_info(struct snx_ser_state *state, unsigned int *value)
+{
+	struct snx_ser_port *port = state->port;
+	unsigned int result = 0;
+
+
+	result = sunix_ser_tx_empty(port);
+
+	if ((port->x_char) ||
+		((snx_ser_circ_chars_pending(&state->info->xmit) > 0) &&
+		!state->info->tty->stopped && !state->info->tty->hw_stopped))
+	{
+		result &= ~TIOCSER_TEMT;
+	}
+
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 18))
+	if (copy_to_user(value, &result, sizeof(int)))
+	{
+		return -EFAULT;
+	}
+
+	return 0;
+#else
+	return put_user(result, value);
+#endif
+}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 39))
+static int snx_ser_tiocmget(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int result = -EIO;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return 0;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if (!(tty->flags & (1 << TTY_IO_ERROR)))
+	{
+		result = port->mctrl;
+		result |= sunix_ser_get_mctrl(port);
+	}
+
+	up(&state->sem);
+
+	return result;
+}
+
+
+static int snx_ser_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int ret = -EIO;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return 0;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if (!(tty->flags & (1 << TTY_IO_ERROR)))
+	{
+		snx_ser_update_mctrl(port, set, clear);
+		ret = 0;
+	}
+
+	up(&state->sem);
+
+	return ret;
+}
+
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+static int snx_ser_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int result = -EIO;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return 0;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if ((!file || !tty_hung_up_p(file)) && !(tty->flags & (1 << TTY_IO_ERROR)))
+	{
+		result = port->mctrl;
+		result |= sunix_ser_get_mctrl(port);
+	}
+
+	up(&state->sem);
+
+	return result;
+}
+
+
+static int snx_ser_tiocmset(struct tty_struct *tty, struct file *file, unsigned int set, unsigned int clear)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int ret = -EIO;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return 0;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if ((!file || !tty_hung_up_p(file)) && !(tty->flags & (1 << TTY_IO_ERROR)))
+	{
+		snx_ser_update_mctrl(port, set, clear);
+		ret = 0;
+	}
+
+	up(&state->sem);
+
+	return ret;
+}
+
+
+#else
+static int snx_ser_get_modem_info(struct snx_ser_state *state, unsigned int *value)
+{
+	struct snx_ser_port *port = NULL;
+	int line;
+	unsigned int result;
+
+
+	if (!state)
+	{
+		return -EIO;
+	}
+
+	port = state->port;
+
+	if (!port)
+	{
+		return -EIO;
+	}
+
+	line = port->line;
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return -EIO;
+	}
+
+	result = port->mctrl;
+	result |= sunix_ser_get_mctrl(port);
+
+	put_user(result, (unsigned long *)value);
+
+	return 0;
+}
+
+
+static int snx_ser_set_modem_info(struct snx_ser_state *state, unsigned int cmd, unsigned int *value)
+{
+	struct snx_ser_port *port = NULL;
+	int line;
+	unsigned int set = 0;
+	unsigned int clr = 0;
+	unsigned int arg;
+
+
+	if (!state)
+	{
+		return -EIO;
+	}
+
+	port = state->port;
+
+	if (!port)
+	{
+		return -EIO;
+	}
+
+	line = port->line;
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return -EIO;
+	}
+
+	get_user(arg, (unsigned long *)value);
+
+	switch (cmd)
+	{
+		case TIOCMBIS:
+		{
+			if (arg & TIOCM_RTS)
+			{
+				set |= TIOCM_RTS;
+			}
+
+			if (arg & TIOCM_DTR)
+			{
+				set |= TIOCM_DTR;
+			}
+
+			if (arg & TIOCM_LOOP)
+			{
+				set |= TIOCM_LOOP;
+			}
+			break;
+		}
+
+		case TIOCMBIC:
+		{
+			if (arg & TIOCM_RTS)
+			{
+				clr |= TIOCM_RTS;
+			}
+
+			if (arg & TIOCM_DTR)
+			{
+				clr |= TIOCM_DTR;
+			}
+
+			if (arg & TIOCM_LOOP)
+			{
+				clr |= TIOCM_LOOP;
+			}
+			break;
+		}
+
+		case TIOCMSET:
+		{
+			if (arg & TIOCM_RTS)
+			{
+				set |= TIOCM_RTS;
+			}
+			else
+			{
+				clr |= TIOCM_RTS;
+			}
+
+			if (arg & TIOCM_DTR)
+			{
+				set |= TIOCM_DTR;
+			}
+			else
+			{
+				clr |= TIOCM_DTR;
+			}
+
+			if (arg & TIOCM_LOOP)
+			{
+				set |= TIOCM_LOOP;
+			}
+			else
+			{
+				clr |= TIOCM_LOOP;
+			}
+			break;
+		}
+
+		default:
+		{
+			return -EINVAL;
+		}
+	}
+
+	snx_ser_update_mctrl(port, set, clr);
+
+	return 0;
+}
+#endif
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27))
+static int  snx_ser_break_ctl(struct tty_struct *tty, int break_state)
+#else
+static void snx_ser_break_ctl(struct tty_struct *tty, int break_state)
+#endif
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27))
+		return 0;
+#else
+		return;
+#endif
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if (port->type != PORT_UNKNOWN)
+	{
+		sunix_ser_break_ctl(port, break_state);
+	}
+
+	up(&state->sem);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27))
+	return 0;
+#endif
+}
+
+
+static int snx_ser_wait_modem_status(struct snx_ser_state *state, unsigned long arg)
+{
+	struct snx_ser_port *port = state->port;
+	DECLARE_WAITQUEUE(wait, current);
+	struct snx_ser_icount cprev;
+	struct snx_ser_icount cnow;
+	int ret = 0;
+
+
+	spin_lock_irq(&port->lock);
+	memcpy(&cprev, &port->icount, sizeof(struct snx_ser_icount));
+
+	sunix_ser_enable_ms(port);
+
+	spin_unlock_irq(&port->lock);
+
+	add_wait_queue(&state->info->delta_msr_wait, &wait);
+
+	for (;;)
+	{
+		spin_lock_irq(&port->lock);
+		memcpy(&cnow, &port->icount, sizeof(struct snx_ser_icount));
+		spin_unlock_irq(&port->lock);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
+			((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
+			((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
+			((arg & TIOCM_CTS) && (cnow.cts != cprev.cts)))
+		{
+			ret = 0;
+			break;
+		}
+
+		schedule();
+
+		if (signal_pending(current))
+		{
+			ret = -ERESTARTSYS;
+			break;
+		}
+
+		cprev = cnow;
+	}
+
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&state->info->delta_msr_wait, &wait);
+
+	return ret;
+}
+
+
+static int snx_ser_get_count(struct snx_ser_state *state, struct serial_icounter_struct *icnt)
+{
+    struct serial_icounter_struct icount;
+    struct snx_ser_icount cnow;
+    struct snx_ser_port *port = state->port;
+
+
+    spin_lock_irq(&port->lock);
+    memcpy(&cnow, &port->icount, sizeof(struct snx_ser_icount));
+    spin_unlock_irq(&port->lock);
+
+    icount.cts         = cnow.cts;
+    icount.dsr         = cnow.dsr;
+    icount.rng         = cnow.rng;
+    icount.dcd         = cnow.dcd;
+    icount.rx          = cnow.rx;
+    icount.tx          = cnow.tx;
+    icount.frame       = cnow.frame;
+    icount.overrun     = cnow.overrun;
+    icount.parity      = cnow.parity;
+    icount.brk         = cnow.brk;
+    icount.buf_overrun = cnow.buf_overrun;
+
+    return copy_to_user(icnt, &icount, sizeof(icount)) ? -EFAULT : 0;
+}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 39))
+static int snx_ser_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
+#else
+static int snx_ser_ioctl(struct tty_struct *tty, struct file *filp, unsigned int cmd, unsigned long arg)
+#endif
+{
+	struct snx_ser_state *state = NULL;
+	int ret = -ENOIOCTLCMD;
+	int line = SNX_SER_DEVNUM(tty);
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0))
+	int status = 0;
+#endif
+
+
+	if (line < SUNIX_SDC_UART_MAX)
+	{
+		state = tty->driver_data;
+	}
+
+
+	switch (cmd)
+	{
+		case TIOCGSERIAL:
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				ret = snx_ser_get_info(state, (struct serial_struct *)arg);
+			}
+			break;
+		}
+
+
+		case TIOCSSERIAL:
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				state->port->setserial_flag = SNX_SER_BAUD_SETSERIAL;
+				ret = snx_ser_set_info(state, (struct serial_struct *)arg);
+			}
+			break;
+		}
+
+
+		case TCSETS:
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				state->port->flags &= ~(SNX_UPF_SPD_HI | SNX_UPF_SPD_VHI | SNX_UPF_SPD_SHI | SNX_UPF_SPD_WARP);
+				state->port->setserial_flag = SNX_SER_BAUD_NOTSETSER;
+				snx_ser_update_termios(state);
+			}
+			break;
+		}
+
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0))
+		case TIOCMGET:
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				ret = verify_area(VERIFY_WRITE, (void *)arg,	sizeof(unsigned int));
+
+				if (ret)
+				{
+					return ret;
+				}
+
+				status = snx_ser_get_modem_info(state, (unsigned int *)arg);
+				return status;
+			}
+			break;
+		}
+
+
+		case TIOCMBIS:
+		case TIOCMBIC:
+		case TIOCMSET:
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				status = snx_ser_set_modem_info(state, cmd, (unsigned int *)arg);
+				return status;
+			}
+			break;
+		}
+#endif
+
+
+		case TIOCSERGWILD:
+		case TIOCSERSWILD:
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				ret = 0;
+			}
+			break;
+		}
+
+		case SNX_SDC_UART_GET_INFO: 
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				struct snx_ser_port *port = NULL;
+				struct snx_sdc_uart_info info;
+
+				port = state->port;
+				if (port != NULL)
+				{
+					memset(&info, 0, sizeof(struct snx_sdc_uart_info));
+
+					memcpy(info.model_name, port->model_name, sizeof(port->model_name));
+					info.bus_number = port->bus_number;
+					info.dev_number = port->dev_number;
+					info.line = port->line;
+					info.iobase = port->iobase;
+					info.irq = port->irq;
+
+					info.version = port->cib_info.version;
+					info.tx_fifo_size = port->cib_info.uart_tx_fifo_size;
+					info.rx_fifo_size = port->cib_info.uart_rx_fifo_size;
+					info.significand_of_clock = port->cib_info.uart_significand_of_clock;
+					info.exponent_of_clock = port->cib_info.uart_exponent_of_clock;
+					info.RS232_cap = port->cib_info.uart_RS232_cap;
+					info.RS422_cap = port->cib_info.uart_RS422_cap;
+					info.RS485_cap = port->cib_info.uart_RS485_cap;
+					info.AHDC_cap = port->cib_info.uart_AHDC_cap;
+					info.CS_cap = port->cib_info.uart_CS_cap;
+					info.auto_RS422485_cap = port->cib_info.uart_auto_RS422485_cap;
+					info.RS422_termination_cap = port->cib_info.uart_RS422_termination_cap;
+					info.RS485_termination_cap = port->cib_info.uart_RS485_termination_cap;
+					info.RI_5V_cap = port->cib_info.uart_RI_5V_cap;
+					info.RI_12V_cap = port->cib_info.uart_RI_12V_cap;
+					info.DCD_5V_cap = port->cib_info.uart_DCD_5V_cap;
+					info.DCD_12V_cap = port->cib_info.uart_DCD_12V_cap;
+
+					if (copy_to_user((void *)arg, &info, sizeof(struct snx_sdc_uart_info)))
+					{
+						ret = -EFAULT;
+					}
+					else
+					{
+						ret = 0;
+					}
+				}
+			}
+			break;
+		}
+
+		case SNX_SDC_UART_GET_ADDITIONAL_REG_0E: 
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				struct snx_ser_port *port = NULL;
+				unsigned char data;
+
+				port = state->port;
+				if (port != NULL)
+				{
+					data = 	inb(port->iobase + 0x0e);
+					if (copy_to_user((void *)arg, &data, sizeof(unsigned char)))
+					{
+						ret = -EFAULT;
+					}
+					else
+					{
+						ret = 0;
+					}
+				}
+			}
+
+			break;
+		}
+
+		case SNX_SDC_UART_SET_ADDITIONAL_REG_0E: 
+		{
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				struct snx_ser_port *port = NULL;
+				unsigned char data = 0x00;
+
+				port = state->port;
+				if (port != NULL)
+				{
+					if (copy_from_user(&data, (void *)arg, sizeof(unsigned char)))
+					{
+						ret = -EFAULT;
+					}
+					else
+					{
+						outb(data, port->iobase + 0x0e);
+						ret = 0;
+					}
+				}
+			}
+
+			break;
+		}
+
+    }
+
+    if (ret != -ENOIOCTLCMD)
+	{
+		goto out;
+    }
+
+    if (tty->flags & (1 << TTY_IO_ERROR))
+	{
+		ret = -EIO;
+		goto out;
+	}
+
+	switch (cmd)
+	{
+		case TIOCMIWAIT:
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				ret = snx_ser_wait_modem_status(state, arg);
+			}
+			break;
+
+		case TIOCGICOUNT:
+			if (line < SUNIX_SDC_UART_MAX)
+			{
+				ret = snx_ser_get_count(state, (struct serial_icounter_struct *)arg);
+			}
+			break;
+	}
+
+
+	if (ret != -ENOIOCTLCMD)
+	{
+		goto out;
+	}
+
+
+    if (line < SUNIX_SDC_UART_MAX)
+	{
+		down(&state->sem);
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39))
+		if (tty_hung_up_p(filp))
+		{
+			ret = -EIO;
+			goto out_up;
+		}
+#endif
+
+		switch (cmd)
+		{
+			case TIOCSERGETLSR:
+				ret = snx_ser_get_lsr_info(state, (unsigned int *)arg);
+				break;
+
+
+			default:
+				break;
+		}
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39))
+out_up:
+#endif
+		up(&state->sem);
+	}
+
+out:
+	return ret;
+}
+
+
+static void snx_ser_hangup(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	struct tty_port *tport = &state->tport;
+#endif
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	tport = &state->tport;
+#endif
+
+	down(&state->sem);
+
+	if (state->info && state->info->flags & SNX_UIF_NORMAL_ACTIVE)
+	{
+		snx_ser_flush_buffer(tty);
+		snx_ser_shutdown(state);
+		state->count = 0;
+		state->info->flags &= ~SNX_UIF_NORMAL_ACTIVE;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		tty_port_tty_set(tport, NULL);
+#endif
+
+		state->info->tty = NULL;
+		wake_up_interruptible(&state->info->open_wait);
+		wake_up_interruptible(&state->info->delta_msr_wait);
+	}
+
+	up(&state->sem);
+}
+
+
+unsigned int snx_ser_get_divisor(struct snx_ser_port *port, unsigned int baud)
+{
+	unsigned int quot;
+
+
+	if (baud == 38400 && (port->flags & SNX_UPF_SPD_MASK) == SNX_UPF_SPD_CUST)
+	{
+		quot = port->custom_divisor;
+	}
+	else
+	{
+		quot = port->uartclk / (16 * baud);
+	}
+
+	return quot;
+}
+
+
+unsigned int snx_ser_get_baud_rate(struct snx_ser_port *port, struct SNXTERMIOS *termios, struct SNXTERMIOS *old, unsigned int min, unsigned int max)
+{
+	unsigned int try;
+	unsigned int baud;
+	unsigned int altbaud = 0;
+	unsigned int flags = port->flags & SNX_UPF_SPD_MASK;
+
+
+	for (try = 0; try < 2; try++)
+	{
+		if ((port->setserial_flag == SNX_SER_BAUD_SETSERIAL) || (port->flags & SNX_UPF_SPD_MASK))
+		{
+			altbaud = 38400;
+
+			if (flags == SNX_UPF_SPD_HI)
+			{
+				altbaud = 57600;
+			}
+
+			if (flags == SNX_UPF_SPD_VHI)
+			{
+				altbaud = 115200;
+			}
+
+			if (flags == SNX_UPF_SPD_SHI)
+			{
+				altbaud = 230400;
+			}
+
+			if (flags == SNX_UPF_SPD_WARP)
+			{
+				altbaud = 460800;
+			}
+
+			baud = altbaud;
+		}
+		else
+		{
+			switch (termios->c_cflag & (CBAUD | CBAUDEX))
+			{
+				case B921600:
+					baud = 921600;
+					break;
+
+				case B460800:
+					baud = 460800;
+					break;
+
+				case B230400:
+					baud = 230400;
+					break;
+
+				case B115200:
+					baud = 115200;
+					break;
+
+				case B57600:
+					baud = 57600;
+					break;
+
+				case B38400:
+					baud = 38400;
+					break;
+
+				case B19200:
+					baud = 19200;
+					break;
+
+				case B9600:
+					baud = 9600;
+					break;
+
+				case B4800:
+					baud = 4800;
+					break;
+
+				case B2400:
+					baud = 2400;
+					break;
+
+				case B1800:
+					baud = 1800;
+					break;
+
+				case B1200:
+					baud = 1200;
+					break;
+
+				case B600:
+					baud = 600;
+					break;
+
+				case B300:
+					baud = 300;
+					break;
+
+				case B200:
+					baud = 200;
+					break;
+
+				case B150:
+					baud = 150;
+					break;
+
+				case B134:
+					baud = 134;
+					break;
+
+				case B110:
+					baud = 110;
+					break;
+
+				case B75:
+					baud = 75;
+					break;
+
+				case B50:
+					baud = 50;
+					break;
+
+				default:
+					baud = 9600;
+					break;
+			}
+		}
+
+		if (baud == 0)
+		{
+			baud = 9600;
+		}
+
+		if (baud >= min && baud <= max)
+		{
+			return baud;
+		}
+
+		termios->c_cflag &= ~CBAUD;
+
+		if (old)
+		{
+			termios->c_cflag |= old->c_cflag & CBAUD;
+			old = NULL;
+			continue;
+		}
+
+		termios->c_cflag |= B9600;
+	}
+
+	return 0;
+}
+
+
+extern void snx_ser_change_speed(struct snx_ser_state *state, struct SNXTERMIOS *old_termios)
+{
+	struct tty_struct *tty = state->info->tty;
+	struct snx_ser_port *port = state->port;
+	struct SNXTERMIOS *termios;
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	if (!tty || port->type == PORT_UNKNOWN)
+	{
+		return;
+	}
+#else
+	if (!tty || !tty->termios || port->type == PORT_UNKNOWN)
+	{
+		return;
+	}
+#endif
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	termios = &tty->termios;
+#else
+	termios = tty->termios;
+#endif
+
+	if (termios->c_cflag & CRTSCTS)
+	{
+		state->info->flags |= SNX_UIF_CTS_FLOW;
+    }
+	else
+	{
+		state->info->flags &= ~SNX_UIF_CTS_FLOW;
+    }
+
+	if (termios->c_cflag & CLOCAL)
+	{
+		state->info->flags &= ~SNX_UIF_CHECK_CD;
+	}
+	else
+	{
+		state->info->flags |= SNX_UIF_CHECK_CD;
+	}
+
+	sunix_ser_set_termios(port, termios, old_termios);
+}
+
+
+static void snx_ser_set_termios(struct tty_struct *tty, struct SNXTERMIOS *old_termios)
+{
+	struct snx_ser_state *state = NULL;
+	unsigned long flags;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	unsigned int cflag = tty->termios.c_cflag;
+#else
+	unsigned int cflag = tty->termios->c_cflag;
+#endif
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+
+#define RELEVANT_IFLAG(iflag)	((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	if ((cflag ^ old_termios->c_cflag) == 0 && RELEVANT_IFLAG(tty->termios.c_iflag ^ old_termios->c_iflag) == 0)
+	{
+		return;
+	}
+#else
+	if ((cflag ^ old_termios->c_cflag) == 0 && RELEVANT_IFLAG(tty->termios->c_iflag ^ old_termios->c_iflag) == 0)
+	{
+		return;
+	}
+#endif
+
+	snx_ser_change_speed(state, old_termios);
+
+	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD))
+	{
+		snx_clear_mctrl(state->port, TIOCM_RTS | TIOCM_DTR);
+	}
+
+	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD))
+	{
+		unsigned int mask = TIOCM_DTR;
+		if (!(cflag & CRTSCTS) || !test_bit(TTY_THROTTLED, &tty->flags))
+		{
+			mask |= TIOCM_RTS;
+		}
+
+		snx_set_mctrl(state->port, mask);
+	}
+
+	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS))
+	{
+		spin_lock_irqsave(&state->port->lock, flags);
+		tty->hw_stopped = 0;
+		__snx_ser_start(tty);
+		spin_unlock_irqrestore(&state->port->lock, flags);
+	}
+}
+
+
+void snx_ser_update_termios(struct snx_ser_state *state)
+{
+	struct tty_struct *tty = state->info->tty;
+	struct snx_ser_port *port = state->port;
+
+
+	if (!(tty->flags & (1 << TTY_IO_ERROR)))
+	{
+		snx_ser_change_speed(state, NULL);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		if (tty->termios.c_cflag & CBAUD)
+		{
+			snx_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+		}
+#else
+		if (tty->termios->c_cflag & CBAUD)
+		{
+			snx_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+		}
+#endif
+	}
+}
+
+
+static void snx_ser_update_timeout(struct snx_ser_port *port, unsigned int cflag, unsigned int baud)
+{
+	unsigned int bits;
+
+
+	switch (cflag & CSIZE)
+	{
+		case CS5:
+			bits = 7;
+			break;
+
+		case CS6:
+			bits = 8;
+			break;
+
+		case CS7:
+			bits = 9;
+			break;
+
+		default:
+			bits = 10;
+			break;
+	}
+
+	if (cflag & CSTOPB)
+	{
+		bits++;
+	}
+
+	if (cflag & PARENB)
+	{
+		bits++;
+	}
+
+	bits = bits * port->fifosize;
+
+	port->timeout = (HZ * bits) / baud + HZ/50;
+}
+
+
+static struct snx_ser_state *snx_ser_get(struct snx_ser_driver *drv, int line)
+{
+	struct snx_ser_state *state = NULL;
+
+
+	down(&ser_port_sem);
+
+	state = drv->state + line;
+
+	if (down_interruptible(&state->sem))
+	{
+		state = ERR_PTR(-ERESTARTSYS);
+		goto out;
+    }
+
+	state->count++;
+
+	if (!state->port)
+	{
+		state->count--;
+		up(&state->sem);
+		state = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	if (!state->port->iobase)
+	{
+		state->count--;
+		up(&state->sem);
+		state = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	if (!state->info)
+	{
+		state->info = kmalloc(sizeof(struct snx_ser_info), GFP_KERNEL);
+
+		if (state->info)
+		{
+			memset(state->info, 0, sizeof(struct snx_ser_info));
+			init_waitqueue_head(&state->info->open_wait);
+			init_waitqueue_head(&state->info->delta_msr_wait);
+
+			state->port->info = state->info;
+
+			tasklet_init(&state->info->tlet, snx_ser_tasklet_action, (unsigned long)state);
+		}
+		else
+		{
+			state->count--;
+			up(&state->sem);
+			state = ERR_PTR(-ENOMEM);
+		}
+	}
+
+out:
+	up(&ser_port_sem);
+
+	return state;
+}
+
+
+static int snx_ser_block_til_ready(struct file *filp, struct snx_ser_state *state)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	struct snx_ser_info *info = state->info;
+	struct snx_ser_port *port = state->port;
+
+
+	info->blocked_open++;
+	state->count--;
+
+	add_wait_queue(&info->open_wait, &wait);
+
+	while (1)
+	{
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (tty_hung_up_p(filp) || info->tty == NULL)
+		{
+			break;
+		}
+
+		if (!(info->flags & SNX_UIF_INITIALIZED))
+		{
+			break;
+		}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		if ((filp->f_flags & O_NONBLOCK) ||
+			(info->tty->termios.c_cflag & CLOCAL) ||
+			(info->tty->flags & (1 << TTY_IO_ERROR)))
+		{
+			break;
+		}
+
+		if (info->tty->termios.c_cflag & CBAUD)
+		{
+			snx_set_mctrl(port, TIOCM_DTR);
+		}
+#else
+		if ((filp->f_flags & O_NONBLOCK) ||
+			(info->tty->termios->c_cflag & CLOCAL) ||
+			(info->tty->flags & (1 << TTY_IO_ERROR)))
+		{
+			break;
+		}
+
+		if (info->tty->termios->c_cflag & CBAUD)
+		{
+			snx_set_mctrl(port, TIOCM_DTR);
+		}
+#endif
+
+		if (sunix_ser_get_mctrl(port) & TIOCM_CAR)
+		{
+			break;
+		}
+
+		up(&state->sem);
+		schedule();
+		down(&state->sem);
+
+		if (signal_pending(current))
+		{
+			break;
+		}
+	}
+
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&info->open_wait, &wait);
+
+	state->count++;
+	info->blocked_open--;
+
+	if (signal_pending(current))
+	{
+		return -ERESTARTSYS;
+	}
+
+	if (!info->tty || tty_hung_up_p(filp))
+	{
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+
+static void snx_ser_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long char_time;
+	unsigned long expire;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line >= SUNIX_SDC_UART_MAX)
+	{
+		return;
+	}
+
+	state = tty->driver_data;
+	port = state->port;
+
+	if (port->type == PORT_UNKNOWN || port->fifosize == 0)
+	{
+		return;
+	}
+
+	char_time = (port->timeout - HZ/50) / port->fifosize;
+
+    char_time = char_time / 5;
+
+    if (char_time == 0)
+	{
+		char_time = 1;
+	}
+
+	if (timeout && timeout < char_time)
+	{
+		char_time = timeout;
+	}
+
+	if (timeout == 0 || timeout > 2 * port->timeout)
+	{
+		timeout = 2 * port->timeout;
+	}
+
+	expire = jiffies + timeout;
+
+	while (!sunix_ser_tx_empty(port))
+	{
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(char_time);
+
+		if (signal_pending(current))
+		{
+			break;
+		}
+
+		if (time_after(jiffies, expire))
+		{
+			break;
+		}
+	}
+	set_current_state(TASK_RUNNING);
+}
+
+
+static int snx_ser_open(struct tty_struct *tty, struct file *filp)
+{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	struct snx_ser_driver *drv = (struct snx_ser_driver *)tty->driver->driver_state;
+#else
+	struct snx_ser_driver *drv = (struct snx_ser_driver *)tty->driver.driver_state;
+#endif
+	struct snx_ser_state *state = NULL;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	struct tty_port *tport = NULL;
+#endif
+	int retval = 0;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line < SUNIX_SDC_UART_MAX)
+	{
+		retval = -ENODEV;
+
+		if (line >= SUNIX_SDC_UART_MAX)
+		{
+			goto fail;
+		}
+
+		state = snx_ser_get(drv, line);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		tport = &state->tport;
+#endif
+
+		if (IS_ERR(state))
+		{
+			retval = PTR_ERR(state);
+			goto fail;
+		}
+
+		if (!state)
+		{
+			goto fail;
+		}
+
+		state->port->suspended = 1;
+		tty->driver_data = state;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+		tport->low_latency = (state->port->flags & SNX_UPF_LOW_LATENCY) ? 1 : 0;
+#else
+		tty->low_latency = (state->port->flags & SNX_UPF_LOW_LATENCY) ? 1 : 0;
+#endif
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0))
+		tty->alt_speed = 0;
+#endif
+		state->info->tty = tty;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		tty_port_tty_set(tport, tty);
+#endif
+
+		if (tty_hung_up_p(filp))
+		{
+			retval = -EAGAIN;
+			state->count--;
+			up(&state->sem);
+			goto fail;
+		}
+
+		retval = snx_ser_startup(state, 0);
+
+		if (retval == 0)
+		{
+			retval = snx_ser_block_til_ready(filp, state);
+		}
+
+		up(&state->sem);
+
+		if (retval == 0 && !(state->info->flags & SNX_UIF_NORMAL_ACTIVE))
+		{
+			state->info->flags |= SNX_UIF_NORMAL_ACTIVE;
+
+			snx_ser_update_termios(state);
+		}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		try_module_get(THIS_MODULE);
+#else
+		MOD_INC_USE_COUNT;
+#endif
+
+	}
+	else
+	{
+	}
+
+fail:
+
+	return retval;
+}
+
+
+static void snx_ser_close(struct tty_struct *tty, struct file *filp)
+{
+	struct snx_ser_state *state = tty->driver_data;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	struct tty_port *tport;
+#endif
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+
+	if (line < SUNIX_SDC_UART_MAX)
+	{
+		if (!state || !state->port)
+		{
+			return;
+		}
+
+		port = state->port;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		tport = &state->tport;
+#endif
+
+		down(&state->sem);
+
+		if (tty_hung_up_p(filp))
+		{
+			goto done;
+		}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		if ((tty->count == 1) && (state->count != 1))
+		{
+			printk("SUNIX: Bad serial port count; tty->count is 1, state->count is %d\n", state->count);
+			state->count = 1;
+		}
+#endif
+
+		if (--state->count < 0)
+		{
+			printk("SUNIX: Bad serial port count for ttySDC%d: %d\n", port->line, state->count);
+			state->count = 0;
+		}
+
+		if (state->count)
+		{
+			goto done;
+		}
+
+		tty->closing = 1;
+
+		port->suspended = 0;
+		if (state->closing_wait != SNX_USF_CLOSING_WAIT_NONE)
+		{
+			tty_wait_until_sent(tty, state->closing_wait);
+		}
+
+		if (state->info->flags & SNX_UIF_INITIALIZED)
+		{
+			unsigned long flags;
+
+			spin_lock_irqsave(&port->lock, flags);
+			sunix_ser_stop_rx(port);
+			spin_unlock_irqrestore(&port->lock, flags);
+
+			snx_ser_wait_until_sent(tty, port->timeout);
+		}
+
+		snx_ser_shutdown(state);
+		snx_ser_flush_buffer(tty);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 31))
+		if (tty->ldisc->ops->flush_buffer)
+		{
+			tty->ldisc->ops->flush_buffer(tty);
+		}
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27) && LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 30))
+		if (tty->ldisc.ops->flush_buffer)
+		{
+			tty->ldisc.ops->flush_buffer(tty);
+		}
+#else
+		if (tty->ldisc.flush_buffer)
+		{
+			tty->ldisc.flush_buffer(tty);
+		}
+#endif
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		tty_port_tty_set(tport, NULL);
+#endif
+
+		tty->closing = 0;
+		state->info->tty = NULL;
+
+		if (state->info->blocked_open)
+		{
+			if (state->close_delay)
+			{
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(state->close_delay);
+			}
+		}
+
+		state->info->flags &= ~SNX_UIF_NORMAL_ACTIVE;
+		wake_up_interruptible(&state->info->open_wait);
+
+done:
+		up(&state->sem);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		module_put(THIS_MODULE);
+#else
+		MOD_DEC_USE_COUNT;
+#endif
+	}
+	else
+	{
+	}
+}
+
+
+static void sunix_ser_set_mctrl(struct snx_ser_port *port, unsigned int mctrl)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+	unsigned char mcr = 0;
+
+
+	if (mctrl & TIOCM_RTS)
+	{
+		mcr |= UART_MCR_RTS;
+	}
+
+	if (mctrl & TIOCM_DTR)
+	{
+		mcr |= UART_MCR_DTR;
+	}
+
+	if (mctrl & TIOCM_OUT1)
+	{
+		mcr |= UART_MCR_OUT1;
+	}
+
+	if (mctrl & TIOCM_OUT2)
+	{
+		mcr |= UART_MCR_OUT2;
+	}
+
+	if (mctrl & TIOCM_LOOP)
+	{
+		mcr |= UART_MCR_LOOP;
+	}
+
+	mcr = (mcr & sp->mcr_mask) | sp->mcr_force | sp->mcr;
+
+	WRITE_UART_MCR(sp, mcr);
+}
+
+
+static unsigned int sunix_ser_tx_empty(struct snx_ser_port *port)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+	ret = READ_UART_LSR(sp) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+
+	return ret;
+}
+
+
+static unsigned int sunix_ser_get_mctrl(struct snx_ser_port *port)
+{
+    struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+    unsigned long flags;
+    unsigned char status;
+    unsigned int ret;
+
+
+	ret = 0;
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+	status = READ_UART_MSR(sp);
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+
+	if (status & UART_MSR_DCD)
+	{
+		ret |= TIOCM_CAR;
+	}
+
+	if (status & UART_MSR_RI)
+	{
+		ret |= TIOCM_RNG;
+	}
+
+	if (status & UART_MSR_DSR)
+	{
+		ret |= TIOCM_DSR;
+	}
+
+	if (status & UART_MSR_CTS)
+	{
+		ret |= TIOCM_CTS;
+	}
+	return ret;
+}
+
+
+static void sunix_ser_stop_tx(struct snx_ser_port *port, unsigned int tty_stop)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	if (sp->ier & UART_IER_THRI)
+	{
+		sp->ier &= ~UART_IER_THRI;
+		WRITE_UART_IER(sp, sp->ier);
+	}
+}
+
+
+static void sunix_ser_start_tx(struct snx_ser_port *port, unsigned int tty_start)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	if (!(sp->ier & UART_IER_THRI))
+	{
+		sp->ier |= UART_IER_THRI;
+		WRITE_UART_IER(sp, sp->ier);
+	}
+}
+
+
+static void sunix_ser_stop_rx(struct snx_ser_port *port)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	sp->ier &= ~UART_IER_RLSI;
+	sp->port.read_status_mask &= ~UART_LSR_DR;
+	WRITE_UART_IER(sp, sp->ier);
+}
+
+
+static void sunix_ser_enable_ms(struct snx_ser_port *port)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	sp->ier |= UART_IER_MSI;
+	WRITE_UART_IER(sp, sp->ier);
+}
+
+
+static void sunix_ser_break_ctl(struct snx_ser_port *port, int break_state)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+	unsigned long flags;
+
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+
+	if (break_state == -1)
+	{
+		sp->lcr |= UART_LCR_SBC;
+	}
+	else
+	{
+		sp->lcr &= ~UART_LCR_SBC;
+	}
+
+	WRITE_UART_LCR(sp, sp->lcr);
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+}
+
+
+static int sunix_ser_startup(struct snx_ser_port *port)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	sp->capabilities = snx_uart_config[sp->port.type].flags;
+	sp->mcr = 0;
+
+	if (sp->capabilities & UART_CLEAR_FIFO)
+	{
+		WRITE_UART_FCR(sp, UART_FCR_ENABLE_FIFO);
+		WRITE_UART_FCR(sp, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+		WRITE_UART_FCR(sp, 0);
+	}
+
+	(void) READ_UART_LSR(sp);
+	(void) READ_UART_RX(sp);
+	(void) READ_UART_IIR(sp);
+	(void) READ_UART_MSR(sp);
+
+	if (!(sp->port.flags & SNX_UPF_BUGGY_UART) && (READ_UART_LSR(sp) == 0xff))
+	{
+		printk("SUNIX: ttySDC%d: LSR safety check engaged!\n", sp->port.line);
+		return -ENODEV;
+	}
+
+	WRITE_UART_LCR(sp, UART_LCR_WLEN8);
+
+	sp->ier = UART_IER_RLSI | UART_IER_RDI;
+	WRITE_UART_IER(sp, sp->ier);
+
+	(void) READ_UART_LSR(sp);
+	(void) READ_UART_RX(sp);
+	(void) READ_UART_IIR(sp);
+	(void) READ_UART_MSR(sp);
+
+	return 0;
+}
+
+
+static void sunix_ser_shutdown(struct snx_ser_port *port)
+{
+    struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+    sp->ier = 0;
+    WRITE_UART_IER(sp, 0);
+
+    WRITE_UART_LCR(sp, READ_UART_LCR(sp) & ~UART_LCR_SBC);
+
+    WRITE_UART_FCR(sp, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+    WRITE_UART_FCR(sp, 0);
+
+    (void) READ_UART_RX(sp);
+}
+
+
+static unsigned int sunix_ser_get_divisor(struct snx_ser_port *port, unsigned int baud)
+{
+	unsigned int quot;
+
+
+	if ((port->flags & SNX_UPF_MAGIC_MULTIPLIER) && baud == (port->uartclk/4))
+	{
+		quot = 0x8001;
+	}
+	else if ((port->flags & SNX_UPF_MAGIC_MULTIPLIER) && baud == (port->uartclk/8))
+	{
+		quot = 0x8002;
+	}
+	else
+	{
+		quot = snx_ser_get_divisor(port, baud);
+	}
+
+    return quot;
+}
+
+
+static void sunix_ser_set_termios(struct snx_ser_port *port, struct SNXTERMIOS *termios, struct SNXTERMIOS *old)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+	unsigned char cval;
+	unsigned char fcr = 0;
+	unsigned long flags;
+	unsigned int baud;
+	unsigned int quot;
+
+
+	switch (termios->c_cflag & CSIZE)
+	{
+		case CS5:
+			cval = 0x00;
+			break;
+
+		case CS6:
+			cval = 0x01;
+			break;
+
+		case CS7:
+			cval = 0x02;
+			break;
+
+		default:
+		case CS8:
+			cval = 0x03;
+			break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+	{
+		cval |= 0x04;
+	}
+
+	if (termios->c_cflag & PARENB)
+	{
+		cval |= UART_LCR_PARITY;
+	}
+
+	if (!(termios->c_cflag & PARODD))
+	{
+		cval |= UART_LCR_EPAR;
+	}
+
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+	{
+		cval |= UART_LCR_SPAR;
+	}
+#endif
+
+	baud = snx_ser_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
+	quot = sunix_ser_get_divisor(port, baud);
+
+	if (sp->capabilities & UART_USE_FIFO)
+	{
+		if (baud < 2400)
+		{
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+		}
+		else
+		{
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
+		}
+	}
+
+	sp->mcr &= ~UART_MCR_AFE;
+
+	if (termios->c_cflag & CRTSCTS)
+	{
+		sp->mcr |= UART_MCR_AFE;
+	}
+
+	fcr |= 0x01;
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+
+
+	snx_ser_update_timeout(port, termios->c_cflag, baud);
+
+
+	sp->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+
+	if (termios->c_iflag & INPCK)
+	{
+		sp->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	}
+
+	if (termios->c_iflag & (BRKINT | PARMRK))
+	{
+		sp->port.read_status_mask |= UART_LSR_BI;
+	}
+
+	sp->port.ignore_status_mask = 0;
+
+	if (termios->c_iflag & IGNPAR)
+	{
+		sp->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	}
+
+
+	if (termios->c_iflag & IGNBRK)
+	{
+		sp->port.ignore_status_mask |= UART_LSR_BI;
+
+		if (termios->c_iflag & IGNPAR)
+		{
+			sp->port.ignore_status_mask |= UART_LSR_OE;
+		}
+	}
+
+	if ((termios->c_cflag & CREAD) == 0)
+	{
+		sp->port.ignore_status_mask |= UART_LSR_DR;
+	}
+
+	sp->ier &= ~UART_IER_MSI;
+	if (SNX_ENABLE_MS(&sp->port, termios->c_cflag))
+	{
+		sp->ier |= UART_IER_MSI;
+	}
+
+	WRITE_UART_LCR(sp, cval | UART_LCR_DLAB);
+
+	WRITE_UART_DLL(sp, quot & 0xff);
+	WRITE_UART_DLM(sp, quot >> 8);
+
+	WRITE_UART_FCR(sp, fcr);
+
+	WRITE_UART_LCR(sp, cval);
+
+	sp->lcr = cval;
+
+	sunix_ser_set_mctrl(&sp->port, sp->port.mctrl);
+
+	WRITE_UART_IER(sp, sp->ier);
+
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0))
+static void sunix_ser_timeout(struct timer_list *t)
+#else
+static void sunix_ser_timeout(unsigned long data)
+#endif
+{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0))
+	struct sunix_sdc_uart_channel *sp = from_timer(sp, t, timer);
+#else
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)data;
+#endif
+	unsigned int timeout;
+	unsigned int iir;
+
+
+	iir = READ_UART_IIR(sp);
+
+	if (!(iir & UART_IIR_NO_INT))
+	{
+		spin_lock(&sp->port.lock);
+		sunix_ser_handle_port(sp, iir);
+		spin_unlock(&sp->port.lock);
+    }
+
+	timeout = sp->port.timeout;
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+	mod_timer(&sp->timer, jiffies + timeout);
+}
+
+
+static _INLINE_ void sunix_ser_receive_chars(struct sunix_sdc_uart_channel *sp, unsigned char *status)
+{
+	struct tty_struct *tty = sp->port.info->tty;
+	unsigned char ch;
+	int max_count = 256;
+	unsigned char lsr = *status;
+	char flag;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+	struct snx_ser_state *state = NULL;
+	struct tty_port *tport = NULL;
+
+
+	state = tty->driver_data;
+	tport = &state->tport;
+#endif
+
+
+	do
+	{
+		ch = READ_UART_RX(sp);
+		flag = TTY_NORMAL;
+		sp->port.icount.rx++;
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2, 4, 18))
+		if (unlikely(lsr & (UART_LSR_BI | UART_LSR_PE | UART_LSR_FE | UART_LSR_OE)))
+#else
+		if (lsr & (UART_LSR_BI | UART_LSR_PE | UART_LSR_FE | UART_LSR_OE))
+#endif
+		{				
+			if (lsr & UART_LSR_BI)
+			{
+				lsr &= ~(UART_LSR_FE | UART_LSR_PE);
+				sp->port.icount.brk++;
+
+				if (snx_ser_handle_break(&sp->port))
+				{					
+					goto ignore_char;
+				}
+			}
+			else if (lsr & UART_LSR_PE)
+			{
+				sp->port.icount.parity++;
+			}
+			else if (lsr & UART_LSR_FE)
+			{
+				sp->port.icount.frame++;
+			}
+
+			if (lsr & UART_LSR_OE)
+			{
+				sp->port.icount.overrun++;
+			}
+
+			lsr &= sp->port.read_status_mask;
+
+			if (lsr & UART_LSR_BI)
+			{
+				flag = TTY_BREAK;
+			}
+			else if (lsr & UART_LSR_PE)
+			{
+				flag = TTY_PARITY;
+			}
+			else if (lsr & UART_LSR_FE)
+			{
+				flag = TTY_FRAME;
+			}
+		}
+
+
+		if ((I_IXOFF(tty)) || I_IXON(tty))
+		{			
+			if (ch == START_CHAR(tty))
+			{
+				tty->stopped = 0;
+				sunix_ser_start_tx(&sp->port, 1);
+				goto ignore_char;
+			}
+			else if (ch == STOP_CHAR(tty))
+			{
+				tty->stopped = 1;
+				sunix_ser_stop_tx(&sp->port, 1);
+				goto ignore_char;
+			}
+		}
+
+		snx_ser_insert_char(&sp->port, lsr, UART_LSR_OE, ch, flag);
+
+ignore_char:
+		lsr = READ_UART_LSR(sp);
+	
+		if (lsr == 0xff)
+		{
+			lsr = 0x01;
+		}
+
+	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+
+	spin_unlock(&sp->port.lock);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0))
+	tty_flip_buffer_push(tport);
+#else
+	tty_flip_buffer_push(tty);
+#endif
+
+	spin_lock(&sp->port.lock);
+	*status = lsr;
+}
+
+
+static _INLINE_ void sunix_ser_transmit_chars(struct sunix_sdc_uart_channel *sp)
+{
+	struct circ_buf *xmit = &sp->port.info->xmit;
+	int count;
+
+
+	if ((!sp) || (!sp->port.iobase))
+	{
+		return;
+	}
+
+	if (!sp->port.info)
+	{
+		return;
+	}
+
+	if (!xmit)
+	{
+		return;
+	}
+
+	if (sp->port.x_char)
+	{
+		WRITE_UART_TX(sp, sp->port.x_char);
+		sp->port.icount.tx++;
+		sp->port.x_char = 0;
+		return;
+	}
+
+	if (snx_ser_circ_empty(xmit))
+	{
+		sunix_ser_stop_tx(&sp->port, 0);
+		return;
+	}
+	
+	if (snx_ser_tx_stopped(&sp->port))
+	{
+		sunix_ser_stop_tx(&sp->port, 0);
+		return;
+	}
+
+	count = sp->port.fifosize;
+
+	do
+	{
+		WRITE_UART_TX(sp, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (SNX_UART_XMIT_SIZE - 1);
+		sp->port.icount.tx++;
+
+		if (snx_ser_circ_empty(xmit))
+		{
+			break;
+		}
+
+	} while (--count > 0);
+
+	if (snx_ser_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	{
+		snx_ser_write_wakeup(&sp->port);
+	}
+}
+
+
+static _INLINE_ void sunix_ser_check_modem_status(struct sunix_sdc_uart_channel *sp, unsigned char status)
+{		
+	if ((status & UART_MSR_ANY_DELTA) == 0)
+	{
+		return;
+	}
+
+	if (!sp->port.info)
+	{
+		return;
+	}
+
+	if (status & UART_MSR_TERI)
+	{
+		sp->port.icount.rng++;
+	}
+
+	if (status & UART_MSR_DDSR)
+	{
+		sp->port.icount.dsr++;
+	}
+
+	if (status & UART_MSR_DDCD)
+	{
+		snx_ser_handle_dcd_change(&sp->port, status & UART_MSR_DCD);
+	}
+
+	if (status & UART_MSR_DCTS)
+	{
+		snx_ser_handle_cts_change(&sp->port, status & UART_MSR_CTS);
+	}
+
+	wake_up_interruptible(&sp->port.info->delta_msr_wait);
+}
+
+
+static _INLINE_ void sunix_ser_handle_port(struct sunix_sdc_uart_channel *sp, unsigned char iir)
+{
+	unsigned char lsr = READ_UART_LSR(sp);
+	unsigned char msr = 0;
+
+
+	if (lsr == 0xff)
+	{
+		lsr = 0x01;		
+	}
+
+	if ((iir == UART_IIR_RLSI) || (iir == UART_IIR_CTO) || (iir == UART_IIR_RDI))
+	{
+		sunix_ser_receive_chars(sp, &lsr);
+	}
+	
+	if ((iir == UART_IIR_THRI) && (lsr & UART_LSR_THRE))
+	{
+		sunix_ser_transmit_chars(sp);
+	}
+
+	msr = READ_UART_MSR(sp);
+
+	if (msr & UART_MSR_ANY_DELTA)
+	{
+		sunix_ser_check_modem_status(sp, msr);
+	}
+}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+static struct tty_operations sunix_tty_ops =
+{
+	.open               = snx_ser_open,
+	.close              = snx_ser_close,
+	.write              = snx_ser_write,
+	.put_char           = snx_ser_put_char,
+	.flush_chars        = snx_ser_flush_chars,
+	.write_room         = snx_ser_write_room,
+	.chars_in_buffer    = snx_ser_chars_in_buffer,
+	.flush_buffer       = snx_ser_flush_buffer,
+	.ioctl              = snx_ser_ioctl,
+	.throttle           = snx_ser_throttle,
+	.unthrottle         = snx_ser_unthrottle,
+	.send_xchar         = snx_ser_send_xchar,
+	.set_termios        = snx_ser_set_termios,
+	.stop               = snx_ser_stop,
+	.start              = snx_ser_start,
+	.hangup             = snx_ser_hangup,
+	.break_ctl          = snx_ser_break_ctl,
+	.wait_until_sent    = snx_ser_wait_until_sent,
+	.tiocmget           = snx_ser_tiocmget,
+	.tiocmset           = snx_ser_tiocmset,
+};
+#endif
+
+
+static struct snx_ser_driver sunix_ser_reg = 
+{
+	.dev_name = "ttySDC",
+	.major = 0,
+	.minor = 0,
+	.nr = (SUNIX_SDC_UART_MAX + 1),
+};
+
+
+int sunix_ser_register_driver(void)
+{
+	struct snx_ser_driver *drv = &sunix_ser_reg;
+	struct tty_driver *normal = NULL;
+	int i;
+	int ret = 0;
+
+
+	drv->state = kmalloc(sizeof(struct snx_ser_state) * drv->nr, GFP_KERNEL);
+
+	ret = -ENOMEM;
+
+	if (!drv->state)
+	{
+		printk("SUNIX: Allocate memory fail !\n");
+		goto out;
+	}
+
+	memset(drv->state, 0, sizeof(struct snx_ser_state) * drv->nr);
+
+	for (i = 0; i < drv->nr; i++)
+	{
+		struct snx_ser_state *state = drv->state + i;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+		struct tty_port *tport = &state->tport;
+		tty_port_init(tport);
+#endif
+
+		if (!state)
+		{
+			ret = -1;
+			printk("SUNIX: Memory error !\n");
+			goto out;
+		}
+
+		state->close_delay     = 5 * HZ / 100;
+		state->closing_wait    = 3 * HZ;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37))
+		sema_init(&state->sem, 1);
+#else
+		init_MUTEX(&state->sem);
+#endif
+    }
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	normal = tty_alloc_driver(SUNIX_SDC_UART_MAX + 1, TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	normal = alloc_tty_driver(drv->nr);
+#else
+	normal = &drv->tty_driver;
+#endif
+
+
+	if (!normal)
+	{
+		printk("SUNIX: Allocate tty driver fail !\n");
+		goto out;
+	}
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+
+#else
+	memset(normal, 0, sizeof(struct tty_driver));
+#endif
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+    drv->tty_driver = normal;
+#endif
+
+	normal->magic                   = TTY_DRIVER_MAGIC;
+	normal->name                    = drv->dev_name;
+	normal->major                   = drv->major;
+	normal->minor_start             = drv->minor;
+	normal->num                     = (SUNIX_SDC_UART_MAX + 1);
+	normal->type                    = TTY_DRIVER_TYPE_SERIAL;
+	normal->subtype                 = SERIAL_TYPE_NORMAL;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+
+#else
+	normal->flags                   = TTY_DRIVER_REAL_RAW ;
+#endif
+
+	normal->init_termios            = tty_std_termios;
+	normal->init_termios.c_cflag    = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	normal->init_termios.c_iflag    = 0;
+
+	normal->driver_state            = drv;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	tty_set_operations(normal, &sunix_tty_ops);
+#else
+	normal->refcount                = &sunix_ser_refcount;
+	normal->table				    = sunix_ser_tty;
+
+	normal->termios				    = sunix_ser_termios;
+	normal->termios_locked		    = sunix_ser_termios_locked;
+
+	normal->open                    = snx_ser_open;
+	normal->close                   = snx_ser_close;
+	normal->write                   = snx_ser_write;
+	normal->put_char                = snx_ser_put_char;
+	normal->flush_chars             = snx_ser_flush_chars;
+	normal->write_room              = snx_ser_write_room;
+	normal->chars_in_buffer         = snx_ser_chars_in_buffer;
+	normal->flush_buffer            = snx_ser_flush_buffer;
+	normal->ioctl                   = snx_ser_ioctl;
+	normal->throttle                = snx_ser_throttle;
+	normal->unthrottle              = snx_ser_unthrottle;
+	normal->send_xchar              = snx_ser_send_xchar;
+	normal->set_termios             = snx_ser_set_termios;
+	normal->stop                    = snx_ser_stop;
+	normal->start                   = snx_ser_start;
+	normal->hangup                  = snx_ser_hangup;
+	normal->break_ctl               = snx_ser_break_ctl;
+	normal->wait_until_sent         = snx_ser_wait_until_sent;
+#endif
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	tty_port_link_device(&snx_service_port, normal, SUNIX_SDC_UART_MAX);
+#endif
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 28))
+	kref_init(&normal->kref);
+#endif
+
+	ret = tty_register_driver(normal);
+
+	if (ret < 0)
+	{
+		printk("SUNIX: Register tty driver fail !\n");
+		goto out;
+	}
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 8, 0))
+	for (i = 0; i < drv->nr; i++)
+	{
+		struct snx_ser_state *state = drv->state + i;
+		struct tty_port *tport = &state->tport;
+
+		tty_port_destroy(tport);
+	}
+#endif
+
+out:
+	if (ret < 0)
+	{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+		put_tty_driver(normal);
+#endif
+		kfree(drv->state);
+	}
+
+	return (ret);
+}
+
+
+void sunix_ser_unregister_driver(void)
+{
+	struct snx_ser_driver *drv = &sunix_ser_reg;
+	struct tty_driver *normal = NULL;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 8, 0))
+	unsigned int i;
+#endif
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0))
+	normal = drv->tty_driver;
+
+	if (!normal)
+	{
+		return;
+	}
+
+	tty_unregister_driver(normal);
+	put_tty_driver(normal);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 8, 0))
+	for (i = 0; i < drv->nr; i++)
+	{
+		struct snx_ser_state *state = drv->state + i;
+		struct tty_port *tport = &state->tport;
+
+		tty_port_destroy(tport);
+	}
+#endif
+
+	drv->tty_driver = NULL;
+
+#else
+	normal = &drv->tty_driver;
+	if (!normal)
+	{
+		return;
+	}
+
+	tty_unregister_driver(normal);
+#endif
+
+	if (drv->state)
+	{
+		kfree(drv->state);
+	}
+}
+
+
+static void sunix_ser_request_io(struct snx_ser_port *port)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	switch (sp->port.iotype)
+	{
+		case SNX_UPIO_PORT:
+			request_region(sp->port.iobase, sp->port.iosize, "sunix_sdc_uart");
+			break;
+
+		default:
+			break;
+	}
+}
+
+
+static void sunix_ser_configure_port(struct snx_ser_driver *drv, struct snx_ser_state *state, struct snx_ser_port *port)
+{
+	unsigned long flags;
+
+
+	if (!port->iobase)
+	{
+		return;
+	}
+
+	flags = SNX_UART_CONFIG_TYPE;
+
+	if (port->type != PORT_UNKNOWN)
+	{
+		sunix_ser_request_io(port);
+
+		spin_lock_irqsave(&port->lock, flags);
+
+		sunix_ser_set_mctrl(port, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+
+static int sunix_ser_add_one_port(struct snx_ser_driver *drv, struct snx_ser_port *port)
+{
+	struct snx_ser_state *state = NULL;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	struct tty_port *tport;
+	struct device *tty_dev;
+#endif
+	int ret = 0;
+
+
+	if (port->line >= drv->nr)
+	{
+		return -EINVAL;
+	}
+
+	state = drv->state + port->line;
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	tport = &state->tport;
+#endif
+
+	down(&ser_port_sem);
+
+	if (state->port)
+	{
+		ret = -EINVAL;
+		goto out;
+	}
+
+	state->port = port;
+
+	port->info = state->info;
+
+	sunix_ser_configure_port(drv, state, port);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+
+	tty_dev = tty_port_register_device(tport, drv->tty_driver, port->line, port->dev);
+
+	if (likely(!IS_ERR(tty_dev)))
+	{
+		device_set_wakeup_capable(tty_dev, 1);
+	}
+	else
+	{
+		printk("SUNIX: Cannot register tty device on line %d\n", port->line);
+	}
+
+#endif
+
+out:
+	up(&ser_port_sem);
+
+	return ret;
+}
+
+
+int sunix_ser_register_ports(void)
+{
+	struct snx_ser_driver *drv = &sunix_ser_reg;
+	struct sunix_sdc_board *sb = NULL;
+	int i;
+	int ret;
+
+
+	sb = &sunix_sdc_board_table[0];
+	if (sb == NULL)
+	{
+		return 0;
+	}
+
+	pci_set_drvdata(sb->pdev, sb);
+
+	for (i = 0; i < SUNIX_SDC_UART_MAX + 1; i++)
+	{
+		struct sunix_sdc_uart_channel *sp = &sunix_sdc_uart_table[i];
+
+		if (!sp)
+		{
+			return -1;
+		}
+
+		sp->port.line = i;
+
+		if (sp->port.iobase)
+		{
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0))
+			timer_setup(&sp->timer, sunix_ser_timeout, 0);
+#else
+			init_timer(&sp->timer);
+			sp->timer.function = sunix_ser_timeout;
+#endif
+			sp->mcr_mask = ~0;
+			sp->mcr_force = 0;
+
+			ret = sunix_ser_add_one_port(drv, &sp->port);
+
+			if (ret != 0)
+			{
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+
+static void sunix_ser_release_io(struct snx_ser_port *port)
+{
+	struct sunix_sdc_uart_channel *sp = (struct sunix_sdc_uart_channel *)port;
+
+
+	switch (sp->port.iotype)
+	{
+		case SNX_UPIO_PORT:
+			release_region(sp->port.iobase, sp->port.iosize);
+			break;
+
+		default:
+			break;
+	}
+}
+
+
+static void sunix_ser_unconfigure_port(struct snx_ser_driver *drv, struct snx_ser_state *state)
+{
+	struct snx_ser_port *port = state->port;
+	struct snx_ser_info *info = state->info;
+
+
+	if (info && info->tty)
+	{
+		tty_hangup(info->tty);
+	}
+
+	down(&state->sem);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
+	tty_unregister_device(drv->tty_driver, port->line);
+#endif
+
+	state->info = NULL;
+
+	if (port->type != PORT_UNKNOWN)
+	{
+		sunix_ser_release_io(port);
+	}
+
+	port->type = PORT_UNKNOWN;
+
+	if (info)
+	{
+		tasklet_kill(&info->tlet);
+		kfree(info);
+	}
+
+	up(&state->sem);
+}
+
+
+static int sunix_ser_remove_one_port(struct snx_ser_driver *drv, struct snx_ser_port *port)
+{
+	struct snx_ser_state *state = drv->state + port->line;
+
+
+	if (state->port != port)
+	{
+		printk("SUNIX: Removing wrong port: %p != %p\n", state->port, port);
+	}
+
+	down(&ser_port_sem);
+
+	sunix_ser_unconfigure_port(drv, state);
+
+	state->port = NULL;
+
+	up(&ser_port_sem);
+
+	return 0;
+}
+
+
+void sunix_ser_unregister_ports(void)
+{
+	struct snx_ser_driver *drv = &sunix_ser_reg;
+	int i;
+
+
+	for (i = 0; i < SUNIX_SDC_UART_MAX + 1; i++)
+	{
+		struct sunix_sdc_uart_channel *sp = &sunix_sdc_uart_table[i];
+
+		if (sp->port.iobase)
+		{
+			sunix_ser_remove_one_port(drv, &sp->port);
+		}
+	}
+}
+
+
+int sunix_ser_interrupt(struct sunix_sdc_uart_channel *sp)
+{
+	unsigned char iir;
+
+
+	iir = READ_UART_IIR(sp) & 0x0f;
+
+	if (!(iir & UART_IIR_NO_INT))
+	{
+		spin_lock(&sp->port.lock);
+		sunix_ser_handle_port(sp, iir);
+		spin_unlock(&sp->port.lock);
+	}
+
+    return 0;
+}
+
-- 
2.20.1

