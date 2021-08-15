Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F8E3EC886
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhHOKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhHOKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:25:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1562C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 03:25:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so9732043wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHXtZAE4yO9OQyKA/b1qZJJcObKkgYRmxLsUtglnXMc=;
        b=ReTTdvEmhOFKhfd25CUZDMb+Oix1oHh/tLRsU6qNvEYfLZBpJ6aJiJARsCcekrykYv
         zDd9+R+nDJzaqIkithfRjEq7hgb7+5BTRy92bMaWcCOhIJC8+mArv0eycDJEP5TB3rfH
         aRrUGCbIjWLBmnd4aSGS9Dlc4mkK0RBkFfF5ItxkDkShXo7mN8BCyqJqlnB8j5x5IRtq
         uIu/FqkjwC0+lXwv1vSL7C72bGKcwohRzkdjGVaugfEhIPz8PUMMjrV3fCDiQofreQjV
         Eb23ldN7OAjVZSJ/etwsWxkRKWukB34wSgjszNPp1hH+7VJDvHv9H8bZLXblFvpnrUjt
         Labg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHXtZAE4yO9OQyKA/b1qZJJcObKkgYRmxLsUtglnXMc=;
        b=S7apInw5L67VsookRtX+q3qUHu/xs8gcKG+Mo1CIj6p8W4NYjwUCyGNEBQmNeYWu6f
         ebUI4NXMopQ+Z5JaG+CF7TaWmUDIErkNpKlfelV1KKq+hzYOK8wjexO52V1QZDE10nq3
         GLmhaGtTUsnEpX1RVHo32ii4wxlSBM0UPMWa/8IowWJEfrTfY9XfD6UZU8TPUa1huSPu
         O/qEZhJxAws6TdSlQxB9pcWyUIKmDVzzrMJkvUcup3mHzsrYKOhf4cnKMAFL6lVJaiXP
         W/MfrToq/0IJwNt8Fh4pJSd8BrheVEumK6DdpEmwRVB54r/0LqVdQOswHJfjKY2TA1N3
         zuAw==
X-Gm-Message-State: AOAM533tNMSZTWDSM2K37StbhzeYzdtKL3w2NrbOakRSIo/NTkLe2KDE
        W7N/58xLgZOBDCtXnh4yDttIUE/kwPk=
X-Google-Smtp-Source: ABdhPJwKuEcz0JPleUFLY0hqQkHU5snGigsQchBQ1Zr2lNhliPrLUO37FUqxUsFx5dXV7gKJcOuXrQ==
X-Received: by 2002:a1c:10e:: with SMTP id 14mr10440487wmb.93.1629023112324;
        Sun, 15 Aug 2021 03:25:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id x13sm7623167wrq.44.2021.08.15.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 03:25:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove kernel version depended code paths
Date:   Sun, 15 Aug 2021 12:24:06 +0200
Message-Id: <20210815102406.3707-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove kernel version depended code paths from the driver.
Reported by checkpatch.

WARNING: LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      |  4 ----
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 24 +-------------------
 drivers/staging/r8188eu/os_dep/rtw_android.c |  9 --------
 drivers/staging/r8188eu/os_dep/xmit_linux.c  |  5 ----
 4 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 9189f5c845f3..d5ef5783f4ad 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1499,11 +1499,7 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 
 	rcu_read_lock();
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	if (rcu_dereference(adapter->pnetdev->rx_handler_data) &&
-#else
-	if (rcu_dereference(adapter->pnetdev->br_port) &&
-#endif
 	    (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE) == true)) {
 		/*  expire NAT2.5 entry */
 		nat25_db_expire(adapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index cc7e54170948..f4bf4732578a 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -637,19 +637,7 @@ static unsigned int rtw_classify8021d(struct sk_buff *skb)
 	return dscp >> 5;
 }
 
-static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 2, 0))
-			    ,struct net_device *sb_dev
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0))
-			    ,struct net_device *sb_dev
-                            ,select_queue_fallback_t fallback
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 14, 0))
-			    ,void *unused
-                            ,select_queue_fallback_t fallback
-#elif (LINUX_VERSION_CODE == KERNEL_VERSION(3, 13, 0))
-			    , void *accel
-#endif
-)
+static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb, struct net_device *sb_dev)
 {
 	struct adapter	*padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -706,15 +694,9 @@ int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
 	return 0;
 }
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,39)
 static const struct device_type wlan_type = {
 	.name = "wlan",
 };
-#else
-static struct device_type wlan_type = {
-	.name = "wlan",
-};
-#endif
 
 struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 {
@@ -992,11 +974,7 @@ void netdev_br_init(struct net_device *netdev)
 
 	rcu_read_lock();
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	if (rcu_dereference(adapter->pnetdev->rx_handler_data)) {
-#else
-	if (rcu_dereference(adapter->pnetdev->br_port)) {
-#endif
 		struct net_device *br_netdev;
 		struct net *devnet = NULL;
 
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index d666feb87a7a..bdd381606ba6 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -63,13 +63,8 @@ int rtw_android_cmdstr_to_num(char *cmdstr)
 {
 	int cmd_num;
 	for (cmd_num=0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0))
 		if (!strncasecmp(cmdstr, android_wifi_cmd_str[cmd_num],
 		    strlen(android_wifi_cmd_str[cmd_num])))
-#else
-		if (0 == strnicmp(cmdstr, android_wifi_cmd_str[cmd_num],
-		   strlen(android_wifi_cmd_str[cmd_num])))
-#endif
 			break;
 	return cmd_num;
 }
@@ -162,11 +157,7 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 		ret = -ENOMEM;
 		goto exit;
 	}
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 0, 0))
 	if (!access_ok(priv_cmd.buf, priv_cmd.total_len)) {
-#else
-	if (!access_ok(VERIFY_READ, priv_cmd.buf, priv_cmd.total_len)) {
-#endif
 		DBG_88E("%s: failed to access memory\n", __func__);
 		ret = -EFAULT;
 		goto exit;
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 3a1b9d8988f2..4f1ce346b3a5 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -108,7 +108,6 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 {
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 35))
 	u16	queue;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
@@ -121,10 +120,6 @@ void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 		if (__netif_subqueue_stopped(padapter->pnetdev, queue))
 			netif_wake_subqueue(padapter->pnetdev, queue);
 	}
-#else
-	if (netif_queue_stopped(padapter->pnetdev))
-		netif_wake_queue(padapter->pnetdev);
-#endif
 
 	dev_kfree_skb_any(pkt);
 }
-- 
2.32.0

