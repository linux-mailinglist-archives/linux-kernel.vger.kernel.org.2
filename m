Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2733C3E2013
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbhHFAlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbhHFAk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:40:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A39C06179A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id x17so4461267wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PegLaMgCLA483OQ2FYUTnGJ/mPU5ZJS0l25ewYVKbj4=;
        b=Awaib9DcinCrQKCVOepFxC2mmtq/IgBYQ8T3WLZpHfc8BIsWYeIR8H3W0VBsy0Dxeu
         66UEYxaGF5pznr0IANSEBgtIZZrMlSNuHDlHPll+tMuU87QqBWdl3oT5c3YZNlwGXSSu
         XCZufKIBQKuEc2id/5E2zj3qTmomOYKQVFeD9x2btmJEOd0aZKfrgoOpuIDDiKW47lT4
         ifD2x1rQG7oOXkjzhsf3u41epY/KpaPpoPNFomU0l5yu1vnn0vNO2bn4tpbTIvXFSh5R
         ckPhru9LEA0+Kuum1DzlwpuLnsg75X/LEwa92SbMyjn7xnWQ+AElm3LLtxvpzA5ynZyd
         VsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PegLaMgCLA483OQ2FYUTnGJ/mPU5ZJS0l25ewYVKbj4=;
        b=sl5fWTfSftc+xQJfD/NwJGiK086IV4ymE4xxyeNr28uvf9prnJy46df+oRPFyYnlap
         mZfyh7rGAVz2kbDWjLSD3Vp8pZCKSTC9dJbWRI5H2LH+uLjjHQSna6LHWaeCy12vD/My
         wanpvCJmkFpKy2ZSbKSD3TmefteZObgJvi1uSJUttQ/SbfiCPoHJNN2h/O2zvkE4PFNq
         3oLYlIAVzz93WtFEJkAdfXT6YUq0bQ60KKI9tYjDAXPmmFtjTAItIUMvNuOrL2r8LhbS
         uGfglAj7yMx9WD+ziFxaw7ifoecYVVtIdWpiPtEkz5Xlbyq8o5iBRNYOpbiHtBsxGd54
         fmsA==
X-Gm-Message-State: AOAM532bjMTDuzIoUS/kaqJGXbOfbKV0psGwGDchTvlvT7MrycMvNMTo
        w3jmlCcahD+YN9dzCv31EzZkuQ==
X-Google-Smtp-Source: ABdhPJwATpORKozWI1nEbiquAzAXagM8kLVSvuKtQRuon+UZMiVwXN95KYzdpeUiWH25NSQ5O+tNyQ==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr8645502wmh.38.1628210441990;
        Thu, 05 Aug 2021 17:40:41 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:41 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 05/11] staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
Date:   Fri,  6 Aug 2021 01:40:28 +0100
Message-Id: <20210806004034.82233-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_mp.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 252d5c37d813..def0c250a4ac 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -383,7 +383,6 @@ s32 mp_start_test(struct adapter *padapter)
 
 	psta = rtw_alloc_stainfo(&padapter->stapriv, bssid.MacAddress);
 	if (!psta) {
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
@@ -938,7 +933,6 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -972,8 +966,6 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 
 void Hal_ProSetCrystalCap (struct adapter *pAdapter, u32 CrystalCapVal)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
-
 	CrystalCapVal = CrystalCapVal & 0x3F;
 
 	// write 0x24[16:11] = 0x24[22:17] = CrystalCap
-- 
2.31.1

