Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1351E43542C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJTT45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJTT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:56:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:54:38 -0700 (PDT)
Received: from dslb-188-096-142-022.188.096.pools.vodafone-ip.de ([188.96.142.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mdHfW-0007Cd-H6; Wed, 20 Oct 2021 21:54:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: use helper to set broadcast address
Date:   Wed, 20 Oct 2021 21:54:00 +0200
Message-Id: <20211020195401.12931-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211020195401.12931-1-martin@kaiser.cx>
References: <20211020195401.12931-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eth_broadcast_addr helper assigns the broadcast address to an address
array. Call this function instead of copying the address bytes manually.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 13 +++++--------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  |  3 +--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b0dfafe526f7..7b372374e638 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3409,7 +3409,6 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	unsigned char			*mac;
 	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 wpsie[255] = { 0x00 }, p2pie[255] = { 0x00 };
 	u16 wpsielen = 0, p2pielen = 0;
@@ -3443,8 +3442,8 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 			memcpy(pwlanhdr->addr3, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
 		} else {
 			/*	broadcast probe request frame */
-			memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
-			memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
+			eth_broadcast_addr(pwlanhdr->addr1);
+			eth_broadcast_addr(pwlanhdr->addr3);
 		}
 	}
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -4311,7 +4310,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
-	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -4334,7 +4332,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
-	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
+	eth_broadcast_addr(pwlanhdr->addr1);
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
@@ -4676,7 +4674,6 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	int	bssrate_len = 0;
-	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -4702,8 +4699,8 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 		memcpy(pwlanhdr->addr3, da, ETH_ALEN);
 	} else {
 		/*	broadcast probe request frame */
-		memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
-		memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
+		eth_broadcast_addr(pwlanhdr->addr1);
+		eth_broadcast_addr(pwlanhdr->addr3);
 	}
 
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index c5f9353fe3e6..14eed14a4c6a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -226,14 +226,13 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
-	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
+	eth_broadcast_addr(pwlanhdr->addr1);
 	memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
-- 
2.20.1

