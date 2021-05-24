Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88A938E813
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhEXNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:52:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C3C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:51:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e15so8031420plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8hENKovfpvL6qtdxJzB/suCkGhj752NHX7VOuctV34=;
        b=ERK8CtiL4/8YwgrrwO+D0EZ3kHnCqH4RfKxzFBdDq2UqNUrGB1hvYL3SvaDFhT2cAQ
         O6bxOqofbcrxsucfQArl5VorUP0NaYjuThxYXdDfVP/zqeGSQBc52FZKaD+5GQkhvGvq
         XovCQehsX/PwnHIbd0/3gRWAl8iRyAyXEDMLbXdcZ+L2hIHYheOHZqIaJ4pcgLOgLp1p
         VgEdSk3EEf7WQB1j9oBPjQ9KJimOvOTBBj38yYjhXYRi/bL7j7tvjn3RQus9s1V8oXDJ
         MqubMPw3K+5kgs4cnmzLtv3p6k+YY/xId3IaG1c2QnOuQS0eLkCG5fjYyXSsdGXuUXu+
         HHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8hENKovfpvL6qtdxJzB/suCkGhj752NHX7VOuctV34=;
        b=T1wM9N0M4MA+l9vJyOOMEnXVdA68gBWkITT32SPPYLcAJ5vfKzZiOwVqFAVUTDOBr+
         FRVNKecZQ0oWG4UWaeAFUAB7Cc7K0uLm+UkUY/ifVZIk3Uw1IYmMgZR8vVWTtkxA+ogV
         NSdzUfcCJSRDkrfWIBXc7NUiDZ0Y8Z2HA8c3Ld/jGH7YtHpB9vZDcLudoL2aVRWuTpJs
         nLRkpFQUR30EXeazQ0r2JucijeOTW4nA3EpFFAUwPOxycVCQ6mNe19ZzbSFOkvLG5ug7
         fusF/bI3HdO4FnKx2upoMk2ZBGI0OY+GhJRrOAuT2BdJLXtdxmsVLAhnuLFk1Wh8m2uT
         Dj7g==
X-Gm-Message-State: AOAM532HQUgHeHFMNypAjme/O2Paec5T3CIFir3zpWs5yNrjj5g1G8X3
        0NTd5QotC6yu939cAWn+b5k=
X-Google-Smtp-Source: ABdhPJz0jbc2LkB9lXoPQ4uJ24NWB3wUrOt1yphHzlXsONnxRhE/EHfRL32S4EGveonoA2dqBWz0wQ==
X-Received: by 2002:a17:90a:4bc3:: with SMTP id u3mr25660179pjl.158.1621864279004;
        Mon, 24 May 2021 06:51:19 -0700 (PDT)
Received: from fedora.. ([49.36.218.98])
        by smtp.googlemail.com with ESMTPSA id z9sm8638106pji.47.2021.05.24.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 06:51:18 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, fabioaiuto83@gmail.com
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8723bs: remove unnecessary braces from conditionals
Date:   Mon, 24 May 2021 19:21:04 +0530
Message-Id: <20210524135105.5550-3-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524135105.5550-1-chouhan.shreyansh630@gmail.com>
References: <20210524135105.5550-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the braces from if else statements in core/rtw_wlan_util.c since
the previous commit (6a257dd6de516573) caused all conditional blocks to
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

