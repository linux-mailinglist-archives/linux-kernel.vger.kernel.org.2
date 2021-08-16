Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E183ED179
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhHPKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhHPKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:00:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E9C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u15so11193394wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Numga2hqtD01622lT/5bjEpXP8+Om7SgZ96+WGsQTRk=;
        b=ZHE7l0A/jC1ogN8tUXdtbzpjmzb228cQYd9kyxVufzH1FDPNdeJxzpId5+Ce2e+vaV
         4/rpREGlOYwgAB2boHXyUvOgilOJQBT07cegirefHAm7YTEPwAdOY4MjAtzo07aDYSof
         H4DVlRAoR3DidXoXh4B2/tV3qi8Cgf00yiwWQwCroBGVALojCVFJt46voQ6v6yLKpesD
         v8iKqP41S9hrlpF8d1O8ErAq/sH5wGo5fh82hyIVfyD6iwPLPTwPOb+36ez+64c68LAb
         IGBETucBOIADKTAdfT4d8/+/eesEtIOjynj5QoueLpHvZjxVnZRkqJen4d+tHbnZswn2
         BiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Numga2hqtD01622lT/5bjEpXP8+Om7SgZ96+WGsQTRk=;
        b=K4ohukIf9TXmnS1anfp5OkRSR5tHzxHxD/1ks42SOSWHEYKRHhbkK9WihDVovm9mT7
         d5ogBVCtRL5P7Nq/EDjzho26EhrQchycBCxcGVWrTEsRWPgFUFQFmG2qtay+udEucKsN
         pzWflcjV5A+O51rUn/ggVRZkx7GZ6TIR49nUebFlrZpXV1M5XCDqkV6Ra+MS5t7LO53h
         5vVt/GSdjAJlQGptITgIdhDTmZqQ/sH1UeW4o+SJ5lza9OEDjXp49uoOXXT1rGtzzlzu
         OTGaV/ASYlDNWH2x2jp+Xry7pSwYn+HL21tz107Ia37j+6Uqhzu/u8GvrMQrx9UBQGel
         JvDA==
X-Gm-Message-State: AOAM531QsSLZXjy00vWn8HduRuM7UOPaJl5qh9QBH8xt8ygzl5ZcTdST
        7d+qf1CltGXAlagVBTSGAKNgan+p+/w=
X-Google-Smtp-Source: ABdhPJyIke+MPO0KYbzPWDNTLA1WQFAkQmmAMGGdzdCES3dQA0fa43plOkooJrRHwa27bCxbJG5fcw==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr14383455wmi.176.1629107973356;
        Mon, 16 Aug 2021 02:59:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id g21sm1946635wmk.8.2021.08.16.02.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:59:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: refactor rtw_is_cckrates_included()
Date:   Mon, 16 Aug 2021 11:58:37 +0200
Message-Id: <20210816095840.24259-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rtw_is_cckrates_included(). Improves readability
and slightly reduces object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 0c7231cefdda..beff2ab73a1a 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -70,13 +70,12 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 
 uint	rtw_is_cckrates_included(u8 *rate)
 {
-	u32	i = 0;
+	while (*rate) {
+		u8 r = *rate & 0x7f;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+		if (r == 2 || r == 4 || r == 11 || r == 22)
 			return true;
-		i++;
+		rate++;
 	}
 	return false;
 }
-- 
2.32.0

