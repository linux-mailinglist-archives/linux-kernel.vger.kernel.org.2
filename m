Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C6401FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbhIFS1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244527AbhIFS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536CBC0617AD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc21so14953016ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuNxZwRTVgjFNWkdcTAaEszvzH8ZSmNqL8GXmzgUcKE=;
        b=Auwh7shzf+y1i1vQTcTVr0QwNjcc5dp+HxXis3DoeZdH7WCI3PDfvW8gfXKf9zA7xz
         EDPlPIfJpbKYma7gORZITzS2msRggxA4VL7FRsf5bkWubPuPjmzvxQnSxiWOITErIVz+
         IFJOD/zNA1SHRLRFS411T220AbF/RQcyW7h0E3xbYj2oMyZ6U21cGnbtU7QHuvbrSOp4
         EROeohZ9w2Sc20JbOqwB7KyoFtzLSMOrw4Xd7PFrPlPQ0IHR79pyJQG+VePYcjPrjIYC
         kLcKv4fD5KviOGaSNdKpMWOm2YQL579bTbCu6C06QrVuIueRBfaAeBR809JTf7C827jo
         dExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuNxZwRTVgjFNWkdcTAaEszvzH8ZSmNqL8GXmzgUcKE=;
        b=UHK6uxiJVxxoa5E+xWzdAKF0rf+iGOo/92CtFf36aPUVqULXoi+Hlqfl/9HAclwxCb
         6iIjgXPKA6FMhaXK/bpffaJkfqblBAlnZl1EArxJveP3aObxEC0F432MDgeMcdVHNJ/9
         gS5MxVOICxzOUjUxaupDeSNrMBkU4SRBpZc8g5VqAlO5BAKVF2MsIuRFe8BoSJuIPKXC
         KUNv2Lg1lFLRKWNAzHTOtJoN5mOrEDvgk4m+iLG0HWpvD68Pe0H/rSw8NAXYquxAw2JR
         PHbuMSe2zvzTU/lEarFkH3Ff8PMT6BwlB3kRkOTU0QKSkG7eIZTdCJrf2v1VjjVmuZoV
         dx2g==
X-Gm-Message-State: AOAM531QdcFufnmk4q8S/rRMTn4A9RHcf2wKQY89G6k/nCGmGAYL5b2l
        vYlsn4E2owONdrCkonvQ/k8=
X-Google-Smtp-Source: ABdhPJwHgCSIUrfupiWN27tAReCe0302VFy4g+I1nDKlBCUR2SHpFRYyw2fxcqJ5urPgjD6hJp4h+w==
X-Received: by 2002:a17:906:9914:: with SMTP id zl20mr14979515ejb.263.1630952713861;
        Mon, 06 Sep 2021 11:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/40] staging: r8188eu: remove silentreset from hal_ops
Date:   Mon,  6 Sep 2021 20:24:15 +0200
Message-Id: <20210906182438.5417-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove silentreset from hal_ops and remove its wrapper
rtw_hal_sreset_reset().
Call rtl8188e_silentreset_for_specific_platform() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 2 +-
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index e5267c23ab86..51f6160f7dec 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -221,12 +221,6 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
 		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
 }
 
-void rtw_hal_sreset_reset(struct adapter *adapt)
-{
-	if (adapt->HalFunc.silentreset)
-		adapt->HalFunc.silentreset(adapt);
-}
-
 void rtw_hal_sreset_xmit_status_check(struct adapter *adapt)
 {
 	if (adapt->HalFunc.sreset_xmit_status_check)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 222e66656aa9..f9852eae7c74 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,7 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->silentreset = &rtl8188e_silentreset_for_specific_platform;
 	pHalFunc->sreset_xmit_status_check = &rtl8188e_sreset_xmit_status_check;
 	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
 	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 946896698655..1a85f11ba596 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	void (*silentreset)(struct adapter *padapter);
 	void (*sreset_xmit_status_check)(struct adapter *padapter);
 	void (*sreset_linked_status_check) (struct adapter *padapter);
 	u8 (*sreset_get_wifi_status)(struct adapter *padapter);
@@ -272,7 +271,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
 
-void rtw_hal_sreset_reset(struct adapter *padapter);
 void rtw_hal_sreset_xmit_status_check(struct adapter *padapter);
 void rtw_hal_sreset_linked_status_check(struct adapter *padapter);
 u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index c7229878ee53..803caf94da4c 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4304,7 +4304,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x0f:
 			if (extra_arg == 0) {
 				DBG_88E("###### silent reset test.......#####\n");
-				rtw_hal_sreset_reset(padapter);
+				rtl8188e_silentreset_for_specific_platform(padapter);
 			}
 			break;
 		case 0x15:
-- 
2.33.0

