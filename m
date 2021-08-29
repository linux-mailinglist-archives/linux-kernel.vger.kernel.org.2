Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125F03FADA0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhH2SIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhH2SIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:08:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:07:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso7905108wmr.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sL3q5BOrUOSwHA12R2JhIzt7TAoia6mkYVfF1Nh53XU=;
        b=YGWWFJs39bbIiiQAw1AJzle4BZkYZ/DTIYm7gcgiPP7eqZndvAODj7R2OsNbXyO6Vp
         AUaSbwzhWW2wHdENqvFX6oNF6Hv1G98OjRHD8jTT+R9o0ZaVp3SdjHUzcZOI2CsuNKaD
         cr42NgvhLk2gbFW5a5kCwC/yku8F0aLxjzVSWtpTHAqmHQtXazsyrv1pv7omNIEMuP7q
         NMJIIyn6c64PO9eH2550wqlmOyVhXdHLw68v6qUB0rf/73znIVCqwrloTjVp7mWERatp
         27FIxLHRY31+H/bBgClrbTuVON7pXLQmHmGabudWesDfVnzzPmGmiMczcCcLyKEekU3P
         UI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sL3q5BOrUOSwHA12R2JhIzt7TAoia6mkYVfF1Nh53XU=;
        b=aA1tSXrmoUZB5vtQRjpHCHo01F/FV2niZTDk0JNVzv4nfjvYXK7zUgKfzKEcjUN1Ug
         +0L+JEE8ZnEJMLfiRbtEKI2kW5O7IRnIl0cOskYBcOeE4kR4ptXDCiSEJeuyqQEzih0M
         kvOIihD95jpt7fKmiqNntPf44373Gmvz0bV6krAu2+AjElezqB1FQKlLEgJn7eewXfb1
         YzESmkoPojezhNSZ9pbC9CGRtLojejNziNtRjVw0J9zy+t6QKBOwWB27G1ebQgOTbuNc
         8rmVwKqXAVsq4HHLSB2nX5BJt3ynDXv1+Hxl2TZxXeF7F32DArXbemESrklcO0PvdmXr
         +hoQ==
X-Gm-Message-State: AOAM530lBGDW9QU2UPHunNdSAAIiUhU33/PaQYJgXD5U+kCxm+9FEwsf
        IKcicRTzJawfIogY0rev6dQ=
X-Google-Smtp-Source: ABdhPJzVA/bsxb3Wf7vRyIaanehNUmwxg3iMzl6iisTzS6M2/BKpe+kyWa5Of4iiCKuyx3Bkf3ystg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr18808112wmc.150.1630260456344;
        Sun, 29 Aug 2021 11:07:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f7sm17124287wmh.20.2021.08.29.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 11:07:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove commented constants from wifi.h
Date:   Sun, 29 Aug 2021 20:07:17 +0200
Message-Id: <20210829180717.15393-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829180717.15393-1-straube.linux@gmail.com>
References: <20210829180717.15393-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented constants from wifi.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 50 --------------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index eb07ac9b8943..193a557f0f47 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -114,33 +114,6 @@ enum WIFI_REASON_CODE	{
 	_RSON_TDLS_TEAR_UN_RSN_		= 26,
 };
 
-/* Reason codes (IEEE 802.11-2007, 7.3.1.7, Table 7-22)
-
-#define WLAN_REASON_UNSPECIFIED 1
-#define WLAN_REASON_PREV_AUTH_NOT_VALID 2
-#define WLAN_REASON_DEAUTH_LEAVING 3
-#define WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY 4
-#define WLAN_REASON_DISASSOC_AP_BUSY 5
-#define WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA 6
-#define WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA 7
-#define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
-#define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9 */
-/* IEEE 802.11h */
-
-/* IEEE 802.11i
-#define WLAN_REASON_INVALID_IE 13
-#define WLAN_REASON_MICHAEL_MIC_FAILURE 14
-#define WLAN_REASON_4WAY_HANDSHAKE_TIMEOUT 15
-#define WLAN_REASON_GROUP_KEY_UPDATE_TIMEOUT 16
-#define WLAN_REASON_IE_IN_4WAY_DIFFERS 17
-#define WLAN_REASON_GROUP_CIPHER_NOT_VALID 18
-#define WLAN_REASON_PAIRWISE_CIPHER_NOT_VALID 19
-#define WLAN_REASON_AKMP_NOT_VALID 20
-#define WLAN_REASON_UNSUPPORTED_RSN_IE_VERSION 21
-#define WLAN_REASON_INVALID_RSN_IE_CAPAB 22
-#define WLAN_REASON_IEEE_802_1X_AUTH_FAILED 23
-#define WLAN_REASON_CIPHER_SUITE_REJECTED 24 */
-
 enum WIFI_STATUS_CODE {
 	_STATS_SUCCESSFUL_		= 0,
 	_STATS_FAILURE_			= 1,
@@ -155,19 +128,6 @@ enum WIFI_STATUS_CODE {
 	_STATS_RATE_FAIL_		= 18,
 };
 
-/* Status codes (IEEE 802.11-2007, 7.3.1.9, Table 7-23)
-#define WLAN_STATUS_SUCCESS 0
-#define WLAN_STATUS_UNSPECIFIED_FAILURE 1
-#define WLAN_STATUS_CAPS_UNSUPPORTED 10
-#define WLAN_STATUS_REASSOC_NO_ASSOC 11
-#define WLAN_STATUS_ASSOC_DENIED_UNSPEC 12
-#define WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG 13
-#define WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION 14
-#define WLAN_STATUS_CHALLENGE_FAIL 15
-#define WLAN_STATUS_AUTH_TIMEOUT 16
-#define WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA 17
-#define WLAN_STATUS_ASSOC_DENIED_RATES 18 */
-
 /* entended */
 /* IEEE 802.11b */
 #define WLAN_STATUS_ASSOC_DENIED_NOSHORT 19
@@ -552,16 +512,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _IEEE8021X_MGT_			1	/*  WPA */
 #define _IEEE8021X_PSK_			2	/*  WPA with pre-shared key */
 
-/*
-#define _NO_PRIVACY_			0
-#define _WEP_40_PRIVACY_		1
-#define _TKIP_PRIVACY_			2
-#define _WRAP_PRIVACY_			3
-#define _CCMP_PRIVACY_			4
-#define _WEP_104_PRIVACY_		5
-#define _WEP_WPA_MIXED_PRIVACY_ 6	WEP + WPA
-*/
-
 /*-----------------------------------------------------------------------------
 				Below is the definition for WMM
 ------------------------------------------------------------------------------*/
-- 
2.33.0

