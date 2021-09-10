Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6594072B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhIJUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhIJUwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:52:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2204723wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iAT6vLWA7SKgknSIHLXo9GdL/YYBAwnSTFPjOdYfd0=;
        b=eWTtIypzD/LNXBH1Yi2nGDC9b6HBRhqKvG7janrMp7WwFZVBg65eI1U7AJIS5FSkNx
         FdHuYkgr3UJjd4HZKvIHMTaPDKYgUKLqX0gw9jhW6DsQVtdhe6L58Cn1mqcadY15R3+8
         J0qSAuplFXsN7FIOWNd9GkgcRb1pOj02WpmjMriaWUrTxYHjtzqo5A63Xug11828mMWA
         hq42QzwXLlqUH5ZYdWMXV22C+s9DOyoAZH9GQM/m4OrCUPaA2QqwTIHU6kLj0bCWh+/z
         Didnr17tKLD+jqOL6eKI+rRxruNmdBQIePQM0Pbylt9Rzf3Y5Fa+OOTH62YdTKwgUpQh
         zcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iAT6vLWA7SKgknSIHLXo9GdL/YYBAwnSTFPjOdYfd0=;
        b=Mepvpbz3kJ8h6V75PYLvlaDA0XJrWnbUY3uo039xTbdjx6VvF6lR4nssBSKwUP3jEQ
         klGW4VG4ZtcTqacXDM/LNOZbHKPRJyST+vZts1WrNqP4D2CbcML+5/COy7QE6TMQJJN1
         tOPz6CWBiK1JwPwVA3Ntt96HUrSuGOVQyp0KceRyHX/C1um6vd72QisDUNZAQyHpkweX
         RcUgsL7pilOsrWyLO73wHsYpwwz3GSw3QtuxcPNgEg8ER/p+yagk7Ncop/M2N+AFrvBG
         pWOjqg/fXs0Mhnc+eUG2SNCupJkFXHkn+ofqyKn3rVlpIdJoAYsndsqjnzqgpx/nAoha
         8SDQ==
X-Gm-Message-State: AOAM532H8lFwB4L+z0OJlP2hpHUgQcNxnMHT/zgVFc+UDa1tKvTmfMMX
        ik7KXpDbfnVo57hzPzjHedEzcyw82oY0IA==
X-Google-Smtp-Source: ABdhPJzVAWtHyP6HE8oR+4OHfiQMMLQ1l2uySwqzN+/LyNcZEMfDVP6wVWVSzLL2gimm6FqmmPEGuw==
X-Received: by 2002:a05:600c:3b89:: with SMTP id n9mr4455621wms.186.1631307047595;
        Fri, 10 Sep 2021 13:50:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: r8188eu: remove read_bbreg from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:29 +0200
Message-Id: <20210910205033.3778-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove read_bbreg from struct hal_ops and its wrapper
rtw_hal_read_bbreg(). Call rtl8188e_PHY_QueryBBReg() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c           | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 9 ---------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 3 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 4 ++--
 5 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 8b53a460edf8..678ac4ad8bdb 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -9,7 +9,7 @@
 
 u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask)
 {
-	return rtw_hal_read_bbreg(padapter, addr, bitmask);
+	return rtl8188e_PHY_QueryBBReg(padapter, addr, bitmask);
 }
 
 void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index fecdd272f84e..0036a6e8dc58 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -125,15 +125,6 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 }
 
-u32 rtw_hal_read_bbreg(struct adapter *adapt, u32 regaddr, u32 bitmask)
-{
-	u32 data = 0;
-
-	if (adapt->HalFunc.read_bbreg)
-		data = adapt->HalFunc.read_bbreg(adapt, regaddr, bitmask);
-	return data;
-}
-
 void rtw_hal_write_bbreg(struct adapter *adapt, u32 regaddr, u32 bitmask,
 			 u32 data)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5ea96a5ac630..f6618b5f6849 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1750,7 +1750,6 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
 	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index da1fd5bddeb7..1d3ef4ba6c6b 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -147,8 +147,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	u32	(*read_bbreg)(struct adapter *padapter, u32 RegAddr,
-			      u32 BitMask);
 	void	(*write_bbreg)(struct adapter *padapter, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 	u32	(*read_rfreg)(struct adapter *padapter,
@@ -221,7 +219,6 @@ void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 
-u32	rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask);
 void	rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask,
 			    u32 Data);
 u32	rtw_hal_read_rfreg(struct adapter *padapter, enum rf_radio_path eRFPath,
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 911bcb69d008..ee4029bb48a7 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3958,11 +3958,11 @@ static int rtw_dbg_port(struct net_device *dev,
 		}
 		break;
 	case 0x72:/* read_bb */
-		DBG_88E("read_bbreg(0x%x) = 0x%x\n", arg, rtw_hal_read_bbreg(padapter, arg, 0xffffffff));
+		DBG_88E("read_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x73:/* write_bb */
 		rtw_hal_write_bbreg(padapter, arg, 0xffffffff, extra_arg);
-		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtw_hal_read_bbreg(padapter, arg, 0xffffffff));
+		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x74:/* read_rf */
 		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
-- 
2.33.0

