Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838CB3F1823
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhHSLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbhHSLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:23:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:23:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so8315136edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buu5/LlT/wY8R2dObdowDUNyc0UUwmBR3hVh0l4eAaY=;
        b=dWlPrs/iV+Sfjk+sXEPdm9O+hxfCpx2tf/7j18yjciuWVYIRq9PoehDuQzPCKgSBQ9
         fbEHh1Aut1qAoW9/M6BscFkKwvcT1869EWioEvws+YGQwpEpENFNoXg9gfDbON/Gtdfr
         iJzq97aYg8jKzdBOObly/zli1nkN7JtQGUaxxyclMTVRKSKFSlYff/crjmGZi00Y4P/t
         0N1o/KxX/pF2ZaoX2lperFL1AaZU8au63cSazLgZ8fWQdYFShry6tPRifD5z+gcZ5+H1
         MoKapsOwwtjGDCgQsRnes+C06ZIno04376ZxcEW4rSi/ZhjZC1GPKKuPvHiMOf8Pm7eD
         x0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buu5/LlT/wY8R2dObdowDUNyc0UUwmBR3hVh0l4eAaY=;
        b=Lvsmf2j0cl1LaksoU71VY5BW6aG4yFkitlK2CnDMdSklhb4vPEyYIVdesJN1IhPzzY
         ppadhhDflsBKCiEOSTxRMnxfmmHgzqzm5LY1blgY5vpf9z8m5miLq2I1HRE/v9qO6n+1
         WFh7ZRhLzvP3ufWPqWZOK6MjSzWmTPinJFnCwRYIzjh8iMAOJfPcZudLSUqrS3LJ2faq
         7WIGizO4hIPEIPZdEISlzOMgzH0VT66h1bVvTo1C+hOpyyWJpOv5jEjsUvHa8nUsk566
         zUEtom5vXSng+JP57/yf81ns9fWmlD97qlIx/12BFOTI14z5axpJRwocRZyd101pIfpq
         a9Uw==
X-Gm-Message-State: AOAM531/9pzrjZFUcY16diOMFxoZdP+5CBT7FMmzOE8z6fudYaKwYygc
        yYZZYQA33kjaOy0uRZXa/8c=
X-Google-Smtp-Source: ABdhPJx6LwVW66OMnQDje5jQ/X2gCu4rPMjTB1PlokMMKVXBaToJn5ZUBMPPXwoB7wyoockaiT0K3g==
X-Received: by 2002:aa7:d147:: with SMTP id r7mr15701438edo.148.1629372183426;
        Thu, 19 Aug 2021 04:23:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id d23sm1563046edt.39.2021.08.19.04.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:23:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove unused function rtw_add_bcn_ie()
Date:   Thu, 19 Aug 2021 13:21:59 +0200
Message-Id: <20210819112200.32030-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_add_bcn_ie() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c    | 63 ------------------------
 drivers/staging/r8188eu/include/rtw_ap.h |  2 -
 2 files changed, 65 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1127e9a52458..0237b7f8e42f 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -139,69 +139,6 @@ static void update_BCNTIM(struct adapter *padapter)
 	set_tx_beacon_cmd(padapter);
 }
 
-void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork, u8 index, u8 *data, u8 len)
-{
-	struct ndis_802_11_var_ie *pIE;
-	u8 bmatch = false;
-	u8 *pie = pnetwork->IEs;
-	u8 *p = NULL, *dst_ie = NULL, *premainder_ie = NULL;
-	u8 *pbackup_remainder_ie = NULL;
-	u32 i, offset, ielen = 0, ie_offset, remainder_ielen = 0;
-
-	for (i = sizeof(struct ndis_802_11_fixed_ie); i < pnetwork->IELength;) {
-		pIE = (struct ndis_802_11_var_ie *)(pnetwork->IEs + i);
-
-		if (pIE->ElementID > index) {
-			break;
-		} else if (pIE->ElementID == index) { /*  already exist the same IE */
-			p = (u8 *)pIE;
-			ielen = pIE->Length;
-			bmatch = true;
-			break;
-		}
-		p = (u8 *)pIE;
-		ielen = pIE->Length;
-		i += (pIE->Length + 2);
-	}
-
-	if (p && ielen > 0) {
-		ielen += 2;
-
-		premainder_ie = p + ielen;
-
-		ie_offset = (int)(p - pie);
-
-		remainder_ielen = pnetwork->IELength - ie_offset - ielen;
-
-		if (bmatch)
-			dst_ie = p;
-		else
-			dst_ie = (p + ielen);
-	}
-
-	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
-		if (pbackup_remainder_ie && premainder_ie)
-			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
-	}
-
-	*dst_ie++ = index;
-	*dst_ie++ = len;
-
-	memcpy(dst_ie, data, len);
-	dst_ie += len;
-
-	/* copy remainder IE */
-	if (pbackup_remainder_ie) {
-		memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);
-
-		kfree(pbackup_remainder_ie);
-	}
-
-	offset =  (uint)(dst_ie - pie);
-	pnetwork->IELength = offset + remainder_ielen;
-}
-
 void rtw_remove_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork, u8 index)
 {
 	u8 *p, *dst_ie = NULL, *premainder_ie = NULL;
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index b20edab3bb00..fffb6794b1ce 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -16,8 +16,6 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter,
 				     struct sta_info *psta);
 void init_mlme_ap_info(struct adapter *padapter);
 void free_mlme_ap_info(struct adapter *padapter);
-void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
-		    u8 index, u8 *data, u8 len);
 void rtw_remove_bcn_ie(struct adapter *padapter,
 		       struct wlan_bssid_ex *pnetwork, u8 index);
 void update_beacon(struct adapter *padapter, u8 ie_id,
-- 
2.32.0

