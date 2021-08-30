Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115943FB5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhH3MQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbhH3MQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B973C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so9301163wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAHgeCZ2aQN7mfS6aEnntPuA7ia/SDZIlFdYCZ9jF4o=;
        b=kiOUuvFAE0zvKJUtpB1jRnJhlpN8+Mx117LfzLHszz8bVF0ElSLgSAJIykgWJsYEO/
         eNxDxkIpL7HkxFZyp+pzNwUzaEJ7s735RQdi68Xh6FoiV+cMenaE1mWn/FAk7QTR/qTT
         rENofRCCsavYJR0j4UCjsTTcHYI54Pj+m+ME74kbFXDEu9pHP1wKkb9oe6zh1JtwWahQ
         JKzJZC9gw2eqGHuH8AeOGBE/6YJDKf/pbB+DByuBvNQNYklFvo8BOTxgXFtiAeexoBmH
         ikc8a1WdLlnNVdGudQs4H7aNTLc+zYvCrN7Unh5dROYv0Bz9meMG/ZLYHeHTwTbOGeq/
         dnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAHgeCZ2aQN7mfS6aEnntPuA7ia/SDZIlFdYCZ9jF4o=;
        b=uO7APiI3hc9nDL2Zvdn+kIeZjpBIjokdB0qiSN7Eqen4ObxydRXK1dr+SAYT6LNsvy
         PEuqHNtNLjkiTd1386ZEX+4BNMayRf0doHJHYgNF0aKraIE225epk3V/XsJ1VI6/rc7u
         /ybfVVVsGwk/7O8Tx2iFCdeLAoE15QOYoZQ6q35l8i/HAteVndJTsIrVKij5VR3xW3P8
         899K2tt2rbGR01ZnrPMEh2LCSAknVhtHil2BFORucXP+Ejo9epbHGvH5zPt6iHlmtDvo
         i4XRFL2P3RZUlX15TbPk0AV+U0kpw9Xflvailbzdml+Rrn4KRJe255Epd4a5OeNJN738
         8DkA==
X-Gm-Message-State: AOAM5325ErHA5EYB2j6vjYjjIMSBg7ls9OHWpBLMgJcOt8LbW2I8GsRw
        y0Fz241THop6G+Hel6ZFpR4=
X-Google-Smtp-Source: ABdhPJzunjo29uR0UqAwHv1j3hhBU+S59KbcNnj9PklJ/MCcBUGRianH1LT+J4ZOtdakyjDAhLMElA==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr26850417wmr.28.1630325741867;
        Mon, 30 Aug 2021 05:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/8] staging: r8188eu: use mac_pton() in rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:15:01 +0200
Message-Id: <20210830121508.6411-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a custom approach use mac_pton() to convert the mac
address string. With mac_pton() the driver also validates the
input now.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index b3a74198596a..205798b76cf9 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1024,13 +1024,11 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 	if (!mac_addr)
 		return;
 
-	if (rtw_initmac) {	/* Users specify the mac address */
-		int jj, kk;
-
-		for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
-			mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
+	if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
+		/* Users specify the mac address */
 		memcpy(mac_addr, mac, ETH_ALEN);
-	} else {	/* Use the mac address stored in the Efuse */
+	} else {
+		/* Use the mac address stored in the Efuse */
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-- 
2.33.0

