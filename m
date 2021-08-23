Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709B63F4C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhHWONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhHWONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:13:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D13C061760
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r19so26362281eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dEok0ftov6OdbLpl61I4vva2hw26c/MHrjNeu1j1lc=;
        b=KJfTDXblyYhqHqYLP5W9zfBieZwzSuerwtiu3d+S8rFzD74iVBjrCyhDyCjaOOab+P
         qLjrMt6wQLjsx7S945sQaR0FXT5y9qOQ6snudWSuYxbRmw0hFSukggGFmMZKIfaHxto1
         EmPcJhiT3lmJPzhn+a8tqZlypQcJQ0KI+zpQqSAG34gDE5IJeRsd3BuZAec7GLFHIGS9
         VNJkwG6bZbOy16ysk3GPektJZD10gMTrNI5jSfWDOMNkF/aapnamHz1VSNVive/C4N1t
         caSndtgGcFySI0Fn9/l9eS3rGKKf0ZFW2lwgxZd9z/1L9q/C86nR4S0YzyH//cNYYBzd
         qu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dEok0ftov6OdbLpl61I4vva2hw26c/MHrjNeu1j1lc=;
        b=tqwy519sz+BVsvVI7TrhhLkl0zqAnaRufaXb4aobrn+/NdmHeD60cQt/Vetrs6nbRu
         8xdr4avBVyXJ7DtzgXc7ay7V6qNAZD33mSBLp7bJTUzZb8cwDPMBajFnxVoT9tMV2Q5h
         1k5TasqHtVhprBjMBDrP9G/0B9VFbw73gEjRRSMqNroTTiumfXU28lviomt3kwPd5wuO
         0pvYgNXlry0y3cCgQHQN++GeawaA8FOBVSTaE8o2xuc+eVZq3aZTadnYwfUfBjMDiaBG
         aoQlCLcxh4xwONCh/QF9HpUWnRQODyEJjHfuzGjz6M+jkvLN2ceEt2HXFI9vJEVHN8pG
         kl/w==
X-Gm-Message-State: AOAM5305KwmoIOEjR6HNItqMmFMDap432edyAf0VtB/HCTpg2q4L841e
        hWK89SI/XEBe1mpqGNIxOd8/wRo++/4=
X-Google-Smtp-Source: ABdhPJw9rhr82x+pczzBcsywIFlOJ4dB5ygGwHa/u2az0o3KcztH/LVTqS8sa/WxTaXi7kDm/glLoA==
X-Received: by 2002:a05:6402:482:: with SMTP id k2mr38172145edv.188.1629727934027;
        Mon, 23 Aug 2021 07:12:14 -0700 (PDT)
Received: from agape ([5.171.81.132])
        by smtp.gmail.com with ESMTPSA id cn16sm9464811edb.9.2021.08.23.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:12:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: rtl8723bs: remove unused rtw_set_802_11_bssid() function
Date:   Mon, 23 Aug 2021 16:12:03 +0200
Message-Id: <b3d1756b6ae4be7ca4fc50e12bd7e10587a6020c.1629727333.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1629727333.git.fabioaiuto83@gmail.com>
References: <cover.1629727333.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove rtw_set_802_11_bssid() function left unused
after wext routines removal.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    | 64 -------------------
 .../staging/rtl8723bs/include/rtw_ioctl_set.h |  1 -
 2 files changed, 65 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index eee250f12df3..5cfde7176617 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -134,70 +134,6 @@ u8 rtw_do_join(struct adapter *padapter)
 	return ret;
 }
 
-u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
-{
-	u8 status = _SUCCESS;
-
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	netdev_dbg(padapter->pnetdev, "set bssid:%pM\n", bssid);
-
-	if ((bssid[0] == 0x00 && bssid[1] == 0x00 && bssid[2] == 0x00 && bssid[3] == 0x00 && bssid[4] == 0x00 && bssid[5] == 0x00) ||
-	    (bssid[0] == 0xFF && bssid[1] == 0xFF && bssid[2] == 0xFF && bssid[3] == 0xFF && bssid[4] == 0xFF && bssid[5] == 0xFF)) {
-		status = _FAIL;
-		goto exit;
-	}
-
-	spin_lock_bh(&pmlmepriv->lock);
-
-
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
-		goto handle_tkip_countermeasure;
-	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true)
-		goto release_mlme_lock;
-
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		if (!memcmp(&pmlmepriv->cur_network.network.mac_address, bssid, ETH_ALEN)) {
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
-				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
-		} else {
-			rtw_disassoc_cmd(padapter, 0, true);
-
-			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
-				rtw_indicate_disconnect(padapter);
-
-			rtw_free_assoc_resources(padapter, 1);
-
-			if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
-				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_MASTER_STATE);
-				set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
-			}
-		}
-	}
-
-handle_tkip_countermeasure:
-	if (rtw_handle_tkip_countermeasure(padapter, __func__) == _FAIL) {
-		status = _FAIL;
-		goto release_mlme_lock;
-	}
-
-	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
-	memcpy(&pmlmepriv->assoc_bssid, bssid, ETH_ALEN);
-	pmlmepriv->assoc_by_bssid = true;
-
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
-		pmlmepriv->to_join = true;
-	else
-		status = rtw_do_join(padapter);
-
-release_mlme_lock:
-	spin_unlock_bh(&pmlmepriv->lock);
-
-exit:
-
-	return status;
-}
-
 u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 {
 	u8 status = _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
index 31424bf2d926..ab349de733c8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
@@ -11,7 +11,6 @@
 typedef u8 NDIS_802_11_PMKID_VALUE[16];
 
 u8 rtw_set_802_11_authentication_mode(struct adapter *pdapter, enum ndis_802_11_authentication_mode authmode);
-u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid);
 u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep);
 u8 rtw_set_802_11_disassociate(struct adapter *padapter);
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num);
-- 
2.20.1

