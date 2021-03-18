Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E212340ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhCRUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhCRUGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:06:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0366C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:06:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so6851452wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nypa92rIONIP6MHeDAjQaLrMxV8licEdgYTWekxdpk=;
        b=X3T1butCCUApSfe0+au8WFNDSoZuYBcFth5FTIHS2MPBLcBZeUIkJ3bZZAJ/JX90LX
         8yj6nKC5xVsE4sgRIixAykDxOilGevK9osLarV+lgPtQ7Akrx5yIXWiXqEaaKQVxXlgO
         9RvqpHrKY9jOBjVRdxCzTqMPvygE11EXfTmSDoHd0UvcTQrWLi9CHqaXIwvbmHSPJI1t
         SLJKbnO481SpK0L3sEfkE15mpxD4KZb2KyS2JWSTQjJ7Q9uSlyhYIJIQI0IkQwKhY6Pi
         unz1355JAuPmWmcOywx320ZyPcszxiCk2bDr7cVpTfwl6plOYdjlAaBkrydscBVkI0lJ
         T2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nypa92rIONIP6MHeDAjQaLrMxV8licEdgYTWekxdpk=;
        b=OVG/YsEpoPYgwQYOx2ckusvCTTTuL96NxFyDLWDQ0ejy5pA0nnwkDbxM0CVqf6HXzf
         +K5Nt3CvvrxsntjWUDwsjKRvRFqZbS3/o9pMVXHZCYvBtZ31GmhqUgQZNAqGzYL24nEp
         P4PfUXl4t2DGD2XcqC3RyH5OyXuTRTQeWhcy+pd8kHaRMXYBpwhRY6XNsPeaRPeRXEbd
         igOIdYVCBj8Jg+f6t3B2PG0Vr7/2q4nkpmzk1lZ+37Go5ftnvmTnJwl4iGHrb5u+d70l
         Fstv8oA6AjPoiweF7g8nbYMmZ6CudyoBhQJoM85voFOORxk8AvqD2kTbQvXnroM5kHBE
         lUYA==
X-Gm-Message-State: AOAM533AH2CLGE3+M33AxCvV5Jl0PJe50vEciWdfbCsmtu14SjGJQnB6
        N5oGgoJzX/iQ6FXja65kHzQ=
X-Google-Smtp-Source: ABdhPJxP16vnvDW1wA6vqk+QP4YRlv2nWh+2JwxEUwlf0mDTX/8PdtXzs2d4kpiTBmSe4fqHHP/bkw==
X-Received: by 2002:adf:f843:: with SMTP id d3mr923942wrq.55.1616098006616;
        Thu, 18 Mar 2021 13:06:46 -0700 (PDT)
Received: from gamer-pc.Home ([78.17.203.10])
        by smtp.gmail.com with ESMTPSA id m17sm4222365wrx.92.2021.03.18.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:06:46 -0700 (PDT)
From:   Paul McQuade <paulmcquad@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Paul McQuade <paulmcquad@gmail.com>
Subject: [PATCH] rtl8188eu: Removed Unnecessary ftrace-like logging
Date:   Thu, 18 Mar 2021 20:05:27 +0000
Message-Id: <20210318200527.454486-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prefer using ftrace

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

