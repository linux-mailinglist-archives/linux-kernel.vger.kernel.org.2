Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DEF3AD9A2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhFSKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhFSKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BDEC0617AD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so5210950wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzFrqHGl0cYS27Ypm4XF1HD4hXM1cpi1KCAV815SAkE=;
        b=CxRhcmv7ahuC+L16zluXOKgTfpfBKiLdVdRxBHZvGVTwsAQatljYQOD/C+fosg+Tai
         mLP5LmucExjPuEd4I6UjIY2OQrM80gvzFK7coI+EHH49QswKZhrz9EiQkuy20CB2sIPZ
         NKcTv0WCXcbpHF6ym7bUg3UxYe4ogUVSo1iyeHEFFfQBbWWsVz0d0G/+L47dgBbgoVul
         sj2HxS+LzQ533oIgMjBfvcPaw9NgmESgjcaXCRfKAMiPSlOx7ANCPPbO5ZCRADR7OEOn
         SAUIc/PlpKUHbdBuEbxLUDr5qnvUAroZoBd5ZiLxFoaURcJeX05LHZHM7nwtPNFm1Dce
         h+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzFrqHGl0cYS27Ypm4XF1HD4hXM1cpi1KCAV815SAkE=;
        b=d+HiD4A7U/3vah5IRfofuFmnyEjfcpXSGp+nfwMnxnnf+LAJfhQcsI5GT7pF300n7n
         gcYJ+3PqAtq50Kc+NwvhBmQHAtG3J28ZxRfrKbfa369+zKtiLLnqIc5fEUlw1al5ikKA
         DM4bkbkCwxT4LRva1gUMPt7/rM6koEQVJhs7qtVU3wZtE5EErWy6BFczc0R862U2T7jh
         oOhhXPYd9CKq5oLNtr6V5pPW4ohm16EMBPNMcjK6eD8vHxJqQtRvP3bekIBpzvHFewX3
         QC1ZLmZgl1rvNCTCSEK3PqxuF4/NChuV0FokV8RNZU81eSzbzZiKeJseqlNpwSG3idxp
         LIOA==
X-Gm-Message-State: AOAM532yrnwsBCRQJmqg/ZntCq57PaopXw7GofzgAz5Bc3aj0VvHF2kB
        IhISFeWm9FcLOMyXAWYMD6MZlmtZ3AZTtw==
X-Google-Smtp-Source: ABdhPJxygZu+ByZT7nW1jMCQR7YyGPBM5Piz3zZ0E0yfqb4jyoiTszMwnniaRixAODm7DF4PyBGVdQ==
X-Received: by 2002:a05:600c:511d:: with SMTP id o29mr16439288wms.0.1624099665054;
        Sat, 19 Jun 2021 03:47:45 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id w8sm10673236wmi.45.2021.06.19.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] staging: rtl8723bs: remove obsolete 5Ghz comments
Date:   Sat, 19 Jun 2021 12:47:19 +0200
Message-Id: <b9863335ffee88e00131744ee455165ea7823278.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete 5Ghz comments.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 --
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c      | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8514cfb3d7e0..427f0b88abd7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -202,8 +202,6 @@ rtw_cfg80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	* there are overlapping channel numbers in 5GHz and 2GHz bands */
 	if (band == NL80211_BAND_2GHZ) {
 		if (chan == 14)
 			return 2484;
diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index 0084589499b9..5eef1d68c6f0 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -44,10 +44,6 @@ static const struct ieee80211_regdomain rtw_regdom_rd = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	 * there are overlapping channel numbers in 5GHz and 2GHz bands
-	 */
-
 	/* NL80211_BAND_2GHZ */
 	if (chan == 14)
 		return 2484;
-- 
2.20.1

