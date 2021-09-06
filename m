Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46C401F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbhIFS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbhIFS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dm15so10513826edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmbLARluVxMQ+ZokkZJzSgEYmy1Qusxy/6FmmYzAGJc=;
        b=QPjBGxYpaTXRbLo79G8n5XOw7drooL8zTWBJdNo94poIZGQaSwsKGJuY/xifOdjk0k
         szDcAB2s3q+8bjtP57QC3sJ63pYyT6rfRNz1oYPR58q47Vrlx1GwEBZnUkD9u2hctqVY
         m1dgRt5jafNm0CUGLOET7k8y4qqqyTLm4ns3nkbQTlpOJFfoLxyu0xB0eZh7+e6tazTN
         LbFXS/Q8UURJVdxCPsWPVl3taBPJ90Q3QvKHeEtKqkLoFpiceDleMzMLsuFg90/MKN24
         q7H8yjAjasKhOsAvMDj32LCh9jdC5boOoxYE7MuTj42VtilPblajjN7PozkvAhqDmB0U
         OysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmbLARluVxMQ+ZokkZJzSgEYmy1Qusxy/6FmmYzAGJc=;
        b=gxrz/NiYVBM7klBzXFAxCNS9rNtnDrvwMxG9NL0X8GJqWWts3Hd7JItOgIGtqAbXnB
         H5NhP1KEiv1uCs0sjZz6bNdPbIR0nRBELfCTYpsN341nz+NMYwQ2X6ZyZNN1x6RbSw53
         G5Rg8ygHC0gfc1+Cbwa+pKLLtJqoLCD+A8pVZyNtWGuyrt2oWHNmYWLAzU1ALrlMaldR
         IJI3uqQItATNXYJs7rm9k8M0Np7x8BdNq3MwIZnuofXih5BPJCCz0xoY0bCl65BK5HFe
         oJpcZ/0E38mo1k/Cm1u6J9guulci4zpxEUSlwtXB09XbovtYxsdQyyGjdp/0qflvz5ku
         Zpxg==
X-Gm-Message-State: AOAM530Vij5ubRAnjFD/feGC2RHpxlpb+N8T0atVcQ2gsXWrr26Tq0MM
        3xb8zbCFkB/GGcgdjw2oF8UYaOQcXLVTvA==
X-Google-Smtp-Source: ABdhPJxI7E5GBYOAFMTl8SHj/soCIRQZuzeOCYnsIS07M/0JDa9h1ngl1T3j2vsDAN54amE2d38SHg==
X-Received: by 2002:a05:6402:1d1b:: with SMTP id dg27mr14641881edb.59.1630952711746;
        Mon, 06 Sep 2021 11:25:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/40] staging: r8188eu: remove hal_power_on from hal_ops
Date:   Mon,  6 Sep 2021 20:24:12 +0200
Message-Id: <20210906182438.5417-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_power_on from hal_ops and remove its wrapper
rtw_hal_power_on(). Call rtl8188eu_InitPowerOn() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 7 -------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c       | 3 +--
 drivers/staging/r8188eu/include/hal_intf.h      | 4 +---
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 39b1a8711754..58ece9a1232c 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -12,13 +12,6 @@ void rtw_hal_free_data(struct adapter *adapt)
 		adapt->HalFunc.free_hal_data(adapt);
 }
 
-u32 rtw_hal_power_on(struct adapter *adapt)
-{
-	if (adapt->HalFunc.hal_power_on)
-		return adapt->HalFunc.hal_power_on(adapt);
-	return _FAIL;
-}
-
 uint	 rtw_hal_init(struct adapter *adapt)
 {
 	uint	status = _SUCCESS;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 0b14748e1346..207fb182ee6c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -904,7 +904,7 @@ static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u1
 	if (!bPseudoTest) {
 		int ret = _FAIL;
 		if (rtw_IOL_applied(Adapter)) {
-			rtw_hal_power_on(Adapter);
+			rtl8188eu_InitPowerOn(Adapter);
 
 			iol_mode_enable(Adapter, 1);
 			ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 7b9cca4e3cb4..2c010f12118a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -85,7 +85,7 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 				pdvobjpriv->RtNumInPipes, pdvobjpriv->RtNumOutPipes);
 }
 
-static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
+u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 {
 	u16 value16;
 	/*  HW Power on sequence */
@@ -2214,7 +2214,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 		DBG_88E("cant not alloc memory for HAL DATA\n");
 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
 
-	halfunc->hal_power_on = rtl8188eu_InitPowerOn;
 	halfunc->hal_init = &rtl8188eu_hal_init;
 	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9f804f9f5363..63842cd469c5 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -124,7 +124,6 @@ enum hal_odm_variable {
 typedef s32 (*c2h_id_filter)(u8 id);
 
 struct hal_ops {
-	u32	(*hal_power_on)(struct adapter *padapter);
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
 
@@ -227,10 +226,9 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 			   enum hal_odm_variable eVariable, void *pValue1, bool bSet);
+u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 
 void	rtw_hal_free_data(struct adapter *padapter);
-
-u32 rtw_hal_power_on(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
-- 
2.33.0

