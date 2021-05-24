Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC8D38E812
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhEXNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:52:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:51:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x188so20883298pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZtKdiXneeaLWvfNp9Guks/t8UbmChTN9qjKMw6k9W0=;
        b=Vosdy+R3bG6UbzPu2864eSSC5PbFyqda5f8/njPIgmYFYJrM5kNCxj0HaRqhGueezn
         CUY5c/Z4h8dnjyPgzzCkhB6EphhB8gRPZJfMZJ7OjxcWBFXi4mZiTiLg8YfSaxSkQok4
         nTtbtUD3/3wOBpQsYjKWmrdzOLXXGm5WTzoQGoRJ2aWfuDmFtiyn60rkk476opk5onRv
         jCKx5RS/N7liLDtoEpzNin8lI7FD6jTaQyK4yTAYZPdyr8xRFlXdl5/YLc8lYHPwxFaJ
         jAy6TsooG96WSy4+4iRvB5mhTy84cQAT28aFyjHJBzCtzAYqg9Qke13YgVWrnX409WFJ
         wqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZtKdiXneeaLWvfNp9Guks/t8UbmChTN9qjKMw6k9W0=;
        b=VKmop0mZ/ejdBafeg7x3owCPneyaRKLltrK/8pFyGc+R9CMPHNSgkhB7NpEfcPNKCK
         hTF8gFXV6qtlLWmPfzB8812fkLsA1xK/jCp/EGVh5M8FzwwzDYSTFwLRccjA8gD0id62
         rNf9HlnGvmGr5eB1nmpfRad5zUdGT4B+P9xJr6tvzT5s2vjHHlQmwp6YJSDPXHbK3FGT
         ZGwrxN8G6KvpaXsIafCKSKSdYXJ62ioczSOoNxcl05BsIgq6qrmLnL7jSmbLWxlFCIHl
         xNIyopBkc2F1YAz2bJr1Gs7YTkFKbeHrA5BBqWE1iPeMVFuL3wEgM9CF/Gvf8UJrbyKm
         YXyw==
X-Gm-Message-State: AOAM531fhQ7gZcnjQy9Q9rppJYkDTfEaysUAwjlL+Xx6bLxS6MI7QiUe
        M/tgZ/4MB5HZE40FqY7Kj5M=
X-Google-Smtp-Source: ABdhPJyNDc8xSk+4jxutKOOTCD4DRA9o0qJnvuSGTaGrQn+OMY6J7XozYQmTfBH0QY1ZOVlliCgdqw==
X-Received: by 2002:a63:795:: with SMTP id 143mr13612903pgh.43.1621864275356;
        Mon, 24 May 2021 06:51:15 -0700 (PDT)
Received: from fedora.. ([49.36.218.98])
        by smtp.googlemail.com with ESMTPSA id z9sm8638106pji.47.2021.05.24.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 06:51:14 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, fabioaiuto83@gmail.com
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: refactor to reduce indents
Date:   Mon, 24 May 2021 19:21:03 +0530
Message-Id: <20210524135105.5550-2-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524135105.5550-1-chouhan.shreyansh630@gmail.com>
References: <20210524135105.5550-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the number of indents in rtw_wlan_util.c file by refactoring the
code.

Moved the part of code that rearranged ac paramaters in the function
WMMOnAssocResp to a separate function named sort_wmm_ac_params. It takes
both the array of ac params and their indexes as arguments and sorts them.
Has return type void.

Moved the part of code that checked IE for realtek vendor in the
function check_assoc_AP to a separate function named
get_realtek_assoc_AP_vender. It takes a struct ndis_80211_var_ie * as an
argument and returns u32 realtek vendor.

Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 108 +++++++++---------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index ce47ef4edea0..36e515a7ab5c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -777,6 +777,32 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	return true;
 }
 
+static void sort_wmm_ac_params(u32 *inx, u32 *edca)
+{
+	u32 i, j, change_inx = false;
+
+	/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
+	for (i = 0; i < 4; i++) {
+		for (j = i + 1; j < 4; j++) {
+			/* compare CW and AIFS */
+			if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
+				change_inx = true;
+			} else if ((edca[j] & 0xFFFF) == (edca[i] & 0xFFFF)) {
+				/* compare TXOP */
+				if ((edca[j] >> 16) > (edca[i] >> 16))
+					change_inx = true;
+			}
+
+			if (change_inx) {
+				swap(edca[i], edca[j]);
+				swap(inx[i], inx[j]);
+
+				change_inx = false;
+			}
+		}
+	}
+}
+
 void WMMOnAssocRsp(struct adapter *padapter)
 {
 	u8 ACI, ACM, AIFS, ECWMin, ECWMax, aSifsTime;
@@ -873,35 +899,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 		inx[0] = 0; inx[1] = 1; inx[2] = 2; inx[3] = 3;
 
-		if (pregpriv->wifi_spec == 1) {
-			u32 j, tmp, change_inx = false;
-
-			/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
-			for (i = 0; i < 4; i++) {
-				for (j = i+1; j < 4; j++) {
-					/* compare CW and AIFS */
-					if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
-						change_inx = true;
-					} else if ((edca[j] & 0xFFFF) == (edca[i] & 0xFFFF)) {
-						/* compare TXOP */
-						if ((edca[j] >> 16) > (edca[i] >> 16))
-							change_inx = true;
-					}
-
-					if (change_inx) {
-						tmp = edca[i];
-						edca[i] = edca[j];
-						edca[j] = tmp;
-
-						tmp = inx[i];
-						inx[i] = inx[j];
-						inx[j] = tmp;
-
-						change_inx = false;
-					}
-				}
-			}
-		}
+		if (pregpriv->wifi_spec == 1)
+			sort_wmm_ac_params(inx, edca);
 
 		for (i = 0; i < 4; i++)
 			pxmitpriv->wmm_para_seq[i] = inx[i];
@@ -1496,6 +1495,33 @@ void set_sta_rate(struct adapter *padapter, struct sta_info *psta)
 	Update_RA_Entry(padapter, psta);
 }
 
+static u32 get_realtek_assoc_AP_vender(struct ndis_80211_var_ie *pIE)
+{
+	u32 Vender = HT_IOT_PEER_REALTEK;
+
+	if (pIE->Length >= 5) {
+		if (pIE->data[4] == 1)
+			/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
+			/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
+			if (pIE->data[5] & RT_HT_CAP_USE_92SE)
+				/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
+				Vender = HT_IOT_PEER_REALTEK_92SE;
+
+		if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
+			Vender = HT_IOT_PEER_REALTEK_SOFTAP;
+
+		if (pIE->data[4] == 2) {
+			if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
+				Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
+
+			if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
+				Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
+		}
+	}
+
+	return Vender;
+}
+
 unsigned char check_assoc_AP(u8 *pframe, uint len)
 {
 	unsigned int	i;
@@ -1519,29 +1545,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
 				return HT_IOT_PEER_CISCO;
 			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
-				u32 Vender = HT_IOT_PEER_REALTEK;
-
-				if (pIE->Length >= 5) {
-					if (pIE->data[4] == 1)
-						/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
-						/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
-						if (pIE->data[5] & RT_HT_CAP_USE_92SE)
-							/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
-							Vender = HT_IOT_PEER_REALTEK_92SE;
-
-					if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
-						Vender = HT_IOT_PEER_REALTEK_SOFTAP;
-
-					if (pIE->data[4] == 2) {
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
-							Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
-
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
-							Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
-					}
-				}
-
-				return Vender;
+				return get_realtek_assoc_AP_vender(pIE);
 			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
 				return HT_IOT_PEER_AIRGO;
 			} else {
-- 
2.31.1

