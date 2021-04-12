Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1235CFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbhDLR7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbhDLR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:59:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:59:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 18so16168925edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpHzwr+heS9t2NcYSyICKCt14obVPA73oKjnrQ9jx7A=;
        b=tk6amiVLI1YZwnjzPKMpyDPVslNhfiTBnYoS2Sv4JgDekur2tBaZ6/86m0rXlUzQUn
         45lxW1LWM8dmgXj1RAdiWb+6jSfOocjpqPWvrLdnPg0gY+XvgnAjEN3SjWbkPr3EFp2a
         BKvQYLdHvDvn6pd4ThMT1HjT5XD6uyOl7Zt/M/dtnOjPeGLJWGshdAZZ34GShG1iLkid
         BmfvmBBl6zlZv9zd/HGdK0ZEXEDG5up/g/8UWH3FbS+SIfRfA57epZLjv271h4G7UX3l
         nmpSAGRUD8zzTWlv3q1pz4uZVKc4fJkedSkVPupzUkpxixf6VwPhYHgbYhXMCLDnyKoh
         WQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpHzwr+heS9t2NcYSyICKCt14obVPA73oKjnrQ9jx7A=;
        b=HY3GLMXDlElpvIQJ8eUCGm2968sFYpL30P0BSSvg5E2btdud02iZywu9L7c5YsTRkZ
         E1yOg77zJxTjCzH/sQ0N/z5p1dFdchXNDGbZZ3jERIQbKJ0bJXaiEhUjb4PJ9/IipPqZ
         b5jfp35yJSvUo8r1nAca7Jl2ZB7VhhyY8E84gNUWf6yLypGzp5W+3NYVxw12eA+z9omI
         7R1nLv6SgOW5+gd8DnLNsV+AJUnSbUch5ldKTY1NX6OACKEh1rBGsqtocWR04dRZ4FEs
         dec8MQ+ml2IbH5lpWq+AGZW9rXWzTMol/ML+VTg2n8i9tzn7nqcHYDr3Nbm6f1zzpGIt
         fIXg==
X-Gm-Message-State: AOAM531BjJVQlR8bMspnW8l7IAB2+Gol93LfJJ5uw7rzb06tGtKsxGhR
        G/3Ce3JIxDJVb/7onahsO6M=
X-Google-Smtp-Source: ABdhPJxmXN7cTVpr8OZcuB9BUgyHdVWealRPIV7CiF9Gawcr1SOh1quLnyGvJKlZvWNeAUPfZJ5lYQ==
X-Received: by 2002:a05:6402:95b:: with SMTP id h27mr30593847edz.93.1618250350767;
        Mon, 12 Apr 2021 10:59:10 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gz20sm6300534ejc.25.2021.04.12.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:59:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove spaces before tabs
Date:   Mon, 12 Apr 2021 19:59:02 +0200
Message-Id: <20210412175903.17819-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412175903.17819-1-fmdefrancesco@gmail.com>
References: <20210412175903.17819-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed spaces before tabs. Issue detected by checkpatch.pl.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 36 ++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index 616d20106392..1ff2043fb2e2 100644
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
@@ -263,15 +263,15 @@
 #define REG_RD_CTRL_8723B				0x0524
 /*  */
 /*  Format for offset 540h-542h: */
-/* 	[3:0]:   TBTT prohibit setup in unit of 32us. The time for HW getting beacon content before TBTT. */
-/* 	[7:4]:   Reserved. */
-/* 	[19:8]:  TBTT prohibit hold in unit of 32us. The time for HW holding to send the beacon packet. */
-/* 	[23:20]: Reserved */
+/*	[3:0]:   TBTT prohibit setup in unit of 32us. The time for HW getting beacon content before TBTT. */
+/*	[7:4]:   Reserved. */
+/*	[19:8]:  TBTT prohibit hold in unit of 32us. The time for HW holding to send the beacon packet. */
+/*	[23:20]: Reserved */
 /*  Description: */
-/* 	              | */
+/*			| */
 /*      |<--Setup--|--Hold------------>| */
-/* 	--------------|---------------------- */
-/*                 | */
+/*	--------------|---------------------- */
+/*			| */
 /*                TBTT */
 /*  Note: We cannot update beacon content to HW or send any AC packets during the time between Setup and Hold. */
 /*  Described by Designer Tim and Bruce, 2011-01-14. */
@@ -300,7 +300,7 @@
 #define REG_ACMHWCTRL_8723B		0x05C0
 #define REG_SCH_TXCMD_8723B		0x05F8
 
-/* 	0x0600h ~ 0x07FFh	WMAC Configuration */
+/*	0x0600h ~ 0x07FFh	WMAC Configuration */
 #define REG_MAC_CR_8723B		0x0600
 #define REG_TCR_8723B			0x0604
 #define REG_RCR_8723B			0x0608
@@ -356,10 +356,10 @@
 #define REG_SND_PTCL_CTRL_8723B		0x0718
 
 
-/* 	Redifine 8192C register definition for compatibility */
+/*	Redifine 8192C register definition for compatibility */
 
-/*  TODO: use these definition when using REG_xxx naming rule. */
-/*  NOTE: DO NOT Remove these definition. Use later. */
+/*	TODO: use these definition when using REG_xxx naming rule. */
+/*	NOTE: DO NOT Remove these definition. Use later. */
 #define	EFUSE_CTRL_8723B	REG_EFUSE_CTRL_8723B	/*  E-Fuse Control. */
 #define	EFUSE_TEST_8723B	REG_EFUSE_TEST_8723B	/*  E-Fuse Test. */
 #define	MSR_8723B		(REG_CR_8723B + 2)	/*  Media Status register */
-- 
2.31.1

