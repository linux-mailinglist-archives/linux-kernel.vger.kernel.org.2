Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A6401FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbhIFS2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbhIFS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E282C0617AD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a25so14979960ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGs9GphWZZtf+FuA3V7VBkOJBN3a0kKtobp5qpsYgWE=;
        b=DHdxW3X+uZlIFgIzR8MJO1SQnriDnJXL+xCnjfgNz2ou3vfyOKNTIjDfFuRXOFU3dP
         0o3ggq4fk/O2L06kHD/RqXCuGPWbINXv6GYTOqSBZ1K5fzQtKxU6KXeijgd6NuX19mm1
         qefZbaRcBEqTJBpy/9DdLrj3FMmMKlf8gnr5+4Sv7AGCALZ/kKIP0tjv375OiGzuD/GI
         aAq9M4bSzLg0Y3uk7ipgqhZ2OJDEeKzg28DG6gKlu4/18x/crvKi0t+W5GndXTP8s5/p
         HdoyyaWbVvH5Xkwls7VN1z36QbF2JorXLeaGwAN4PJx8XB0JIwspmLepRfD4VfZ0HPhi
         avrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGs9GphWZZtf+FuA3V7VBkOJBN3a0kKtobp5qpsYgWE=;
        b=bowSYhGH8K7ICF0Cth/MyO/c32E2MxWbunAC2lYj5NtSXnDCiEHsROriILJj7m1XPG
         QKvCKGiPPOGGL46unU6YTEriXVB/c595v6ApLumLrx6LLxDRykpfc/2kDmj3+fkxbECl
         PB+Jiz15KMePgNCbr+9r2rEIozohG9SsKV+6+oi48oaytPd2pljdpn/Ds2vzUKqUi/PL
         cwtxmHD10o+9dPBflOUy8gsZb9azbuong+6w798NCzOTOXTuN200zu03kuYQ9j9A1pJw
         DyxIz4DIySfKhyx6tnrx8O1c1EZYx3RL9IZyYAxm0bgE/ZcqBB/cBnth3Mwfy6elbRro
         gOFQ==
X-Gm-Message-State: AOAM5301AA6pNoxe58L2mepbbb7jkpHscdj8My+o711vllwsYa4hCt79
        ihz7cT19oCP4Tj73DCcfBzc=
X-Google-Smtp-Source: ABdhPJyp7RthB1EvkSNJm9wj9gXYaLBk8pm3DZ+cspTbUGwl536ecO6F6/hoylFeIP60qkH9DWHzaQ==
X-Received: by 2002:a17:906:bcd7:: with SMTP id lw23mr15075785ejb.141.1630952727852;
        Mon, 06 Sep 2021 11:25:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 36/40] staging: r8188eu: remove hal_notch_filter from hal_ops
Date:   Mon,  6 Sep 2021 20:24:34 +0200
Message-Id: <20210906182438.5417-37-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_notch_filter hal_ops and remove its wrapper
rtw_hal_notch_filter(). Call hal_notch_filter_8188e() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 +-------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 6 ++----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 4a9820c2b36e..4394c6825f1a 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -24,7 +24,7 @@ uint	 rtw_hal_init(struct adapter *adapt)
 		adapt->hw_init_completed = true;
 
 		if (adapt->registrypriv.notch_filter == 1)
-			rtw_hal_notch_filter(adapt, 1);
+			hal_notch_filter_8188e(adapt, 1);
 	} else {
 		adapt->hw_init_completed = false;
 		DBG_88E("rtw_hal_init: hal__init fail\n");
@@ -201,9 +201,3 @@ int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 							   bndy_cnt);
 	return _FAIL;
 }
-
-void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
-{
-	if (adapter->HalFunc.hal_notch_filter)
-		adapter->HalFunc.hal_notch_filter(adapter, enable);
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f87cfa0e404a..9a76e9aaa2d0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1748,7 +1748,7 @@ void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_ada
 	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
 }
 
-static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
+void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
@@ -1768,8 +1768,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
-
-	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fdde4b2b8ec4..35201286704f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -172,8 +172,6 @@ struct hal_ops {
 	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
 				  struct xmit_frame *frame, u32 max_wait,
 				  u32 bndy_cnt);
-
-	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -207,6 +205,8 @@ u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bP
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
+void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
+
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
@@ -249,8 +249,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt);
 
-void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
-
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
-- 
2.33.0

