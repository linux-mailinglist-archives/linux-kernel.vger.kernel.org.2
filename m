Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880C636DC42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbhD1PqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbhD1Ppl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:45:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E204C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:40:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y62so11370277pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sqkVdXeEz4owYNw6h1aYR7WoMUz4ve5xHSXB8//YGWw=;
        b=ccoRy0gYBQe41sNLt74ah3nRbUdOBJ2bw1Bm3k1Apx523tVBhJX/F1T2BnLyt5xx1R
         asG3dgV/ylNZvfwDzDEksOrqQwQ6ki9UvZa5aS+zcfKr3Fbk11r0WhA3M1xmuIAp8tMH
         9b1w7MxEo+vEsa37ENMdoWT8U1lU8HI4nqo0DDOcjk0E/lw8jVL9FO8AidohWBuv5xor
         QSW64MmnNv4Yzy6V4iI3zttZ9vxSD6s/uJnKY6q5TxunhhnGHG3t1nYPFYBYo8mdT4zW
         VaOZdgyZ1Sko2vaSUTg5OiuSwDOOLn0cOzHI6uxZDwv2iSHmZFB5PItpzO7K53AQQNAs
         zYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sqkVdXeEz4owYNw6h1aYR7WoMUz4ve5xHSXB8//YGWw=;
        b=oPHkSyjR29jiSnL2cr1xZtHPpNvJMyy/bnkWfgiT9Sl+izY1SSsP8j4x43HYF9N94k
         lDadd3lKCnUhPbN0kuQUVSnsmaO8szjoPY4TChliM4Op4sMGEhn4IHYUt4rXqO1c+US3
         EsgCnOtvLvvXd24JXk5uvqNYDZe6DkB/teY62dBlqAxnxf3hHDa7jZhAvCgVbAqL+g/m
         vzHp39EcyMwc47yqk3UYtKs/FHK1UbnQWDjbcESkG2rfyi/nQey/YV1i1hAEnO/ynvzW
         aW2Ywq8Z74rXIl4tsZaEtfODOJsrnkY6n+lOy7fOjDCMLxN/KWbcTa1FikYWzpNs1sGX
         HN8A==
X-Gm-Message-State: AOAM533Y+Q59ZMpBv+ExVQQvhJF1IxKYmBpNztkxe6bNHkWCMI2gox8y
        RcloOAn3AiBQXqSoaiZvQ5U=
X-Google-Smtp-Source: ABdhPJx6g+dy19HdvPNYIEKkMqQbOC0n20H5k0NOWxk84Bb3A08rDV64qcGNpHp5izWoLYtXxVpFhg==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr27076461pgk.154.1619624420506;
        Wed, 28 Apr 2021 08:40:20 -0700 (PDT)
Received: from user ([2001:4490:4409:14a:3c1e:9a4c:c5d6:1dec])
        by smtp.gmail.com with ESMTPSA id u13sm107606pgm.41.2021.04.28.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:40:19 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
X-Google-Original-From: Saurav Girepunje <saurav.girepunje@google.com>
Date:   Wed, 28 Apr 2021 21:10:11 +0530
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        fabioaiuto83@gmail.com, martinsdecarvalhobeatriz@gmail.com,
        saurav.girepunje@gmail.com, marcocesati@gmail.com,
        manuelpalenzuelamerino@gmail.com, fmdefrancesco@gmail.com,
        42.hyeyoo@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: remove unneeded variable
Message-ID: <20210428154011.GA5571@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below are the changes:

Remove unneeded variable "u8 *pbuf" from function start_bss_network
argument as this can be get from first argument "padapter"

Remove the struct wlan_bssid_ex *network from createbss_hdl function
as this is only used to pass as second argument to start_bss_network()

Remove the struct mlme_priv *mlmepriv from rtw_ap_restore_network
function as this is only used to pass as second argument
to start_bss_network()

Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 5 ++---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +---
 drivers/staging/rtl8723bs/include/rtw_ap.h    | 2 +-
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 2d6fb440d383..004921715ceb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -652,7 +652,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	/* pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3; */
 }
 
-void start_bss_network(struct adapter *padapter, u8 *pbuf)
+void start_bss_network(struct adapter *padapter)
 {
 	u8 *p;
 	u8 val8, cur_channel, cur_bwmode, cur_ch_offset;
@@ -2038,7 +2038,6 @@ void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 /* restore hw setting from sw data structures */
 void rtw_ap_restore_network(struct adapter *padapter)
 {
-	struct mlme_priv *mlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta;
@@ -2057,7 +2056,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 		pmlmeext->cur_bwmode
 	);
 
-	start_bss_network(padapter, (u8 *)&mlmepriv->cur_network.network);
+	start_bss_network(padapter);
 
 	if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
 	    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 0297fbad7bce..269e391bb92a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -663,7 +663,7 @@ int rtw_startbss_cmd(struct adapter  *padapter, int flags)
 
 	if (flags & RTW_CMDF_DIRECTLY) {
 		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		start_bss_network(padapter, (u8 *)&(padapter->mlmepriv.cur_network.network));
+		start_bss_network(padapter);
 	} else {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f19a15a3924b..662491b31a4e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5442,9 +5442,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 	/* u32 initialgain; */
 
 	if (pmlmeinfo->state == WIFI_FW_AP_STATE) {
-		struct wlan_bssid_ex *network = &padapter->mlmepriv.cur_network.network;
-
-		start_bss_network(padapter, (u8 *)network);
+		start_bss_network(padapter);
 		return H2C_SUCCESS;
 	}
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_ap.h b/drivers/staging/rtl8723bs/include/rtw_ap.h
index 4a1ed9eff83a..7a735e691399 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ap.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ap.h
@@ -14,7 +14,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx);
 void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level);
 void expire_timeout_chk(struct adapter *padapter);
 void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
-void start_bss_network(struct adapter *padapter, u8 *pbuf);
+void start_bss_network(struct adapter *padapter);
 int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len);
 void rtw_ap_restore_network(struct adapter *padapter);
 void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
-- 
2.25.1

