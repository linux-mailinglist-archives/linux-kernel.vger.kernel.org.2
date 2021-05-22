Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7038D4B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhEVJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhEVJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:22:03 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114D9C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:20:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r1so1320565pgk.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJBXwjmQxlDJj35yQdpTUYgfqMS8ZGbhH8f1wKExiAI=;
        b=cF9xLTMJ+pU64iRwPGX9er3cCNibQ8WqGQ/BY2TVv0u8rLOaIAp1dpp7OTdYBRfkoR
         Ww/k9H/Zx7IOBUeS/FXsZDZhXOHL8XugRHRmZfF0hJqlIupjtCDE+O3yAHT5cecEshPQ
         h9gZ6/uiew6yhndu5bFXdBHkrGaBC1m2qNQhzxEj9t0eO34P5FIrjRRneiyDQ/CJxaVQ
         /Os13DVq31JTCACtgm546NgYHJVAYTNohJAvfr9bhNkPJNBH2KU4lfmzO8vedEe/QV/P
         btbQZjGzzXhMRA/mZRsgg7RhGR1Ff2MT4BaaxWlMd+xmugZwScfPoHazFllfY7XYLJlo
         HXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJBXwjmQxlDJj35yQdpTUYgfqMS8ZGbhH8f1wKExiAI=;
        b=fUE3FiPzxKyKF0vGXADxnDU2wL4lcB/yWy/W7ENTree6NpZl8cEyUFDiYk7XCzmOuM
         9QCwE683Mn7jnblp+DD2ORpa1cdFlBeXWaaPXCTc0aIVmGnspCVNtLp2FEmmtUm5YubB
         HQ+pH9GQnepwrjeFa4XTjG4d/nIrlD/29zZPjT+BcFf1WljZA5pS+VBxMHdspLvtmyMe
         qtCIoseDxgbf1ALUrS8J/DZvEvf0f2rwU8f859kPEbfhGxcJV507nqgwcKikXFdE8mih
         2lvswQEb349oGpXLBerF3faoqc6M8jnG3oaY1pyNRFBhswKN1b7793xMzWvzrHPA6NSr
         RB8A==
X-Gm-Message-State: AOAM531LMNXXNFaCJVe7cN7+KeVoItljWek1vHKByG7KVOX2Ay2H/Mac
        +O8eHPCG/8lpLLkXtQFafCg=
X-Google-Smtp-Source: ABdhPJxouJCUIDwK1lWiJC5/3Ax9Y1LMEgCyVT0bJ7ojlaowowixUewyW9YjsSXVI1S/FMwF5y8zGA==
X-Received: by 2002:a62:1a0d:0:b029:2da:21a6:6838 with SMTP id a13-20020a621a0d0000b02902da21a66838mr14142991pfa.76.1621675238568;
        Sat, 22 May 2021 02:20:38 -0700 (PDT)
Received: from fedora.. ([2405:201:6000:a04d:2131:362f:d566:c9d5])
        by smtp.googlemail.com with ESMTPSA id gt23sm5925752pjb.13.2021.05.22.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 02:20:38 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, straube.linux@gmail.com
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [Resend] [PATCH 2/2] [RFC] staging: rtl8723bs: remove unnecessary braces from conditionals
Date:   Sat, 22 May 2021 14:50:24 +0530
Message-Id: <20210522092024.65018-3-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522092024.65018-1-chouhan.shreyansh630@gmail.com>
References: <20210522092024.65018-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the braces from if else statements in core/rtw_wlan_util.c since
the previous commit 6a257dd6de516573 caused all conditional blocks to
have a single statement in the function check_assoc_AP.

Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 35 +++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 36e515a7ab5c..dd965c810967 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1532,25 +1532,24 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 
 		switch (pIE->ElementID) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) || (!memcmp(pIE->data, ARTHEROS_OUI2, 3))) {
+			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) || (!memcmp(pIE->data, ARTHEROS_OUI2, 3)))
 				return HT_IOT_PEER_ATHEROS;
-			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
-				   (!memcmp(pIE->data, BROADCOM_OUI2, 3)) ||
-				   (!memcmp(pIE->data, BROADCOM_OUI3, 3))) {
-				return HT_IOT_PEER_BROADCOM;
-			} else if (!memcmp(pIE->data, MARVELL_OUI, 3)) {
-				return HT_IOT_PEER_MARVELL;
-			} else if (!memcmp(pIE->data, RALINK_OUI, 3)) {
-				return HT_IOT_PEER_RALINK;
-			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
-				return HT_IOT_PEER_CISCO;
-			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
-				return get_realtek_assoc_AP_vender(pIE);
-			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
-				return HT_IOT_PEER_AIRGO;
-			} else {
-				break;
-			}
+			else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
+			         (!memcmp(pIE->data, BROADCOM_OUI2, 3)) ||
+			         (!memcmp(pIE->data, BROADCOM_OUI3, 3)))
+			      return HT_IOT_PEER_BROADCOM;
+			else if (!memcmp(pIE->data, MARVELL_OUI, 3))
+			      return HT_IOT_PEER_MARVELL;
+			else if (!memcmp(pIE->data, RALINK_OUI, 3))
+			      return HT_IOT_PEER_RALINK;
+			else if (!memcmp(pIE->data, CISCO_OUI, 3))
+			      return HT_IOT_PEER_CISCO;
+			else if (!memcmp(pIE->data, REALTEK_OUI, 3))
+			      return get_realtek_assoc_AP_vender(pIE);
+			else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3))
+			      return HT_IOT_PEER_AIRGO;
+			else
+			      break;
 
 		default:
 			break;
-- 
2.31.1

