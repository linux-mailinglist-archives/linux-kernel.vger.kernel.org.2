Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED97E453A45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbhKPTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbhKPTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:39:01 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CA2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:36:04 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id u16so306734qvk.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRD03vZUiO35SuJxmo9HD1JF0YRDKsYmubD6ARoYY1c=;
        b=luBEGe0fGnlw2XoXo/H2cEPwzPs1EEf7ApqlHxrjOHMdsI8FW0DdCO0UrnhkW36IFb
         pM1yehDPfD20AhJsUeWsjNZ0xVG7DAsTY3n+feEtwu53U0ozbPiajSw6x90IQAI8RGy+
         J7hI43w+vc1BERVpBAv+bHzxB5nwB/eWNwY4Ft/bhVaAPAH0PlCvbnxaybymcK+8jNtg
         P8bDos2uMk7g0YkRBr9QpGYKAdOFShyCbO9sXYmYdUj9ZcOgJgtKV5KYaF2udFZYQC0o
         m04nzIuS3a8ZTEWXadm2x0b20kgrqfbzAusDblAUUsEGzQ13ru0uVVkssi//lyteJw56
         J78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRD03vZUiO35SuJxmo9HD1JF0YRDKsYmubD6ARoYY1c=;
        b=JHvQfsNVHRHuEzC5yg7chrW3X9lfUTpF6xpCj52fENIk6xb7JtUf48Ve5ZSMkRBk55
         CxyFS3HZbWyjecrJvWvti3rdFAx1qeqVLrCcEz+nMVGUBuMyECAEjDN8I9g0H5vLD3JH
         ctKVNxWpsSYwiyTTnt2eox1O5k+2jFYTYzHjzAcqFkXR5noM8zLOBY28z3cgogS9XAa1
         n5aam0RvMzqSzx7DCdN61VYakP1I3bx3a1kxrhY1p2uBV2bEkTcU4klIx+hMRjrnshVq
         INS53XAdgJxzNiCWhsLdi0r4a96+SpkpbSr/YCAYcl/MgbHE/dfloklZw/ur4ojOSOrd
         CNVQ==
X-Gm-Message-State: AOAM532jLUU/0E6QSIbnLcZh6J1g9vKrjArUGgZXOg+tuWYV4z+8+PfE
        dWMrctY2csioS3VSekwhNH4=
X-Google-Smtp-Source: ABdhPJyeqxRTsXC9iGmy5DlVeQca/vNindMaHl3sAy/USsIeY8huFO4/w6MujJLaBRcCGQ8tpkJqOQ==
X-Received: by 2002:ad4:5ce8:: with SMTP id iv8mr48456598qvb.21.1637091363413;
        Tue, 16 Nov 2021 11:36:03 -0800 (PST)
Received: from localhost.localdomain (pool-98-113-42-30.nycmny.fios.verizon.net. [98.113.42.30])
        by smtp.googlemail.com with ESMTPSA id l2sm9724484qtk.41.2021.11.16.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:36:02 -0800 (PST)
From:   Zameer Manji <zmanji@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Zameer Manji <zmanji@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: r8188eu: delete unused header
Date:   Tue, 16 Nov 2021 19:35:41 +0000
Message-Id: <20211116193557.1188939-1-zmanji@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iee80211_ext.h header is unused and can be removed.

Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 .../staging/r8188eu/include/ieee80211_ext.h   | 271 ------------------
 1 file changed, 271 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/ieee80211_ext.h

diff --git a/drivers/staging/r8188eu/include/ieee80211_ext.h b/drivers/staging/r8188eu/include/ieee80211_ext.h
deleted file mode 100644
index e7ade835d478..000000000000
--- a/drivers/staging/r8188eu/include/ieee80211_ext.h
+++ /dev/null
@@ -1,271 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __IEEE80211_EXT_H
-#define __IEEE80211_EXT_H
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-#define WMM_OUI_TYPE 2
-#define WMM_OUI_SUBTYPE_INFORMATION_ELEMENT 0
-#define WMM_OUI_SUBTYPE_PARAMETER_ELEMENT 1
-#define WMM_OUI_SUBTYPE_TSPEC_ELEMENT 2
-#define WMM_VERSION 1
-
-#define WPA_PROTO_WPA BIT(0)
-#define WPA_PROTO_RSN BIT(1)
-
-#define WPA_KEY_MGMT_IEEE8021X BIT(0)
-#define WPA_KEY_MGMT_PSK BIT(1)
-#define WPA_KEY_MGMT_NONE BIT(2)
-#define WPA_KEY_MGMT_IEEE8021X_NO_WPA BIT(3)
-#define WPA_KEY_MGMT_WPA_NONE BIT(4)
-
-#define WPA_CAPABILITY_PREAUTH BIT(0)
-#define WPA_CAPABILITY_MGMT_FRAME_PROTECTION BIT(6)
-#define WPA_CAPABILITY_PEERKEY_ENABLED BIT(9)
-
-#define PMKID_LEN 16
-
-struct wpa_ie_hdr {
-	u8 elem_id;
-	u8 len;
-	u8 oui[4]; /* 24-bit OUI followed by 8-bit OUI type */
-	u8 version[2]; /* little endian */
-} __packed;
-
-struct rsn_ie_hdr {
-	u8 elem_id; /* WLAN_EID_RSN */
-	u8 len;
-	u8 version[2]; /* little endian */
-} __packed;
-
-struct wme_ac_parameter {
-#if defined(__LITTLE_ENDIAN)
-	/* byte 1 */
-	u8	aifsn:4,
-		acm:1,
-		aci:2,
-		reserved:1;
-
-	/* byte 2 */
-	u8	eCWmin:4,
-		eCWmax:4;
-#elif defined(__BIG_ENDIAN)
-	/* byte 1 */
-	u8	reserved:1,
-		aci:2,
-		acm:1,
-		aifsn:4;
-
-	/* byte 2 */
-	u8	eCWmax:4,
-		eCWmin:4;
-#else
-#error	"Please fix <endian.h>"
-#endif
-
-	/* bytes 3 & 4 */
-	u16 txopLimit;
-} __packed;
-
-struct wme_parameter_element {
-	/* required fields for WME version 1 */
-	u8 oui[3];
-	u8 oui_type;
-	u8 oui_subtype;
-	u8 version;
-	u8 acInfo;
-	u8 reserved;
-	struct wme_ac_parameter ac[4];
-
-} __packed;
-
-#define WPA_PUT_LE16(a, val)			\
-	do {					\
-		(a)[1] = ((u16) (val)) >> 8;	\
-		(a)[0] = ((u16) (val)) & 0xff;	\
-	} while (0)
-
-#define WPA_PUT_BE32(a, val)					\
-	do {							\
-		(a)[0] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[2] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[3] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
-
-#define WPA_PUT_LE32(a, val)					\
-	do {							\
-		(a)[3] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
-		(a)[2] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
-		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
-		(a)[0] = (u8) (((u32) (val)) & 0xff);		\
-	} while (0)
-
-#define RSN_SELECTOR_PUT(a, val) WPA_PUT_BE32((u8 *)(a), (val))
-
-/* Action category code */
-enum ieee80211_category {
-	WLAN_CATEGORY_SPECTRUM_MGMT = 0,
-	WLAN_CATEGORY_QOS = 1,
-	WLAN_CATEGORY_DLS = 2,
-	WLAN_CATEGORY_BACK = 3,
-	WLAN_CATEGORY_HT = 7,
-	WLAN_CATEGORY_WMM = 17,
-};
-
-/* SPECTRUM_MGMT action code */
-enum ieee80211_spectrum_mgmt_actioncode {
-	WLAN_ACTION_SPCT_MSR_REQ = 0,
-	WLAN_ACTION_SPCT_MSR_RPRT = 1,
-	WLAN_ACTION_SPCT_TPC_REQ = 2,
-	WLAN_ACTION_SPCT_TPC_RPRT = 3,
-	WLAN_ACTION_SPCT_CHL_SWITCH = 4,
-	WLAN_ACTION_SPCT_EXT_CHL_SWITCH = 5,
-};
-
-/* BACK action code */
-enum ieee80211_back_actioncode {
-	WLAN_ACTION_ADDBA_REQ = 0,
-	WLAN_ACTION_ADDBA_RESP = 1,
-	WLAN_ACTION_DELBA = 2,
-};
-
-/* HT features action code */
-enum ieee80211_ht_actioncode {
-	WLAN_ACTION_NOTIFY_CH_WIDTH = 0,
-	WLAN_ACTION_SM_PS = 1,
-	WLAN_ACTION_PSPM = 2,
-	WLAN_ACTION_PCO_PHASE = 3,
-	WLAN_ACTION_MIMO_CSI_MX = 4,
-	WLAN_ACTION_MIMO_NONCP_BF = 5,
-	WLAN_ACTION_MIMP_CP_BF = 6,
-	WLAN_ACTION_ASEL_INDICATES_FB = 7,
-	WLAN_ACTION_HI_INFO_EXCHG = 8,
-};
-
-/* BACK (block-ack) parties */
-enum ieee80211_back_parties {
-	WLAN_BACK_RECIPIENT = 0,
-	WLAN_BACK_INITIATOR = 1,
-	WLAN_BACK_TIMER = 2,
-};
-
-struct ieee80211_mgmt {
-	u16 frame_control;
-	u16 duration;
-	u8 da[6];
-	u8 sa[6];
-	u8 bssid[6];
-	u16 seq_ctrl;
-	union {
-		struct {
-			u16 auth_alg;
-			u16 auth_transaction;
-			u16 status_code;
-			/* possibly followed by Challenge text */
-			u8 variable[0];
-		}  __packed auth;
-		struct {
-			u16 reason_code;
-		}  __packed deauth;
-		struct {
-			u16 capab_info;
-			u16 listen_interval;
-			/* followed by SSID and Supported rates */
-			u8 variable[0];
-		}  __packed assoc_req;
-		struct {
-			u16 capab_info;
-			u16 status_code;
-			u16 aid;
-			/* followed by Supported rates */
-			u8 variable[0];
-		}  __packed assoc_resp, reassoc_resp;
-		struct {
-			u16 capab_info;
-			u16 listen_interval;
-			u8 current_ap[6];
-			/* followed by SSID and Supported rates */
-			u8 variable[0];
-		}  __packed reassoc_req;
-		struct {
-			u16 reason_code;
-		}  __packed disassoc;
-		struct {
-			__le64 timestamp;
-			u16 beacon_int;
-			u16 capab_info;
-			/* followed by some of SSID, Supported rates,
-			 * FH Params, DS Params, CF Params, IBSS Params, TIM */
-			u8 variable[0];
-		}  __packed beacon;
-		struct {
-			/* only variable items: SSID, Supported rates */
-			u8 variable[0];
-		}  __packed probe_req;
-		struct {
-			__le64 timestamp;
-			u16 beacon_int;
-			u16 capab_info;
-			/* followed by some of SSID, Supported rates,
-			 * FH Params, DS Params, CF Params, IBSS Params */
-			u8 variable[0];
-		}  __packed probe_resp;
-		struct {
-			u8 category;
-			union {
-				struct {
-					u8 action_code;
-					u8 dialog_token;
-					u8 status_code;
-					u8 variable[0];
-				}  __packed wme_action;
-				struct {
-					u8 action_code;
-					u8 dialog_token;
-					u16 capab;
-					u16 timeout;
-					u16 start_seq_num;
-				}  __packed addba_req;
-				struct {
-					u8 action_code;
-					u8 dialog_token;
-					u16 status;
-					u16 capab;
-					u16 timeout;
-				}  __packed addba_resp;
-				struct {
-					u8 action_code;
-					u16 params;
-					u16 reason_code;
-				}  __packed delba;
-				structi {
-					u8 action_code;
-					/* capab_info for open and confirm,
-					 * reason for close
-					 */
-					u16 aux;
-					/* Followed in plink_confirm by status
-					 * code, AID and supported rates,
-					 * and directly by supported rates in
-					 * plink_open and plink_close
-					 */
-					u8 variable[0];
-				}  __packed plink_action;
-				struct{
-					u8 action_code;
-					u8 variable[0];
-				}  __packed mesh_action;
-			} __packed u;
-		}  __packed action;
-	} __packed u;
-} __packed;
-
-/* mgmt header + 1 byte category code */
-#define IEEE80211_MIN_ACTION_SIZE				\
-	 FIELD_OFFSET(struct ieee80211_mgmt, u.action.u)
-
-#endif
-- 
2.25.1

