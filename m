Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E13479EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhCXNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhCXNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:48:47 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1188C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:48:47 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g20so18003379qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iyE9OqAjQZg/OzYxknxNdb9tDwATqAe8JxpLJvUVtw=;
        b=BcgI9394uPGMaOnLshwgOzLKCyg1UQgyona4sTBOljxtro6giwVYeoYVfucB6WeGrE
         ueEO2nr4BT7j73Mf8Oj1hbnQbYWdy/5hw3fN4segKfZ9i1ilN7PzqIVFR0cqWmZ9d3CS
         lleqAu5YZKOHe5ahkvSgyaBk+fz3YGCaXtgAj8tLjShzcgvC4awHI8wXQ4XvUHHby02C
         gmGaxzNR4Qslga8xBfsfU6S5ARnty5VItgr56mtG725GX+kjEpXfJY9Glkm9NO3Bn/+d
         KdhqhuDeKyxaCimhBB8qdT0zva/MVqUGQK3gCnJY/dRUjXH240GCM2Acmmw95wSstc6h
         aZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iyE9OqAjQZg/OzYxknxNdb9tDwATqAe8JxpLJvUVtw=;
        b=RTlERoPiFz11sf20ykIhwIDnHNbDNKSspPp48J6luEZtdFW403Lf6MCPFuECcrPwyp
         tNJFXpTWgXaPdrxSolhZvDQEc9JadUBrHurD22bsoifhxU3+0SHQVvtiJLdEcFDQyKi3
         Fhosj5Ab3QLlUwUvIAHxDx3U1lBjmI6y8ZBDQVfV/IbpqVjkZWubFG5fQTphaFcrHq05
         aH2cB0IvmOIAWHpd9K2kk0TwbVr3nTs4xB/VAxLpC1jr0k1RsCGuznTkVxt3nCIX9MTT
         s/u5uD6P8eQCP8bpTkfMJVQQkfcmx4fYY7tutVo9+QaC42g2vTItKz2TVvSAR60s7PvL
         lPOA==
X-Gm-Message-State: AOAM5303f1rKC31rLKzob9oKL1eK4p1+MkL7kUuGdV8kvKIVxQ+Ubuqx
        qPohrmlHofhjz7TyD2iSISRVfqTKIyDXJG/M
X-Google-Smtp-Source: ABdhPJwmWigcrxAN4YFNnDUNCapP3mlwg7uTwWBcNkPMJT3NLKnoQoRpFLP1JTLi4vJ/bIvre85Vag==
X-Received: by 2002:a37:46c5:: with SMTP id t188mr3219408qka.47.1616593726965;
        Wed, 24 Mar 2021 06:48:46 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.36.138])
        by smtp.gmail.com with ESMTPSA id a14sm1746068qkc.47.2021.03.24.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:48:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm/radeon/r600_cs: Couple of typo fixes
Date:   Wed, 24 Mar 2021 19:20:26 +0530
Message-Id: <20210324135026.3540-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/miror/mirror/
s/needind/needing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 34b7c6f16479..aded1f2264e0 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -38,7 +38,7 @@ extern void r600_cs_legacy_get_tiling_conf(struct drm_device *dev, u32 *npipes,


 struct r600_cs_track {
-	/* configuration we miror so that we use same code btw kms/ums */
+	/* configuration we mirror so that we use same code btw kms/ums */
 	u32			group_size;
 	u32			nbanks;
 	u32			npipes;
@@ -963,7 +963,7 @@ static int r600_cs_parse_packet0(struct radeon_cs_parser *p,
  *
  * This function will test against r600_reg_safe_bm and return 0
  * if register is safe. If register is not flag as safe this function
- * will test it against a list of register needind special handling.
+ * will test it against a list of register needing special handling.
  */
 static int r600_cs_check_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 {
--
2.30.1

