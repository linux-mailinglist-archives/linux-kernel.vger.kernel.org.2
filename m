Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7471D41510F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhIVUIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbhIVUHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so10344758wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTMycjhf7bQ4/iwIBGKReOWRba8a40NSGVgfRFeXVyw=;
        b=U/JK16CULZzzTiRpUJyKHh7JkIFkM/fpi6DYhONrevIT534u/XPjhNvx00eyMYoIEP
         DMVVx22NA/RbHXWbja+s3Ro4d7gdnMWyvhTvJjdPRWtkbOO8lG+bNhI9BRHZx9vM7ZFb
         36NmqpWLbDvB5DO/zPumenq72QQ/Uzz3rj8fgL0cIlyYnG615y161tPdgrHHh3lDJwWt
         hHKUPcfbEd/YBFAfmwdK/u5N8tujp3PxQ3SeLj0vBESwsd5SyDlAc74w/4co/VHHbF2l
         lcKXtAtFy3at9P7k8EsBUYtdkhwOd6ci13NbfjZj91IRxuqMzq7UJvO3Q4g0Ne0CGK3v
         7n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTMycjhf7bQ4/iwIBGKReOWRba8a40NSGVgfRFeXVyw=;
        b=TiH4UdUMYIegiUJ0NX3qcZ57UD6IJWm6dz97NL0UozL3AOALzCO/7nisvYLwtPr8zq
         E4YcLelaoJBFPVUoaBxPdz16vHBCqEl543U7zwBxPUNASfIWN5LUdzvq/IcTCZG1YW8r
         7AmuE8K3zJQiNlbOsdvK9ujBq/l6lg7fu31qOsZOAxohXDDD/YtbJbueOtb0ksXkj4dE
         u1eALBGVVI1GrVkHUHYULx5GRcdjuJYbvTai12RsZM73CDI2lQgWAJxdaCc6S1K23HQU
         c3nvH4DipRP0Ih93IQukjUYg+kKrSfP0V+IsDJy1TwE4kn6LS33xorhslqNx1gETu5MB
         fqqQ==
X-Gm-Message-State: AOAM533wtcPIWe4FKsMQXEjx4TppvSTSVG/84lTGEG1KlHIRBdZTp91R
        bmPF33K7l5RfVrM11BWsTbCLWFQAbbtEOA==
X-Google-Smtp-Source: ABdhPJxgvGDUDdGRfxeZvRkGVW9QHcJFLmxkoRsRhGFBTGRbkRf2wnUZzhdOw9hNwz6s6HYPf8oN1A==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr841175wmb.125.1632341140849;
        Wed, 22 Sep 2021 13:05:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/47] staging: r8188eu: remove sreset_get_wifi_status()
Date:   Wed, 22 Sep 2021 22:03:48 +0200
Message-Id: <20210922200420.9693-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sreset_get_wifi_status() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sreset.c    | 30 --------------------
 drivers/staging/r8188eu/include/rtw_sreset.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index 1787c2d7ea5f..baa2a080a46e 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -25,36 +25,6 @@ void sreset_reset_value(struct adapter *padapter)
 	psrtpriv->last_tx_complete_time = 0;
 }
 
-u8 sreset_get_wifi_status(struct adapter *padapter)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
-	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
-
-	u8 status = WIFI_STATUS_SUCCESS;
-	u32 val32 = 0;
-
-	if (psrtpriv->silent_reset_inprogress)
-		return status;
-	val32 = rtw_read32(padapter, REG_TXDMA_STATUS);
-	if (val32 == 0xeaeaeaea) {
-		psrtpriv->wifi_error_status = WIFI_IF_NOT_EXIST;
-	} else if (val32 != 0) {
-		DBG_88E("txdmastatu(%x)\n", val32);
-		psrtpriv->wifi_error_status = WIFI_MAC_TXDMA_ERROR;
-	}
-
-	if (WIFI_STATUS_SUCCESS != psrtpriv->wifi_error_status) {
-		DBG_88E("==>%s error_status(0x%x)\n", __func__, psrtpriv->wifi_error_status);
-		status = (psrtpriv->wifi_error_status & (~(USB_READ_PORT_FAIL | USB_WRITE_PORT_FAIL)));
-	}
-	DBG_88E("==> %s wifi_status(0x%x)\n", __func__, status);
-
-	/* status restore */
-	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
-
-	return status;
-}
-
 void sreset_set_wifi_error_status(struct adapter *padapter, u32 status)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index 4e97997c305b..47ad185c755f 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -28,7 +28,6 @@ struct sreset_priv {
 
 void sreset_init_value(struct adapter *padapter);
 void sreset_reset_value(struct adapter *padapter);
-u8 sreset_get_wifi_status(struct adapter *padapter);
 void sreset_set_wifi_error_status(struct adapter *padapter, u32 status);
 
 #endif
-- 
2.33.0

