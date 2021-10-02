Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF741FC71
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhJBOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhJBOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 10:15:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A591C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 07:13:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h1so6441973pfv.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GmWwwc/7x5Zt6Q9LrNLIvEiUYEg4AjgxYm4UNuFf9Ig=;
        b=i1HJZNUFFGNOjpzYrPGS487erP/Dutkcy538JXmzDZ9BuDeIe/r1sGe+SCkueYIROW
         sP91bmwvjhpc6Vo9cZ43jAlWN63S1FmGdy0gg5CgLoRK3ELNxUfbCDgBdm5uV3hmvppP
         FL3kmrPQ5M3ZcdbYWg+dI5+H1o+MCUq0UNOn0w/tbpyRrKoT6xnqZ6Aygaag4oaecrIy
         swkwAEukFOMaEtRvXecg7nF0X+A/5JyjvCKLLe+EE5qZnsiMopsxGuIw1ug6CEfvT4ob
         IjxEUrLDOe4qeWW3jePZQSL+eNycVW0qwzAkkdaeGGeI8yUsaXrQLKDOpqOPsLY+RtIE
         nRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GmWwwc/7x5Zt6Q9LrNLIvEiUYEg4AjgxYm4UNuFf9Ig=;
        b=g8BAVpi7mAxLw+XBHOyPR22LDjEUGpfyXNc2pz6WxW6OLQff2dH3kFGOKjJL+CAP7f
         barT9dNXg2dPYtTWJCzedHtqIXpw1zFg97PrxeMF/JtggMjXwXn7b/8T7o+sVigRHsR9
         kiAS3joW/qkoW2QLw2QYjUVd4vqfhvTmw8/Hhr4+D2CjcvpSDEMLUUgIuk7fNymFhwqX
         6ihs6wyIzIdpAWpsQs5ptHBydBpS6IKaSSuEPFEhPn8XRDp2uhViLSpz26Arkbw93Gch
         Df4Fc4z0wSYDrNZJoPp/toupooeLcWH5UKjz0jxEIrnBC3QmndfCmJPif2irzRAlv3xz
         sN6g==
X-Gm-Message-State: AOAM531LnjNikilYAPlvzC6JRpvblFpEUb7jNxMmgYXc5oS8pNdP8qmi
        +xVqUt+PXjQoMcEa5zwxA0k=
X-Google-Smtp-Source: ABdhPJxL3P/OBvBoNSKbjJ71tJMJERPJcFe+QbVr8EnjkA4fcsksLk89hxLzrnxT9iAB6PnHTYYZtw==
X-Received: by 2002:a63:950f:: with SMTP id p15mr3013366pgd.265.1633184012883;
        Sat, 02 Oct 2021 07:13:32 -0700 (PDT)
Received: from user ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id l185sm9308237pfd.29.2021.10.02.07.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 07:13:32 -0700 (PDT)
Date:   Sat, 2 Oct 2021 19:43:25 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com,
        straube.linux@gmail.com, saurav.girepunje@gmail.com,
        linux@roeck-us.net, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove unused variable local variable
Message-ID: <YVhpBWhNt7mwfNKU@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused local variable macAddr.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c    | 3 +--
 drivers/staging/r8188eu/core/rtw_xmit.c      | 2 +-
 drivers/staging/r8188eu/include/usb_osintf.h | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 62a672243696..bcd0f9dd64b1 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -695,8 +695,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 	}
 }

-void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
-				unsigned char *ipAddr)
+void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr)
 {
 	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
 	struct nat25_network_db_entry *db;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f9ae48f73cdf..b34cb5b97df1 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1593,7 +1593,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 		if (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP)) {
 			if (memcmp(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN)) {
 				padapter->scdb_entry = (struct nat25_network_db_entry *)scdb_findEntry(padapter,
-							skb->data + MACADDRLEN, skb->data + WLAN_ETHHDR_LEN + 12);
+							skb->data + WLAN_ETHHDR_LEN + 12);
 				if (padapter->scdb_entry) {
 					memcpy(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN);
 					memcpy(padapter->scdb_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);
diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
index 34229b1cb081..624298b4bd0b 100644
--- a/drivers/staging/r8188eu/include/usb_osintf.h
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -19,8 +19,7 @@ u8 usbvendorrequest(struct dvobj_priv *pdvobjpriv, enum bt_usb_request brequest,
 int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
 void netdev_br_init(struct net_device *netdev);
 void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb);
-void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
-		     unsigned char *ipAddr);
+void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);
 void nat25_db_expire(struct adapter *priv);
 int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);

--
2.32.0

