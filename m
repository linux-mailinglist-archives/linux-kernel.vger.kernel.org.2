Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC8401FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245270AbhIFSzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbhIFSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C06C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id me10so15053439ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+27fWh63R63N+X/Iw73hVrw7vVcTyoRqHIRYToSkYs=;
        b=UUTo7f17T+jz7YeDnJWpV9ZPsSeCm4FZGJ/sOypJPl2CUHyinUTBwRjA8NFwsakfGn
         HV2ohmdjOUBnB1DV8aHsHPWmAY3X47jhOztXvXlnp/mo8PwwOSzbUfP7zH2Z6lcSWh45
         ODMTAX7uSo26IGlODnl1xqGSaswcmPdOG8efb9j1ND+ABM5/bvyMQmTkjwzHMheJATxE
         PFsZg14FOAj6BD7ukHMTiOnKE4kJu+pJ3xdupJ1cdwXbSmK6P2CTl2G7XVII+uUtXEFW
         VuErgDEtLSnqd/jk8GS7Sj3U4FbXgBOjmtUpDXI2aC2rj2FY216fxFDHzcp7FgGPTRU/
         6hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+27fWh63R63N+X/Iw73hVrw7vVcTyoRqHIRYToSkYs=;
        b=OsUvOkmVtjTc1u2bWQg6IqExz3sXXA2vHQOazgkZP7RQ5b3md/3xcjK8xd5EQv9GqX
         JJsuyM5cG6Fw2QY70OiHPu0h+JV1HTtIebgV9hBFfeVnE63JW8R0AHyKQgLxgrSkriWq
         rYg1SnN3eeG3DBHzXUlKszdh/Er/Evt1imtWEAS46TevcoqbEZm9TW/ih2EXhRjoIlDn
         JqAK9FC6drbcbOmu7HoOo5oJLjOUNsdKueApwF2+j+MA+i5hU8Kd18/TEUOhvx2Jq1wL
         BT3U9yEKStvuQDZF+V54SPshyZevoXZP9qOoBVFrAIDbHe5XOQRN8stBHYh8260DHz39
         iwMA==
X-Gm-Message-State: AOAM530Dgghh1sp7oYqi0er/u4pbvaBiGmMz6JGp5Wm/6XP/VtX+HihM
        jO+lGDGWtKOv88ggQCEzpKQ=
X-Google-Smtp-Source: ABdhPJzSYVWWgTXIk7wlAg5sta5EDPFaBM6VTDnOcTYSh661+nTK6qIdRZ3gVfRkhh0+1ROjCPOQlw==
X-Received: by 2002:a17:906:c9c2:: with SMTP id hk2mr15316997ejb.328.1630954448507;
        Mon, 06 Sep 2021 11:54:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 08/40] staging: r8188eu: remove interface_ps_func from hal_ops
Date:   Mon,  6 Sep 2021 20:52:55 +0200
Message-Id: <20210906185327.10326-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove interface_ps_func from hal_ops from hal_ops and remove its
wrapper rtw_hal_intf_ps_func() and the unused rtl8188eu_ps_func().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 9 ---------
 drivers/staging/r8188eu/hal/usb_halinit.c  | 9 ---------
 drivers/staging/r8188eu/include/hal_intf.h | 5 -----
 3 files changed, 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 4f893333cade..45166f160756 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -101,15 +101,6 @@ u32 rtw_hal_inirp_deinit(struct adapter *adapt)
 	return _FAIL;
 }
 
-u8 rtw_hal_intf_ps_func(struct adapter *adapt,
-			enum hal_intf_ps_func efunc_id, u8 *val)
-{
-	if (adapt->HalFunc.interface_ps_func)
-		return adapt->HalFunc.interface_ps_func(adapt, efunc_id,
-							   val);
-	return _FAIL;
-}
-
 s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 {
 	if (adapt->HalFunc.hal_xmit)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 65f68f35b611..7b9cca4e3cb4 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2205,12 +2205,6 @@ void rtl8188eu_init_default_value(struct adapter *adapt)
 		haldata->odmpriv.RFCalibrateInfo.ThermalValue_HP[i] = 0;
 }
 
-static u8 rtl8188eu_ps_func(struct adapter *Adapter, enum hal_intf_ps_func efunc_id, u8 *val)
-{
-	u8 bResult = true;
-	return bResult;
-}
-
 void rtl8188eu_set_hal_ops(struct adapter *adapt)
 {
 	struct hal_ops	*halfunc = &adapt->HalFunc;
@@ -2243,8 +2237,5 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->hal_xmit = &rtl8188eu_hal_xmit;
 	halfunc->mgnt_xmit = &rtl8188eu_mgnt_xmit;
 
-	halfunc->interface_ps_func = &rtl8188eu_ps_func;
-
 	rtl8188e_set_hal_ops(halfunc);
-
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f6f0763e0ab3..44a8943eadfe 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -175,8 +175,6 @@ struct hal_ops {
 	void	(*AntDivCompareHandler)(struct adapter *adapter,
 					struct wlan_bssid_ex *dst,
 					struct wlan_bssid_ex *src);
-	u8	(*interface_ps_func)(struct adapter *padapter,
-				     enum hal_intf_ps_func efunc_id, u8 *val);
 
 	s32	(*hal_xmit)(struct adapter *padapter,
 			    struct xmit_frame *pxmitframe);
@@ -261,9 +259,6 @@ u8 rtw_hal_get_def_var(struct adapter *padapter,
 u32	rtw_hal_inirp_init(struct adapter *padapter);
 u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
-u8	rtw_hal_intf_ps_func(struct adapter *padapter,
-			     enum hal_intf_ps_func efunc_id, u8 *val);
-
 s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
 s32	rtw_hal_mgnt_xmit(struct adapter *padapter,
 			  struct xmit_frame *pmgntframe);
-- 
2.33.0

