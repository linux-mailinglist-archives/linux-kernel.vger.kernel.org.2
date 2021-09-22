Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111D415117
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhIVUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbhIVUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49ABC0617BB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i23so10503939wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQRjrd1hqS1tn11TLgM7TMQnbVhuuEudKXbyztmf3pE=;
        b=OEzr9qtnMO9lewSaSXEAN7P2TQmsvFbg8uTMqyc7cprQpZbm0iHY6/r1u26kAAfEVl
         tvTcije5zHH8xu4Jj/e80QrGvbxTzllsFOpwtkr6TH8RnZGOKMFiKFpNSX33a/JP9jDW
         6p+fvZFDXQu/x5cxYBhzTLNWR0R4ywjOEWZ6KZYwyMP+dE/0gQKdzOanwiF24xZaboPt
         eT52keAy76Kv7NzJFkN92SKBFq4P028QUUoPtFFpLS/YIoXdkxrNFBhFRKaMAu+tZp0u
         IbDphL3007idYyKsMJ+k56C72PufYw95driJxU/rpb84ImAxkZjVdQZBqZrn8KsJSmAM
         lFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQRjrd1hqS1tn11TLgM7TMQnbVhuuEudKXbyztmf3pE=;
        b=NBERsBdHjZzTSH21yfP8o4NSSCvY/JJR7B8vH+VNeuQ10rpn4d9RebZFdgRIuZmBMJ
         yN8l0Hiin0YN14ZDKE4ioNLq9VrHluhJf1GCDhwWm/nm0ozYAg5AO0d7eZVb/ML5wdum
         Ve6vkGO1N59kbWl+Zx5x3aU0UllzgiHOIvLX3aTIf4UF2UG9ccKNo+/TU9KxQ1XRJzJd
         i10dXTF/6EQFhMmpPKKsMcmLWdmKfAJtd+MccrtS1f9l5nZ6LfI9F+logRZ/MEqR5CN2
         FgIOvj/gKZBdAfH7oFahAkkXzWG0MWMW0Ozwi15Z7J/h5ERGrWTXHKr3/+FWaXGOldQi
         d0OA==
X-Gm-Message-State: AOAM532ri8QbBCb09uEsYCZTgVP58y2+Rbj6syPMYAgotD3CIPfVaEIZ
        NvkkNtYmDort7lt9NQpocaY=
X-Google-Smtp-Source: ABdhPJyRKSoPeA2AraM3W4fEt0ER7vURurlZk/WbyaPSQlZ0/akipk2HG+5Q4I7i0KNpflc2GjRFqg==
X-Received: by 2002:adf:de09:: with SMTP id b9mr937125wrm.114.1632341156496;
        Wed, 22 Sep 2021 13:05:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 35/47] staging: r8188eu: remove ieee80211_is_empty_essid()
Date:   Wed, 22 Sep 2021 22:04:08 +0200
Message-Id: <20210922200420.9693-36-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ieee80211_is_empty_essid() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 17 -----------------
 drivers/staging/r8188eu/include/ieee80211.h  |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 956b9bafcdd1..29bf3bdb598b 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1197,23 +1197,6 @@ void rtw_wlan_bssid_ex_remove_p2p_attr(struct wlan_bssid_ex *bss_ex, u8 attr_id)
 	}
 }
 
-/* Baron adds to avoid FreeBSD warning */
-int ieee80211_is_empty_essid(const char *essid, int essid_len)
-{
-	/* Single white space is for Linksys APs */
-	if (essid_len == 1 && essid[0] == ' ')
-		return 1;
-
-	/* Otherwise, if the entire essid is 0, we assume it is hidden */
-	while (essid_len) {
-		essid_len--;
-		if (essid[essid_len] != '\0')
-			return 0;
-	}
-
-	return 1;
-}
-
 static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 {
 	u32 wpa_ielen;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 7e9520c7fac5..af1e074e0bdf 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -888,9 +888,6 @@ struct tx_pending {
 #define IEEE_G	    (1<<2)
 #define IEEE_MODE_MASK    (IEEE_A|IEEE_B|IEEE_G)
 
-/* Baron move to ieee80211.c */
-int ieee80211_is_empty_essid(const char *essid, int essid_len);
-
 /* Action category code */
 enum rtw_ieee80211_category {
 	RTW_WLAN_CATEGORY_SPECTRUM_MGMT = 0,
-- 
2.33.0

