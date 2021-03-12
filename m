Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40A5338A98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhCLKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhCLKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:51:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57925C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:51:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4331256wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1xqbdJpzo9WZ92Ur0/uK5J2PqPmNSDd9F341QSbm7Dc=;
        b=Uednlt9G1tV+9cEcaaO0SYY595OIOPWY2an+lijefiDCw63Slkl4s3uLeIjeZ+kcJs
         UMXDatma8bhnWRY3BDLMJCDcKKHqlhwVRytm6MhgpuAIJ7sDfma/3l/FqsXkOIi8z7Tk
         0PVT9AGsMg2MAHfkoPgRZ0eTF89vf0Pr3A9s8wbsBCHChJ7Sdo5H3RdvbguBliYy3Rjz
         b/TnzvPVRuq4ZZC7l6NkWgQsc4wG44EM2jjt4sqSTXE6P3b7M8/1DXuxInh32oDpek+p
         Pgyb1GSjO/lZjWpFRBgd8DUy9GpscmKKoXfwIK7jrUCdNrJYnY+oXVhHQnIJ71dgrB46
         j8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1xqbdJpzo9WZ92Ur0/uK5J2PqPmNSDd9F341QSbm7Dc=;
        b=km7GkIAO81gBQr7kf0sB2VKDIcvFfKm0mJZdHO7HcORtpGiUL/Qb6Ho7kZA8C9QeX8
         tF212aCt/eRnHKnC+aCgg20J2+douMr20L0wo+lkaajkxIE92xFpv3ngPsCeWdJvNE99
         zxGH0lhZi8+dn/PCYSc620Rh137G7cAzifBCXvR33fFAud+bDG3ODmk1K9p1nLWKgqUu
         xPkhZSNF+sGreQbDbFbwvSTSVQmLIqnf2BDwt+wfd9t88S59IYxWlWt/STGj1EER2A93
         VoFcm7ftlHRIHcRPZc5NA9Mxea7YVas/8o/PUQz3/Alys7Rwz+xcf/sHJyzzaz8cKUML
         ZMBw==
X-Gm-Message-State: AOAM533HBsg1cv4SjSKTj5lz6z1Ru6XsmCj6SK8BWkpXCX52//r+RGlU
        LSeJ0RMHXFnny84o4L3/62Bpt0Iyyyg=
X-Google-Smtp-Source: ABdhPJz8WmWHma02Qb3eE+57SlmK2DG0BHdrPgW/wZYw4VMHeb/PSXzvltZe0dT2YwqDuAhm+KdUUA==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr12440710wmc.103.1615546300066;
        Fri, 12 Mar 2021 02:51:40 -0800 (PST)
Received: from agape.jhs ([5.171.81.107])
        by smtp.gmail.com with ESMTPSA id n6sm8481257wrw.63.2021.03.12.02.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:51:39 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:51:37 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: put quoted string in a single line
Message-ID: <20210312105134.GA6079@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: quoted string split across lines
+		DBG_871X("HT: STA %pM HT Capabilities "
+			   "Info: 0x%04x\n", MAC_ARG(psta->hwaddr), ht_capab);

WARNING: quoted string split across lines
+			DBG_871X("%s STA %pM - no "
+				   "greenfield, num of non-gf stations %d\n",

WARNING: quoted string split across lines
+			DBG_871X("%s STA %pM - 20 MHz HT, "
+				   "num of 20MHz HT STAs %d\n",

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index b6f944b37b08..b8706e1eb8ca 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -2009,8 +2009,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	if (psta->flags & WLAN_STA_HT) {
 		u16 ht_capab = le16_to_cpu(psta->htpriv.ht_cap.cap_info);
 
-		DBG_871X("HT: STA %pM HT Capabilities "
-			   "Info: 0x%04x\n", MAC_ARG(psta->hwaddr), ht_capab);
+		DBG_871X("HT: STA %pM HT Capabilities Info: 0x%04x\n",
+			 MAC_ARG(psta->hwaddr), ht_capab);
 
 		if (psta->no_ht_set) {
 			psta->no_ht_set = 0;
@@ -2022,10 +2022,9 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->no_ht_gf_set = 1;
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
-			DBG_871X("%s STA %pM - no "
-				   "greenfield, num of non-gf stations %d\n",
-				   __func__, MAC_ARG(psta->hwaddr),
-				   pmlmepriv->num_sta_ht_no_gf);
+			DBG_871X("%s STA %pM - no greenfield, num of non-gf stations %d\n",
+				 __func__, MAC_ARG(psta->hwaddr),
+				 pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH) == 0) {
@@ -2033,10 +2032,9 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
-			DBG_871X("%s STA %pM - 20 MHz HT, "
-				   "num of 20MHz HT STAs %d\n",
-				   __func__, MAC_ARG(psta->hwaddr),
-				   pmlmepriv->num_sta_ht_20mhz);
+			DBG_871X("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
+				 __func__, MAC_ARG(psta->hwaddr),
+				 pmlmepriv->num_sta_ht_20mhz);
 		}
 
 	} else {
-- 
2.20.1

