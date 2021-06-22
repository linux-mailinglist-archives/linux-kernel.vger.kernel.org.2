Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C93B0473
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFVMcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhFVMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E4DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m18so23450624wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a1RBDBYhuIJn1PW20GeA3uF2Znuq27Dnh+SWYloe64=;
        b=L50MIrFslCAbZ7Kg6DQVLoRqs45y1ASIR01IJGc0pNVHoUe98XCMBwXH2+JF9rVOsP
         oghb5I/NmCw0z7ljaVDqWrugu0ufb1giyBXVIoNDq4sMqmvEH1IKzezGItcBeDu68VbU
         hKeWyJy8BAIHd87ap64nyD9JpDEKzuhZbljdHeY90Ea7JORj04tK3t27yJkYvfPIS+IH
         CHaS/ETDcjS0F3Awd0oG8t5C8FFwCq9CK/ywuvdfyPXloW/CKZ9F3ab7CtNrD9JAoaWl
         g3uMRQ9kc0r1ft9Oi5FnCESxqlla7mhaSKDRylwTYFUplWf8zKXBTLM5qY30CB+GETt2
         Zsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a1RBDBYhuIJn1PW20GeA3uF2Znuq27Dnh+SWYloe64=;
        b=QIAgaLvAYup4dVHfzhVRCo1M/0IAlXW1fz0/jCpfmBPBfgyYHTMflC+zjV85KPx0q7
         ODRRrUDfMT9f5T/UyMEU3qfmt/GFGyghn3Ruh1fpd/Qm2tqn2/lP0lpyu5XwSH39kzvl
         L86KqcWNoWxFyefiKXQyyg9tdK6vJAJuF7x0m8KOLvnasUIYu1cg28ahZITUXhdZwY5g
         zTTj2/x8zA2GIM8dkgUgMihBaidC1bsoW1YtlwLaG/D8+kHJWw0dWSWlEqAIDHxpFWLU
         UOQ25SaQRarHnGlewpPQMzEgbLg24NfYirqkkf7+0017etKRgHAMJTO+5T0qB0HAXgbs
         T3Lg==
X-Gm-Message-State: AOAM533WEFvvU2xDTf69Np23/Z00XCs+/pJCUkZR53+1lwUqtAerRLjR
        5FFoKOTv1ptYcvWlOyLwUaZJ/H5X5K7fEg==
X-Google-Smtp-Source: ABdhPJwbSrsNN6gYIrtsShaVkh1V0ZwqQkH1O6Xn6pca8ZyaPxSxwndFFwZScRcdxsoHwROS9S8PZQ==
X-Received: by 2002:a5d:410f:: with SMTP id l15mr4497847wrp.82.1624364998819;
        Tue, 22 Jun 2021 05:29:58 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id m18sm2289652wmq.45.2021.06.22.05.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] staging: rtl8723bs: remove some unused 5Ghz macro definitions
Date:   Tue, 22 Jun 2021 14:29:35 +0200
Message-Id: <e7a067fe3c22b8843ec2252b41a429c9d52f38f2.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove some unused 5Ghz macro definitions. Fix
comments accordingly.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h                | 1 -
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h | 2 --
 drivers/staging/rtl8723bs/include/hal_com_reg.h    | 1 -
 drivers/staging/rtl8723bs/include/hal_pg.h         | 2 --
 4 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 788fc1c068b5..afb36de7a4e5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -628,7 +628,6 @@ struct fat_t { /* _FAST_ANTENNA_TRAINNING_ */
 	u32 MinMaxRSSI;
 	u8 idx_AntDiv_counter_2G;
 	u8 idx_AntDiv_counter_5G;
-	u32 AntDiv_2G_5G;
 	u32 CCK_counter_main;
 	u32 CCK_counter_aux;
 	u32 OFDM_counter_main;
diff --git a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
index 4b3a7c051630..aad962548278 100644
--- a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
+++ b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
@@ -558,7 +558,6 @@
 
 #define		b3WireRFPowerDown			0x1	/*  Useless now */
 /* define bHWSISelect				0x8 */
-#define		b5GPAPEPolarity				0x40000000
 #define		b2GPAPEPolarity				0x80000000
 #define		bRFSW_TxDefaultAnt			0x3
 #define		bRFSW_TxOptionAnt			0x30
@@ -577,7 +576,6 @@
 #define		bRFSI_ANTSW				0x100
 #define		bRFSI_ANTSWB				0x200
 #define		bRFSI_PAPE					0x400
-#define		bRFSI_PAPE5G				0x800
 #define		bBandSelect					0x1
 #define		bHTSIG2_GI					0x80
 #define		bHTSIG2_Smoothing			0x01
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index b14585cb0233..b2f179b48019 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -717,7 +717,6 @@ Default: 00b.
 /*        BW_OPMODE bits				(Offset 0x603, 8bit) */
 /*  */
 #define BW_OPMODE_20MHZ			BIT2
-#define BW_OPMODE_5G				BIT1
 
 /*  */
 /*        CAM Config Setting (offset 0x680, 1 byte) */
diff --git a/drivers/staging/rtl8723bs/include/hal_pg.h b/drivers/staging/rtl8723bs/include/hal_pg.h
index 0b7a8adf5c74..2d8ccc9ddebb 100644
--- a/drivers/staging/rtl8723bs/include/hal_pg.h
+++ b/drivers/staging/rtl8723bs/include/hal_pg.h
@@ -16,10 +16,8 @@
 
 /*  For VHT series TX power by rate table. */
 /*  VHT TX power by rate off setArray = */
-/*  Band:-2G&5G = 0 / 1 */
 /*  RF: at most 4*4 = ABCD = 0/1/2/3 */
 /*  CCK = 0 OFDM = 1/2 HT-MCS 0-15 =3/4/56 VHT =7/8/9/10/11 */
-#define TX_PWR_BY_RATE_NUM_BAND			2
 #define TX_PWR_BY_RATE_NUM_RF			4
 #define TX_PWR_BY_RATE_NUM_RATE			84
 #define MAX_RF_PATH_NUM				2
-- 
2.20.1

