Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1587035CEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbhDLQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbhDLQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:36:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3AC061372
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:30:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s7so13477442wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eh1mnVKkK4yFVKdTnxX/2Y3WTTkS22th6g31Kio/Gyw=;
        b=ugP1cGZKSSUhJQZJlGGrQKkao8NVaX8OWKRt/T/R7GJS6xvJYdFVlejfrnNlzXfQXq
         DjbBSx+Tbd3mm/d3S1Szw+mDsuBQq77Nwjv8ISvd585FuqPmb5wNSnShdtfR6lfJPjvK
         YOeakxfVmLRe8/fuIyGjw0aL9w/9ykob6fXRnuaHq3G7QJWL2b+JzS1i6roaAuFGSdUc
         z6YLjAUr7DypkdeK312RFbHdsham+dFwUOE5IwP78uR3xnXrYxuuRD+4gmo0xBqYRXlT
         q7qI/8AsStIS9hejDEk/jDzfyi0hGRa9KTzhygAvqENgpClbdWJDynSB21T6Fm/+A2M+
         qDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eh1mnVKkK4yFVKdTnxX/2Y3WTTkS22th6g31Kio/Gyw=;
        b=XipNGWIKbJgb8wQWbrXOvQm7hYaJLb8wdaj9f1ataCG+OVIKmCf4htI/jJuLSk8v1w
         aQQEzb1ctPQgeAxSNLnUTQWGMUljiVXY94fiN9hRYXkP50l1JssjZLQ9EeaP4+9j/c9i
         6vpy5MjxCaik2ga5nMLgBkWrCh3sAdYXTnrSN3lcjKQysAU/Wqp2mz7gFSilAiKCotsA
         Djbo1m3nxNnca2Z8oiDbfftyxIQCDpMfgzbYB2gq/39LBvpu40C+4JgPOnp3KGUVv1Es
         lRw3dHZm86+uFlQBWkKxkWdTXbuHOZYBJcq9+cKbV5sGjDWhMIMBnE8Rd8zpyYZmHVvA
         36fA==
X-Gm-Message-State: AOAM533IsSW4UCFbT/LobJ8PxDFNB9fA+Z7W0s9wZwVlocfB+yP7O4+T
        y7z43U2QaUoPvvMqc3zQ3sw=
X-Google-Smtp-Source: ABdhPJwVKaRF406oXJ1OCQ1zk2cqAA889fWFV2BFwUoiTDA7DWVy+BPcF5BbM3y52ud7gagyQqzC+Q==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr32249468wro.257.1618245011246;
        Mon, 12 Apr 2021 09:30:11 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:813f:b20e:675a:834d])
        by smtp.gmail.com with ESMTPSA id b5sm16786524wri.57.2021.04.12.09.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:30:10 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: hal: Correct indentation
Date:   Mon, 12 Apr 2021 17:29:38 +0100
Message-Id: <68e91c54a3be0b57607101fa8b284c00bb7dff1a.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct random indentation to improve readability. This problem
was observed when working on other checkpatch reports in the
file Hal8723BReg.h

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 380 ++++++++++----------
 1 file changed, 190 insertions(+), 190 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index 1279ff82c097..6bf7933cbe4a 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
+++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
@@ -31,97 +31,97 @@
 #define REG_SYS_ISO_CTRL_8723B			0x0000	/*  2 Byte */
 #define REG_SYS_FUNC_EN_8723B			0x0002	/*  2 Byte */
 #define REG_APS_FSMCO_8723B			0x0004	/*  4 Byte */
-#define REG_SYS_CLKR_8723B				0x0008	/*  2 Byte */
-#define REG_9346CR_8723B				0x000A	/*  2 Byte */
-#define REG_EE_VPD_8723B				0x000C	/*  2 Byte */
-#define REG_AFE_MISC_8723B				0x0010	/*  1 Byte */
-#define REG_SPS0_CTRL_8723B				0x0011	/*  7 Byte */
+#define REG_SYS_CLKR_8723B			0x0008	/*  2 Byte */
+#define REG_9346CR_8723B			0x000A	/*  2 Byte */
+#define REG_EE_VPD_8723B			0x000C	/*  2 Byte */
+#define REG_AFE_MISC_8723B			0x0010	/*  1 Byte */
+#define REG_SPS0_CTRL_8723B			0x0011	/*  7 Byte */
 #define REG_SPS_OCP_CFG_8723B			0x0018	/*  4 Byte */
-#define REG_RSV_CTRL_8723B				0x001C	/*  3 Byte */
-#define REG_RF_CTRL_8723B				0x001F	/*  1 Byte */
+#define REG_RSV_CTRL_8723B			0x001C	/*  3 Byte */
+#define REG_RF_CTRL_8723B			0x001F	/*  1 Byte */
 #define REG_LPLDO_CTRL_8723B			0x0023	/*  1 Byte */
-#define REG_AFE_XTAL_CTRL_8723B		0x0024	/*  4 Byte */
+#define REG_AFE_XTAL_CTRL_8723B			0x0024	/*  4 Byte */
 #define REG_AFE_PLL_CTRL_8723B			0x0028	/*  4 Byte */
 #define REG_MAC_PLL_CTRL_EXT_8723B		0x002c	/*  4 Byte */
 #define REG_EFUSE_CTRL_8723B			0x0030
 #define REG_EFUSE_TEST_8723B			0x0034
-#define REG_PWR_DATA_8723B				0x0038
-#define REG_CAL_TIMER_8723B				0x003C
-#define REG_ACLK_MON_8723B				0x003E
+#define REG_PWR_DATA_8723B			0x0038
+#define REG_CAL_TIMER_8723B			0x003C
+#define REG_ACLK_MON_8723B			0x003E
 #define REG_GPIO_MUXCFG_8723B			0x0040
 #define REG_GPIO_IO_SEL_8723B			0x0042
 #define REG_MAC_PINMUX_CFG_8723B		0x0043
 #define REG_GPIO_PIN_CTRL_8723B			0x0044
-#define REG_GPIO_INTM_8723B				0x0048
-#define REG_LEDCFG0_8723B				0x004C
-#define REG_LEDCFG1_8723B				0x004D
-#define REG_LEDCFG2_8723B				0x004E
-#define REG_LEDCFG3_8723B				0x004F
-#define REG_FSIMR_8723B					0x0050
-#define REG_FSISR_8723B					0x0054
-#define REG_HSIMR_8723B					0x0058
-#define REG_HSISR_8723B					0x005c
-#define REG_GPIO_EXT_CTRL				0x0060
+#define REG_GPIO_INTM_8723B			0x0048
+#define REG_LEDCFG0_8723B			0x004C
+#define REG_LEDCFG1_8723B			0x004D
+#define REG_LEDCFG2_8723B			0x004E
+#define REG_LEDCFG3_8723B			0x004F
+#define REG_FSIMR_8723B				0x0050
+#define REG_FSISR_8723B				0x0054
+#define REG_HSIMR_8723B				0x0058
+#define REG_HSISR_8723B				0x005c
+#define REG_GPIO_EXT_CTRL			0x0060
 #define REG_MULTI_FUNC_CTRL_8723B		0x0068
 #define REG_GPIO_STATUS_8723B			0x006C
-#define REG_SDIO_CTRL_8723B				0x0070
-#define REG_OPT_CTRL_8723B				0x0074
-#define REG_AFE_XTAL_CTRL_EXT_8723B	0x0078
-#define REG_MCUFWDL_8723B				0x0080
+#define REG_SDIO_CTRL_8723B			0x0070
+#define REG_OPT_CTRL_8723B			0x0074
+#define REG_AFE_XTAL_CTRL_EXT_8723B		0x0078
+#define REG_MCUFWDL_8723B			0x0080
 #define REG_BT_PATCH_STATUS_8723B		0x0088
-#define REG_HIMR0_8723B					0x00B0
-#define REG_HISR0_8723B					0x00B4
-#define REG_HIMR1_8723B					0x00B8
-#define REG_HISR1_8723B					0x00BC
+#define REG_HIMR0_8723B				0x00B0
+#define REG_HISR0_8723B				0x00B4
+#define REG_HIMR1_8723B				0x00B8
+#define REG_HISR1_8723B				0x00BC
 #define REG_PMC_DBG_CTRL2_8723B			0x00CC
 #define	REG_EFUSE_BURN_GNT_8723B		0x00CF
-#define REG_HPON_FSM_8723B				0x00EC
-#define REG_SYS_CFG_8723B				0x00F0
-#define REG_SYS_CFG1_8723B				0x00FC
-#define REG_ROM_VERSION					0x00FD
+#define REG_HPON_FSM_8723B			0x00EC
+#define REG_SYS_CFG_8723B			0x00F0
+#define REG_SYS_CFG1_8723B			0x00FC
+#define REG_ROM_VERSION				0x00FD
 
 /*  */
 /*  */
 /*	0x0100h ~ 0x01FFh	MACTOP General Configuration */
 /*  */
 /*  */
-#define REG_CR_8723B						0x0100
-#define REG_PBP_8723B					0x0104
-#define REG_PKT_BUFF_ACCESS_CTRL_8723B	0x0106
+#define REG_CR_8723B				0x0100
+#define REG_PBP_8723B				0x0104
+#define REG_PKT_BUFF_ACCESS_CTRL_8723B		0x0106
 #define REG_TRXDMA_CTRL_8723B			0x010C
 #define REG_TRXFF_BNDY_8723B			0x0114
 #define REG_TRXFF_STATUS_8723B			0x0118
-#define REG_RXFF_PTR_8723B				0x011C
-#define REG_CPWM_8723B					0x012F
-#define REG_FWIMR_8723B					0x0130
-#define REG_FWISR_8723B					0x0134
-#define REG_FTIMR_8723B					0x0138
+#define REG_RXFF_PTR_8723B			0x011C
+#define REG_CPWM_8723B				0x012F
+#define REG_FWIMR_8723B				0x0130
+#define REG_FWISR_8723B				0x0134
+#define REG_FTIMR_8723B				0x0138
 #define REG_PKTBUF_DBG_CTRL_8723B		0x0140
-#define REG_RXPKTBUF_CTRL_8723B		0x0142
-#define REG_PKTBUF_DBG_DATA_L_8723B	0x0144
-#define REG_PKTBUF_DBG_DATA_H_8723B	0x0148
+#define REG_RXPKTBUF_CTRL_8723B			0x0142
+#define REG_PKTBUF_DBG_DATA_L_8723B		0x0144
+#define REG_PKTBUF_DBG_DATA_H_8723B		0x0148
 
-#define REG_TC0_CTRL_8723B				0x0150
-#define REG_TC1_CTRL_8723B				0x0154
-#define REG_TC2_CTRL_8723B				0x0158
-#define REG_TC3_CTRL_8723B				0x015C
-#define REG_TC4_CTRL_8723B				0x0160
+#define REG_TC0_CTRL_8723B			0x0150
+#define REG_TC1_CTRL_8723B			0x0154
+#define REG_TC2_CTRL_8723B			0x0158
+#define REG_TC3_CTRL_8723B			0x015C
+#define REG_TC4_CTRL_8723B			0x0160
 #define REG_TCUNIT_BASE_8723B			0x0164
-#define REG_RSVD3_8723B					0x0168
-#define REG_C2HEVT_MSG_NORMAL_8723B	0x01A0
-#define REG_C2HEVT_CMD_SEQ_88XX		0x01A1
-#define REG_C2HEVT_CMD_CONTENT_88XX	0x01A2
-#define REG_C2HEVT_CMD_LEN_88XX		0x01AE
+#define REG_RSVD3_8723B				0x0168
+#define REG_C2HEVT_MSG_NORMAL_8723B		0x01A0
+#define REG_C2HEVT_CMD_SEQ_88XX			0x01A1
+#define REG_C2HEVT_CMD_CONTENT_88XX		0x01A2
+#define REG_C2HEVT_CMD_LEN_88XX			0x01AE
 #define REG_C2HEVT_CLEAR_8723B			0x01AF
-#define REG_MCUTST_1_8723B				0x01C0
-#define REG_MCUTST_WOWLAN_8723B		0x01C7
-#define REG_FMETHR_8723B				0x01C8
-#define REG_HMETFR_8723B				0x01CC
-#define REG_HMEBOX_0_8723B				0x01D0
-#define REG_HMEBOX_1_8723B				0x01D4
-#define REG_HMEBOX_2_8723B				0x01D8
-#define REG_HMEBOX_3_8723B				0x01DC
-#define REG_LLT_INIT_8723B				0x01E0
+#define REG_MCUTST_1_8723B			0x01C0
+#define REG_MCUTST_WOWLAN_8723B			0x01C7
+#define REG_FMETHR_8723B			0x01C8
+#define REG_HMETFR_8723B			0x01CC
+#define REG_HMEBOX_0_8723B			0x01D0
+#define REG_HMEBOX_1_8723B			0x01D4
+#define REG_HMEBOX_2_8723B			0x01D8
+#define REG_HMEBOX_3_8723B			0x01DC
+#define REG_LLT_INIT_8723B			0x01E0
 #define REG_HMEBOX_EXT0_8723B			0x01F0
 #define REG_HMEBOX_EXT1_8723B			0x01F4
 #define REG_HMEBOX_EXT2_8723B			0x01F8
@@ -132,11 +132,11 @@
 /*	0x0200h ~ 0x027Fh	TXDMA Configuration */
 /*  */
 /*  */
-#define REG_RQPN_8723B					0x0200
-#define REG_FIFOPAGE_8723B				0x0204
+#define REG_RQPN_8723B				0x0200
+#define REG_FIFOPAGE_8723B			0x0204
 #define REG_DWBCN0_CTRL_8723B			REG_TDECTRL
-#define REG_TXDMA_OFFSET_CHK_8723B	0x020C
-#define REG_TXDMA_STATUS_8723B		0x0210
+#define REG_TXDMA_OFFSET_CHK_8723B		0x020C
+#define REG_TXDMA_STATUS_8723B			0x0210
 #define REG_RQPN_NPQ_8723B			0x0214
 #define REG_DWBCN1_CTRL_8723B			0x0228
 
@@ -146,41 +146,41 @@
 /*  */
 /*  */
 #define REG_RXDMA_AGG_PG_TH_8723B		0x0280
-#define REG_FW_UPD_RDPTR_8723B		0x0284 /*  FW shall update this register before FW write RXPKT_RELEASE_POLL to 1 */
-#define REG_RXDMA_CONTROL_8723B		0x0286 /*  Control the RX DMA. */
+#define REG_FW_UPD_RDPTR_8723B			0x0284 /*  FW shall update this register before FW write RXPKT_RELEASE_POLL to 1 */
+#define REG_RXDMA_CONTROL_8723B			0x0286 /*  Control the RX DMA. */
 #define REG_RXPKT_NUM_8723B			0x0287 /*  The number of packets in RXPKTBUF. */
 #define REG_RXDMA_STATUS_8723B			0x0288
 #define REG_RXDMA_PRO_8723B			0x0290
-#define REG_EARLY_MODE_CONTROL_8723B	0x02BC
-#define REG_RSVD5_8723B					0x02F0
-#define REG_RSVD6_8723B					0x02F4
+#define REG_EARLY_MODE_CONTROL_8723B		0x02BC
+#define REG_RSVD5_8723B				0x02F0
+#define REG_RSVD6_8723B				0x02F4
 
 /*  */
 /*  */
 /*	0x0300h ~ 0x03FFh	PCIe */
 /*  */
 /*  */
-#define	REG_PCIE_CTRL_REG_8723B		0x0300
-#define	REG_INT_MIG_8723B				0x0304	/*  Interrupt Migration */
+#define	REG_PCIE_CTRL_REG_8723B			0x0300
+#define	REG_INT_MIG_8723B			0x0304	/*  Interrupt Migration */
 #define	REG_BCNQ_DESA_8723B			0x0308	/*  TX Beacon Descriptor Address */
-#define	REG_HQ_DESA_8723B				0x0310	/*  TX High Queue Descriptor Address */
+#define	REG_HQ_DESA_8723B			0x0310	/*  TX High Queue Descriptor Address */
 #define	REG_MGQ_DESA_8723B			0x0318	/*  TX Manage Queue Descriptor Address */
 #define	REG_VOQ_DESA_8723B			0x0320	/*  TX VO Queue Descriptor Address */
-#define	REG_VIQ_DESA_8723B				0x0328	/*  TX VI Queue Descriptor Address */
+#define	REG_VIQ_DESA_8723B			0x0328	/*  TX VI Queue Descriptor Address */
 #define	REG_BEQ_DESA_8723B			0x0330	/*  TX BE Queue Descriptor Address */
 #define	REG_BKQ_DESA_8723B			0x0338	/*  TX BK Queue Descriptor Address */
-#define	REG_RX_DESA_8723B				0x0340	/*  RX Queue	Descriptor Address */
+#define	REG_RX_DESA_8723B			0x0340	/*  RX Queue	Descriptor Address */
 #define	REG_DBI_WDATA_8723B			0x0348	/*  DBI Write Data */
 #define	REG_DBI_RDATA_8723B			0x034C	/*  DBI Read Data */
-#define	REG_DBI_ADDR_8723B				0x0350	/*  DBI Address */
-#define	REG_DBI_FLAG_8723B				0x0352	/*  DBI Read/Write Flag */
-#define	REG_MDIO_WDATA_8723B		0x0354	/*  MDIO for Write PCIE PHY */
+#define	REG_DBI_ADDR_8723B			0x0350	/*  DBI Address */
+#define	REG_DBI_FLAG_8723B			0x0352	/*  DBI Read/Write Flag */
+#define	REG_MDIO_WDATA_8723B			0x0354	/*  MDIO for Write PCIE PHY */
 #define	REG_MDIO_RDATA_8723B			0x0356	/*  MDIO for Reads PCIE PHY */
 #define	REG_MDIO_CTL_8723B			0x0358	/*  MDIO for Control */
-#define	REG_DBG_SEL_8723B				0x0360	/*  Debug Selection Register */
+#define	REG_DBG_SEL_8723B			0x0360	/*  Debug Selection Register */
 #define	REG_PCIE_HRPWM_8723B			0x0361	/* PCIe RPWM */
 #define	REG_PCIE_HCPWM_8723B			0x0363	/* PCIe CPWM */
-#define	REG_PCIE_MULTIFET_CTRL_8723B	0x036A	/* PCIE Multi-Fethc Control */
+#define	REG_PCIE_MULTIFET_CTRL_8723B		0x036A	/* PCIE Multi-Fethc Control */
 
 /*  spec version 11 */
 /*  */
@@ -194,46 +194,46 @@
 #define REG_BKQ_INFORMATION_8723B		0x040C
 #define REG_MGQ_INFORMATION_8723B		0x0410
 #define REG_HGQ_INFORMATION_8723B		0x0414
-#define REG_BCNQ_INFORMATION_8723B	0x0418
+#define REG_BCNQ_INFORMATION_8723B		0x0418
 #define REG_TXPKT_EMPTY_8723B			0x041A
 
-#define REG_FWHW_TXQ_CTRL_8723B		0x0420
+#define REG_FWHW_TXQ_CTRL_8723B			0x0420
 #define REG_HWSEQ_CTRL_8723B			0x0423
-#define REG_TXPKTBUF_BCNQ_BDNY_8723B	0x0424
-#define REG_TXPKTBUF_MGQ_BDNY_8723B	0x0425
+#define REG_TXPKTBUF_BCNQ_BDNY_8723B		0x0424
+#define REG_TXPKTBUF_MGQ_BDNY_8723B		0x0425
 #define REG_LIFECTRL_CTRL_8723B			0x0426
-#define REG_MULTI_BCNQ_OFFSET_8723B	0x0427
-#define REG_SPEC_SIFS_8723B				0x0428
-#define REG_RL_8723B						0x042A
-#define REG_TXBF_CTRL_8723B				0x042C
-#define REG_DARFRC_8723B				0x0430
-#define REG_RARFRC_8723B				0x0438
-#define REG_RRSR_8723B					0x0440
-#define REG_ARFR0_8723B					0x0444
-#define REG_ARFR1_8723B					0x044C
-#define REG_CCK_CHECK_8723B				0x0454
+#define REG_MULTI_BCNQ_OFFSET_8723B		0x0427
+#define REG_SPEC_SIFS_8723B			0x0428
+#define REG_RL_8723B				0x042A
+#define REG_TXBF_CTRL_8723B			0x042C
+#define REG_DARFRC_8723B			0x0430
+#define REG_RARFRC_8723B			0x0438
+#define REG_RRSR_8723B				0x0440
+#define REG_ARFR0_8723B				0x0444
+#define REG_ARFR1_8723B				0x044C
+#define REG_CCK_CHECK_8723B			0x0454
 #define REG_AMPDU_MAX_TIME_8723B		0x0456
-#define REG_TXPKTBUF_BCNQ_BDNY1_8723B	0x0457
+#define REG_TXPKTBUF_BCNQ_BDNY1_8723B		0x0457
 
-#define REG_AMPDU_MAX_LENGTH_8723B	0x0458
+#define REG_AMPDU_MAX_LENGTH_8723B		0x0458
 #define REG_TXPKTBUF_WMAC_LBK_BF_HD_8723B	0x045D
-#define REG_NDPA_OPT_CTRL_8723B		0x045F
+#define REG_NDPA_OPT_CTRL_8723B			0x045F
 #define REG_FAST_EDCA_CTRL_8723B		0x0460
 #define REG_RD_RESP_PKT_TH_8723B		0x0463
-#define REG_DATA_SC_8723B				0x0483
-#define REG_TXRPT_START_OFFSET		0x04AC
-#define REG_POWER_STAGE1_8723B		0x04B4
-#define REG_POWER_STAGE2_8723B		0x04B8
-#define REG_AMPDU_BURST_MODE_8723B	0x04BC
-#define REG_PKT_VO_VI_LIFE_TIME_8723B	0x04C0
-#define REG_PKT_BE_BK_LIFE_TIME_8723B	0x04C2
+#define REG_DATA_SC_8723B			0x0483
+#define REG_TXRPT_START_OFFSET			0x04AC
+#define REG_POWER_STAGE1_8723B			0x04B4
+#define REG_POWER_STAGE2_8723B			0x04B8
+#define REG_AMPDU_BURST_MODE_8723B		0x04BC
+#define REG_PKT_VO_VI_LIFE_TIME_8723B		0x04C0
+#define REG_PKT_BE_BK_LIFE_TIME_8723B		0x04C2
 #define REG_STBC_SETTING_8723B			0x04C4
 #define REG_HT_SINGLE_AMPDU_8723B		0x04C7
 #define REG_PROT_MODE_CTRL_8723B		0x04C8
-#define REG_MAX_AGGR_NUM_8723B		0x04CA
-#define REG_RTS_MAX_AGGR_NUM_8723B	0x04CB
-#define REG_BAR_MODE_CTRL_8723B		0x04CC
-#define REG_RA_TRY_RATE_AGG_LMT_8723B	0x04CF
+#define REG_MAX_AGGR_NUM_8723B			0x04CA
+#define REG_RTS_MAX_AGGR_NUM_8723B		0x04CB
+#define REG_BAR_MODE_CTRL_8723B			0x04CC
+#define REG_RA_TRY_RATE_AGG_LMT_8723B		0x04CF
 #define REG_MACID_PKT_DROP0_8723B		0x04D0
 #define REG_MACID_PKT_SLEEP_8723B		0x04D4
 
@@ -242,21 +242,21 @@
 /*	0x0500h ~ 0x05FFh	EDCA Configuration */
 /*  */
 /*  */
-#define REG_EDCA_VO_PARAM_8723B		0x0500
-#define REG_EDCA_VI_PARAM_8723B		0x0504
-#define REG_EDCA_BE_PARAM_8723B		0x0508
-#define REG_EDCA_BK_PARAM_8723B		0x050C
-#define REG_BCNTCFG_8723B				0x0510
-#define REG_PIFS_8723B					0x0512
-#define REG_RDG_PIFS_8723B				0x0513
-#define REG_SIFS_CTX_8723B				0x0514
-#define REG_SIFS_TRX_8723B				0x0516
+#define REG_EDCA_VO_PARAM_8723B			0x0500
+#define REG_EDCA_VI_PARAM_8723B			0x0504
+#define REG_EDCA_BE_PARAM_8723B			0x0508
+#define REG_EDCA_BK_PARAM_8723B			0x050C
+#define REG_BCNTCFG_8723B			0x0510
+#define REG_PIFS_8723B				0x0512
+#define REG_RDG_PIFS_8723B			0x0513
+#define REG_SIFS_CTX_8723B			0x0514
+#define REG_SIFS_TRX_8723B			0x0516
 #define REG_AGGR_BREAK_TIME_8723B		0x051A
-#define REG_SLOT_8723B					0x051B
+#define REG_SLOT_8723B				0x051B
 #define REG_TX_PTCL_CTRL_8723B			0x0520
-#define REG_TXPAUSE_8723B				0x0522
-#define REG_DIS_TXREQ_CLR_8723B		0x0523
-#define REG_RD_CTRL_8723B				0x0524
+#define REG_TXPAUSE_8723B			0x0522
+#define REG_DIS_TXREQ_CLR_8723B			0x0523
+#define REG_RD_CTRL_8723B			0x0524
 /*  */
 /*  Format for offset 540h-542h: */
 /*	[3:0]:	TBTT prohibit setup in unit of 32us. The time for HW getting beacon content before TBTT. */
@@ -272,84 +272,84 @@
 /*  Note: We cannot update beacon content to HW or send any AC packets during the time between Setup and Hold. */
 /*  Described by Designer Tim and Bruce, 2011-01-14. */
 /*  */
-#define REG_TBTT_PROHIBIT_8723B		0x0540
-#define REG_RD_NAV_NXT_8723B		0x0544
-#define REG_NAV_PROT_LEN_8723B		0x0546
-#define REG_BCN_CTRL_8723B		0x0550
-#define REG_BCN_CTRL_1_8723B		0x0551
-#define REG_MBID_NUM_8723B		0x0552
-#define REG_DUAL_TSF_RST_8723B		0x0553
-#define REG_BCN_INTERVAL_8723B		0x0554
-#define REG_DRVERLYINT_8723B		0x0558
-#define REG_BCNDMATIM_8723B		0x0559
-#define REG_ATIMWND_8723B		0x055A
-#define REG_USTIME_TSF_8723B		0x055C
-#define REG_BCN_MAX_ERR_8723B		0x055D
-#define REG_RXTSF_OFFSET_CCK_8723B	0x055E
-#define REG_RXTSF_OFFSET_OFDM_8723B	0x055F
-#define REG_TSFTR_8723B			0x0560
-#define REG_CTWND_8723B			0x0572
-#define REG_SECONDARY_CCA_CTRL_8723B	0x0577
-#define REG_PSTIMER_8723B		0x0580
-#define REG_TIMER0_8723B		0x0584
-#define REG_TIMER1_8723B		0x0588
-#define REG_ACMHWCTRL_8723B		0x05C0
-#define REG_SCH_TXCMD_8723B		0x05F8
+#define REG_TBTT_PROHIBIT_8723B			0x0540
+#define REG_RD_NAV_NXT_8723B			0x0544
+#define REG_NAV_PROT_LEN_8723B			0x0546
+#define REG_BCN_CTRL_8723B			0x0550
+#define REG_BCN_CTRL_1_8723B			0x0551
+#define REG_MBID_NUM_8723B			0x0552
+#define REG_DUAL_TSF_RST_8723B			0x0553
+#define REG_BCN_INTERVAL_8723B			0x0554
+#define REG_DRVERLYINT_8723B			0x0558
+#define REG_BCNDMATIM_8723B			0x0559
+#define REG_ATIMWND_8723B			0x055A
+#define REG_USTIME_TSF_8723B			0x055C
+#define REG_BCN_MAX_ERR_8723B			0x055D
+#define REG_RXTSF_OFFSET_CCK_8723B		0x055E
+#define REG_RXTSF_OFFSET_OFDM_8723B		0x055F
+#define REG_TSFTR_8723B				0x0560
+#define REG_CTWND_8723B				0x0572
+#define REG_SECONDARY_CCA_CTRL_8723B		0x0577
+#define REG_PSTIMER_8723B			0x0580
+#define REG_TIMER0_8723B			0x0584
+#define REG_TIMER1_8723B			0x0588
+#define REG_ACMHWCTRL_8723B			0x05C0
+#define REG_SCH_TXCMD_8723B			0x05F8
 
 /*	0x0600h ~ 0x07FFh	WMAC Configuration */
-#define REG_MAC_CR_8723B		0x0600
-#define REG_TCR_8723B			0x0604
-#define REG_RCR_8723B			0x0608
-#define REG_RX_PKT_LIMIT_8723B		0x060C
-#define REG_RX_DLK_TIME_8723B		0x060D
-#define REG_RX_DRVINFO_SZ_8723B		0x060F
+#define REG_MAC_CR_8723B			0x0600
+#define REG_TCR_8723B				0x0604
+#define REG_RCR_8723B				0x0608
+#define REG_RX_PKT_LIMIT_8723B			0x060C
+#define REG_RX_DLK_TIME_8723B			0x060D
+#define REG_RX_DRVINFO_SZ_8723B			0x060F
 
-#define REG_MACID_8723B			0x0610
-#define REG_BSSID_8723B			0x0618
-#define REG_MAR_8723B			0x0620
-#define REG_MBIDCAMCFG_8723B		0x0628
+#define REG_MACID_8723B				0x0610
+#define REG_BSSID_8723B				0x0618
+#define REG_MAR_8723B				0x0620
+#define REG_MBIDCAMCFG_8723B			0x0628
 
-#define REG_USTIME_EDCA_8723B		0x0638
-#define REG_MAC_SPEC_SIFS_8723B		0x063A
-#define REG_RESP_SIFP_CCK_8723B		0x063C
-#define REG_RESP_SIFS_OFDM_8723B	0x063E
-#define REG_ACKTO_8723B			0x0640
-#define REG_CTS2TO_8723B		0x0641
-#define REG_EIFS_8723B			0x0642
+#define REG_USTIME_EDCA_8723B			0x0638
+#define REG_MAC_SPEC_SIFS_8723B			0x063A
+#define REG_RESP_SIFP_CCK_8723B			0x063C
+#define REG_RESP_SIFS_OFDM_8723B		0x063E
+#define REG_ACKTO_8723B				0x0640
+#define REG_CTS2TO_8723B			0x0641
+#define REG_EIFS_8723B				0x0642
 
-#define REG_NAV_UPPER_8723B		0x0652	/*  unit of 128 */
-#define REG_TRXPTCL_CTL_8723B		0x0668
+#define REG_NAV_UPPER_8723B			0x0652	/*  unit of 128 */
+#define REG_TRXPTCL_CTL_8723B			0x0668
 
 /*  Security */
-#define REG_CAMCMD_8723B		0x0670
-#define REG_CAMWRITE_8723B		0x0674
-#define REG_CAMREAD_8723B		0x0678
-#define REG_CAMDBG_8723B		0x067C
-#define REG_SECCFG_8723B		0x0680
+#define REG_CAMCMD_8723B			0x0670
+#define REG_CAMWRITE_8723B			0x0674
+#define REG_CAMREAD_8723B			0x0678
+#define REG_CAMDBG_8723B			0x067C
+#define REG_SECCFG_8723B			0x0680
 
 /*  Power */
-#define REG_WOW_CTRL_8723B		0x0690
-#define REG_PS_RX_INFO_8723B		0x0692
-#define REG_UAPSD_TID_8723B		0x0693
-#define REG_WKFMCAM_CMD_8723B		0x0698
-#define REG_WKFMCAM_NUM_8723B		0x0698
-#define REG_WKFMCAM_RWD_8723B		0x069C
-#define REG_RXFLTMAP0_8723B		0x06A0
-#define REG_RXFLTMAP1_8723B		0x06A2
-#define REG_RXFLTMAP2_8723B		0x06A4
-#define REG_BCN_PSR_RPT_8723B		0x06A8
-#define REG_BT_COEX_TABLE_8723B		0x06C0
-#define REG_BFMER0_INFO_8723B		0x06E4
-#define REG_BFMER1_INFO_8723B		0x06EC
-#define REG_CSI_RPT_PARAM_BW20_8723B	0x06F4
-#define REG_CSI_RPT_PARAM_BW40_8723B	0x06F8
-#define REG_CSI_RPT_PARAM_BW80_8723B	0x06FC
+#define REG_WOW_CTRL_8723B			0x0690
+#define REG_PS_RX_INFO_8723B			0x0692
+#define REG_UAPSD_TID_8723B			0x0693
+#define REG_WKFMCAM_CMD_8723B			0x0698
+#define REG_WKFMCAM_NUM_8723B			0x0698
+#define REG_WKFMCAM_RWD_8723B			0x069C
+#define REG_RXFLTMAP0_8723B			0x06A0
+#define REG_RXFLTMAP1_8723B			0x06A2
+#define REG_RXFLTMAP2_8723B			0x06A4
+#define REG_BCN_PSR_RPT_8723B			0x06A8
+#define REG_BT_COEX_TABLE_8723B			0x06C0
+#define REG_BFMER0_INFO_8723B			0x06E4
+#define REG_BFMER1_INFO_8723B			0x06EC
+#define REG_CSI_RPT_PARAM_BW20_8723B		0x06F4
+#define REG_CSI_RPT_PARAM_BW40_8723B		0x06F8
+#define REG_CSI_RPT_PARAM_BW80_8723B		0x06FC
 
 /*  Hardware Port 2 */
-#define REG_MACID1_8723B		0x0700
-#define REG_BSSID1_8723B		0x0708
-#define REG_BFMEE_SEL_8723B		0x0714
-#define REG_SND_PTCL_CTRL_8723B		0x0718
+#define REG_MACID1_8723B			0x0700
+#define REG_BSSID1_8723B			0x0708
+#define REG_BFMEE_SEL_8723B			0x0714
+#define REG_SND_PTCL_CTRL_8723B			0x0718
 
 /*	Redifine 8192C register definition for compatibility */
 
-- 
2.25.1

