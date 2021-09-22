Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811C9415112
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhIVUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbhIVUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D145C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so10346436wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJkcpqLnzjZnnA5rvx4w3eTJYY2j/84Osno+0Usot4s=;
        b=TiLIVNHQJ0LLrs1e4y7ag2Nl0PoOlnajHByhc4halOLwGsyWWNwMSSeYecOx40mK11
         USj2eGpGI/EjqlUnbm1arwv1um96AUGV3QiNSdmKFuVVlGy5pz4TCIrlWLePQbbvWUYp
         lCnXaIDJYlCeWYdV5XwfarsZJ13mQyjegjprY2MU/R7KKFm5U221WIfrPdzU5BRgt7gj
         tpPGh96xEAlt9L8B/ICxHiDHAupydj29qPR0k/NYy4i2D9aj6wr9Uzs+xEKLyirPPEU7
         NQYscbxmf4kKYi4yNc8xCi+4Ipxb0jQziWu9cCbrCBPxmJ39oohoTTmqBXDnRIT7xQng
         fDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJkcpqLnzjZnnA5rvx4w3eTJYY2j/84Osno+0Usot4s=;
        b=EHFIeFDVDsfi5XrXtlEWiYWnTIbqD4fDrGbrK8/F7J4TTiykIICr+fAcgI8P1xoXEo
         qnOk/uI2fX/btSHZ5fuytOzmP0YW3++1S6py78A6UOgLKuGZyzreTTt98v8QXGVY9gId
         Xra2D7fnCZTTUJyfAPrM8duiHlc5Rk42ZZustTKT5fp3J6FDwCk7B/fqyELdQ9rKM0Ok
         vJrM5DjhvucIsajyvcI7itHQbJi35BjuEip5WabgU5Efah9PKEqwMgKCBJ6Re1wGKMiI
         hvBDTYnajp+CllEMWVYPqT1VuemYc1ztxkOu+M/6sBB47ttQ8pqJOXoeo0xwh2Gk469E
         e/aw==
X-Gm-Message-State: AOAM532A/ee+jjsAc1kKVDGzTpIj8AEYdV1ltqszmwvxn5gjaUJDn/hL
        mqwfVimIbswDfXyv46v+BTM=
X-Google-Smtp-Source: ABdhPJwf7OilZozm1mkBD8VbwcSXrNNWZP0mkunmyN3DTjNcUqM+EzrtiyulyKuM+cVP4iDu87X04A==
X-Received: by 2002:adf:fe08:: with SMTP id n8mr923951wrr.246.1632341152877;
        Wed, 22 Sep 2021 13:05:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 30/47] staging: r8188eu: remove action_public_str()
Date:   Wed, 22 Sep 2021 22:04:03 +0200
Message-Id: <20210922200420.9693-31-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function action_public_str() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 26 --------------------
 drivers/staging/r8188eu/include/ieee80211.h  |  1 -
 2 files changed, 27 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 5f8bd8cd886d..7dc40d6a5de1 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1495,29 +1495,3 @@ int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *act
 
 	return true;
 }
-
-static const char *_action_public_str[] = {
-	"ACT_PUB_BSSCOEXIST",
-	"ACT_PUB_DSE_ENABLE",
-	"ACT_PUB_DSE_DEENABLE",
-	"ACT_PUB_DSE_REG_LOCATION",
-	"ACT_PUB_EXT_CHL_SWITCH",
-	"ACT_PUB_DSE_MSR_REQ",
-	"ACT_PUB_DSE_MSR_RPRT",
-	"ACT_PUB_MP",
-	"ACT_PUB_DSE_PWR_CONSTRAINT",
-	"ACT_PUB_VENDOR",
-	"ACT_PUB_GAS_INITIAL_REQ",
-	"ACT_PUB_GAS_INITIAL_RSP",
-	"ACT_PUB_GAS_COMEBACK_REQ",
-	"ACT_PUB_GAS_COMEBACK_RSP",
-	"ACT_PUB_TDLS_DISCOVERY_RSP",
-	"ACT_PUB_LOCATION_TRACK",
-	"ACT_PUB_RSVD",
-};
-
-const char *action_public_str(u8 action)
-{
-	action = (action >= ACT_PUBLIC_MAX) ? ACT_PUBLIC_MAX : action;
-	return _action_public_str[action];
-}
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index d64358ab8503..c6acb48059f7 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1181,6 +1181,5 @@ u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI_20, u8 short_GI_40,
 
 int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category,
 			   u8 *action);
-const char *action_public_str(u8 action);
 
 #endif /* IEEE80211_H */
-- 
2.33.0

