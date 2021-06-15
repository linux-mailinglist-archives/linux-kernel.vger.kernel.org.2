Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925EF3A72D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFOASD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhFOASB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91DC0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j62so26503574qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkiRKHus/oLF9CxcLgrPgtRpUSPYqUyHv13lrThNXgk=;
        b=pEzD97hXra25xNdKddFDdAYWJaLEeOIBJLYkNV5qZtzzO/O47PKEohNcF0EA1JiYbH
         thkRDbEIRxuXGBXkmblyWEOqNpbYEP6C3UdXNuy5DfAc5A41NFS40PCKZS3IijrpyyQR
         YxEiTv7FvSo2RbvHbHDPcSGBkkGlBNXHzMNBzRuGVWLDzJA7b4/uXRgnmVCWuR0UPPVK
         eFfKvF+3kT2tdjE/t0BvFtRg2ut8fQG46o5EbUNYATVBNzn5PdLszGtsHYrFBNuXAmNs
         IRcIvcXtfG8++O9PGsg27yYWi/6MbydiPlYxw8oNC875hBf6wBNckrELnuJF7Zro3JWg
         59bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkiRKHus/oLF9CxcLgrPgtRpUSPYqUyHv13lrThNXgk=;
        b=kncHsYBEp7+UHzsbQM4tGPF4ivVcKU62okU9+eZwtVq0gX0VGj1ENF5kvzpilsc3lB
         2+bFjpsvv1qFWEOPsMniImXEYlbIhb/v8z4FbskcZE8jzInwpnMNJTqHuvVVlw/ojP6p
         jzDB/ZZ9dWKfNhXO08Lq2LvVF5CqErEKhL+1jkCUI3R9Rr5SU+2TKYqZIcaBar6HeCPI
         RLWNk66Mh/XshEmbV8MLR3xyyFUQXxO7CSDlophISgUDbzmPyNIj27Rjy0okVj5xe4vY
         9V3E88pHz0/bLKv/yxhrL9eNBQ2fVHV2N7rPsQQWWSrxSur4sATvddzDEqgH6Wxt+ysk
         STqA==
X-Gm-Message-State: AOAM532mKBD+Bu05H4a91cAZZYIJTppKDGcWjU//+Auv7tXFoyaNNsFI
        zftXrLw7IVkwW8/HK3/NgxrVrw==
X-Google-Smtp-Source: ABdhPJyeOsyBv0LzRrUHp4U00Xzd5mCnlz5TBTLaSTj6g9elg3TrHk2lotsUxxh4OJP8MGMPCkTqMQ==
X-Received: by 2002:a37:6594:: with SMTP id z142mr15242224qkb.8.1623716145204;
        Mon, 14 Jun 2021 17:15:45 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:44 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 07/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ieee80211.c
Date:   Tue, 15 Jun 2021 01:14:46 +0100
Message-Id: <20210615001507.1171-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_ieee80211.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/core/rtw_ieee80211.c    | 38 +++----------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index e88ebe8891fc..7a0544cba4bf 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -686,13 +686,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type.
 	 */
-	if (elen < 4) {
-		if (show_errors) {
-			DBG_88E("short vendor specific information element ignored (len=%lu)\n",
-				(unsigned long)elen);
-		}
+	if (elen < 4)
 		return -1;
-	}
 
 	oui = RTW_GET_BE24(pos);
 	switch (oui) {
@@ -711,11 +706,9 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wpa_ie_len = elen;
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
-			if (elen < 5) {
-				DBG_88E("short WME information element ignored (len=%lu)\n",
-					(unsigned long)elen);
+			if (elen < 5)
 				return -1;
-			}
+
 			switch (pos[4]) {
 			case WME_OUI_SUBTYPE_INFORMATION_ELEMENT:
 			case WME_OUI_SUBTYPE_PARAMETER_ELEMENT:
@@ -727,8 +720,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 				elems->wme_tspec_len = elen;
 				break;
 			default:
-				DBG_88E("unknown WME information element ignored (subtype=%d len=%lu)\n",
-					pos[4], (unsigned long)elen);
 				return -1;
 			}
 			break;
@@ -738,8 +729,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wps_ie_len = elen;
 			break;
 		default:
-			DBG_88E("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
@@ -751,14 +740,10 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->vendor_ht_cap_len = elen;
 			break;
 		default:
-			DBG_88E("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
 	default:
-		DBG_88E("unknown vendor specific information element ignored (vendor OUI %3phC len=%lu)\n",
-			pos, (unsigned long)elen);
 		return -1;
 	}
 	return 0;
@@ -789,13 +774,8 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		elen = *pos++;
 		left -= 2;
 
-		if (elen > left) {
-			if (show_errors) {
-				DBG_88E("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
-					id, elen, (unsigned long)left);
-			}
+		if (elen > left)
 			return ParseFailed;
-		}
 
 		switch (id) {
 		case WLAN_EID_SSID:
@@ -876,10 +856,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			break;
 		default:
 			unknown++;
-			if (!show_errors)
-				break;
-			DBG_88E("IEEE 802.11 element parse ignored unknown element (id=%d elen=%d)\n",
-				id, elen);
 			break;
 		}
 		left -= elen;
@@ -905,12 +881,8 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		ether_addr_copy(mac, mac_addr);
 	}
 
-	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac))
 		eth_random_addr(mac_addr);
-		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
-	}
-
-	DBG_88E("%s MAC Address  = %pM\n", __func__, mac_addr);
 }
 
 static int rtw_get_cipher_info(struct wlan_network *pnetwork)
-- 
2.30.2

