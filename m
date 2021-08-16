Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611723ED36F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHPL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhHPL4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:56:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BA7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:56:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x10so16891647wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2xGLfnPPWqf54A6afov/9HyHzSrHz7FHYNX1qYDG/8=;
        b=bvcRXoUpV0tyWRQHkCxXBGYcQuP9++d0ETBCxp2QzTQj1pOL3mhLrPNlSOpyQ9ws4P
         clpObso0ZzlzAzPXmiGeDJ2v3w1CroSfc2j7BCe8X/K2C1p5Brw0tLIm3GKV5F3pRqRe
         uhiq+65lqO1puBb5r/s9S9D9zwbl1vLilwzbWRONuQjdJh54N0n7+E/gVwUzLHhcxsX+
         J6HhSVOz+8pH8fW2pCWmpi3hKXDI/LLN17+ey0xAcoT66Od99ajMSg71g74l6zOnec37
         rsR+wUhSgsOML0V7WEnQ8qE/UZW4s7GZkNnLcAKnJooyu5G2aW5Hcxo30iMkqWtM2YmG
         Xy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2xGLfnPPWqf54A6afov/9HyHzSrHz7FHYNX1qYDG/8=;
        b=RVL2LUZicNXYffvDtLWjAknKRAs7aKFctR3KHX1+D8NtF+PQNtOwDZNfz4bg3Jknp9
         ASh95Ar4SgDiq8jL4GZLF/srTyhPP5O7cPELScQ6cfkHaGNmr249MbaWllXQbgUNH3/s
         mB2mgTHvjaUphNirV/ZIrTiEYMSt6aEgbYL+Lk4yD7iXk86avZDHWSTmM7SJBwDHVQM6
         fHlB1s1tCtXDXNCi7dYKuyLfKy2aQ1IcY/7j5mC4+UsSh2YgZradS6aNIHgE24IMYklR
         Dbcvb0LzxPV8GX+tiXTE8JzwforImPmm9QDn96iAIpQMiAtqRmV7/P+gxqD5wBy8cufM
         T2cw==
X-Gm-Message-State: AOAM533UrfxZvWZTuXWUlwq3xThGC+q2ZSIH+tmGAj88t9FejMDC6Aw2
        fDdx62s9aPFtmTRnD8xmF1I=
X-Google-Smtp-Source: ABdhPJzRoO7OxaZuMnIs1lR/oYUcvVZVP3Y1tkFoIbWgvTFojB6bsitGNLJsu0DGc/wMdXHXg1X6vQ==
X-Received: by 2002:a5d:694f:: with SMTP id r15mr17841148wrw.86.1629114978987;
        Mon, 16 Aug 2021 04:56:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id i8sm8397107wrv.70.2021.08.16.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:56:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/4] staging: r8188eu: refactor rtw_is_cckrates_included()
Date:   Mon, 16 Aug 2021 13:54:27 +0200
Message-Id: <20210816115430.28264-1-straube.linux@gmail.com>
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
v1 -> v2
Refactored to more compact code as suggested by Joe Perches.

 drivers/staging/r8188eu/core/rtw_ieee80211.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 0c7231cefdda..964255a8c778 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -70,14 +70,13 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 
 uint	rtw_is_cckrates_included(u8 *rate)
 {
-	u32	i = 0;
+	u8 r;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+	while ((r = *rate++ & 0x7f)) {
+		if (r == 2 || r == 4 || r == 11 || r == 22)
 			return true;
-		i++;
 	}
+
 	return false;
 }
 
-- 
2.32.0

