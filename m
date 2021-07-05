Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16F83BB811
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGEHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:46:02 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:41701 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:46:01 -0400
Received: from ubuntu-CJ.passengers.t26.sncf ([109.190.253.13])
        by mwinf5d50 with ME
        id RKjC250060J6jfR03KjFor; Mon, 05 Jul 2021 09:43:21 +0200
X-ME-Helo: ubuntu-CJ.passengers.t26.sncf
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Jul 2021 09:43:21 +0200
X-ME-IP: 109.190.253.13
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, insafonov@gmail.com,
        zhansayabagdaulet@gmail.com, mike.ximing.chen@intel.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: rtl8712: Remove some unused #define and enum
Date:   Mon,  5 Jul 2021 09:43:07 +0200
Message-Id: <6d5b505e7de20fdaba1831557baee1daf4656845.1625470822.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These #define and the enum WIFI_REG_DOMAIN are unused.
They can be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/staging/rtl8712/wifi.h | 48 ----------------------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 577a95c62d6c..b8acb9c7395d 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -20,26 +20,10 @@
 #define WLAN_HDR_A3_LEN		24
 #define WLAN_HDR_A3_QOS_LEN	26
 
-#define P80211CAPTURE_VERSION	0x80211001
-
 enum WIFI_FRAME_TYPE {
 	WIFI_QOS_DATA_TYPE	= (BIT(7) | BIT(3)),	/*!< QoS Data */
 };
 
-enum WIFI_REG_DOMAIN {
-	DOMAIN_FCC	= 1,
-	DOMAIN_IC	= 2,
-	DOMAIN_ETSI	= 3,
-	DOMAIN_SPAIN	= 4,
-	DOMAIN_FRANCE	= 5,
-	DOMAIN_MKK	= 6,
-	DOMAIN_ISRAEL	= 7,
-	DOMAIN_MKK1	= 8,
-	DOMAIN_MKK2	= 9,
-	DOMAIN_MKK3	= 10,
-	DOMAIN_MAX
-};
-
 #define SetToDs(pbuf) ({ \
 	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS); \
 })
@@ -194,46 +178,14 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-/*-----------------------------------------------------------------------------
- *		Below is for the security related definition
- *-----------------------------------------------------------------------------
- */
-#define _ASOCREQ_IE_OFFSET_	4	/* excluding wlan_hdr */
-#define	_ASOCRSP_IE_OFFSET_	6
-#define _REASOCREQ_IE_OFFSET_	10
-#define _REASOCRSP_IE_OFFSET_	6
-#define _PROBEREQ_IE_OFFSET_	0
-#define	_PROBERSP_IE_OFFSET_	12
-#define _AUTH_IE_OFFSET_	6
-#define _DEAUTH_IE_OFFSET_	0
-#define _BEACON_IE_OFFSET_	12
-
-#define _FIXED_IE_LENGTH_	_BEACON_IE_OFFSET_
-
 /* ---------------------------------------------------------------------------
  *			Below is the fixed elements...
  * ---------------------------------------------------------------------------
  */
-#define _AUTH_ALGM_NUM_			2
-#define _AUTH_SEQ_NUM_			2
 #define _BEACON_ITERVAL_		2
 #define _CAPABILITY_			2
-#define _CURRENT_APADDR_		6
-#define _LISTEN_INTERVAL_		2
-#define _RSON_CODE_				2
-#define _ASOC_ID_				2
-#define _STATUS_CODE_			2
 #define _TIMESTAMP_				8
 
-#define AUTH_ODD_TO				0
-#define AUTH_EVEN_TO			1
-
-/*-----------------------------------------------------------------------------
- *			Below is the definition for 802.11i / 802.1x
- *------------------------------------------------------------------------------
- */
-#define _IEEE8021X_MGT_			1	/*WPA */
-#define _IEEE8021X_PSK_			2	/* WPA with pre-shared key */
 
 /*-----------------------------------------------------------------------------
  *			Below is the definition for WMM
-- 
2.27.0

