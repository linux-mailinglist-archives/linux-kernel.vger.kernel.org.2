Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D035CEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbhDLQrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbhDLQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:36:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D042C06136D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:30:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so13574947wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKFmckhJz1VQS6Awob+qO1rgj7w9RZgnwYkma6KaDks=;
        b=ecZVrX285qWlOUfKCveyPLbvKpIuiTuqI0EHT3oh5gbDaxMPsPdq2ieycXoduoZcAB
         b1QZuJoFjuMG7ba8awJAiRR4WwNCEYvD4CUGaO1cvtHm7u9kB2lJDrt+JZP+hrDr107+
         oXYxKNC9VmNWu0jL1U9xWrCZnMKvoZ5yB1eORPex+1IhZ+vrxBXZBZjR4ztpoxNtNsa+
         yhnuFDJJkEj+Nyt8XUTvN526yEfreyyjpWfSpbu44fZpWdQpVNBAdydygU5jqkcYZ24W
         TY4XYrugvEp9I9kbQZ8BqBQm3+RA5c3/ej/H4uvv99ziNAOqo6Z/zC5hHCEzjzf/f0Eo
         VI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKFmckhJz1VQS6Awob+qO1rgj7w9RZgnwYkma6KaDks=;
        b=LefwL3u6Cxot1gLYJjSHqrraGRZumbole/XszlgUYVgBhQSAjcstqBgqMn0HoYeDuc
         aSOqzrdqf6zbfBMrkyQy8ActHhLi58lVfiNubPBtaMrmiNZx6jLfkp82MqllVlJ+hMsi
         fuqqKdMYpMBCRu6fz0w55H94F2Nawc077Tp2LJZDQZ7Ay3MlqOyJQBMgbJ/V6vXaruFE
         UvLVWii40SminlfkIqnh8YUerDc3jVctPmTIz5Y6IK6VTlRAbf2wS8ZibrJyrMex7jei
         +7kHZqpw+0JytEvo5yWxUzNGeZfQXQGWt+Ou17BEUa/piYNpXq84qSc1EDHlMZbSehdO
         4V2g==
X-Gm-Message-State: AOAM533mhrzD8Zk5OCMD/b5ugmVWj1VamJliTcR76Q8jfaUsXTesiZYn
        Y8XuZyq9228LzlL4eKUJ1mM=
X-Google-Smtp-Source: ABdhPJwaxWWWdCEKP71OaUul8gGzPUcFLqO2mrxNUEt8grdarnRRAfHGqjrOtzlMNR//zBS8afESMQ==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr31946331wrq.20.1618245006273;
        Mon, 12 Apr 2021 09:30:06 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:813f:b20e:675a:834d])
        by smtp.gmail.com with ESMTPSA id b5sm16786524wri.57.2021.04.12.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:30:05 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: hal: remove space before tabs
Date:   Mon, 12 Apr 2021 17:29:36 +0100
Message-Id: <9694aafb614bdcbb15fdea614502c1b31a534871.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary space before tabs to conform with Linux kernel
coding style.
Reported by checkpatch in file Hal8723BReg.h

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 26 ++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index 616d20106392..68a56627546f 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
+++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
@@ -27,7 +27,7 @@
 
 /*  */
 /*  */
-/* 	0x0000h ~ 0x00FFh	System Configuration */
+/*	0x0000h ~ 0x00FFh	System Configuration */
 /*  */
 /*  */
 #define REG_SYS_ISO_CTRL_8723B			0x0000	/*  2 Byte */
@@ -84,7 +84,7 @@
 
 /*  */
 /*  */
-/* 	0x0100h ~ 0x01FFh	MACTOP General Configuration */
+/*	0x0100h ~ 0x01FFh	MACTOP General Configuration */
 /*  */
 /*  */
 #define REG_CR_8723B						0x0100
@@ -131,7 +131,7 @@
 
 /*  */
 /*  */
-/* 	0x0200h ~ 0x027Fh	TXDMA Configuration */
+/*	0x0200h ~ 0x027Fh	TXDMA Configuration */
 /*  */
 /*  */
 #define REG_RQPN_8723B					0x0200
@@ -145,7 +145,7 @@
 
 /*  */
 /*  */
-/* 	0x0280h ~ 0x02FFh	RXDMA Configuration */
+/*	0x0280h ~ 0x02FFh	RXDMA Configuration */
 /*  */
 /*  */
 #define REG_RXDMA_AGG_PG_TH_8723B		0x0280
@@ -161,7 +161,7 @@
 
 /*  */
 /*  */
-/* 	0x0300h ~ 0x03FFh	PCIe */
+/*	0x0300h ~ 0x03FFh	PCIe */
 /*  */
 /*  */
 #define	REG_PCIE_CTRL_REG_8723B		0x0300
@@ -189,7 +189,7 @@
 /*  spec version 11 */
 /*  */
 /*  */
-/* 	0x0400h ~ 0x047Fh	Protocol Configuration */
+/*	0x0400h ~ 0x047Fh	Protocol Configuration */
 /*  */
 /*  */
 #define REG_VOQ_INFORMATION_8723B		0x0400
@@ -243,7 +243,7 @@
 
 /*  */
 /*  */
-/* 	0x0500h ~ 0x05FFh	EDCA Configuration */
+/*	0x0500h ~ 0x05FFh	EDCA Configuration */
 /*  */
 /*  */
 #define REG_EDCA_VO_PARAM_8723B		0x0500
@@ -263,10 +263,10 @@
 #define REG_RD_CTRL_8723B				0x0524
 /*  */
 /*  Format for offset 540h-542h: */
-/* 	[3:0]:   TBTT prohibit setup in unit of 32us. The time for HW getting beacon content before TBTT. */
-/* 	[7:4]:   Reserved. */
-/* 	[19:8]:  TBTT prohibit hold in unit of 32us. The time for HW holding to send the beacon packet. */
-/* 	[23:20]: Reserved */
+/*	[3:0]:	TBTT prohibit setup in unit of 32us. The time for HW getting beacon content before TBTT. */
+/*	[7:4]:	Reserved. */
+/*	[19:8]:	TBTT prohibit hold in unit of 32us. The time for HW holding to send the beacon packet. */
+/*	[23:20]: Reserved */
 /*  Description: */
 /* 	              | */
 /*      |<--Setup--|--Hold------------>| */
@@ -300,7 +300,7 @@
 #define REG_ACMHWCTRL_8723B		0x05C0
 #define REG_SCH_TXCMD_8723B		0x05F8
 
-/* 	0x0600h ~ 0x07FFh	WMAC Configuration */
+/*	0x0600h ~ 0x07FFh	WMAC Configuration */
 #define REG_MAC_CR_8723B		0x0600
 #define REG_TCR_8723B			0x0604
 #define REG_RCR_8723B			0x0608
@@ -356,7 +356,7 @@
 #define REG_SND_PTCL_CTRL_8723B		0x0718
 
 
-/* 	Redifine 8192C register definition for compatibility */
+/*	Redifine 8192C register definition for compatibility */
 
 /*  TODO: use these definition when using REG_xxx naming rule. */
 /*  NOTE: DO NOT Remove these definition. Use later. */
-- 
2.25.1

