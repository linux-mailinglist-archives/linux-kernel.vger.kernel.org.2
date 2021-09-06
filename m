Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7CC401FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbhIFSz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244995AbhIFSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48ABC0617A8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i21so15113604ejd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuNxZwRTVgjFNWkdcTAaEszvzH8ZSmNqL8GXmzgUcKE=;
        b=oXWVXd+oKXbnZ5Nl6Sme1xEzOLICcRhQsfkxewdpZM46XOKeFhWyqtEsDopxtup3eI
         YwNwJ7FIS7uSHCGNBgrxJ5tl8/V3/aunFTTE4NaWH9PDg0NypCsMtVJjobcjR/xwVm6p
         jGsOVZFZuNcdS9eDDpFoJ22JilvInwB3PeYachk5d/+L74l8coDZTDaA8J5BS/6Vpahl
         Y0aT8H1X7cElYXC8tDcjxYRjZladVPwKWPldl5WxlBPi+GJvznz2aFhYP9upIoWfeQzu
         +OXqO0pdxfjl6iljKV87QNurPAl1R8Xx0Ezot/u36oP9j0Nlw5wr1EZvf+1U+UhNJNaP
         vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuNxZwRTVgjFNWkdcTAaEszvzH8ZSmNqL8GXmzgUcKE=;
        b=QKs8hVTpHi9LjlNjmXvPy1g8FhciU+H672QoaAOMRPGi4WVnllsvhnxyxE0MvD7S8/
         aE2zKKoEstKEKeJIKYCL6csps0xF1D+sYEZwS1/ln05wOj0YRn+3Hrw7ILOjbZ7Txni8
         HmPDzrCjgsqI5/OWeRCcsFqQYZm462KVwiYS0cnb6gFf5W0WgNg9dyUlx/XEBxHQHb8v
         AlCJnIsV4XzmQwkUOl0A6pse+u15nGa9aVWMedkiCuKFBy0/1LAoi4PRQahC5eCSmvBP
         TEL1giQnL5lv5rBMpkLyjiL/VUDB+1U9K3VJpm6f0aTvE8DYYdf5t7s8uJ/9Qm1OQWDh
         OG3Q==
X-Gm-Message-State: AOAM531MrGu4GKWlOGUfZGA8sQqre2QbK4XaLr2WI/TD4VNH+5+Ablv7
        y4mQd+fUZRDcpZh0SN1vORo=
X-Google-Smtp-Source: ABdhPJw8B4errjuS0XPIybDsUwOTuOZRAElRSYPjcLVmHs27JtQxsIVc90BwqLNfEXeepYXZrgzDIw==
X-Received: by 2002:a17:906:7c56:: with SMTP id g22mr4747680ejp.282.1630954455239;
        Mon, 06 Sep 2021 11:54:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 17/40] staging: r8188eu: remove silentreset from hal_ops
Date:   Mon,  6 Sep 2021 20:53:04 +0200
Message-Id: <20210906185327.10326-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
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

