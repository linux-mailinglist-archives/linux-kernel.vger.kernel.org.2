Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A992351217
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhDAJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhDAJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E3C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so1853411ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xwsyk5M2ogLi9nmW/kQchMobHehDTMMJkPU2CSpl2Eg=;
        b=XPirmGbU1Byh6T47qPfpQdbAJ8B0KZWCA9E+kHR46hGyVW+5slLVobTzKdePtdMWPE
         /GfBtYl6CYADeX+OXTawlgaQGTc/AMkvJbDLwvFwg+pPOFERuY65Wvh1DHEZazM42d/M
         ER+3OB5cTGMzNn/y3/4kisth3P5TGLC5dJNHBznxLylcVIXD6R9GZo0hoI1zo6No4jdV
         1yb3aV1gfO+gv/Y/xDdVopinQr2n7YDNj7UGU8NexmE6S3ZrJZ2pVjhLV8D0lwBzkt6U
         g+W03ieah9NrqNRvCAoAf33c9WQs8+yUMcL13h6HbXTaLwVfOgFo+jQmUWlHUzudVkbd
         vDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xwsyk5M2ogLi9nmW/kQchMobHehDTMMJkPU2CSpl2Eg=;
        b=TIUbe3uHlJQ1RsAbNblcVUP+rVJq0aGLx0UfIpvE7sxT1HjN/92Z1GU0yxoj9aeMKs
         a4mpttM3yUNMfN9UwUCX0zMnvoXmQ0vQ049B0nWzY5myII6TvVZAP92TKZZBNg4tiTde
         BAe56wNhCnxgxxXJ038bSoTEgyCRW/cNgcsfT9XoGtFCKo29Mbb9BtESIvAQ5YPqyK4G
         VsZl0zwtjPqRb58dr98oNn8/9JAKeXgqyy32f12ZDxbyHIy9E8z0s1LA5PdzVzshurK7
         wNBJ+OTHXvxdlqXaBsHlcGgt3q8Z0eP5YkHFxsyP7Fr0q6bqq61cANDH5HW5Cnu666aJ
         j4bg==
X-Gm-Message-State: AOAM532J/8IiVYO94ilbdUZ6p0lYAdJVEBJDzQekFVTTNPm31jTos1wB
        e2blgaey8hvn7kavavueUeU=
X-Google-Smtp-Source: ABdhPJx48JyACV/VpHs6TP6A1mk3zdz60VKNL8UAA3fbUGBC/KiZDHsjUwXiMIWnZtCWcdIZPIE/5A==
X-Received: by 2002:a17:906:cc4b:: with SMTP id mm11mr8009792ejb.549.1617268940659;
        Thu, 01 Apr 2021 02:22:20 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id 90sm3336777edf.31.2021.04.01.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 35/49] staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723bs_xmit.c
Date:   Thu,  1 Apr 2021 11:21:05 +0200
Message-Id: <3d24811fe7136774ff51e014c96ec9e1778e73c2.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 597cf3a88c51..c18587cc78a5 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -102,11 +102,6 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 		(padapter->bSurpriseRemoved) ||
 		(padapter->bDriverStopped)
 	) {
-		RT_TRACE(
-			_module_hal_xmit_c_,
-			_drv_notice_,
-			("%s: bSurpriseRemoved(write port)\n", __func__)
-		);
 		goto free_xmitbuf;
 	}
 
@@ -151,16 +146,6 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 
 	ret = (padapter->bDriverStopped) || (padapter->bSurpriseRemoved);
 	if (ret) {
-		RT_TRACE(
-			_module_hal_xmit_c_,
-			_drv_err_,
-			(
-				"%s: bDriverStopped(%d) bSurpriseRemoved(%d)!\n",
-				__func__,
-				padapter->bDriverStopped,
-				padapter->bSurpriseRemoved
-			)
-		);
 		return _FAIL;
 	}
 
@@ -374,8 +359,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 
 		/*  dump xmit_buf to hw tx fifo */
 		if (pxmitbuf) {
-			RT_TRACE(_module_hal_xmit_c_, _drv_info_, ("pxmitbuf->len =%d enqueue\n", pxmitbuf->len));
-
 			if (pxmitbuf->len > 0) {
 				struct xmit_frame *pframe;
 				pframe = (struct xmit_frame *)pxmitbuf->priv_data;
@@ -424,16 +407,6 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 		(padapter->bDriverStopped) ||
 		(padapter->bSurpriseRemoved)
 	) {
-		RT_TRACE(
-			_module_hal_xmit_c_,
-			_drv_notice_,
-			(
-				"%s: bDriverStopped(%d) bSurpriseRemoved(%d)\n",
-				__func__,
-				padapter->bDriverStopped,
-				padapter->bSurpriseRemoved
-			)
-		);
 		return _FAIL;
 	}
 
@@ -492,8 +465,6 @@ int rtl8723bs_xmit_thread(void *context)
 
 	complete(&pxmitpriv->SdioXmitTerminate);
 
-	RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("-%s\n", __func__));
-
 	thread_exit();
 }
 
@@ -509,8 +480,6 @@ s32 rtl8723bs_mgnt_xmit(
 	u8 *pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	u8 txdesc_size = TXDESC_SIZE;
 
-	RT_TRACE(_module_hal_xmit_c_, _drv_info_, ("+%s\n", __func__));
-
 	pattrib = &pmgntframe->attrib;
 	pxmitbuf = pmgntframe->pxmitbuf;
 
@@ -572,7 +541,6 @@ s32 rtl8723bs_hal_xmit(
 	err = rtw_xmitframe_enqueue(padapter, pxmitframe);
 	spin_unlock_bh(&pxmitpriv->lock);
 	if (err != _SUCCESS) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("rtl8723bs_hal_xmit: enqueue xmitframe fail\n"));
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 		pxmitpriv->tx_drop++;
-- 
2.20.1

