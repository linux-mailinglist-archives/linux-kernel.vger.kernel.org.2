Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520533FAA72
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhH2J0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbhH2J0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D8C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d6so16800761edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2nLY9bxz+JbWZICE9X6brYpetbTS5b7tdHTmciRbeg=;
        b=n/Q+UFRSMfKigPpKTAXNFUmmC9dtlpbf/TM1MCQBM4UlzNY99Frzxf8ct+ou/0yd+u
         jaD6t0FnyHLS+GcgxlqZXyjNqv5C5IvnaSWHXHXZmIwehugZl+ljwuedJIJw0o+ZSj4e
         WlyubP1boQSWQHiGOIe0LCHwYVTX3qTZUAZ+6WQpU2N9/eDJaAEK/t0DUsjJCMIVR3xf
         8epjtIbQDsVei541FMGwjR+wb1wkNQ6ikSNlX5KLAlPHlrq41wZ4ij6S9BUjIBVzSR4o
         hbQO9wtdDIFzdltIjq2s9mbuJI52K1+xYmKs7KQYfR2mOcOPID71RsKz+JjEu4bbddva
         8zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2nLY9bxz+JbWZICE9X6brYpetbTS5b7tdHTmciRbeg=;
        b=E+wI1flodQ/llM9wQdkStbCbs5I3hIBg4AJkoUd5Xqtmog4ErmBPotX4c//BTCIqHR
         rGovB4D2JkI3n1+F6FT2zdavy/M5gw54E5jFOUJEXLbGlUl1ja3ZVoDa/JgquCXxhBYY
         dwLKnlYhQaNNCfIMUBOPqze8M/8rrhtjeYRNLAQmccXzSP+ekwjEJShOa161RS6NFJmB
         JuotdjPHwcztMr6LTE9TeDDRhcsBjfebiBNb96tCNmViqvzSZwmVJN5a8Wky/J9yiYAP
         z9LZN34UWxMTWq0RWuib0b0vmndvqOYWXRSJIgYU+E1d9SsHiNIPAXNXfrmYI7/d+VRu
         apSw==
X-Gm-Message-State: AOAM530q00UMwHYwy/ZO9xhO4aeJxAguB1Jx61XHXPIdaexXA6sOftKm
        R9pHto1UMqapUpBmzcVq0r0=
X-Google-Smtp-Source: ABdhPJzg6gJhgOmAKutVRldIdUtXRSRPkmlgscysnDt4294IyhfpYr2pKgemush/zixPz8l/96sX9g==
X-Received: by 2002:a05:6402:d6b:: with SMTP id ec43mr14953958edb.107.1630229126800;
        Sun, 29 Aug 2021 02:25:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id d23sm5814414edt.39.2021.08.29.02.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: remove should_forbid_n_rate()
Date:   Sun, 29 Aug 2021 11:25:02 +0200
Message-Id: <20210829092502.3658-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829092502.3658-1-straube.linux@gmail.com>
References: <20210829092502.3658-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function should_forbid_n_rate() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 36 -------------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  1 -
 2 files changed, 37 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 8491d82f4a70..ccb5fbbc3ffb 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1098,42 +1098,6 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	}
 }
 
-unsigned int should_forbid_n_rate(struct adapter *padapter)
-{
-	u32 i;
-	struct ndis_802_11_var_ie *pIE;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct wlan_bssid_ex  *cur_network = &pmlmepriv->cur_network.network;
-
-	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
-		for (i = sizeof(struct ndis_802_11_fixed_ie); i < cur_network->IELength;) {
-			pIE = (struct ndis_802_11_var_ie *)(cur_network->IEs + i);
-
-			switch (pIE->ElementID) {
-			case _VENDOR_SPECIFIC_IE_:
-				if (!memcmp(pIE->data, RTW_WPA_OUI, 4) &&
-				    ((!memcmp((pIE->data + 12), WPA_CIPHER_SUITE_CCMP, 4)) ||
-				    (!memcmp((pIE->data + 16), WPA_CIPHER_SUITE_CCMP, 4))))
-					return false;
-				break;
-			case _RSN_IE_2_:
-				if  ((!memcmp((pIE->data + 8), RSN_CIPHER_SUITE_CCMP, 4))  ||
-				     (!memcmp((pIE->data + 12), RSN_CIPHER_SUITE_CCMP, 4)))
-					return false;
-				break;
-			default:
-				break;
-			}
-
-			i += (pIE->Length + 2);
-		}
-
-		return true;
-	} else {
-		return false;
-	}
-}
-
 int wifirate2_ratetbl_inx(unsigned char rate)
 {
 	int	inx = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 1695a9695ddf..e15e2cec77bd 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -516,7 +516,6 @@ unsigned int receive_disconnect(struct adapter *padapter,
 unsigned char get_highest_rate_idx(u32 mask);
 int support_short_GI(struct adapter *padapter, struct HT_caps_element *caps);
 unsigned int is_ap_in_tkip(struct adapter *padapter);
-unsigned int should_forbid_n_rate(struct adapter *padapter);
 
 void report_join_res(struct adapter *padapter, int res);
 void report_survey_event(struct adapter *padapter, struct recv_frame *precv_frame);
-- 
2.32.0

