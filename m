Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005DB3DCD2A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhHATFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhHATE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54FC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p5so18808427wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyvuVBVuXkJQQgpwzFWDdtDXAB5I90GortRYzoxqYpk=;
        b=U+OulQ3miDkLlo5Oc4L4J3afXW1pkimUIL54IUOnL/WQ15mWq11UENprTR4FPTQ7La
         IiALDWANOxBv0/9t/aVM+Uw8YaykGMVNHNi0f8NoNrKXu57psWEHwp7xh0fYEzAGJ8Cp
         LNpzify46qrOJrG75YiR+tWXrj/xB6ccKYqCO50RhdQGftTVGcX77qls3NuAsxqHLtk0
         rx0TBBpfv+h8Y7+g7u/ZQa9PnutR+97ZhdWr85OXskbxjVeVbkyXCk1vE4SueLizMxMa
         P98pX71CRtpDaXE26Qvn9edqQbOFtfwldfFxrd23qpqXCg3nePoaU6Xohx533/0Z7ve3
         4hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyvuVBVuXkJQQgpwzFWDdtDXAB5I90GortRYzoxqYpk=;
        b=dupGPAGsPJklVRx2mR0kqz5sy9tLinIoZYHrep4hFIlJ41eInGvhfc67yk8v5qTXbB
         AvmU6iMtvZa74p7SDufaY7AbAuW9pGLhXMLad6NnpY6yIRtspwQWj+r4lZ+fmgDVzMgZ
         eroY3enOz+m7A/4jQaRWPFHPjWqLSfgQ0/VTMNmKA42u/qXmW42hDvioVrzV1JcrbfGr
         5iH8lpt8gVQ9JAsF65Sar7U+XDKLffjKcTQaJtHsrpIMGkSfcjo4s3RtQx6IJRnQDT5M
         qvkla1+G2hfLzr4VZAxQ2yBSgJ/fBezHTV64ZgOE5XwZX5N59Zoyon++kfMTRgsNoho5
         hyMA==
X-Gm-Message-State: AOAM532/+zor4/SBefSi1xGmcLCz0vk7hZ1Q4k+SMx3OMCZ0F9X9y7hI
        UnVsaWvVSbVh64R+HcwKDjqvmgCLr30T5pdi
X-Google-Smtp-Source: ABdhPJzrVnaRlLRfvI0XmD3YddJ1Bw1c3MEoPtpbeUi10bgNHZZzKmYER6Eo0Bb42H2+BBqnTFO05w==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr5028211wri.128.1627844686730;
        Sun, 01 Aug 2021 12:04:46 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:46 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 09/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
Date:   Sun,  1 Aug 2021 20:04:31 +0100
Message-Id: <20210801190437.82017-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_mp.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 1b4e9bbc394b..a2d08c724a07 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -383,7 +383,6 @@ s32 mp_start_test(struct adapter *padapter)
 
 	psta = rtw_alloc_stainfo(&padapter->stapriv, bssid.MacAddress);
 	if (psta == NULL) {
-		RT_TRACE(_module_mp_, _drv_err_, ("mp_start_test: Can't alloc sta_info!\n"));
 		pmlmepriv->fw_state = pmppriv->prev_fw_state;
 		res = _FAIL;
 		goto end_of_mp_start_test;
@@ -864,15 +863,11 @@ u32 mp_query_psd(struct adapter *pAdapter, u8 *data)
 	u32 i, psd_pts = 0, psd_start = 0, psd_stop = 0;
 	u32 psd_data = 0;
 
-	if (!netif_running(pAdapter->pnetdev)) {
-		RT_TRACE(_module_mp_, _drv_warning_, ("mp_query_psd: Fail! interface not opened!\n"));
+	if (!netif_running(pAdapter->pnetdev))
 		return 0;
-	}
 
-	if (check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE) == false) {
-		RT_TRACE(_module_mp_, _drv_warning_, ("mp_query_psd: Fail! not in MP mode!\n"));
+	if (check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE) == false)
 		return 0;
-	}
 
 	if (strlen(data) == 0) { /* default value */
 		psd_pts = 128;
@@ -939,7 +934,6 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
 	if (pxmitpriv->pallocated_xmit_extbuf  == NULL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
-- 
2.31.1

