Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6350427918
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbhJIKqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244492AbhJIKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:46:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF5C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 03:44:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v25so37548566wra.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 03:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCovqsK/g5JdyZXgPyx0zG0FN5Hs6YuyIwfiLWnb1Sk=;
        b=NHGsc8Eeo1jlnPbTqQrOk4id/R6TdhIg87W/ULRvtmQh8J4rI/h7oy3AFm2Z2+IY/8
         5ul0MkmICHb+S/GT22NXkGXB+lRzh0pTPXqySqs+eBmp/HOMQaznC+VI145v/V47+8ke
         le7/Sl4earG+9gjH2M28pvavGYUTxd5q8JolJT5p1A4v9lEPltGobFnBuKGRBKJ9BVeu
         MdyuG61UGOij+940xDK3CsevQ6JC7ayz9vNWfkIPaeb0D6b6nZZYP6OSEcKk2BGbJKnC
         gEhN4/kkIXNvG3OyGw4lJ8iICBYBJeAmkWUeRWGljVWGU1EoJx3E2QwMfJ/c75S+khOe
         rsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCovqsK/g5JdyZXgPyx0zG0FN5Hs6YuyIwfiLWnb1Sk=;
        b=zmBIaSO2jCKXfld9ROxU3ExNf2jEGZaPtsnHfafSSB+Ct19YsxupgpuZJtJlCA124N
         EK91h0N4RCDejpDxaXraOsvMgSU0raVM5EZYwOWX8FvPpDcgNI5Bx1t2eUAMHWQ/FZrk
         fi4VuVAfakCNaSHViE8fXb1BR16Nz3ueJ/XjJYpbD2pBFSYtAAwZMck92ifH41AOn5m6
         +NhjKQ4f/VoQfY2AYuNqklHZwqs+sGm7eG6yr1qDhMgRBlV+b/QSvcrJCbGrVNlQ5scp
         Z/aw7fGMDdIWz1glNtHw5d52J49Mdf+R8FtuL5OiAnU4JNmwjtkE4exnDMudi3wHD9jW
         tdzg==
X-Gm-Message-State: AOAM531xgfqrf1RPd76uWP6uxeDeddq0lrNRQwXg7Zz0NkXjziSfsIOE
        dYj31E2nAhtlh/ALdMFkC4U=
X-Google-Smtp-Source: ABdhPJzNRmZFO/zsNbw29UuGaFCcXo03oGe5J+TYMblp9eG3TF8RFVaUTGzE0xQT8wFmFVZVP9fltA==
X-Received: by 2002:a1c:a302:: with SMTP id m2mr8939437wme.111.1633776274347;
        Sat, 09 Oct 2021 03:44:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id a81sm1905431wmd.30.2021.10.09.03.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 03:44:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: replace MACADDRLEN with ETH_ALEN
Date:   Sat,  9 Oct 2021 12:44:18 +0200
Message-Id: <20211009104419.8811-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211009104419.8811-1-straube.linux@gmail.com>
References: <20211009104419.8811-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom constant MACADDRLEN with in-kernel ETH_ALEN.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 44 ++++++++++----------
 drivers/staging/r8188eu/include/drv_types.h  |  6 +--
 drivers/staging/r8188eu/include/rtw_br_ext.h |  3 +-
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4913da785a1d..720e190a7436 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1553,31 +1553,31 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	rcu_read_unlock();
 	spin_lock_bh(&padapter->br_ext_lock);
 	if (!(skb->data[0] & 1) && br_port &&
-	    memcmp(skb->data + MACADDRLEN, padapter->br_mac, MACADDRLEN) &&
-	    *((__be16 *)(skb->data + MACADDRLEN * 2)) != __constant_htons(ETH_P_8021Q) &&
-	    *((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP) &&
-	    !memcmp(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN) && padapter->scdb_entry) {
-		memcpy(skb->data + MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN);
+	    memcmp(skb->data + ETH_ALEN, padapter->br_mac, ETH_ALEN) &&
+	    *((__be16 *)(skb->data + ETH_ALEN * 2)) != __constant_htons(ETH_P_8021Q) &&
+	    *((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_IP) &&
+	    !memcmp(padapter->scdb_mac, skb->data + ETH_ALEN, ETH_ALEN) && padapter->scdb_entry) {
+		memcpy(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN);
 		padapter->scdb_entry->ageing_timer = jiffies;
 		spin_unlock_bh(&padapter->br_ext_lock);
 	} else {
-		if (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_8021Q)) {
+		if (*((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_8021Q)) {
 			is_vlan_tag = 1;
-			vlan_hdr = *((unsigned short *)(skb->data + MACADDRLEN * 2 + 2));
+			vlan_hdr = *((unsigned short *)(skb->data + ETH_ALEN * 2 + 2));
 			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + MACADDRLEN * 2 - 2 - i * 2));
+				*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + ETH_ALEN * 2 - 2 - i * 2));
 			skb_pull(skb, 4);
 		}
-		if (!memcmp(skb->data + MACADDRLEN, padapter->br_mac, MACADDRLEN) &&
-		    (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP)))
+		if (!memcmp(skb->data + ETH_ALEN, padapter->br_mac, ETH_ALEN) &&
+		    (*((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_IP)))
 			memcpy(padapter->br_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);
 
-		if (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP)) {
-			if (memcmp(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN)) {
+		if (*((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_IP)) {
+			if (memcmp(padapter->scdb_mac, skb->data + ETH_ALEN, ETH_ALEN)) {
 				padapter->scdb_entry = (struct nat25_network_db_entry *)scdb_findEntry(padapter,
 							skb->data + WLAN_ETHHDR_LEN + 12);
 				if (padapter->scdb_entry) {
-					memcpy(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN);
+					memcpy(padapter->scdb_mac, skb->data + ETH_ALEN, ETH_ALEN);
 					memcpy(padapter->scdb_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);
 					padapter->scdb_entry->ageing_timer = jiffies;
 					do_nat25 = 0;
@@ -1587,7 +1587,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 					padapter->scdb_entry->ageing_timer = jiffies;
 					do_nat25 = 0;
 				} else {
-					memset(padapter->scdb_mac, 0, MACADDRLEN);
+					memset(padapter->scdb_mac, 0, ETH_ALEN);
 					memset(padapter->scdb_ip, 0, 4);
 				}
 			}
@@ -1601,8 +1601,8 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 					skb_push(skb, 4);
 					for (i = 0; i < 6; i++)
 						*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
-					*((__be16 *)(skb->data + MACADDRLEN * 2)) = __constant_htons(ETH_P_8021Q);
-					*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2)) = vlan_hdr;
+					*((__be16 *)(skb->data + ETH_ALEN * 2)) = __constant_htons(ETH_P_8021Q);
+					*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2)) = vlan_hdr;
 				}
 
 				newskb = skb_copy(skb, GFP_ATOMIC);
@@ -1614,9 +1614,9 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 
 				*pskb = skb = newskb;
 				if (is_vlan_tag) {
-					vlan_hdr = *((unsigned short *)(skb->data + MACADDRLEN * 2 + 2));
+					vlan_hdr = *((unsigned short *)(skb->data + ETH_ALEN * 2 + 2));
 					for (i = 0; i < 6; i++)
-						*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + MACADDRLEN * 2 - 2 - i * 2));
+						*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + ETH_ALEN * 2 - 2 - i * 2));
 					skb_pull(skb, 4);
 				}
 			}
@@ -1640,7 +1640,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 			}
 		}
 
-		memcpy(skb->data + MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN);
+		memcpy(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN);
 
 		dhcp_flag_bcast(padapter, skb);
 
@@ -1648,13 +1648,13 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 			skb_push(skb, 4);
 			for (i = 0; i < 6; i++)
 				*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
-			*((__be16 *)(skb->data + MACADDRLEN * 2)) = __constant_htons(ETH_P_8021Q);
-			*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2)) = vlan_hdr;
+			*((__be16 *)(skb->data + ETH_ALEN * 2)) = __constant_htons(ETH_P_8021Q);
+			*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2)) = vlan_hdr;
 		}
 	}
 
 	/*  check if SA is equal to our MAC */
-	if (memcmp(skb->data + MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN)) {
+	if (memcmp(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN)) {
 		DEBUG_ERR("TX DROP: untransformed frame SA:%02X%02X%02X%02X%02X%02X!\n",
 			  skb->data[6], skb->data[7], skb->data[8], skb->data[9], skb->data[10], skb->data[11]);
 		return -1;
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index edf86b6c254e..ce88575a8726 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -280,11 +280,11 @@ struct adapter {
 	spinlock_t br_ext_lock;
 	struct nat25_network_db_entry	*nethash[NAT25_HASH_SIZE];
 	int				pppoe_connection_in_progress;
-	unsigned char			pppoe_addr[MACADDRLEN];
-	unsigned char			scdb_mac[MACADDRLEN];
+	unsigned char			pppoe_addr[ETH_ALEN];
+	unsigned char			scdb_mac[ETH_ALEN];
 	unsigned char			scdb_ip[4];
 	struct nat25_network_db_entry	*scdb_entry;
-	unsigned char			br_mac[MACADDRLEN];
+	unsigned char			br_mac[ETH_ALEN];
 	unsigned char			br_ip[4];
 	struct br_ext_info		ethBrExtInfo;
 
diff --git a/drivers/staging/r8188eu/include/rtw_br_ext.h b/drivers/staging/r8188eu/include/rtw_br_ext.h
index 69905d30c191..17a6154e760a 100644
--- a/drivers/staging/r8188eu/include/rtw_br_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_br_ext.h
@@ -4,7 +4,6 @@
 #ifndef _RTW_BR_EXT_H_
 #define _RTW_BR_EXT_H_
 
-#define MACADDRLEN		6
 #define _DEBUG_ERR		DBG_88E
 #define _DEBUG_INFO		DBG_88E
 #define DEBUG_WARN		DBG_88E
@@ -40,7 +39,7 @@ struct br_ext_info {
 	unsigned int	macclone_enable;
 	unsigned int	dhcp_bcst_disable;
 	int	addPPPoETag;		/* 1: Add PPPoE relay-SID, 0: disable */
-	unsigned char	nat25_dmzMac[MACADDRLEN];
+	unsigned char	nat25_dmzMac[ETH_ALEN];
 	unsigned int	nat25sc_disable;
 };
 
-- 
2.33.0

