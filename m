Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928C34E319
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC3IYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhC3IYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:24:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80031C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:24:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so5773061ply.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AeSah3qdLzzjmDy7qoL0CNiUpE63KaGu+pQZbe/Qr8=;
        b=nBbHtUhN+EcZmMo32Q+Pj1KAF+T+mQHUp/SW8XAyO458ggfy4ZHP/YhT6r8eoCwkSj
         oEIyLiMFSGNA/tNzIyGf9xSSwv4aPb4fr26nqfImeZxWmp83HZAbSnL0vOF+dQyWsvFU
         EyVwlMQ73jl+1VkGp3Rr7xYbIAE/k9+EMvYCMxd363spmFbyLAjCTTn7zl+zynoIPnpX
         qfr9TUpxubG1SXsVVV/lXzSiEUQH3Lg0VQO1P86hZRrlVQvhCfl1AMfYZZiG3aUMYteN
         xjr+VlQXvZq0J0QaaT+rNM+Qw4S4W4WuvA8n5IbBmQeaSN+WuLgY7WcLw6fLMyRnQKK5
         0K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AeSah3qdLzzjmDy7qoL0CNiUpE63KaGu+pQZbe/Qr8=;
        b=lDkr3kE29fcnwNsMd+deuqK3XBqdmmF5L7EgeDhhr48rh1UBCgjJKOGxueGE8Sys8O
         GkQB3MEpbtL2YhY+CFz7jF2RoDYD1iZ24gNYhFL5GNVniovUhr3NjU2ya7Zizrifj8Pa
         bRnGerkeeh3WD6Tt1RHqaXiB5r1KNvPe5fnx5q17YiVlwmoKodbjnI0puqmbmUFnyvtV
         +KFFLfX4wvXETTFWRocEiIw5UHYQEzbNcgPN2Q12HJR7JEY9AvZsvNDzhSghx1TXdJ1q
         5LmU1VRJ49J7DdQTYxfPwkMFBGL8DRvRHCk5cLt99hxTzcd8ZDGSTc6Wb3/nm/w8A5nX
         ienA==
X-Gm-Message-State: AOAM53266tVjIN7RpgI6/k8q+hEmh6UhV+aggJXpQO4E2mztVHK3lpfA
        EdeVuwX81Yp4vCaIuX1a6wn5FmI8cPE=
X-Google-Smtp-Source: ABdhPJw7HpfnpSbied0AhaHu+i+Wrz6om7aCIa6ONSyzRog3cEiYJglSIHJttRRXrR/HfhA6ez9pGw==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr3208924pjv.129.1617092659530;
        Tue, 30 Mar 2021 01:24:19 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id z2sm19835272pfq.198.2021.03.30.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:24:18 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Morris <saumah@gmail.com>
Subject: [PATCH v1 1/7] Add Driver for SUNIX PCI(e) I/O expansion board
Date:   Tue, 30 Mar 2021 16:23:50 +0800
Message-Id: <20210330082350.6890-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris <saumah@gmail.com>

Signed-off-by: Morris <saumah@gmail.com>
---
 spi_pack.c | 1506 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1506 insertions(+)
 create mode 100644 spi_pack.c

diff --git a/spi_pack.c b/spi_pack.c
new file mode 100644
index 0000000..ff49e0a
--- /dev/null
+++ b/spi_pack.c
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
-- 
2.20.1

