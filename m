Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33AC4072B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhIJUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhIJUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:52:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2509C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w29so3618940wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qb535C7gVpM2wp22I8VzDGm4D/2pIh5jcDuS+WxFxG4=;
        b=l1UTvWSsJdFB8+MwfK52YDD3WtUm0dJUOfBJGgqFNd4UBYUr3XZcsU10NK7nNHoiJi
         FjPqFetjU0E9Z8Idq1p02qGEUPUvVJOtVSIHFWQqFJ/rLktpgfu6vnG2z4ZBHho3g4Pn
         0FYyakZ9hitB6du4ViNAiid+Y6W2aPU3Bn7Ofzq2MjneIt0HgPWFeWcBMyZc0Pj3PAR6
         9hEs0NQ1JpGk00rm1d1aQtTRme4u8vepflCU9GFZNvfXZe5n+f3iSOHiKd3f1Kh5pgm9
         MPnXI6QOtC+tmJoMjoWMK9HGFzPEsUeu45DARzKgMbU1Ka4iSPnCQhT3ly09dn2Loaqx
         G48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qb535C7gVpM2wp22I8VzDGm4D/2pIh5jcDuS+WxFxG4=;
        b=w/l8J4IxTXtEpZnP+zTqEF9C3U+JTSxN6s4Hbvisu1yJ1/hWfPKasLZkN+MF2uZoGF
         MiLwwcWkeIfWyqKlMCCJ18Gm+ILhLrC33c62SkmTomP5UQNa3UBWkswnBf1fp0/nTdAT
         f9HP4Hgihq12FrvWNGMccxmgSIP8zpwcgrDNZl1aroYYnarRQBLF/bPu/e0HWiJ+3Q5h
         iTUQeKjrgIzMSEToiAKEwq1Y65fVvecF1yOSluELwv6Rtv86EGfjiRwvaRNqlmx0RGLX
         N623m+vNbU2EKqCBas7E/eEHoA2Xxm3vsVWlvZMOJmwI8Xejo872F46Ft/Wp3WJGghsH
         bNlQ==
X-Gm-Message-State: AOAM530oxTSVvtixLzf31MJHaMleCgdncuPWhwnjooOamLTulMNvKfVt
        OK+g+1yOCwZZMNxtxrfzMG0=
X-Google-Smtp-Source: ABdhPJzvaJxtpzJAy/cNMWlb00tQIctgX3IjsQ4tpRattZLCS3mNehHk6zMVIWgUd60l7SYR9Y/p9w==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr8933894wrn.352.1631307048322;
        Fri, 10 Sep 2021 13:50:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: r8188eu: remove write_bbreg from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:30 +0200
Message-Id: <20210910205033.3778-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove write_bbreg from struct hal_ops and its wrapper
rtw_hal_write_bbreg(). Call rtl8188e_PHY_SetBBReg() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c           | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 4 ----
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 2 +-
 5 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 678ac4ad8bdb..c0400196b55e 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -14,7 +14,7 @@ u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask)
 
 void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val)
 {
-	rtw_hal_write_bbreg(padapter, addr, bitmask, val);
+	rtl8188e_PHY_SetBBReg(padapter, addr, bitmask, val);
 }
 
 u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 0036a6e8dc58..155b2f580054 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -125,13 +125,6 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 }
 
-void rtw_hal_write_bbreg(struct adapter *adapt, u32 regaddr, u32 bitmask,
-			 u32 data)
-{
-	if (adapt->HalFunc.write_bbreg)
-		adapt->HalFunc.write_bbreg(adapt, regaddr, bitmask, data);
-}
-
 u32 rtw_hal_read_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 		       u32 regaddr, u32 bitmask)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f6618b5f6849..dfc38ff3c750 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1750,7 +1750,6 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1d3ef4ba6c6b..11b0871ab66a 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -147,8 +147,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	void	(*write_bbreg)(struct adapter *padapter, u32 RegAddr,
-			       u32 BitMask, u32 Data);
 	u32	(*read_rfreg)(struct adapter *padapter,
 			      enum rf_radio_path eRFPath, u32 RegAddr,
 			      u32 BitMask);
@@ -219,8 +217,6 @@ void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 
-void	rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask,
-			    u32 Data);
 u32	rtw_hal_read_rfreg(struct adapter *padapter, enum rf_radio_path eRFPath,
 			   u32 RegAddr, u32 BitMask);
 void	rtw_hal_write_rfreg(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ee4029bb48a7..cc03be3bbe0b 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3961,7 +3961,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		DBG_88E("read_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x73:/* write_bb */
-		rtw_hal_write_bbreg(padapter, arg, 0xffffffff, extra_arg);
+		rtl8188e_PHY_SetBBReg(padapter, arg, 0xffffffff, extra_arg);
 		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x74:/* read_rf */
-- 
2.33.0

