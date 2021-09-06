Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57B401FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbhIFS1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244336AbhIFS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7039FC0613A4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a25so14979057ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZ8hvk2KSV8oopavLExWfw4yI0Bc1nqib2i1tXgASFw=;
        b=PjFeeg0YfjU59OSRDgj1iEoAjWqP3OdlBVdDw8VG9lT9Hi+GFBN06AUeAfVufFxF6Q
         Sf5G0TLLbreEB7NgNF/c3WLrwaJyeVr7SgVlJfVRhkafVWSqL6psVyqzv0kquDcav6E4
         /PA2lexCWpWfMwFfxUmgOFjigeq2j5TDAZv5J7rVix2u20JkXL/+kVVtwfht2dmShQEC
         SLvsTOcIyGHj7xeLUBzFRekhNaPBUJrbQq1HlscDkX9DjFfqO+cZfD6Yq0z+qIqXf8Dq
         Yo0o8c/qYShL3In3nGLJMtOLB69s4f0KAUVeWvYdUSKdGu/7pIoZCtrhnFtVUkD4SqGT
         WFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZ8hvk2KSV8oopavLExWfw4yI0Bc1nqib2i1tXgASFw=;
        b=U4kvDgCJxxeiGXQPgOptxKOmV7VNfiCt47OwVdNi75UNgZwY1rlhIXymmB9ZjhFyj+
         f0MpnwSrm3ZhKA9pF9kcVcMVAtEBQZ5pV1xTbofeMzkbjpzBbrBFkwOP6TYhnkjeYH5i
         23yUibjzx2lCRlvJiODCeZJ+6sbkUkL3e8n9zvPNjE3aSpdR0xN7FtzRR8ILctEGol8M
         ilm3mOttcwxlmBtk2R2/62AxWoipaASNx14wNoyKNYwu0ODSp5QrXx9B+hVzlGgb6z51
         cRwuu93TOeZIQtXygjtdafC0rFHoAZ+WOQDRhKapQTGd4r0nmbSORo/ZP5ZjkXGjI+1m
         5yBw==
X-Gm-Message-State: AOAM531bm7IWzTMQ4+XiFkb+mNVv5bVMjkClks4yjlABA2y/jw0vz9ZI
        j4cQd9bhxPsgRe69CVMNA8X9xGAZgxW1yg==
X-Google-Smtp-Source: ABdhPJwQL+vQEjm5Dip6cqHc2I008/nnhIJ9KTuSq+RzS2Y6DqUSG+vYlXyD7WJ0s5bGkggznQsw+Q==
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr14989176ejc.62.1630952716086;
        Mon, 06 Sep 2021 11:25:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 20/40] staging: r8188eu: remove sreset_get_wifi_status from hal_ops
Date:   Mon,  6 Sep 2021 20:24:18 +0200
Message-Id: <20210906182438.5417-21-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_get_wifi_status hal_ops and remove its wrapper
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

