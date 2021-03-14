Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA1133A3B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhCNJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:03:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F0AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:38 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u10so1165009lju.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDmgiXUSzmm2majymEOkDHSGxbMKskzOJ0uRIpAdcyQ=;
        b=Y1nXQ1cWFbW2zbR9MKyC1A/0Qa2lzi7LefG4Ba1PW4wC4DzCKp8A23+DdDlcACrYe2
         Ri889xjhzChONsld3wEASfTeP/EXaLOIsTvKpusinGgjdhg1VSn1UoqvqsuPbF70q0c4
         tAJGcWrC8Ft5jZtTo30v3ZUkst4Hhz1uUhErbnvtr/d3mSDvwqIYALrdLTrraoHYPeq/
         G9TBqO/1cXOLem/ok9RgVv052TQN8nK6gW4s1PGicYqSPxg1V6IonO8jn5yQhqJuF7tv
         rr3vRotq9R4bn4qGq2TqpWbFVq26Bonf/Ue16jyGuF2+XJ58BQcL+2ptB9VhwmApCMTw
         5QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDmgiXUSzmm2majymEOkDHSGxbMKskzOJ0uRIpAdcyQ=;
        b=qW21+sDnwnLqjPY/Zg7mLEH2b9701lWE6/jK7capMvZzP3kcNieiI7Bi4MIrcGPMEN
         Y6zwTYj1eMQOSgzAjU+z8qzftw8a+2+rG80VgM/HVTzRBzwpD4zsFXFOaWKl+XC6fEUN
         KST1BAkfl0Ql0Sh01QMIpYJNAFZxfVQOaqutHXip4bZIFjVr+LQsDuo1GeHcXjqGWQ9T
         t7cCFLKqYA64/miOcc15FdNrXTSvdHOnEXBXqBoLNk6QUVdXK/COedYMV1AqjFr8A29R
         pDIyyDvvrW9a0Sd0AaDp+0zFR7rl3eJ08zD3U9nWseD5ixZ+JSNJIk2PKBgysUsmpH6G
         Bo/A==
X-Gm-Message-State: AOAM532E+VZP2xfoNFdidihwCPiMvjz/o4avAufsIUX9WZwC4OEkrQPc
        4mRQbaHarCPgF7I1kNzqVlg=
X-Google-Smtp-Source: ABdhPJylcnI19hcaWVgdWt3zYtrmSNZyHc9VBTkmGS1VvYlXlIByP+LIi7+i4rP1jDDdKhYxD9Wuhg==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr7285433ljp.495.1615712617123;
        Sun, 14 Mar 2021 01:03:37 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id h24sm2555474lji.35.2021.03.14.01.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:03:36 -0800 (PST)
Received: (nullmailer pid 21231 invoked by uid 1000);
        Sun, 14 Mar 2021 09:03:26 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mrinal Pandey <mrinalmni@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Simon Fong <simon.fodin@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 2/4] staging:r8188eu: remove unused definitions from wifi.h
Date:   Sun, 14 Mar 2021 12:02:45 +0300
Message-Id: <20210314090247.21181-3-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210314090247.21181-1-insafonov@gmail.com>
References: <20210314090247.21181-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These definitions are not used and will not be useful in the future.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 92 ------------------------
 1 file changed, 92 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 5ee4d02e293c..f03359602db7 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -7,21 +7,8 @@
 #ifndef _WIFI_H_
 #define _WIFI_H_
 
-#define WLAN_IEEE_OUI_LEN	3
-#define WLAN_CRC_LEN		4
-#define WLAN_BSSID_LEN		6
-#define WLAN_BSS_TS_LEN		8
 #define WLAN_HDR_A3_LEN		24
-#define WLAN_HDR_A4_LEN		30
 #define WLAN_HDR_A3_QOS_LEN	26
-#define WLAN_HDR_A4_QOS_LEN	32
-#define WLAN_DATA_MAXLEN	2312
-
-#define WLAN_A3_PN_OFFSET	24
-#define WLAN_A4_PN_OFFSET	30
-
-#define WLAN_MIN_ETHFRM_LEN	60
-#define WLAN_MAX_ETHFRM_LEN	1514
 
 #define P80211CAPTURE_VERSION	0x80211001
 
@@ -74,20 +61,6 @@ enum WIFI_FRAME_SUBTYPE {
 	WIFI_QOS_DATA_NULL	= (BIT(6) | WIFI_QOS_DATA_TYPE),
 };
 
-enum WIFI_REG_DOMAIN {
-	DOMAIN_FCC	= 1,
-	DOMAIN_IC	= 2,
-	DOMAIN_ETSI	= 3,
-	DOMAIN_SPA	= 4,
-	DOMAIN_FRANCE	= 5,
-	DOMAIN_MKK	= 6,
-	DOMAIN_ISRAEL	= 7,
-	DOMAIN_MKK1	= 8,
-	DOMAIN_MKK2	= 9,
-	DOMAIN_MKK3	= 10,
-	DOMAIN_MAX
-};
-
 #define SetToDs(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS)
 
@@ -199,8 +172,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr3Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 16))
 
-#define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
-
 static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 {
 	unsigned char	*sa;
@@ -237,19 +208,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 /*-----------------------------------------------------------------------------
 			Below is for the security related definition
 ------------------------------------------------------------------------------*/
-#define _RESERVED_FRAME_TYPE_		0
-#define _SKB_FRAME_TYPE_		2
-#define _PRE_ALLOCMEM_			1
-#define _PRE_ALLOCHDR_			3
-#define _PRE_ALLOCLLCHDR_		4
-#define _PRE_ALLOCICVHDR_		5
-#define _PRE_ALLOCMICHDR_		6
-
-#define _SIFSTIME_				\
-	((priv->pmib->dot11BssType.net_work_type & WIRELESS_11A) ? 16 : 10)
-#define _ACKCTSLNG_		14	/* 14 bytes long, including crclng */
-#define _CRCLNG_		4
-
 #define _ASOCREQ_IE_OFFSET_	4	/*  excluding wlan_hdr */
 #define	_ASOCRSP_IE_OFFSET_	6
 #define _REASOCREQ_IE_OFFSET_	10
@@ -280,10 +238,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define AUTH_ODD_TO		0
 #define AUTH_EVEN_TO		1
 
-#define WLAN_ETHCONV_ENCAP	1
-#define WLAN_ETHCONV_RFC1042	2
-#define WLAN_ETHCONV_8021h	3
-
 #define cap_ESS		BIT(0)
 #define cap_IBSS	BIT(1)
 #define cap_CFPollable	BIT(2)
@@ -316,7 +270,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 				Below is the definition for WMM
 ------------------------------------------------------------------------------*/
 #define _WMM_IE_Length_				7  /*  for WMM STA */
-#define _WMM_Para_Element_Length_		24
 
 /*-----------------------------------------------------------------------------
 				Below is the definition for 802.11n
@@ -388,13 +341,6 @@ enum ht_cap_ampdu_factor {
 #define HT_INFO_OPERATION_MODE_TRANSMIT_BURST_LIMIT	((u8)BIT(3))
 #define HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT	((u8)BIT(4))
 
-#define HT_INFO_STBC_PARAM_DUAL_BEACON		((u16)BIT(6))
-#define HT_INFO_STBC_PARAM_DUAL_STBC_PROTECT	((u16)BIT(7))
-#define HT_INFO_STBC_PARAM_SECONDARY_BC		((u16)BIT(8))
-#define HT_INFO_STBC_PARAM_LSIG_TXOP_PROTECT_ALLOWED	((u16)BIT(9))
-#define HT_INFO_STBC_PARAM_PCO_ACTIVE		((u16)BIT(10))
-#define HT_INFO_STBC_PARAM_PCO_PHASE		((u16)BIT(11))
-
 /*	===============WPS Section=============== */
 /*	For WPSv1.0 */
 #define WPSOUI					0x0050f204
@@ -453,48 +399,10 @@ enum ht_cap_ampdu_factor {
 #define WPS_CONFIG_METHOD_VDISPLAY	0x2008
 #define WPS_CONFIG_METHOD_PDISPLAY	0x4008
 
-/*	Value of Category ID of WPS Primary Device Type Attribute */
-#define WPS_PDT_CID_DISPLAYS		0x0007
-#define WPS_PDT_CID_MULIT_MEDIA		0x0008
-#define WPS_PDT_CID_RTK_WIDI		WPS_PDT_CID_MULIT_MEDIA
-
-/*	Value of Sub Category ID of WPS Primary Device Type Attribute */
-#define WPS_PDT_SCID_MEDIA_SERVER	0x0005
-#define WPS_PDT_SCID_RTK_DMP		WPS_PDT_SCID_MEDIA_SERVER
-
-/*	Value of Device Password ID */
-#define WPS_DPID_P			0x0000
-#define WPS_DPID_USER_SPEC		0x0001
-#define WPS_DPID_MACHINE_SPEC		0x0002
-#define WPS_DPID_REKEY			0x0003
-#define WPS_DPID_PBC			0x0004
-#define WPS_DPID_REGISTRAR_SPEC		0x0005
-
 /*	Value of WPS RF Bands Attribute */
 #define WPS_RF_BANDS_2_4_GHZ		0x01
 #define WPS_RF_BANDS_5_GHZ		0x02
 
-/*	Value of WPS Association State Attribute */
-#define WPS_ASSOC_STATE_NOT_ASSOCIATED		0x00
-#define WPS_ASSOC_STATE_CONNECTION_SUCCESS	0x01
-#define WPS_ASSOC_STATE_CONFIGURATION_FAILURE	0x02
-#define WPS_ASSOC_STATE_ASSOCIATION_FAILURE	0x03
-#define WPS_ASSOC_STATE_IP_FAILURE		0x04
-
-/*	WPS Configuration Method */
-#define	WPS_CM_NONE			0x0000
-#define	WPS_CM_LABEL			0x0004
-#define	WPS_CM_DISPLYA			0x0008
-#define	WPS_CM_EXTERNAL_NFC_TOKEN	0x0010
-#define	WPS_CM_INTEGRATED_NFC_TOKEN	0x0020
-#define	WPS_CM_NFC_INTERFACE		0x0040
-#define	WPS_CM_PUSH_BUTTON		0x0080
-#define	WPS_CM_KEYPAD			0x0100
-#define	WPS_CM_SW_PUHS_BUTTON		0x0280
-#define	WPS_CM_HW_PUHS_BUTTON		0x0480
-#define	WPS_CM_SW_DISPLAY_P		0x2008
-#define	WPS_CM_LCD_DISPLAY_P		0x4008
-
 #define IP_MCAST_MAC(mac)				\
 	((mac[0] == 0x01) && (mac[1] == 0x00) && (mac[2] == 0x5e))
 #define ICMPV6_MCAST_MAC(mac)				\
-- 
2.26.2

