Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6581C452914
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhKPEWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbhKPEVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:21:14 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C7C081979
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:15:40 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f20so17147951qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTmVpcqEuNMF9B6vHrRyqFuTKE2hk54YsDuclLPVpbY=;
        b=PDmzrL+XWLfAsLwwkwQSUW4yVuUce0rRD2qTUpkaZBZuc7GWpmP+PW1WJgUDaXJn4J
         h1n52CwV5OnJCCyZX/gp+j3FjXLC0Vty1fDLdrONijqSg/Gg/gLKj8rDxTZ7VNPgUz41
         ExlDrWfd9mdlLGf1bqqDzZ+i4IOQkMql9HhkpWI2d+gZPrW2qEslA6Fh3no6KqBGLfuA
         sLqr0e9laHkJNbOR8v7t+Lo6aKUl4mXTYnR1rc0QWTr2KFsU7SHtt6+aZ869awMykNHK
         9Gd8o7JHJPUCIQ16l7k4r+ols0+8NUAAFzn/HvqHsKzt99YUCrj6lm7H03eQAK48aDlV
         4kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTmVpcqEuNMF9B6vHrRyqFuTKE2hk54YsDuclLPVpbY=;
        b=YUUi6ccz6ilyf51l06SJWxh+UFokIkWx5a4pEgvUwLHOpNBzuTUqpsIeD9Af7/HOc/
         YWLmY37k2BOZQpxAre2JmCxE23okGY3bjbDOREiUKsOlkGU+RuR5SpbQEKHXN0RUw9fH
         DJNIIIr9XIq37SUxUx3RrlTsUdcD/M7uL4qu47zIElFRYNq8zm3UjFVsCHJ3vFwNUi1c
         YjLhgDo+QGS2R7NoxIsOcNTire+RNk53Y7Ja7JakWCk8ipYfKHTZzAsLBuZ+Xy0dt/wr
         pKppBcZVuQ7hkIr/YrtM6sVs35BCnMEP6jyZiKA7Kll4QyTyoVbl03FlvNcqnegDoGTM
         XDfw==
X-Gm-Message-State: AOAM530mz37Z0LfFWTAaqLsSeht71TBaNMrkeLXiKZuqym5Lc/VTIVhP
        Q0Fh7quOnngz7P+TFngIT849RZnAAhg=
X-Google-Smtp-Source: ABdhPJwUR8gPRHS+I+YnegLkVJD3iVLubw7CsFtS/vmJ3/Pd2BRRnmFO7rKWizwo57d5LwgzFN29NQ==
X-Received: by 2002:ac8:3d49:: with SMTP id u9mr3648750qtf.264.1637025339162;
        Mon, 15 Nov 2021 17:15:39 -0800 (PST)
Received: from localhost.localdomain (pool-98-113-42-30.nycmny.fios.verizon.net. [98.113.42.30])
        by smtp.googlemail.com with ESMTPSA id j20sm3472493qtj.43.2021.11.15.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 17:15:38 -0800 (PST)
From:   Zameer Manji <zmanji@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Zameer Manji <zmanji@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unused defines in wifi.h
Date:   Tue, 16 Nov 2021 01:14:33 +0000
Message-Id: <20211116011451.896714-1-zmanji@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these defines in wifi.h are used so they
can be safely removed.

Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 57 --------------------------
 1 file changed, 57 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 193a557f0f47..7cbc7015e90f 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -13,32 +13,9 @@
 #define BIT(x)	(1 << (x))
 
 #define WLAN_ETHHDR_LEN		14
-#define WLAN_ETHADDR_LEN	6
-#define WLAN_IEEE_OUI_LEN	3
-#define WLAN_ADDR_LEN		6
-#define WLAN_CRC_LEN		4
-#define WLAN_BSSID_LEN		6
-#define WLAN_BSS_TS_LEN		8
 #define WLAN_HDR_A3_LEN		24
-#define WLAN_HDR_A4_LEN		30
 #define WLAN_HDR_A3_QOS_LEN	26
-#define WLAN_HDR_A4_QOS_LEN	32
 #define WLAN_SSID_MAXLEN	32
-#define WLAN_DATA_MAXLEN	2312
-
-#define WLAN_A3_PN_OFFSET	24
-#define WLAN_A4_PN_OFFSET	30
-
-#define WLAN_MIN_ETHFRM_LEN	60
-#define WLAN_MAX_ETHFRM_LEN	1514
-#define WLAN_ETHHDR_LEN		14
-
-#define P80211CAPTURE_VERSION	0x80211001
-
-/*  This value is tested by WiFi 11n Test Plan 5.2.3. */
-/*  This test verifies the WLAN NIC can update the NAV through sending
- *  the CTS with large duration. */
-#define	WiFiNavUpperUs				30000	/*  30 ms */
 
 enum WIFI_FRAME_TYPE {
 	WIFI_MGT_TYPE  =	(0),
@@ -487,13 +464,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _STATUS_CODE_		2
 #define _TIMESTAMP_		8
 
-#define AUTH_ODD_TO		0
-#define AUTH_EVEN_TO		1
-
-#define WLAN_ETHCONV_ENCAP	1
-#define WLAN_ETHCONV_RFC1042	2
-#define WLAN_ETHCONV_8021h	3
-
 #define cap_ESS		BIT(0)
 #define cap_IBSS	BIT(1)
 #define cap_CFPollable	BIT(2)
@@ -632,13 +602,6 @@ enum ht_cap_ampdu_factor {
 #define HT_INFO_OPERATION_MODE_TRANSMIT_BURST_LIMIT	((u8) BIT(3))
 #define HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT	((u8) BIT(4))
 
-#define HT_INFO_STBC_PARAM_DUAL_BEACON		((u16) BIT(6))
-#define HT_INFO_STBC_PARAM_DUAL_STBC_PROTECT	((u16) BIT(7))
-#define HT_INFO_STBC_PARAM_SECONDARY_BC		((u16) BIT(8))
-#define HT_INFO_STBC_PARAM_LSIG_TXOP_PROTECT_ALLOWED	((u16) BIT(9))
-#define HT_INFO_STBC_PARAM_PCO_ACTIVE		((u16) BIT(10))
-#define HT_INFO_STBC_PARAM_PCO_PHASE		((u16) BIT(11))
-
 /*	===============WPS Section=============== */
 /*	For WPSv1.0 */
 #define WPSOUI					0x0050f204
@@ -949,26 +912,6 @@ enum P2P_PS_MODE {
 	P2P_PS_MIX = 3, /*  CTWindow and NoA */
 };
 
-/*	=====================WFD Section===================== */
-/*	For Wi-Fi Display */
-#define	WFD_ATTR_DEVICE_INFO		0x00
-#define	WFD_ATTR_ASSOC_BSSID		0x01
-#define	WFD_ATTR_COUPLED_SINK_INFO	0x06
-#define	WFD_ATTR_LOCAL_IP_ADDR		0x08
-#define	WFD_ATTR_SESSION_INFO		0x09
-#define	WFD_ATTR_ALTER_MAC		0x0a
-
-/*	For WFD Device Information Attribute */
-#define	WFD_DEVINFO_SOURCE			0x0000
-#define	WFD_DEVINFO_PSINK			0x0001
-#define	WFD_DEVINFO_SSINK			0x0002
-#define	WFD_DEVINFO_DUAL			0x0003
-
-#define	WFD_DEVINFO_SESSION_AVAIL		0x0010
-#define	WFD_DEVINFO_WSD				0x0040
-#define	WFD_DEVINFO_PC_TDLS			0x0080
-#define	WFD_DEVINFO_HDCP_SUPPORT		0x0100
-
 #define IP_MCAST_MAC(mac)				\
 	((mac[0] == 0x01) && (mac[1] == 0x00) && (mac[2] == 0x5e))
 #define ICMPV6_MCAST_MAC(mac)				\
-- 
2.25.1

