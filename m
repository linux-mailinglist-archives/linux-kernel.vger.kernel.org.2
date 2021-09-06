Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6055401FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245535AbhIFS4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbhIFSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62CCC0613A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s25so10673793edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I71lkep6zOcslL4BykWHkhODqaJTjlyYljZt7QjV/g0=;
        b=d5xPSQTD1Y/P93gmLPRInPoNyrqyzzYGpEDdAqMKyOMZZKow5RNC8OchzZcIlWRuXa
         lDTy7/0+z+xtMvS/9ucUXb66+UO9VyYpxthn1P2D1QXbObUKWAUBJDu25D8j1xXQJ/hs
         bNQjPcbxIEo7diEkD2ylD4Uf9ooNldqzy0M9jiB5kxha6Jxpt/9ZDLJMArcLUWH8rgI0
         J+CW0Q3+IcW1ZkWyvwckQ2MseI6Sml2maNfiFdo3TSVswUVxgXryJSLlUya7zo3byJI5
         4BaRv/EJscFZub9WUzYS5FWLtIxFMtQSSH52kt0uFKyRn8Rj0igzvkTTnW2BU7CsPpAs
         RUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I71lkep6zOcslL4BykWHkhODqaJTjlyYljZt7QjV/g0=;
        b=SRmkRvsP57EKvcF209+mF5g0wLJSOdEAx6k8boywkt3tSaX7s7w6L2L1haQoFHVkF7
         Kw5Fv3bl/Gs3TGahZwm38I39sEcPqhHCBfrVbBKUt4BHFCcGq5q/S7RVvDIYWLz3yyDt
         HHbt9hQcEZwQVv9q7tua/V5K9iWSrT7949HiUlCkGORbT12ZZxdDnh4h1Hy32J9ZWRyF
         AQjrdU3qi1dkRXYilUmC/AfpqPawGkqI+yLVdjQ+iZ1S2tM6L/MBNstSpP858tS6vcEO
         BQ243JcAB6EFN4yRNkVO3kvcVmW7zsOa0HRrr1jLhbDVNp0OjM8uyil0s/hsHDj6av9+
         NblA==
X-Gm-Message-State: AOAM532sxRxSYLhRWhLNGASOUT9vZsNY0FkGZ/2o8HttVLOWj1RSUVuW
        1tvn+Hhud32o7h/C1fuivFw=
X-Google-Smtp-Source: ABdhPJzBuEpjJ2iAOS0fti+p0WnYOWToenOBafGo29+4KtrEfe5Rpm5K/8fwnpcKhkJCQPaXYh2JbA==
X-Received: by 2002:a05:6402:205:: with SMTP id t5mr14738727edv.81.1630954457338;
        Mon, 06 Sep 2021 11:54:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 20/40] staging: r8188eu: remove sreset_get_wifi_status from hal_ops
Date:   Mon,  6 Sep 2021 20:53:07 +0200
Message-Id: <20210906185327.10326-21-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_get_wifi_status from hal_ops and remove its wrapper
rtw_hal_sreset_get_wifi_status(). Call sreset_get_wifi_status()
directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 9 ---------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 drivers/staging/r8188eu/include/hal_intf.h      | 4 ----
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 2 +-
 4 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 1840c4046859..27adaea61f84 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -221,15 +221,6 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
 		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
 }
 
-u8   rtw_hal_sreset_get_wifi_status(struct adapter *adapt)
-{
-	u8 status = 0;
-
-	if (adapt->HalFunc.sreset_get_wifi_status)
-		status = adapt->HalFunc.sreset_get_wifi_status(adapt);
-	return status;
-}
-
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 0ee7da10633a..04c382e698f9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,8 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
-
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
 
 	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index baa08d9346f9..f85385cc9288 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,8 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	u8 (*sreset_get_wifi_status)(struct adapter *padapter);
-
 	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
 				  struct xmit_frame *frame, u32 max_wait,
 				  u32 bndy_cnt);
@@ -269,8 +267,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
 
-u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
-
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 803caf94da4c..19354eb41031 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2305,7 +2305,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 		rtw_hal_set_hwreg(padapter, HW_VAR_TRIGGER_GPIO_0, NULL);
 		break;
 	case GEN_MP_IOCTL_SUBCODE(GET_WIFI_STATUS):
-		*pdata = rtw_hal_sreset_get_wifi_status(padapter);
+		*pdata = sreset_get_wifi_status(padapter);
 		break;
 	default:
 		break;
-- 
2.33.0

