Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D23F4C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhHWONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhHWOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:12:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A28C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d11so37257367eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gd/UxYevi+G4kNYb51ak9+gmuz/dblR9kVc8KItLL1o=;
        b=qy3L2E8tuhkogc2PPLenM6iTt2GlQq84LsgK4ngAo8wlo2ZRqm3vu/sj7XNiAgWvhI
         us7ggOF076U6m2LRdJnHPi3b2lDJO4Lc1Pzt30atpl7srs8w6zSaaA2IVyRNeZDfmRC0
         YyMbthhl7nwdoIWl6ZBrYHUx6ozXzHdPaUKYV7/2oziaimWwlZ47bh5gmmDhunFOiz4L
         yS9CtJ3RR/Chf+K1QXJul9kz9HGZpZrD2FK8CSCfVxykJw1abTQ1BZKIcI9cgGXygYPf
         sK00IUlqph2oIyMP87QmIOw1JrOkF7/tNmQtJGVk4zG4jXlqmCxKO8WPTlXBK6yHOUZr
         l6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gd/UxYevi+G4kNYb51ak9+gmuz/dblR9kVc8KItLL1o=;
        b=R4WLycv+u4ANY6TByYduLDvhvEjdYtBHK5RHZkE4yT/9cM5d7Mo1QFsKAeQDFAUILI
         3hVmf4SyxHccYdlTviqpq3Pr3BlWVWoeiv6k0goOCVbRszmMums17kcCod3uKxEBpWoh
         8IPR16eqe8rFV3sPA0nWGlwT7IQMUOnmvMoKffFX1c18ey8sogYn4qg61c/o94uKwrIM
         0PY5jRfW4WDjMezXNLwP5ZVDkEtt56kn78JM/ldVgmD8jqQjujBYSbDWav+15KLrcLQq
         6EZ/sM3Wc9CgWM5K75vzcdHf1mrd/COyXU9G1pqLAtuYlu85roDYDtBxPVlYIzsXJa9G
         2RJg==
X-Gm-Message-State: AOAM531VJYcSnnEEfujNSbpF3+DqWy3pumLNT9JP0QDbSgyRAoN1428b
        3ia8JsUdJ4IZy0leP+iArpMypX/1vSM=
X-Google-Smtp-Source: ABdhPJz5ht1tmeg7mfC/3cSY5LGnVao/47oKz+6lOXYSki7CcFDPZBWa1lWjORxEPsS0YuedUrxbhQ==
X-Received: by 2002:a17:906:1d43:: with SMTP id o3mr36159931ejh.44.1629727932389;
        Mon, 23 Aug 2021 07:12:12 -0700 (PDT)
Received: from agape ([5.171.81.132])
        by smtp.gmail.com with ESMTPSA id u2sm7496079ejc.61.2021.08.23.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:12:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: rtl8723bs: remove functions notifying wext events
Date:   Mon, 23 Aug 2021 16:12:02 +0200
Message-Id: <0d745350ff3d411dda329b8c1e2261361570db6e.1629727333.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1629727333.git.fabioaiuto83@gmail.com>
References: <cover.1629727333.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove functions that once were meant to notify
wext events to userspace. Now they are donig nothing
useful so just remove them.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  4 +-
 drivers/staging/rtl8723bs/include/drv_types.h |  3 --
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 38 -------------------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  4 --
 4 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 5f25cbf83723..eee250f12df3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -449,10 +449,8 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		res = true;
 
 	} else {
-		if (rtw_is_scan_deny(padapter)) {
-			indicate_wx_scan_complete_event(padapter);
+		if (rtw_is_scan_deny(padapter))
 			return _SUCCESS;
-		}
 
 		spin_lock_bh(&pmlmepriv->lock);
 
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 580028d28c42..ae32963a156d 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -495,9 +495,6 @@ static inline u8 *myid(struct eeprom_priv *peepriv)
 
 #include <rtw_btcoex.h>
 
-void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
-void rtw_indicate_wx_assoc_event(struct adapter *padapter);
-void indicate_wx_scan_complete_event(struct adapter *padapter);
 int rtw_change_ifname(struct adapter *padapter, const char *ifname);
 
 extern char *rtw_initmac;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 733c6b93eb8f..9d4a233a861e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -29,44 +29,6 @@
 #define WEXT_CSCAN_HOME_DWELL_SECTION	'H'
 #define WEXT_CSCAN_TYPE_SECTION		'T'
 
-void indicate_wx_scan_complete_event(struct adapter *padapter)
-{
-	union iwreq_data wrqu;
-
-	memset(&wrqu, 0, sizeof(union iwreq_data));
-}
-
-
-void rtw_indicate_wx_assoc_event(struct adapter *padapter)
-{
-	union iwreq_data wrqu;
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
-
-	memset(&wrqu, 0, sizeof(union iwreq_data));
-
-	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-
-	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
-		memcpy(wrqu.ap_addr.sa_data, pnetwork->mac_address, ETH_ALEN);
-	else
-		memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.mac_address, ETH_ALEN);
-
-	netdev_dbg(padapter->pnetdev, "assoc success\n");
-}
-
-void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
-{
-	union iwreq_data wrqu;
-
-	memset(&wrqu, 0, sizeof(union iwreq_data));
-
-	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	eth_zero_addr(wrqu.ap_addr.sa_data);
-}
-
 static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index a4560ba22db1..1341801e5c21 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -48,7 +48,6 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 		rtw_cfg80211_indicate_connect(adapter);
 	}
 
-	rtw_indicate_wx_assoc_event(adapter);
 	netif_carrier_on(adapter->pnetdev);
 
 	if (adapter->pid[2] != 0)
@@ -58,7 +57,6 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
 	rtw_cfg80211_indicate_scan_done(padapter, aborted);
-	indicate_wx_scan_complete_event(padapter);
 }
 
 static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
@@ -129,8 +127,6 @@ void rtw_os_indicate_disconnect(struct adapter *adapter)
 
 	rtw_cfg80211_indicate_disconnect(adapter);
 
-	rtw_indicate_wx_disassoc_event(adapter);
-
 	/* modify for CONFIG_IEEE80211W, none 11w also can use the same command */
 	rtw_reset_securitypriv_cmd(adapter);
 }
-- 
2.20.1

