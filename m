Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663AD3FE1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbhIASHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbhIASHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:07:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF97C0613D9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:06:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so310373pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H+/Lyfz9TNtbqDe9NxLVaW+b1GlctI9OD0MfTlvmgNc=;
        b=WTP4TEMkzedv2yNtgJ7iDgcDBULVbrjObJdUgjDn0wOttDyvbplSm9LzhYwaH0ZsdU
         radkKLHEnURIzLZwbFhTCRpakKcKorkRDX47yml3+6703UxiM2slo7NTCOKkJK/yPvU1
         nolHGLuFlZacTTrh4OewVEMIQJ/ZLaQriiJcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H+/Lyfz9TNtbqDe9NxLVaW+b1GlctI9OD0MfTlvmgNc=;
        b=aICYyxUIni0t1iSbQgqfgEtUfroMmhVBdlr/JpySMaMR3neToKC9UWhaxQ2IvHl4R6
         EeQ2WPStbiQZjDxMUECeTMd9zTr7f6ZNFbgDMq6GU9v9Jgqt0U4lxUBXRZougdvZGn6g
         jNTb3fvxQo8NyVksCW78BaDj+iE3L1TH51vvPCVAptPtMyXM4EL2IHOlU049Epf3Yh5g
         7KyBaxNZJbzR6ZFiGZj1CpOvx2BbGTBgOAWYueCkHwSvsUjhpTBcGwH1tnyVUSFQ6vhN
         +GU+ic0I6OGLpQKF2E2vlJ4+4ev/6zLQJiTdvT9Z5U2p/S3Mhzc9sx71zYcjAhPXJuYW
         m24A==
X-Gm-Message-State: AOAM530Zp9ljDEgOETAjgqHr2bJ3VwyNUVq3gn+KPIp38jQZawhK9Bxu
        vCjAiycAx9PcNqqtMeDuPzfHrA==
X-Google-Smtp-Source: ABdhPJxYow6k47ju8zaGAxZ3QDUvTl7R69BptJmcg9HIkO/wrTRp5zileffx5LsgJSu/+VcPjnXxvg==
X-Received: by 2002:a17:90a:6b4d:: with SMTP id x13mr613010pjl.88.1630519582734;
        Wed, 01 Sep 2021 11:06:22 -0700 (PDT)
Received: from localhost (138-229-239-060.res.spectrum.com. [138.229.239.60])
        by smtp.gmail.com with ESMTPSA id i5sm181241pjk.47.2021.09.01.11.06.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:06:21 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Benjamin Li <benl@squareup.com>, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] wcn36xx: handle connection loss indication
Date:   Wed,  1 Sep 2021 11:06:05 -0700
Message-Id: <20210901180606.11686-1-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware sends delete_sta_context_ind when it detects the AP has gone
away in STA mode. Right now the handler for that indication only handles
AP mode; fix it to also handle STA mode.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Li <benl@squareup.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 44 +++++++++++++++++++-------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 57fa857b290b..f6bea896abe8 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2623,30 +2623,52 @@ static int wcn36xx_smd_delete_sta_context_ind(struct wcn36xx *wcn,
 					      size_t len)
 {
 	struct wcn36xx_hal_delete_sta_context_ind_msg *rsp = buf;
-	struct wcn36xx_vif *tmp;
+	struct wcn36xx_vif *vif_priv;
+	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_sta *sta;
+	bool found = false;
 
 	if (len != sizeof(*rsp)) {
 		wcn36xx_warn("Corrupted delete sta indication\n");
 		return -EIO;
 	}
 
-	wcn36xx_dbg(WCN36XX_DBG_HAL, "delete station indication %pM index %d\n",
-		    rsp->addr2, rsp->sta_id);
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "delete station indication %pM index %d reason %d\n",
+		    rsp->addr2, rsp->sta_id, rsp->reason_code);
 
-	list_for_each_entry(tmp, &wcn->vif_list, list) {
+	list_for_each_entry(vif_priv, &wcn->vif_list, list) {
 		rcu_read_lock();
-		sta = ieee80211_find_sta(wcn36xx_priv_to_vif(tmp), rsp->addr2);
-		if (sta)
-			ieee80211_report_low_ack(sta, 0);
+		vif = wcn36xx_priv_to_vif(vif_priv);
+
+		if (vif->type == NL80211_IFTYPE_STATION) {
+			/* We could call ieee80211_find_sta too, but checking
+			 * bss_conf is clearer.
+			 */
+			bss_conf = &vif->bss_conf;
+			if (vif_priv->sta_assoc &&
+			    !memcmp(bss_conf->bssid, rsp->addr2, ETH_ALEN)) {
+				found = true;
+				wcn36xx_dbg(WCN36XX_DBG_HAL,
+					    "connection loss bss_index %d\n",
+					    vif_priv->bss_index);
+				ieee80211_connection_loss(vif);
+			}
+		} else {
+			sta = ieee80211_find_sta(vif, rsp->addr2);
+			if (sta) {
+				found = true;
+				ieee80211_report_low_ack(sta, 0);
+			}
+		}
+
 		rcu_read_unlock();
-		if (sta)
+		if (found)
 			return 0;
 	}
 
-	wcn36xx_warn("STA with addr %pM and index %d not found\n",
-		     rsp->addr2,
-		     rsp->sta_id);
+	wcn36xx_warn("BSS or STA with addr %pM not found\n", rsp->addr2);
 	return -ENOENT;
 }
 
-- 
2.17.1

