Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5477B3558A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbhDFP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhDFP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:58:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3053C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:58:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e12so1726990wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJVOsPOpPhvCUvR1+VHBhDpILBtur99NXP6x6WnJpx0=;
        b=tZVerhjvml6oRiaS0NFeGshg/9K5fZet4K8K6R2oIVFt21ysMu4++4OtjxKrLlagqs
         OUgC54isLnwPHxX/omg6M+hrXW1ZMZtOLOeknH6nW7mMo8e8VHnfwUJnPpLB9+mCLOzr
         9tUL36yQdYijp5cKfO0EcqZVznYDo7AHcQEuTC5G9OFtjxi3YQJTxBrQaLloYTCNnfBc
         jhsKHI2/tGBw/fM/yD5cuJphuaER+AyZBh+eJG9+mLj6JwiD/5uzsIGAj6V1TuP1qrfE
         wEg6iiUPHRsOIlPknMonrD8jD8lRCytIwZdnNPHLwFahJQbKbTckmzWSj3TLnf9IgugO
         Hd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJVOsPOpPhvCUvR1+VHBhDpILBtur99NXP6x6WnJpx0=;
        b=qSGo4+Fl29hHrZCmuYS4GwA1lg0sg5jsdWqkvKzn+I2PMqt1ku9rd174e+4IPRF5ZG
         RgYbBAzAwg6E5iay7jlJJ5uJ8lkxD61LcIGPaRIANj4uRZKQlaA9+kJj7KXTEZUwY8mq
         vjps6nxhv3v4x3ltbJMSCeoKCpShrKsyejqryNu1Y5xBIofcpOO59bf8rUf8MwyOC+xE
         gPSRgAyO5Sbm4Es3yv45CL1ZqVPTqxPeTGXiolqJIkk+pXGGqHvLQyChfjSv0G7eVTWX
         H9BzxuGIbi8xsAWI2a2JyT+d4zGLQqQD1+Bv5Diyx1Y9V+shyA6LiqtIQGP7nXrpCaoE
         hG9A==
X-Gm-Message-State: AOAM530qUnQhD0uZI1m5oodCfadFGozyeIXS/XW77TZjVr0d2zABdFgT
        q0Oe+sSuNR4WRap+u/uJBRMCldObTSPh3Q==
X-Google-Smtp-Source: ABdhPJyvttPXKcE1cEbpYzmnCYYEuYwmq/yz39FEUNvzNmrKKRfafK9e4JuLhjd9WrzgrHh+TqwM9w==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr35818377wrw.173.1617724697503;
        Tue, 06 Apr 2021 08:58:17 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:ad13:af9b:f63b:bc4b])
        by smtp.gmail.com with ESMTPSA id k7sm23219508wrd.24.2021.04.06.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:58:16 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v2] staging: rtl8723bs: core: reorganize characters so the lines are under 100 ch
Date:   Tue,  6 Apr 2021 16:58:15 +0100
Message-Id: <20210406155815.90271-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up warnings of "line over 100 characters" but avoiding
more than 90 characters in file rtw_ap.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
Changes in v2:
	- revert some cleans up warning previously applied wrong

This patch came from patch series that could find in:
https://lore.kernel.org/linux-staging/cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index bee4f83a6db7..d65832b06444 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -278,7 +278,8 @@ void expire_timeout_chk(struct adapter *padapter)
 
 			if (psta->state & WIFI_SLEEP_STATE) {
 				if (!(psta->state & WIFI_STA_ALIVE_CHK_STATE)) {
-					/* to check if alive by another methods if station is at ps mode. */
+					/* to check if alive by another methods */
+					/* if station is at ps mode. */
 					psta->expire_to = pstapriv->expire_to;
 					psta->state |= WIFI_STA_ALIVE_CHK_STATE;
 
@@ -309,7 +310,8 @@ void expire_timeout_chk(struct adapter *padapter)
 			);
 			updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
-			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
+			/* TODO: Aging mechanism to digest frames in sleep_q to */
+			/* avoid running out of xmitframe */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
 				&& padapter->xmitpriv.free_xmitframe_cnt < ((
 					NR_XMITFRAME / pstapriv->asoc_list_cnt
@@ -375,7 +377,8 @@ void expire_timeout_chk(struct adapter *padapter)
 			if (list_empty(&psta->asoc_list) == false) {
 				list_del_init(&psta->asoc_list);
 				pstapriv->asoc_list_cnt--;
-				updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
+				updated = ap_free_sta(padapter, psta, false,
+						      WLAN_REASON_DEAUTH_LEAVING);
 			}
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
 		}
@@ -1117,7 +1120,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 				*(p + 8) |= BIT(7);/* QoS Info, support U-APSD */
 
-				/* disable all ACM bits since the WMM admission control is not supported */
+				/* disable all ACM bits since the WMM admission */
+				/* control is not supported */
 				*(p + 10) &= ~BIT(4); /* BE */
 				*(p + 14) &= ~BIT(4); /* BK */
 				*(p + 18) &= ~BIT(4); /* VI */
-- 
2.25.1

