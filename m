Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE44072BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhIJUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhIJUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:52:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v10so4369789wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaiQfLV/na2Dp/9gG36nqiqId4moJWSXdqDONozjDdc=;
        b=U8HAFy8Ur8f1PxRuDxqcP6zcChLYM2KQBhIb5NxTpjFeyO2hNUVCvTr2ZiNEoST9tb
         JFqHXjvUYz9DuXYhpCmM26RMqHM28LGk9pkRNOKMwbSxfdKPyaZYCLkOwNWi/QqDuXpM
         IHUUVK9OA+jhOmf/xEy2Avk3HtvSPzIt8FnSLMKCW4iRWXQywGdWo/C7dlvOn7XRkAWG
         FK5TXl+b9ayUeCJA5Ke/pq0WARJYfTDlyhv0TN0AVUh4L6vpvXWSxLr+O01Bzu19W6ov
         PirVc3uL7rf8aHC0OGKfIW3sTmfWa15fSGj+o/O4jzsKv+lfPwMg6L8cjBDqfSJyfPuT
         ysPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaiQfLV/na2Dp/9gG36nqiqId4moJWSXdqDONozjDdc=;
        b=6CV07ekwFE67L7BiItKmzP1ccRGWnxanJOuBW5/11F+p4FmpxRotP8PUvQKihhoy1f
         zNCUaY6yyWRYirfpFe1RzXuHvcRfLT53POSXeSTIVyouvkjKlHio/4RWULJMsCCGpAo8
         a++Sfon42XBEn4TiGF/moUKOTimJYVfA0RWv0GH7Gbrrh5wJ1E4tdQbjZ6TJ95XQ6thV
         tmrbqjJ6r4XmiuXP8wO4L3ANEalH7LaLegzXE2qBINd9SdOvWmRcQrvEE6ZYABil2vd8
         RJcYLTvk51gwxrNNq2tSPtdKSbGAy8iQvLQ6uG+8pwN3JFg3aUtR5ty926gCc4CdKSTG
         lS5g==
X-Gm-Message-State: AOAM532Sor1vnRZDO2M5zJyeJXV1OFYaKGaXywnCAWHPs6OF4lpDhsb/
        pKtRH/aVdVkO2339n6Z6n/0=
X-Google-Smtp-Source: ABdhPJyeU5a4WB6ZyvQ5JtiLKA7DNko1ERCfN3XG9akfIrZv9qw4KI+99d1g2XUjdXCdHSbV66BGvQ==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr4671685wrp.349.1631307049875;
        Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: r8188eu: remove write_rfreg from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:32 +0200
Message-Id: <20210910205033.3778-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove write_rfreg from struct hal_ops and its wrapper
rtw_hal_write_rfreg(). Call rtl8188e_PHY_SetRFReg() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c           | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 --------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 8 --------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 6 +++---
 5 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 011d2f915cc9..ab251c49c875 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -24,7 +24,7 @@ u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask)
 
 void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val)
 {
-	rtw_hal_write_rfreg(padapter, (enum rf_radio_path)rfpath, addr, bitmask, val);
+	rtl8188e_PHY_SetRFReg(padapter, (enum rf_radio_path)rfpath, addr, bitmask, val);
 }
 
 u32 read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 72e4b17c9fc0..410cc4197548 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -124,11 +124,3 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 		UpdateHalRAMask8188EUsb(adapt, mac_id, rssi_level);
 	}
 }
-
-void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
-			 u32 regaddr, u32 bitmask, u32 data)
-{
-	if (adapt->HalFunc.write_rfreg)
-		adapt->HalFunc.write_rfreg(adapt, rfpath, regaddr,
-					      bitmask, data);
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 3806afc03d8e..0d6c3adff27e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1750,7 +1750,6 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 0aebf40c8b1f..174819bdff44 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -146,10 +146,6 @@ struct hal_ops {
 	u8	(*SetHalDefVarHandler)(struct adapter *padapter,
 				       enum hal_def_variable eVariable,
 				       void *pValue);
-
-	void	(*write_rfreg)(struct adapter *padapter,
-			       enum rf_radio_path eRFPath, u32 RegAddr,
-			       u32 BitMask, u32 Data);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -214,10 +210,6 @@ void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 
-void	rtw_hal_write_rfreg(struct adapter *padapter,
-			    enum rf_radio_path eRFPath, u32 RegAddr,
-			    u32 BitMask, u32 Data);
-
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 21a5d7c54860..92b8f2c109c3 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2143,7 +2143,7 @@ static int rtw_wx_write_rf(struct net_device *dev,
 	path = *(u32 *)extra;
 	addr = *((u32 *)extra + 1);
 	data32 = *((u32 *)extra + 2);
-	rtw_hal_write_rfreg(padapter, path, addr, 0xFFFFF, data32);
+	rtl8188e_PHY_SetRFReg(padapter, path, addr, 0xFFFFF, data32);
 
 	return 0;
 }
@@ -2275,7 +2275,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 		offset = (u8)prfreg->offset;
 		value = prfreg->value;
 
-		rtw_hal_write_rfreg(padapter, path, offset, 0xffffffff, value);
+		rtl8188e_PHY_SetRFReg(padapter, path, offset, 0xffffffff, value);
 
 		break;
 	case GEN_MP_IOCTL_SUBCODE(TRIGGER_GPIO):
@@ -3968,7 +3968,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 	case 0x75:/* write_rf */
-		rtw_hal_write_rfreg(padapter, minor_cmd, arg, 0xffffffff, extra_arg);
+		rtl8188e_PHY_SetRFReg(padapter, minor_cmd, arg, 0xffffffff, extra_arg);
 		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 
-- 
2.33.0

