Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7841CCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346716AbhI2T3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346627AbhI2T2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:28:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l8so13052412edw.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5WEMTKAqj3+GDD4wcjFKaCDi51DYCzL5pRQuPBSMlA=;
        b=GcNbsg6CCm2AhFiBVDD5YGpjpd1sRjQcaQamo8h6vlb+WpbS6TPi3pl96YUEDTWVzE
         85julXKIBnWHtVzpZeB81RcJ/IRIYQuhCjzxdK8p3uGvKBY2jlay8yddH2ufKG+yQzsg
         njWFFJ5j5gvfB+zVstfdcK1qePuWRvJp2OieSObziKSpXuF75a1PcDvcLM1yFZPFfIBW
         V4SLVbjW050kG6RiaqcCkZuqI+LM4ATohEGUgBV75BXmMKG/x6a/Ty8/5haV0qS9S20j
         Bc1nAk3DDwhpX7LFqJFc8536UMQMgKX15OvWnoISadeF3QHI0XWyF9oxeTEs7MNgje0w
         rqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5WEMTKAqj3+GDD4wcjFKaCDi51DYCzL5pRQuPBSMlA=;
        b=mo/IorIcYmKEfSYC/s3bf/qBvuXwPurgfVIk2CSgDAEQRvpl/lOwaL8JDYZYkj5pHt
         CPfRuaUBkLyD1h6pxQggLl9bXPkOkTNr3C40ZaFiGoXW/0jE0u2c/n+YFXGri4UkKExi
         NYopFoAK4R3R2Vzmq7fBd1aS1d5plExZg9Wr2jZDApgNis3Fe6yKBXNrnIlixQQ5itLe
         elS5VLGgvcBJbkx+Q8A5EjWnLra+NG1YwZ/KvA1PhYYmjd5dheGx7MFeTwgmo3WBzEAz
         Nw4duc2VsfalnWqBgOaof1jg/WJax0e45KAeOFrYiUCRU3svEFONXdLxx8US8eCakLOm
         5nYw==
X-Gm-Message-State: AOAM53362YfDXp5ZvKDZT5eOumxCswxqpI/DyVwMMlvLWbkUA0JPiGia
        w5i/HXiydu6f0WsG6aTx9Yw=
X-Google-Smtp-Source: ABdhPJyM0+A8PZgUR1I/JmxUBGerGJvWQ3WGK3J84RuQlLV/gZwkaTulTFfOC9N5W5p+mAjl5gaTsQ==
X-Received: by 2002:a50:cd06:: with SMTP id z6mr2102579edi.12.1632943631445;
        Wed, 29 Sep 2021 12:27:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::bfc8])
        by smtp.gmail.com with ESMTPSA id f10sm449019edu.70.2021.09.29.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:27:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: r8188eu: remove inirp_init from struct hal_ops
Date:   Wed, 29 Sep 2021 21:26:56 +0200
Message-Id: <20210929192657.9569-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929192657.9569-1-straube.linux@gmail.com>
References: <20210929192657.9569-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inirp_init from struct hal_ops and remove its wrapper
rtw_hal_inirp_init(). Call rtl8188eu_inirp_init() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 11 -----------
 drivers/staging/r8188eu/hal/usb_halinit.c  |  3 +--
 drivers/staging/r8188eu/include/hal_intf.h |  4 ++--
 drivers/staging/r8188eu/os_dep/usb_intf.c  |  2 +-
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 039723d62ae1..ca7f0bcdb4d5 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -53,17 +53,6 @@ void rtw_hal_get_hwreg(struct adapter *adapt, u8 variable, u8 *val)
 		adapt->HalFunc.GetHwRegHandler(adapt, variable, val);
 }
 
-u32 rtw_hal_inirp_init(struct adapter *adapt)
-{
-	u32 rst = _FAIL;
-
-	if (adapt->HalFunc.inirp_init)
-		rst = adapt->HalFunc.inirp_init(adapt);
-	else
-		DBG_88E(" %s HalFunc.inirp_init is NULL!!!\n", __func__);
-	return rst;
-}
-
 u32 rtw_hal_inirp_deinit(struct adapter *adapt)
 {
 	if (adapt->HalFunc.inirp_deinit)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index bdadd801693f..621158900918 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -997,7 +997,7 @@ static u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
 	return _SUCCESS;
  }
 
-static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
+unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 {
 	u8 i;
 	struct recv_buf *precvbuf;
@@ -2150,7 +2150,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->hal_init = &rtl8188eu_hal_init;
 	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
 
-	halfunc->inirp_init = &rtl8188eu_inirp_init;
 	halfunc->inirp_deinit = &rtl8188eu_inirp_deinit;
 
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 2f8c62ebf6b7..4eb9fb81f168 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -125,7 +125,6 @@ struct hal_ops {
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
 
-	u32	(*inirp_init)(struct adapter *padapter);
 	u32	(*inirp_deinit)(struct adapter *padapter);
 
 	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
@@ -174,13 +173,14 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 
+unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
+
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
-u32	rtw_hal_inirp_init(struct adapter *padapter);
 u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index b2cc9060b8ce..a36398774ee5 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -180,7 +180,7 @@ static void chip_by_usb_id(struct adapter *padapter)
 
 static void usb_intf_start(struct adapter *padapter)
 {
-	rtw_hal_inirp_init(padapter);
+	rtl8188eu_inirp_init(padapter);
 }
 
 static void usb_intf_stop(struct adapter *padapter)
-- 
2.33.0

