Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9398B326F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhB0WYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhB0WXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:23:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202BC06178A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id e7so19443514lft.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozW0+8qA2DIjT5bEaDvlYuNWLmMF22eQ+KNwcfhxuPY=;
        b=WZ4St4F+fM1VySf0eqYvV6nJpYexsRX6zklULGnv/CZwolPqW6GZWE3GSoBgGP51JP
         xCyL/B5aFCuo1BV5kZR+2Ltupf0XsMvOuHCLcMrXoaDhQWSBCvLQhppoFCL9+32b2rfd
         A5ArKhwYTQjK0yEr7zmYMQ6SPy9aunRWYklio2GT416P26hUUPLuy5Qj38ycbHg1UL8P
         MBM5VWhLzHr/LO1o6qwvpztBEmjim+8maAACpN6bTNtY6xXdKF/cRUalGRkUP4+cR7ET
         EVa1d/YQ/pP3ufr+fN1JyHXL1S9Z84ktwv6cge2qjruGOLgKbNd5HKGW+KS0MHdBxI1n
         9l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozW0+8qA2DIjT5bEaDvlYuNWLmMF22eQ+KNwcfhxuPY=;
        b=lNd+uPysuBEIXiezoKHYAwO0LGHjnpqSgtnDT1gK//TGCuDprvuoG0mSJGBavWW3OD
         LaHm3O4+vAZpb+f5e9buerh+fcZddHRN2t4w8x+9FdOxwrH1YTr1suyApyhuwqeAseja
         YZBEYjK4M+9je40sLZgELEiUxDi04wltY5pG1VJXaVG8u2pWzjFGwFex5d8LBq+nKjSo
         070aoVinocUqBIm1hW7I11d4XrmZCwhLvdtp2xpqaOhb1OlW8d+zAkqn5LUvwjtRfNdQ
         QuavB+qOxxAr1nqCYNMNhG+jo3JrZHjA5KWDpV7SsHk6sXeaLv6SH4B6f9xX9XpoR/vN
         l5Xg==
X-Gm-Message-State: AOAM533rH6RulHnyn4KjydXWbsYnR6KQif0ln7RYfLWu8Ii8Og/s/Mxg
        vda67n6zCLDHVokw+6hEDhY=
X-Google-Smtp-Source: ABdhPJxIFH0gc0K15t5f/1/h+siZifHT49n8hZvr/hDqlU93HKnZ8fPXG7cdByJ4JLTf0vWFKjWEAg==
X-Received: by 2002:a05:6512:694:: with SMTP id t20mr5360053lfe.151.1614464593995;
        Sat, 27 Feb 2021 14:23:13 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id d7sm1811970lfg.303.2021.02.27.14.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:23:13 -0800 (PST)
Received: (nullmailer pid 581547 invoked by uid 1000);
        Sat, 27 Feb 2021 22:23:09 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 2/4] staging:rtl8712: remove unused definitions from wifi.h
Date:   Sun, 28 Feb 2021 01:22:35 +0300
Message-Id: <20210227222236.581490-3-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210227222236.581490-1-insafonov@gmail.com>
References: <20210227222236.581490-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These definitions are not used and will not be useful in the future.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8712/wifi.h | 74 ----------------------------------
 1 file changed, 74 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 5de0e67b1876..11fba6f9e721 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -16,22 +16,8 @@
 
 #include <linux/compiler.h>
 
-#define WLAN_IEEE_OUI_LEN	3
-#define WLAN_CRC_LEN		4
-#define WLAN_BSSID_LEN		6
-#define WLAN_BSS_TS_LEN		8
 #define WLAN_HDR_A3_LEN		24
-#define WLAN_HDR_A4_LEN		30
 #define WLAN_HDR_A3_QOS_LEN	26
-#define WLAN_HDR_A4_QOS_LEN	32
-#define WLAN_SSID_MAXLEN	32
-#define WLAN_DATA_MAXLEN	2312
-
-#define WLAN_A3_PN_OFFSET	24
-#define WLAN_A4_PN_OFFSET	30
-
-#define WLAN_MIN_ETHFRM_LEN	60
-#define WLAN_MAX_ETHFRM_LEN	1514
 
 #define P80211CAPTURE_VERSION	0x80211001
 
@@ -74,33 +60,6 @@ enum WIFI_FRAME_SUBTYPE {
 	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | WIFI_DATA_TYPE),
 };
 
-enum WIFI_REASON_CODE	{
-	_RSON_RESERVED_			= 0,
-	_RSON_UNSPECIFIED_		= 1,
-	_RSON_AUTH_NO_LONGER_VALID_	= 2,
-	_RSON_DEAUTH_STA_LEAVING_	= 3,
-	_RSON_INACTIVITY_		= 4,
-	_RSON_UNABLE_HANDLE_		= 5,
-	_RSON_CLS2_			= 6,
-	_RSON_CLS3_			= 7,
-	_RSON_DISAOC_STA_LEAVING_	= 8,
-	_RSON_ASOC_NOT_AUTH_		= 9,
-	/* WPA reason */
-	_RSON_INVALID_IE_		= 13,
-	_RSON_MIC_FAILURE_		= 14,
-	_RSON_4WAY_HNDSHK_TIMEOUT_	= 15,
-	_RSON_GROUP_KEY_UPDATE_TIMEOUT_	= 16,
-	_RSON_DIFF_IE_			= 17,
-	_RSON_MLTCST_CIPHER_NOT_VALID_	= 18,
-	_RSON_UNICST_CIPHER_NOT_VALID_	= 19,
-	_RSON_AKMP_NOT_VALID_		= 20,
-	_RSON_UNSUPPORT_RSNE_VER_	= 21,
-	_RSON_INVALID_RSNE_CAP_		= 22,
-	_RSON_IEEE_802DOT1X_AUTH_FAIL_	= 23,
-	/* below are Realtek definitions */
-	_RSON_PMK_NOT_AVAILABLE_	= 24,
-};
-
 enum WIFI_REG_DOMAIN {
 	DOMAIN_FCC	= 1,
 	DOMAIN_IC	= 2,
@@ -234,11 +193,6 @@ static inline unsigned char get_tofr_ds(unsigned char *pframe)
 	0x000f) | (0xfff0 & (num << 4))); \
 })
 
-#define SetDuration(pbuf, dur) ({ \
-	*(__le16 *)((addr_t)(pbuf) + 2) |= \
-	cpu_to_le16(0xffff & (dur)); \
-})
-
 #define SetPriority(pbuf, tid) ({ \
 	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf); \
 })
@@ -253,9 +207,6 @@ static inline unsigned char get_tofr_ds(unsigned char *pframe)
 
 #define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
-#define GetAid(pbuf)	(cpu_to_le16(*(__le16 *)((addr_t)(pbuf) + 2)) \
-			& 0x3fff)
-
 #define GetAddr1Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 4))
 
 #define GetAddr2Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 10))
@@ -290,19 +241,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
  *		Below is for the security related definition
  *-----------------------------------------------------------------------------
  */
-#define _RESERVED_FRAME_TYPE_	0
-#define _SKB_FRAME_TYPE_	2
-#define _PRE_ALLOCMEM_		1
-#define _PRE_ALLOCHDR_		3
-#define _PRE_ALLOCLLCHDR_	4
-#define _PRE_ALLOCICVHDR_	5
-#define _PRE_ALLOCMICHDR_	6
-
-#define _SIFSTIME_		((priv->pmib->BssType.net_work_type & \
-				WIRELESS_11A) ? 16 : 10)
-#define _ACKCTSLNG_		14	/*14 bytes long, including crclng */
-#define _CRCLNG_		4
-
 #define _ASOCREQ_IE_OFFSET_	4	/* excluding wlan_hdr */
 #define	_ASOCRSP_IE_OFFSET_	6
 #define _REASOCREQ_IE_OFFSET_	10
@@ -348,10 +286,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 #define AUTH_ODD_TO				0
 #define AUTH_EVEN_TO			1
 
-#define WLAN_ETHCONV_ENCAP		1
-#define WLAN_ETHCONV_RFC1042	2
-#define WLAN_ETHCONV_8021h		3
-
 #define cap_ESS BIT(0)
 #define cap_IBSS BIT(1)
 #define cap_CFPollable BIT(2)
@@ -371,20 +305,12 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
  *------------------------------------------------------------------------------
  */
 #define _WMM_IE_Length_				7  /* for WMM STA */
-#define _WMM_Para_Element_Length_		24
 
 /*-----------------------------------------------------------------------------
  *			Below is the definition for 802.11n
  *------------------------------------------------------------------------------
  */
 
-#define SetOrderBit(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_ORDER_); \
-})
-
-#define GetOrderBit(pbuf)	(((*(__le16 *)(pbuf)) & \
-				le16_to_cpu(_ORDER_)) != 0)
-
 /*
  * struct rtl_ieee80211_ht_cap - HT capabilities
  *
-- 
2.26.2

