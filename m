Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13803E1CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbhHET1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhHET1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:27:10 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF73C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:26:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bh26so7248598oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0WNWiD9++15y+4clt6BIA4hNTGWYbtTdYbFfD4ej2k=;
        b=L9YAQmtfbn+K+kdeGGuCbI5iJdpOEwlJeJZOrsxk96GUsUVfvJ2JQ2GQg9+eTZ0wjq
         4ra84ysGqKuSufRNtKsaOpYSb0kWpguoqgMJIrPKm82neKceuWcJkHj6bexRzO0WE2SN
         gmHfqU2z0sm/qyi0FJi98eHikp60XbMQzduVZ5Ip9eBSewnvwLqpCDvgl/Qer+IUfCWN
         isaR7eE3MmzSNipdzfj5RMEeqbQ7Zq/LKZD767aQ3jUms0oVydXoP/I1WjDiV64OpuEx
         RRMC3TDxR4KP+pQwISWyojlKTy6VI0O8Q47hZ7R3Zxyuf/3VwWKobO/i+bUxZLudKh0A
         22eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C0WNWiD9++15y+4clt6BIA4hNTGWYbtTdYbFfD4ej2k=;
        b=JwXjTOk1Y0ymZ4cMp6WHUuszmMvtFStXKHIYMQGOFqx+DPzFWoCP59ERcVTWoeJFo0
         pEupL82zjteERMYs+DW2OxvkEsFklDYASql+kOwcy+lLR1vo4/ZUUGN66tRAjx9tOq0I
         144GE+G//BsV1vmt76t6ESjpTnZNI1mCcFbi0GMyR4Q92PQbtXY3Vppl4yTZ2KKKV87b
         F0QvwMVyedPP63jADR6B6nq5dYO8fUh8izdPFJV8y9Gz2Tet1IUQrQ5L4QZ3iDccdcZW
         xSn3HEfCGxJUhhZlYBE8NQEiapzuZZ4DL7vs0wjwDTbbuhQZEzB1ie7fXqzNC+LWmx6R
         34eQ==
X-Gm-Message-State: AOAM532/RqH5aLx4B0s7TtEG8q1uinkdqhfFHMTnslfhzRXsQyO8nwKq
        iV1c7hIiIqheozawijlUMuE=
X-Google-Smtp-Source: ABdhPJxxi/7ln5/mMEA//jJPm1UmYAh69a2ksDHD59B6xLaLin7e+7KXwP1HQzHzF2H5xxk1UbqkzQ==
X-Received: by 2002:aca:bc43:: with SMTP id m64mr12550939oif.174.1628191615785;
        Thu, 05 Aug 2021 12:26:55 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id n7sm1143479otf.45.2021.08.05.12.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:26:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/6] staging: r8188eu: Remove rtw_yield_os()
Date:   Thu,  5 Aug 2021 14:26:39 -0500
Message-Id: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wrapper is just a call to yield().

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c      | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 2 --
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 5 -----
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 470c338b44e1..fe24f72a3cf1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6260,7 +6260,7 @@ unsigned int send_beacon(struct adapter *padapter)
 		issue_beacon(padapter, 100);
 		issue++;
 		do {
-			rtw_yield_os();
+			yield();
 			rtw_hal_get_hwreg(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
 			poll++;
 		} while ((poll%10) != 0 && !bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index f33bf732eeaf..be41e3700969 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -625,7 +625,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 			SetFwRsvdPagePkt(adapt, false);
 			DLBcnCount++;
 			do {
-				rtw_yield_os();
+				yield();
 				/* rtw_mdelay_os(10); */
 				/*  check rsvd page download OK. */
 				rtw_hal_get_hwreg(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 10f0203fd905..87315d1a5c72 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -240,8 +240,6 @@ u32  rtw_atoi(u8 *s);
 void rtw_mdelay_os(int ms);
 void rtw_udelay_os(int us);
 
-void rtw_yield_os(void);
-
 static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
 {
 	return del_timer_sync(ptimer);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 232d3a337be4..e0eddf44b5c7 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -156,11 +156,6 @@ void rtw_udelay_os(int us)
 	udelay((unsigned long)us);
 }
 
-void rtw_yield_os(void)
-{
-	yield();
-}
-
 #define RTW_SUSPEND_LOCK_NAME "rtw_wifi"
 
 static const struct device_type wlan_type = {
-- 
2.32.0

