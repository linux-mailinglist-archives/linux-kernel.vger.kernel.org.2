Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0F3EDA84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhHPQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:06:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:06:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b15so32655018ejg.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sp+ED5Bp4akAUiymE6G4SkCLxIppuWlilfcPp7IwoAA=;
        b=CWXFcVDJVQiN9WydHpeXhj+cPLxcISf10err8IUkVuHx46+4iIGAmsH1UrM2hyBkm+
         XLZx2/d8B4tQHcjzkWtbu/9KEW1Q2yL9QImVyXAPOuBFBhyb4u/ndRWz9WJ4T6N274MV
         dyAZ0ZwuIV01U8EGSJvVrAOgtmEem+AFOOgCod6KcNkJaW42FcnaNvHf+95ZLrmVjbXC
         A/MpsL4MlCboEdtCIwaVn495BJp+WEe/QAzROBD6NljHxUr5ZX9MWyplbWCJq5fPcRyL
         o3WLT6lkoxMyj9f+DjIYL+ay2uBbLKovih7GCnQf0AwKeDCC9IfZGCtId51JEWkMKwlx
         PzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sp+ED5Bp4akAUiymE6G4SkCLxIppuWlilfcPp7IwoAA=;
        b=A9pTcS17l3/YVhOLkdgDb4XOIgEs5v9+jwo3iTTsWgwURn1O5wEUuuohuVoFiNmG72
         u0UCpXqzmzZiMpDdBhH7b0Ny8OTzQUVjpeT9BjEubP5yeUTrcRkH/KY+IprlKjcfgd8g
         aCRPqRXAu1e2HYf7/Vn3bmMzFl4Dg88CI6WMXo+dR3K3eNhEJAxNCxP1HmZU4Ju8kXd9
         rr/oiIUbKwESASAq0oRVgceDOunAlwVhuxlGUxaM96R/IOKNG8hj+eZqQp2HXhL+Wefh
         hCXaHhGrn7/x0k6hemiFChyCEDxLvb8IhZuXQmqB34XDGBramj8Y5F5eoP9dsJKfBBGG
         Ggzg==
X-Gm-Message-State: AOAM531Sici/yPjqLYhAxS7qzuO+XrBQRcuEQBZdWmRgegU2QFo6TW4R
        8ZUEWCyrvWwwmE+LUWrSxrUzHa+vIK4=
X-Google-Smtp-Source: ABdhPJxQqeARaTSl2XkJ046omgG2Mn8W2fnkJpaV/inzbOGhsb6TpBGtBfoICyHWEoBKP3xFuvftuQ==
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr16713449ejb.145.1629129984796;
        Mon, 16 Aug 2021 09:06:24 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id s18sm3906239ejh.12.2021.08.16.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:06:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: Remove unused nat25_handle_frame()
Date:   Mon, 16 Aug 2021 18:06:15 +0200
Message-Id: <20210816160617.11949-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816160617.11949-1-fmdefrancesco@gmail.com>
References: <20210816160617.11949-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove nat25_handle_frame() because it is not called by any other
function of the driver.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c    | 61 --------------------
 drivers/staging/r8188eu/include/recv_osdep.h |  1 -
 2 files changed, 62 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 22737cd0fe44..5035f354081f 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -1019,67 +1019,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 	return -1;
 }
 
-int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb)
-{
-	if (!(skb->data[0] & 1)) {
-		int is_vlan_tag = 0, i, retval = 0;
-		unsigned short vlan_hdr = 0;
-		unsigned short protocol;
-
-		protocol = be16_to_cpu(*((__be16 *)(skb->data + 2 * ETH_ALEN)));
-		if (protocol == ETH_P_8021Q) {
-			is_vlan_tag = 1;
-			vlan_hdr = *((unsigned short *)(skb->data+ETH_ALEN*2+2));
-			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data+ETH_ALEN*2+2-i*2)) = *((unsigned short *)(skb->data+ETH_ALEN*2-2-i*2));
-			skb_pull(skb, 4);
-		}
-
-		if (!priv->ethBrExtInfo.nat25_disable) {
-			spin_lock_bh(&priv->br_ext_lock);
-			/*
-			 *	This function look up the destination network address from
-			 *	the NAT2.5 database. Return value = -1 means that the
-			 *	corresponding network protocol is NOT support.
-			 */
-			if (!priv->ethBrExtInfo.nat25sc_disable &&
-			    (be16_to_cpu(*((__be16 *)(skb->data+ETH_ALEN*2))) == ETH_P_IP) &&
-			    !memcmp(priv->scdb_ip, skb->data+ETH_HLEN+16, 4)) {
-				memcpy(skb->data, priv->scdb_mac, ETH_ALEN);
-
-				spin_unlock_bh(&priv->br_ext_lock);
-			} else {
-				spin_unlock_bh(&priv->br_ext_lock);
-
-				retval = nat25_db_handle(priv, skb, NAT25_LOOKUP);
-			}
-		} else {
-			if (((be16_to_cpu(*((__be16 *)(skb->data+ETH_ALEN*2))) == ETH_P_IP) &&
-			    !memcmp(priv->br_ip, skb->data+ETH_HLEN+16, 4)) ||
-			    ((be16_to_cpu(*((__be16 *)(skb->data+ETH_ALEN*2))) == ETH_P_ARP) &&
-			    !memcmp(priv->br_ip, skb->data+ETH_HLEN+24, 4))) {
-				/*  for traffic to upper TCP/IP */
-				retval = nat25_db_handle(priv, skb, NAT25_LOOKUP);
-			}
-		}
-
-		if (is_vlan_tag) {
-			skb_push(skb, 4);
-			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data+i*2)) = *((unsigned short *)(skb->data+4+i*2));
-			*((__be16 *)(skb->data+ETH_ALEN*2)) = __constant_htons(ETH_P_8021Q);
-			*((unsigned short *)(skb->data+ETH_ALEN*2+2)) = vlan_hdr;
-		}
-
-		if (retval == -1) {
-			/* DEBUG_ERR("NAT25: Lookup fail!\n"); */
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 #define SERVER_PORT			67
 #define CLIENT_PORT			68
 #define DHCP_MAGIC			0x63825363
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index 7308f21c428f..72ddf515071e 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -30,7 +30,6 @@ int rtw_os_recvbuf_resource_free(struct adapter *adapt, struct recv_buf *buf);
 void rtw_os_read_port(struct adapter *padapter, struct recv_buf *precvbuf);
 
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
-int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb);
 int _netdev_open(struct net_device *pnetdev);
 int netdev_open(struct net_device *pnetdev);
 int netdev_close(struct net_device *pnetdev);
-- 
2.32.0

