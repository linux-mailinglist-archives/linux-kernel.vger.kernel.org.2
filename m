Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C013ED371
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhHPL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhHPL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:56:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E822C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:56:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so6076246wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agGKHzXwsFX9a4EiFCXgJQ425GBEK8BAre8y2mUmDZ4=;
        b=aBL+60Vd+Kc2YWVqZyk5e+wengD/6Vy9lfWKWfJ5dUf2P305UmeyXmAqOvovXUk7X3
         FPO+jIwvzgMGFNx5B5R8ICOq0e439hgT8mAZ38uOflWmcupckxeec9uwJ6sAwMBiktie
         ukq/porwWp6wxBicYz4C73iIVo5U2Fx6ga52XMzTUbNtqw2SkdCg0aK+lAK9ZAYoQy1h
         qTOQAIlfvndF2qGWpG6YptTpgC89nU6M0tJwDB81R/BBMMFamwPFud0gstsuZbH08GhH
         +FYnJCIqzIzVmBvxTdmmvVihy7KKIdevUBGXKAv/DKOVMrEyyZWNFgms1dRSJ7gGG1Gr
         0WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agGKHzXwsFX9a4EiFCXgJQ425GBEK8BAre8y2mUmDZ4=;
        b=TXdkT5JLo0ErDUV95fUPRXM9dDhLQUr0fhliWJvKa9ql9hNFRLQ3Y0EANG/n8Rau3T
         ejqulMqVI6ibhFqWFrRl4f70S5l9Tj6iPBuM+JlYS6pZ5KXeZqGNo7Tn14LGLXBvPCuK
         fHZU3BEv4PmziRDa/MJVqEuOIU7GJugTYwBVIVGRZjpDQBbF0hKMhNwaLNk51voLRC8y
         1394jp1sP44xccfHYyjKJAzCdwMC1uzrPaoNNHgFXoYCNn/c8HOmsSz4NVlK3HbszeM+
         BoCYTs7YHIaQH90zw7djkSQGpf2JpqSwuyXzbLXF8eOWt1NU8DY8xG1z+/Tbps3PA6/h
         JRUA==
X-Gm-Message-State: AOAM533X8mIMXj+M23Ut4RSm5TFenh4n5h4ykc749BYvTEOsjCw0dLes
        DdXGPNywk9xSSQkUV8Kcduc=
X-Google-Smtp-Source: ABdhPJzkONR7lKqf/HSdp4DMrb00viVhYPq2RH77SbQ3eHpruUbeG+Rrk1o0vS2mQH8XgRiI/iPAQA==
X-Received: by 2002:adf:ea49:: with SMTP id j9mr11903642wrn.340.1629114981779;
        Mon, 16 Aug 2021 04:56:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id i8sm8397107wrv.70.2021.08.16.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:56:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/4] staging: r8188eu: refactor rtw_is_cckratesonly_included()
Date:   Mon, 16 Aug 2021 13:54:29 +0200
Message-Id: <20210816115430.28264-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816115430.28264-1-straube.linux@gmail.com>
References: <20210816115430.28264-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rtw_is_cckratesonly_included(). Improves readability
and slightly reduces object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Refactored to more compact code as suggested by Joe Perches.

 drivers/staging/r8188eu/core/rtw_ieee80211.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 53556f1af425..b1427e70cdf7 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -82,13 +82,11 @@ bool rtw_is_cckrates_included(u8 *rate)
 
 uint	rtw_is_cckratesonly_included(u8 *rate)
 {
-	u32 i = 0;
+	u8 r;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+	while ((r = *rate++ & 0x7f)) {
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
-		i++;
 	}
 
 	return true;
-- 
2.32.0

