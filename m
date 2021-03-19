Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9AD341FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCSOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhCSOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:42:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:42:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so5376476wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XTbSIMvQ+/BtlwbF+Ev/3WZAC0rKFSDShYJoFzNVMk=;
        b=JW8Chhximx98r8yKuBtPj2rXc/iY2gKNGzzGyBm1faUdhtOCgCZRy0b+8ctz08dcYY
         LeYBh+3EURfQKWtgp5MN9bY2gvNOcwIFXW8JBq20TsQB11kUPVuvurHkclYoKGN69zeQ
         9+hHSrbZEN+t6yOBptSGds4xvI5MpJ1mEdC4PTTRT3avgmk0e4SYKVXGmPk3LgQj9ggK
         yG7inUpjoZszWjFoxrJf6YkKGbB9HVxe83u58hr8RXzlLW9cnLODxOqC9In5xz20A+ZP
         t2KkNDWbI5Gje/swr2b5hNZXLi4U9h0m/7jYqRwuMT6jDkRLLtWYKDKbxIxpXK7nCnYe
         qc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XTbSIMvQ+/BtlwbF+Ev/3WZAC0rKFSDShYJoFzNVMk=;
        b=QO5GtZq/yb4WKmm1nuR/wkoKh5FIQ+uzXqUkK3PZMBatxaY9CpUaauBKR1S7HzVn8y
         RKmITBub/nZmuig953KlFuzmv6fq0wv1MZ0OstrQRnZ4hZG7vFMD30Mp5tddNTS0XT2K
         mkzBLRq+UYkdiiDwGEBXWAFeB6tU31n6FRDxCSHshEEApaS9BQlCiydMW/PHsH5aP+nP
         FF97tQzu0Q5L5DhNNcXz4fUxW079mOxiRNO71JIGqyiJvQfhOSbqSq7+9fN73VPTVeCX
         lpJFWwFNntAPpIX7c/UEu5JbqlepVEn61qW1KF4f5Sb1ShRpQ6qqlU26kHTqMBwQrIPW
         HfAQ==
X-Gm-Message-State: AOAM5339lFAlbRtx3eKlFzwGx848/jXJYIpPmz3c8mwpyqVFiz9euPKb
        pFfStL8OAM66/uJfGVLFFk8=
X-Google-Smtp-Source: ABdhPJwjGKxUSx+L6k/HH7ynujRJcepef0U/wIStL7Sy6ahIZZMV+895+W4JC2P3QTiqFtRCbvUkRQ==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr3951369wme.81.1616164939365;
        Fri, 19 Mar 2021 07:42:19 -0700 (PDT)
Received: from gamer-pc.Home ([78.17.243.211])
        by smtp.gmail.com with ESMTPSA id j123sm6669281wmb.1.2021.03.19.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:42:18 -0700 (PDT)
From:   Paul McQuade <paulmcquad@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, debsoumyajit100@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Paul McQuade <paulmcquad@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: Removed Unnecessary logging
Date:   Fri, 19 Mar 2021 14:42:06 +0000
Message-Id: <20210319144206.23439-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:
WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 182bb944c9b3..008b60e72758 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -507,7 +507,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 	struct ht_priv	*phtpriv_sta = &psta->htpriv;
 
 	psta->mac_id = psta->aid + 1;
-	DBG_88E("%s\n", __func__);
 
 	/* ap mode */
 	rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
@@ -571,8 +570,6 @@ static void update_hw_ht_param(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	DBG_88E("%s\n", __func__);
-
 	/* handle A-MPDU parameter field
 	 * ampdu_params_info [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
 	 * ampdu_params_info [4:2]:Min MPDU Start Spacing
@@ -1166,8 +1163,6 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	unsigned char *ie = pnetwork->ies;
 	u32 ielen = pnetwork->ie_length;
 
-	DBG_88E("%s\n", __func__);
-
 	pwps_ie_src = pmlmepriv->wps_beacon_ie;
 	if (!pwps_ie_src)
 		return;
@@ -1207,7 +1202,6 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 
 static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 {
-	DBG_88E("%s\n", __func__);
 
 	if (!memcmp(WPS_OUI, oui, 4))
 		update_bcn_wps_ie(padapter);
-- 
2.30.1

