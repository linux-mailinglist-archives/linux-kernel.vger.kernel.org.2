Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609E74072BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhIJUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbhIJUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:52:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w29so3619017wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMMWHBlq3Ww3OLNIoPNYbhp6nVa7989cVH911hyE4+U=;
        b=jbIhYI22X7cLru/sHX2rvczYxJBijnM5X034fq4EldZgmdbqHlgwgHkt6r1W4JhUeT
         5B5etgfRtU/yZuwuJr35wBTpDwhoKf2IxLCfO13QyUygDwQErOWMCXsegEsFCLCtp5J3
         76om97PntHUSSrZahIcRZllQG+f5zWATP4zX4s9wORHlMdqvxIggJBlFNM/5ltYK+nSd
         EvvLGiMBhUGWX1LYwaTqPu5YjoohpmOc5oq1IlaTOV3p1Ii95ax9zGMAXEwppK+tSZTu
         C3xps2fr0f00lYrIkkmeUGQzuHJjVSI3o5IM0VDzbpM9b1wZ0IENw0iupY/Rh9xrhwJi
         x1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMMWHBlq3Ww3OLNIoPNYbhp6nVa7989cVH911hyE4+U=;
        b=awYRfV15DA8nchAN3CjveGbbCny0pVkUuK9sXngOBOv20zYVLSDiWB3uwPo+rmauiI
         u17Ns3dTZ+Z+mw2na8ltjAjlSF1rcbt2O5rAD0aE1WFPbkCN3ayi/RJxEN51FALHKybw
         BjZPaTlT3xKmz78bHiv/KZyIxziUNOmBn1dAlSAUXy5V/gQkFDK0Io1a4u0Su+OGuc+h
         NG5UV6LExa2CTV3Z0gQaQxUJJZkeM/vrEhuYuyRYScfp7PI1yz3bgcj2kSgD3cSzkLry
         y4PTotfDmQAzs15YDMaliIse2sS5YyUzp1XNfH4ZGQF42sfyuMdoa9l4gBkSKzo/qicS
         150Q==
X-Gm-Message-State: AOAM5310nrV33gIo8bWKnm0HeFHZH1NSJIcF1vMtKcbzUUEGbsaMCH6r
        uwH99wLubn7it4Ul/fUXy5g=
X-Google-Smtp-Source: ABdhPJwk1U+q73hiCHAKb+pVANoQR4CohugMZFN11YErzoUmfbO1dURQL7TU8MUZb+JkzDQOy3xziQ==
X-Received: by 2002:adf:b741:: with SMTP id n1mr12069596wre.354.1631307049090;
        Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: r8188eu: remove read_rfreg from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:31 +0200
Message-Id: <20210910205033.3778-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove read_rfreg from struct hal_ops and its wrapper
rtw_hal_read_rfreg(). Call rtl8188e_PHY_QueryRFReg() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_debug.c        |  8 ++++----
 drivers/staging/r8188eu/core/rtw_mp.c           |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 11 -----------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  1 -
 drivers/staging/r8188eu/include/hal_intf.h      |  5 -----
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 12 ++++++------
 6 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 65daf674ea69..3d613d997a38 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -428,7 +428,7 @@ int proc_get_rf_reg_dump1(char *page, char **start,
 	path = 1;
 	len += snprintf(page + len, count - len, "\nRF_Path(%x)\n", path);
 	for (i = 0; i < 0xC0; i++) {
-		value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x ", i);
 		len += snprintf(page + len, count - len, " 0x%08x ", value);
@@ -453,7 +453,7 @@ int proc_get_rf_reg_dump2(char *page, char **start,
 	path = 1;
 	len += snprintf(page + len, count - len, "\nRF_Path(%x)\n", path);
 	for (i = 0xC0; i < 0x100; i++) {
-		value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x ", i);
 		len += snprintf(page + len, count - len, " 0x%08x ", value);
@@ -478,7 +478,7 @@ int proc_get_rf_reg_dump3(char *page, char **start,
 	path = 2;
 	len += snprintf(page + len, count - len, "\nRF_Path(%x)\n", path);
 	for (i = 0; i < 0xC0; i++) {
-		value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x ", i);
 		len += snprintf(page + len, count - len, " 0x%08x ", value);
@@ -504,7 +504,7 @@ int proc_get_rf_reg_dump4(char *page, char **start,
 	path = 2;
 	len += snprintf(page + len, count - len, "\nRF_Path(%x)\n", path);
 	for (i = 0xC0; i < 0x100; i++) {
-		value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x ", i);
 		len += snprintf(page + len, count - len, " 0x%08x ", value);
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index c0400196b55e..011d2f915cc9 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -19,7 +19,7 @@ void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val)
 
 u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask)
 {
-	return rtw_hal_read_rfreg(padapter, (enum rf_radio_path)rfpath, addr, bitmask);
+	return rtl8188e_PHY_QueryRFReg(padapter, (enum rf_radio_path)rfpath, addr, bitmask);
 }
 
 void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 155b2f580054..72e4b17c9fc0 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -125,17 +125,6 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 }
 
-u32 rtw_hal_read_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
-		       u32 regaddr, u32 bitmask)
-{
-	u32 data = 0;
-
-	if (adapt->HalFunc.read_rfreg)
-		data = adapt->HalFunc.read_rfreg(adapt, rfpath, regaddr,
-						    bitmask);
-	return data;
-}
-
 void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 			 u32 regaddr, u32 bitmask, u32 data)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index dfc38ff3c750..3806afc03d8e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1750,7 +1750,6 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 }
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 11b0871ab66a..0aebf40c8b1f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -147,9 +147,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	u32	(*read_rfreg)(struct adapter *padapter,
-			      enum rf_radio_path eRFPath, u32 RegAddr,
-			      u32 BitMask);
 	void	(*write_rfreg)(struct adapter *padapter,
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
@@ -217,8 +214,6 @@ void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 
-u32	rtw_hal_read_rfreg(struct adapter *padapter, enum rf_radio_path eRFPath,
-			   u32 RegAddr, u32 BitMask);
 void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index cc03be3bbe0b..21a5d7c54860 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2122,7 +2122,7 @@ static int rtw_wx_read_rf(struct net_device *dev,
 
 	path = *(u32 *)extra;
 	addr = *((u32 *)extra + 1);
-	data32 = rtw_hal_read_rfreg(padapter, path, addr, 0xFFFFF);
+	data32 = rtl8188e_PHY_QueryRFReg(padapter, path, addr, 0xFFFFF);
 	/*
 	 * IMPORTANT!!
 	 * Only when wireless private ioctl is at odd order,
@@ -2262,7 +2262,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 		path = (u8)prfreg->path;
 		offset = (u8)prfreg->offset;
 
-		value = rtw_hal_read_rfreg(padapter, path, offset, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, offset, 0xffffffff);
 
 		prfreg->value = value;
 
@@ -3890,7 +3890,7 @@ static void rf_reg_dump(struct adapter *padapter)
 	for (path = 0; path < path_nums; path++) {
 		pr_info("\nRF_Path(%x)\n", path);
 		for (i = 0; i < 0x100; i++) {
-			value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
+			value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
 			if (j % 4 == 1)
 				pr_info("0x%02x ", i);
 			pr_info(" 0x%08x ", value);
@@ -3965,11 +3965,11 @@ static int rtw_dbg_port(struct net_device *dev,
 		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x74:/* read_rf */
-		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
+		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 	case 0x75:/* write_rf */
 		rtw_hal_write_rfreg(padapter, minor_cmd, arg, 0xffffffff, extra_arg);
-		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
+		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 
 	case 0x76:
@@ -6069,7 +6069,7 @@ static int rtw_mp_dump(struct net_device *dev,
 
 		for (path = 0; path < path_nums; path++) {
 			for (i = 0; i < 0x34; i++) {
-				value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
+				value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
 				if (j % 4 == 1)
 					DBG_88E("0x%02x ", i);
 				DBG_88E(" 0x%08x ", value);
-- 
2.33.0

