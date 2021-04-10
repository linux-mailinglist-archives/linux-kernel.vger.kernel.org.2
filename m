Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3434D35AE39
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhDJOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhDJOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AFBC06134D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g17so9042358edm.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KH662KAlap1QpCcmNJTm3ptVnk0anldAtalYzgkYKck=;
        b=t4YRtEi5AXIII2TAC+6ufPO0Rj/DHpue0eANEtN7GtpWiJ768LGX4nj3fX/Zbcj94/
         0tWdN2fsHTx/FGNnSIptqSWnO36lbVSGK+pghJteKtLMFA8ihG1DZ81UV5Z5cKq9vEKB
         m4Pm6qb4ca9zPh+JdLoYKrgG8+VdRFGJYT0wcb7R6SxW830daVg3ii4FeyIl1P1AkSzp
         LnzXk9ifCcrfJxFOv5kRGDoSqCH84u18FI6n3k2dtwH/AeDEB9hvjji0ipF+CWRCrZnK
         9V9L5DkK1tqBh+6hqhZefD5J7khSBLtzu3h0lLhCBq6cd+l/AIoWM3cq2i2fKDoDCGCP
         oIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH662KAlap1QpCcmNJTm3ptVnk0anldAtalYzgkYKck=;
        b=QzHD5TTpP4N2mZAz9J+2ccStXN+DE49SukG0IoH+GbajfTHaGKNEiP+jkVa594LlBC
         ZoXKC/Y5P50B+grUbeCXj91QSEQ6yQMHwCGs/RwnKRYVvXikgIjX85h+WwPyF5TbJfuK
         3bA/dFVwhwPHGh96vSHka5kgQD7nXP48xBdT9qfVJRAeyGiirjS04p10vbbZSEZyb1Wk
         tL2MGo1AeaBngz57T91Vl0MoHzmq9PhSWyoka0LOjDp+UAlavSVich0j0Dlh8nlW2cf0
         gak/K15N9a7EnGJeS4ZUJK2o5K5j4Su7/ESjya80ad/0YB1N9SqxMdsv3AcfSG0RD9eM
         9h3Q==
X-Gm-Message-State: AOAM532I+Q3e2c4O/2T5Klg0U84PJaqltDQVRuCyiZgqVlfLnprrVcpe
        HYf8hPO8JZSfwkMPX0wz08czlb2Drs4zUw==
X-Google-Smtp-Source: ABdhPJwuOEYys8mFTM6rRQZqKi30EbCt45//9AikiRQIQbh142r6kBKIshF/BWu1FY4D2UkfTIBnZw==
X-Received: by 2002:a05:6402:1350:: with SMTP id y16mr21772951edw.309.1618064478362;
        Sat, 10 Apr 2021 07:21:18 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id x17sm2698593ejd.68.2021.04.10.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] staging: rtl8723bs: remove more unnecessary parentheses
Date:   Sat, 10 Apr 2021 16:20:37 +0200
Message-Id: <c730d2719cb2ed385dd55811d6e205c6c31f2355.1618064275.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove more unnecessary parentheses after
DBG_8192C deletion.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 21 ++++++++-----------
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  4 ++--
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 6bf0cbb17b99..8d6ea8850556 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -754,9 +754,8 @@ static void hal_ReadEFuse_WiFi(
 
 	while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
 		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
-		if (efuseHeader == 0xFF) {
+		if (efuseHeader == 0xFF)
 			break;
-		}
 
 		/*  Check PG header for section num. */
 		if (EXT_HEADER(efuseHeader)) { /* extended header */
@@ -1319,9 +1318,9 @@ static u8 hal_EfusePgCheckAvailableAddr(
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &max_available, bPseudoTest);
 
 	current_size = Efuse_GetCurrentSize(padapter, efuseType, bPseudoTest);
-	if (current_size >= max_available) {
+	if (current_size >= max_available)
 		return false;
-	}
+
 	return true;
 }
 
@@ -1469,14 +1468,13 @@ static u8 hal_EfusePgPacketWrite1ByteHeader(
 		efuse_OneByteRead(padapter, efuse_addr, &tmp_header, bPseudoTest);
 		if (tmp_header != 0xFF)
 			break;
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
+		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
 			return false;
-		}
+
 	} while (1);
 
-	if (tmp_header != pg_header) {
+	if (tmp_header != pg_header)
 		return false;
-	}
 
 	*pAddr = efuse_addr;
 
@@ -1498,9 +1496,8 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &efuse_max_available_len, bPseudoTest);
 
 	efuse_addr = *pAddr;
-	if (efuse_addr >= efuse_max_available_len) {
+	if (efuse_addr >= efuse_max_available_len)
 		return false;
-	}
 
 	pg_header = ((pTargetPkt->offset & 0x07) << 5) | 0x0F;
 
@@ -3734,9 +3731,9 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 	case HW_VAR_MACID_SLEEP:
 		/*  Input is MACID */
 		val32 = *(u32 *)val;
-		if (val32 > 31) {
+		if (val32 > 31)
 			break;
-		}
+
 		val8 = (u8)val32; /*  macid is between 0~31 */
 
 		val32 = rtw_read32(padapter, REG_MACID_SLEEP);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index a69cc24c81c7..7c2680b6508c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -123,9 +123,9 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 
 	pstapriv = &padapter->stapriv;
 	psta = rtw_get_stainfo(pstapriv, sa);
-	if (psta) {
+	if (psta)
 		pkt_info.station_id = psta->mac_id;
-	}
+
 	pkt_info.data_rate = pattrib->data_rate;
 
 	/* rtl8723b_query_rx_phy_status(precvframe, pphy_status); */
-- 
2.20.1

