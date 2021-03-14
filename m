Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE333A3B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhCNJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhCNJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:03:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id t18so4434218lfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hguw5+O2RXZ1hrL363Zt/JpzxYDjK5DKbtQbdHmjNfA=;
        b=XIpf0NlDgf3jaQj4Rkx43hV8ifcplrc9YfH+4IhyWcdGFYN7Mm9hfMtMY2GZ2H8JPt
         0182mRSaSP5WhwgPaH9nXHMeNrcw7G9jN5hXQ1IL0KABfd4fkKa/6rmURo5xj+thVgTF
         Ou6nf9IFIn9D8/um+vWUO4UJ3H6XZoQXJUDUxkFexrbCrxJ2GtyjtSaT0cu1SJXSIdRd
         4g11P1qKwKB6o+soteNlSRTOwvnWrk+sL2xwXhbXoRtWRjeqax+hqLSVp5RTm7YZWP/0
         76NKv10W9RjNFqMAkj1zyhv1RZwTwkytF3IGcQTy0He8UVAwPBNu8378VoRmo3BjxdFD
         IBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hguw5+O2RXZ1hrL363Zt/JpzxYDjK5DKbtQbdHmjNfA=;
        b=WMxsoqM9sIXGLpExilNwuBLHWLUQ1Uxaj5x//lfL5XdYWMGk36aNFAxbqKgZ8ll/iM
         JhkMr34bjJMzUc4Kk78nWInl6sKJdTxdRhRZnNpUx7WsBaIR+3j4wE3+h9LzbRaFqRWU
         7pgEJB8WMvlq8lljTtClzTo2paYjI5SppEeqK2S/awgRhubfTOm2Hzv4KxIhZz2LUCCq
         t6ueLL+ppmTDrcf+bsMvn8ynP47Tub4UvgY0VA2q5GE0oHxfIr5IqHaZ3I7wFGs7IzDE
         iUC5S+WbNrJhbGVRKTv5F5qC6yakBOG98VUnfxbDJ5Ac4ccK9CqZp/KMuD7xERxI49ZC
         NYHg==
X-Gm-Message-State: AOAM530RQ3t2ZMO0kim0paRovbswTr56KkvPWjoNq5lnw81nwdA5KODU
        r9J57FK63Sc5Ugjfb8C2tfU=
X-Google-Smtp-Source: ABdhPJw8YisPXI7lgmJQPChYNB1hUVwl5a1e9hxwlgEvYUMROXFHSiaWgjPd97NarrONVpmd7qKPJQ==
X-Received: by 2002:ac2:482c:: with SMTP id 12mr4601474lft.4.1615712618184;
        Sun, 14 Mar 2021 01:03:38 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id w5sm2265319lfu.179.2021.03.14.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:03:37 -0800 (PST)
Received: (nullmailer pid 21235 invoked by uid 1000);
        Sun, 14 Mar 2021 09:03:26 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mrinal Pandey <mrinalmni@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Simon Fong <simon.fodin@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 4/4] staging:r8188eu: use ieee80211_is_ctl instead IsFrameTypeCtrl
Date:   Sun, 14 Mar 2021 12:02:47 +0300
Message-Id: <20210314090247.21181-5-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210314090247.21181-1-insafonov@gmail.com>
References: <20210314090247.21181-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IsFrameTypeCtrl() duplicate ieee80211_is_ctl().

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c | 8 +++++---
 drivers/staging/rtl8188eu/include/wifi.h        | 8 --------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 4fae75fc3dd5..8669bf097479 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -133,6 +133,8 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 	struct odm_phy_status_info *pPHYInfo  = (struct odm_phy_status_info *)(&pattrib->phy_info);
 	u8 *wlanhdr;
+	struct ieee80211_hdr *hdr =
+		(struct ieee80211_hdr *)precvframe->pkt->data;
 	struct odm_per_pkt_info	pkt_info;
 	u8 *sa = NULL;
 	struct sta_priv *pstapriv;
@@ -144,13 +146,13 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 
 	wlanhdr = precvframe->pkt->data;
 
-	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
+	pkt_info.bPacketMatchBSSID = (!ieee80211_is_ctl(hdr->frame_control) &&
 		!pattrib->icv_err && !pattrib->crc_err &&
 		!memcmp(get_hdr_bssid(wlanhdr),
 		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
 
 	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
-				 (!memcmp(ieee80211_get_DA((struct ieee80211_hdr *)wlanhdr),
+				 (!memcmp(ieee80211_get_DA(hdr),
 				  myid(&padapter->eeprompriv), ETH_ALEN));
 
 	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
@@ -161,7 +163,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 			sa = padapter->mlmepriv.cur_network.network.MacAddress;
 		/* to do Ad-hoc */
 	} else {
-		sa = ieee80211_get_SA((struct ieee80211_hdr *)wlanhdr);
+		sa = ieee80211_get_SA(hdr);
 	}
 
 	pstapriv = &padapter->stapriv;
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index d65a0a88a69a..84e17330628e 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -197,14 +197,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-static inline int IsFrameTypeCtrl(unsigned char *pframe)
-{
-	if (GetFrameType(pframe) == WIFI_CTRL_TYPE)
-		return true;
-	else
-		return false;
-}
-
 /*-----------------------------------------------------------------------------
 			Below is for the security related definition
 ------------------------------------------------------------------------------*/
-- 
2.26.2

