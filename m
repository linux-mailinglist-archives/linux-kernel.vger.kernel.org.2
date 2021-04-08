Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8322E358DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhDHT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:58:58 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:40918 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhDHT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:58:54 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d05 with ME
        id qKyg2400B3g7mfN03KyhB8; Thu, 08 Apr 2021 21:58:41 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Apr 2021 21:58:41 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] staging: rtl8712: remove enum WIFI_FRAME_SUBTYPE
Date:   Thu,  8 Apr 2021 21:58:40 +0200
Message-Id: <5a6fdcf0b5eb43c3d5511b5badd60bfac9389628.1617911201.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <4291cb10744457cc12c89fc9fd414c37d732bc9d.1617911201.git.christophe.jaillet@wanadoo.fr>
References: <4291cb10744457cc12c89fc9fd414c37d732bc9d.1617911201.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values defined in enum WIFI_FRAME_SUBTYPE are the same the #define
IEEE80211_STYPE_xxx from <linux/ieee80211.h>

Use theses values to avoid code duplication.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8712/rtl871x_recv.c     |  2 +-
 drivers/staging/rtl8712/rtl871x_security.c | 14 +++++-----
 drivers/staging/rtl8712/wifi.h             | 32 ----------------------
 3 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index f4b871637795..c13076b0e3d1 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -373,7 +373,7 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
 	    check_fwstate(pmlmepriv, _FW_LINKED)) {
 		/* if NULL-frame, drop packet */
-		if ((GetFrameSubType(ptr)) == WIFI_DATA_NULL)
+		if ((GetFrameSubType(ptr)) == IEEE80211_STYPE_NULLFUNC)
 			return _FAIL;
 		/* drop QoS-SubType Data, including QoS NULL,
 		 * excluding QoS-Data
diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index b0cc3c922842..1c7df65db3c9 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -30,10 +30,10 @@
 #include <linux/atomic.h>
 #include <linux/crc32poly.h>
 #include <linux/semaphore.h>
+#include <linux/ieee80211.h>
 
 #include "osdep_service.h"
 #include "drv_types.h"
-#include "wifi.h"
 #include "osdep_intf.h"
 
 /* =====WEP related===== */
@@ -1045,9 +1045,9 @@ static void aes_cipher(u8 *key, uint hdrlen,
 	else
 		a4_exists = 1;
 
-	if ((frtype == WIFI_DATA_CFACK) ||
-	     (frtype == WIFI_DATA_CFPOLL) ||
-	     (frtype == WIFI_DATA_CFACKPOLL)) {
+	if ((frtype == IEEE80211_STYPE_DATA_CFACK) ||
+	    (frtype == IEEE80211_STYPE_DATA_CFPOLL) ||
+	    (frtype == IEEE80211_STYPE_DATA_CFACKPOLL)) {
 		qc_exists = 1;
 		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
@@ -1225,9 +1225,9 @@ static void aes_decipher(u8 *key, uint hdrlen,
 		a4_exists = 0;
 	else
 		a4_exists = 1;
-	if ((frtype == WIFI_DATA_CFACK) ||
-	    (frtype == WIFI_DATA_CFPOLL) ||
-	    (frtype == WIFI_DATA_CFACKPOLL)) {
+	if ((frtype == IEEE80211_STYPE_DATA_CFACK) ||
+	    (frtype == IEEE80211_STYPE_DATA_CFPOLL) ||
+	    (frtype == IEEE80211_STYPE_DATA_CFACKPOLL)) {
 		qc_exists = 1;
 		if (hdrlen != WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 61ebc730427f..68c253b0f66d 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -29,38 +29,6 @@ enum WIFI_FRAME_TYPE {
 	WIFI_QOS_DATA_TYPE	= (BIT(7) | BIT(3)),	/*!< QoS Data */
 };
 
-enum WIFI_FRAME_SUBTYPE {
-	/* below is for mgt frame */
-	WIFI_ASSOCREQ       = (0 | WIFI_MGT_TYPE),
-	WIFI_ASSOCRSP       = (BIT(4) | WIFI_MGT_TYPE),
-	WIFI_REASSOCREQ     = (BIT(5) | WIFI_MGT_TYPE),
-	WIFI_REASSOCRSP     = (BIT(5) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_PROBEREQ       = (BIT(6) | WIFI_MGT_TYPE),
-	WIFI_PROBERSP       = (BIT(6) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_BEACON         = (BIT(7) | WIFI_MGT_TYPE),
-	WIFI_ATIM           = (BIT(7) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_DISASSOC       = (BIT(7) | BIT(5) | WIFI_MGT_TYPE),
-	WIFI_AUTH           = (BIT(7) | BIT(5) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_DEAUTH         = (BIT(7) | BIT(6) | WIFI_MGT_TYPE),
-	WIFI_ACTION         = (BIT(7) | BIT(6) | BIT(4) | WIFI_MGT_TYPE),
-	/* below is for control frame */
-	WIFI_PSPOLL         = (BIT(7) | BIT(5) | WIFI_CTRL_TYPE),
-	WIFI_RTS            = (BIT(7) | BIT(5) | BIT(4) | WIFI_CTRL_TYPE),
-	WIFI_CTS            = (BIT(7) | BIT(6) | WIFI_CTRL_TYPE),
-	WIFI_ACK            = (BIT(7) | BIT(6) | BIT(4) | WIFI_CTRL_TYPE),
-	WIFI_CFEND          = (BIT(7) | BIT(6) | BIT(5) | WIFI_CTRL_TYPE),
-	WIFI_CFEND_CFACK = (BIT(7) | BIT(6) | BIT(5) | BIT(4) | WIFI_CTRL_TYPE),
-	/* below is for data frame */
-	WIFI_DATA           = (0 | WIFI_DATA_TYPE),
-	WIFI_DATA_CFACK     = (BIT(4) | WIFI_DATA_TYPE),
-	WIFI_DATA_CFPOLL    = (BIT(5) | WIFI_DATA_TYPE),
-	WIFI_DATA_CFACKPOLL = (BIT(5) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_DATA_NULL      = (BIT(6) | WIFI_DATA_TYPE),
-	WIFI_CF_ACK         = (BIT(6) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_CF_POLL        = (BIT(6) | BIT(5) | WIFI_DATA_TYPE),
-	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | WIFI_DATA_TYPE),
-};
-
 enum WIFI_REG_DOMAIN {
 	DOMAIN_FCC	= 1,
 	DOMAIN_IC	= 2,
-- 
2.27.0

