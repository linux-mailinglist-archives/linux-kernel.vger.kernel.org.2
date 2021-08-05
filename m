Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8C3E1CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhHET1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242960AbhHET1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:27:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAAC061799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:26:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so8772930oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=je3vB2cojmZex/MiJ8ttJMn0wFB5SY7cFhx0GlbFLPI=;
        b=LQSO+Os3jf0Y97S1ZSPmQHX3gwZJBIwx7bHmdohwUlQlYddE3SW2qjTBdEwnd0b9HW
         JKfEpqTdO4TtWEM1bcx2r3l1ku6DhZPkT6FV9XH1tV/PInDyF/GNMtH2RGXtfcll7zyc
         TVBnQi0uywcZx4ph10oXW/eEX1hR4UwYuJxYn+AdcQCJCu3EHZvt+nWla9RH2IoOY6v8
         vXK0d03oTAhoH+AR4WR93bEFAWBl/e3djgzsCJYxt2gA9slRpvy6UopFTUJRThCHye3m
         cxHArgRsspWLeUtofGpwp4kU79NQOIOg4OKsu0ppPyiANuAkGnM9HCM4TLX7krfzN7Yx
         3mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=je3vB2cojmZex/MiJ8ttJMn0wFB5SY7cFhx0GlbFLPI=;
        b=RkWx864A/l4yB+809E3sGJ+04orxfamyLRReDanFJVsTWVDO2KVOA/BY5qiMykuzdt
         HKuTUDSyTvNr2VQ6n7kPUGrQJXjMrnuKSvOH8nVHlBFf5gRcgQZR8MWFb7uWQ6d7fCu8
         FxTLD3+VvZjCY4vMGHagyQ8mCJ+F1uhxER/E1mi585sxOodgBgZ/FJuLKGi1Zw228x3T
         F3TvPBD3u4Y8/8/QblsP6PJn0RmZ6vXRppu+Fru67NJ0P3xol82LREaMOH7TxZW1c68F
         J+iC5OckYM6IKc0t4u4MzsFx5j0DxQFKCR/kPRew+kJzf2iwIMFCy3gs5MLWqlukvQrf
         og7g==
X-Gm-Message-State: AOAM5326c1AS0U/bO/SPTkFNFfYQF/D8JVk+Q7D0bv5yl3VefwGSjY2o
        J3rVa/wEtJvBbT19VvZrP2Y=
X-Google-Smtp-Source: ABdhPJzH09b1J4Q++mJbmBCAiTHhX3UgGQEZJMXuWXNjxMm0xGFh4AELMDFM3DxgLG0fqW65FgzakA==
X-Received: by 2002:a05:6808:1791:: with SMTP id bg17mr4935590oib.46.1628191618506;
        Thu, 05 Aug 2021 12:26:58 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id n7sm1143479otf.45.2021.08.05.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:26:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/6] staging: r8188eu: Remove wrapper rtw_mdelay_os()
Date:   Thu,  5 Aug 2021 14:26:41 -0500
Message-Id: <20210805192644.15978-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
References: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wrapper just calls mdelay(). Remove it.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_mp.c           | 4 ++--
 drivers/staging/r8188eu/hal/odm_interface.c     | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c      | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c       | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 5 -----
 6 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 76db563d3969..252d5c37d813 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -840,11 +840,11 @@ static u32 rtw_GetPSDData(struct adapter *pAdapter, u32 point)
 	psd_val |= point;
 
 	rtw_write32(pAdapter, 0x808, psd_val);
-	rtw_mdelay_os(1);
+	mdelay(1);
 	psd_val |= 0x00400000;
 
 	rtw_write32(pAdapter, 0x808, psd_val);
-	rtw_mdelay_os(1);
+	mdelay(1);
 	psd_val = rtw_read32(pAdapter, 0x8B4);
 
 	psd_val &= 0x0000FFFF;
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index d39556d4a347..a64eeb5ae2e2 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -137,7 +137,7 @@ void ODM_StallExecution(u32 usDelay)
 
 void ODM_delay_ms(u32 ms)
 {
-	rtw_mdelay_os(ms);
+	mdelay(ms);
 }
 
 void ODM_delay_us(u32 us)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index be41e3700969..712307bc674f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -626,7 +626,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 			DLBcnCount++;
 			do {
 				yield();
-				/* rtw_mdelay_os(10); */
+				/* mdelay(10); */
 				/*  check rsvd page download OK. */
 				rtw_hal_get_hwreg(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
 				poll++;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b214b7b1e9de..ca5ec98a7235 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1846,7 +1846,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				/* RQPN Load 0 */
 				rtw_write16(Adapter, REG_RQPN_NPQ, 0x0);
 				rtw_write32(Adapter, REG_RQPN, 0x80000000);
-				rtw_mdelay_os(10);
+				mdelay(10);
 			}
 		}
 		break;
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 5b83f2efd94c..16d6df702788 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -236,7 +236,6 @@ void rtw_usleep_os(int us);
 
 u32  rtw_atoi(u8 *s);
 
-void rtw_mdelay_os(int ms);
 void rtw_udelay_os(int us);
 
 static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index a29d10f281e9..99497bb11e0b 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -141,11 +141,6 @@ void rtw_usleep_os(int us)
 		msleep((us/1000) + 1);
 }
 
-void rtw_mdelay_os(int ms)
-{
-	mdelay((unsigned long)ms);
-}
-
 void rtw_udelay_os(int us)
 {
 	udelay((unsigned long)us);
-- 
2.32.0

