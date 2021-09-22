Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB2415116
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhIVUJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbhIVUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20CC0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so10520680wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEYKYQ5J9H6qMmee2VNKEvAyB/3XJjxnpzB4yMio1yg=;
        b=k4ZQ6heS+dr+E3tmWYKdhMFXef/P8mdd59c7stIPxv+AmyIJTOe/q2/OTI5c5yikcc
         tE0yXLb8sEQ0OrXulX9/FXmhGXIW0uJm/cwykVsg2WJ8Q49cV1EPfVFXyMRW+SdgGILn
         +MqMC956Qe5a4xhB5CVvT39+8M/aEu/3uekg9a8/MXzme7Mvlivbusap2bvOFxahykjf
         wTA2H+8ky6UAk0z1BWL7qeFhGjA74DcgRLtK9sscKEebZqEqG7FFaDqjb+HlT0DGTgDf
         zo8ljAk635ZSuEuc/e4ePlm35GGlCR8rs8vIYZZtMgeM4Tx/o0XRyeA/lxki1clXgtaq
         o/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEYKYQ5J9H6qMmee2VNKEvAyB/3XJjxnpzB4yMio1yg=;
        b=nOItr6Czh6X2+QQTCciI20t/wsYGA/F8KiVXaM49ddDp7A4H00gNEAQ0TpZBMCrFiF
         OceZGr5SapwM6wFUbJ4c6u8YFuYFpJCyBQ0VboCndLyvff98sD7FywhYdyMgS2u8RYRd
         uEGtyc1Pw/H15GQ2ZBkB2/xFQoCcF3KpxlGGjLuvK92oSciA3TK/tUqqpp6nA3Hd8k2i
         dBms384xCtWoWIR7Mgt2VYN6fV3Oo2DfMuNpqfA0L+RYrZvbRUC+/7trFut4bheaFyBD
         UgxbOBvZ3eMhnAl56jrFVZRzQj4WxyNZSxSwqxLSIgDJgWCWPj/ph8tWF6XN001TbkRN
         mBJA==
X-Gm-Message-State: AOAM531+H+b+s/uwq28PeGcCvh/ZtXbplwxeK5wnEP1kQmQAeGmtqmTX
        cfa0okBQ1bvv7MnA+cXX8Zw=
X-Google-Smtp-Source: ABdhPJzPlninuCiJAb0mSSKwhdWv+D5bEApZfgQeWvIMZfsPP4v6o9z7qp+MqNQsxaejD8pDMj8zlA==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr845151wrv.405.1632341155821;
        Wed, 22 Sep 2021 13:05:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 34/47] staging: r8188eu: remove ieee80211_get_hdrlen()
Date:   Wed, 22 Sep 2021 22:04:07 +0200
Message-Id: <20210922200420.9693-35-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ieee80211_get_hdrlen() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 27 --------------------
 drivers/staging/r8188eu/include/ieee80211.h  |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 3f0c1a78ccb1..956b9bafcdd1 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1214,33 +1214,6 @@ int ieee80211_is_empty_essid(const char *essid, int essid_len)
 	return 1;
 }
 
-int ieee80211_get_hdrlen(u16 fc)
-{
-	int hdrlen = 24;
-
-	switch (WLAN_FC_GET_TYPE(fc)) {
-	case RTW_IEEE80211_FTYPE_DATA:
-		if (fc & RTW_IEEE80211_STYPE_QOS_DATA)
-			hdrlen += 2;
-		if ((fc & RTW_IEEE80211_FCTL_FROMDS) && (fc & RTW_IEEE80211_FCTL_TODS))
-			hdrlen += 6; /* Addr4 */
-		break;
-	case RTW_IEEE80211_FTYPE_CTL:
-		switch (WLAN_FC_GET_STYPE(fc)) {
-		case RTW_IEEE80211_STYPE_CTS:
-		case RTW_IEEE80211_STYPE_ACK:
-			hdrlen = 10;
-			break;
-		default:
-			hdrlen = 16;
-			break;
-		}
-		break;
-	}
-
-	return hdrlen;
-}
-
 static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 {
 	u32 wpa_ielen;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 8df83481bf47..7e9520c7fac5 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -890,7 +890,6 @@ struct tx_pending {
 
 /* Baron move to ieee80211.c */
 int ieee80211_is_empty_essid(const char *essid, int essid_len);
-int ieee80211_get_hdrlen(u16 fc);
 
 /* Action category code */
 enum rtw_ieee80211_category {
-- 
2.33.0

