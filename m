Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3A371127
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhECFHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhECFHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:07:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2CC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 22:06:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t22so2870809pgu.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 22:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkwodlzPuswZX36UULvqpGAyXMlhiyqxqgMMR+wsn/g=;
        b=eqOPXZ405QGSAfKdidGpykTin6aOgHrzeqTfYQ4nV3CJHfysaWQhp/2XJDWj+mcrCu
         3MZw3qM5sLPRMaRUEgJAwgPCFTa29MHcr0vqwAg1QcbhffE+Ejzi2bIN9hyVVY3C0YxG
         daeTW64oG6UhfoeyA4ejA/0PMIvicDM9Z4PAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkwodlzPuswZX36UULvqpGAyXMlhiyqxqgMMR+wsn/g=;
        b=sf9eESgCEA/EzpWXgv/0JV8mVp8c05aS2Zsk2u2BSGCQLRLK5PLaMrHTK3HnrA5f9g
         c6mX3Av325gwbeBX9xHOEtCq1L3jLrHTAOKVRk3iQZzbx8hFsbLwdqFmAsjXyKsnvVa+
         LRFMb5fzAVHY20wX/K1U+4wFc1X51pCsJF0n2wHSh5D+tQSqtXApMNzvxdhkO2m66lGa
         zb2s5yAR4up0+XdeywKokOgyWp1c0lXcqaNkIku30JFlW3WUVJCa8Ua5kyH3VHtVHCAj
         GB4it4+LQpQ/6g3ZNRgB+qjMFaELUdrUlTpO/88K7h2v8slj/QjYcvZFWrJuTxKJkG+L
         3DRw==
X-Gm-Message-State: AOAM531udshU/z1SPa7TJGaYyOyfzuZvlBm4Kcke3G/tT2v5nBA9I6QG
        qVdVeXaonpXWWmwEnWTUK03xHQ==
X-Google-Smtp-Source: ABdhPJwrNT9OoQVR40I3+lYvVv4+9nyLd7c3AniqwdJ+4Wlqg7gno9fSObobRVa/3hiZPBFuzewOcA==
X-Received: by 2002:aa7:864b:0:b029:272:947e:85d7 with SMTP id a11-20020aa7864b0000b0290272947e85d7mr16806869pfo.45.1620018372448;
        Sun, 02 May 2021 22:06:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10sm7722053pjy.42.2021.05.02.22.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 22:06:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/radeon: Avoid power table parsing memory leaks
Date:   Sun,  2 May 2021 22:06:08 -0700
Message-Id: <20210503050608.2158996-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503050608.2158996-1-keescook@chromium.org>
References: <20210503050608.2158996-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; g=5587411a193bf9edeee00e4cedc613b3ef4ab595; i=RLpnWS4N4EAN7vS2kSGJsC2/Z1bOXLnXB/5m+ZzGvSQ=; m=pxFMtRfS+5OYF3CVbar6V5LSKxDznZRhhtHzAGrKHyk=; p=Y3P6ZdBpqNetVNCsZST5lNppgqyKAxbk7rqUPN2j2Rg=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCPhL8ACgkQiXL039xtwCY2zRAAqlP BnaPQIK2UkL4N+J8Uhn6rf1DwF1TCalirs9jwqPngXwYss6neOBwTG0T//WVb9QMr3BjtjbB3El+Q kJLWL+uRdkGC5WGVTTxB1Rt7CBODIQeVjpm2B8sxORQusgnG88c8xZD4i3Jn90st/270iUG+TWd7o sclb7HBIRr8pwjmqUeWNq5RjdJ069jrLmTJsn6xJUd+q/Hb4APCe9u3NrltjK8dPgwgv2q951nhk2 jwP+1ToRJR5x4OISD9QGGGQsZ+AeJMOlQLzW0IDfONECA2/l6oiOz5PgaGJWIwzlrrxcmBIG6GfUr O8WfnoP147xN3CMVemI3aSR5Xxs2umK8vElvriITY2OGGE8WQ6ar/sE56bYQISGnWDfHT3MKhLDYU fnZO0AaZTvkXpP/iReTJfWb9yLsIXVz1QkbxQ8QfI00RLaU3rLpSAmNxgtWZbe09+sbgsifNbzKaN pa2FarA6u9sKQ+PeJi9LtsbVXQarDp4C97vxj+ZFDIo9FSrjEL1pzlQSo4amuKBvKbkRBfRKXCygd rafoxsTZjaFTlS1PycdtphI2NGWAndJKDOIw/dS3ixkPykFEJ+3mP/3Nf/qMOXyuu0KyKxs5MnrAc fzYxUrpYMH74s2EiOc/0ZSZBxFewKhTTy0F04ZfI3kF4GKndUDNE19uUpYJdiz6w=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid leaving a hanging pre-allocated clock_info if last mode is
invalid, and avoid heap corruption if no valid modes are found.

Fixes: 6991b8f2a319 ("drm/radeon/kms: fix segfault in pm rework")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index f9f4efa1738c..28c4413f4dc8 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -2120,11 +2120,14 @@ static int radeon_atombios_parse_power_table_1_3(struct radeon_device *rdev)
 		return state_index;
 	/* last mode is usually default, array is low to high */
 	for (i = 0; i < num_modes; i++) {
-		rdev->pm.power_state[state_index].clock_info =
-			kcalloc(1, sizeof(struct radeon_pm_clock_info),
-				GFP_KERNEL);
+		/* avoid memory leaks from invalid modes or unknown frev. */
+		if (!rdev->pm.power_state[state_index].clock_info) {
+			rdev->pm.power_state[state_index].clock_info =
+				kzalloc(sizeof(struct radeon_pm_clock_info),
+					GFP_KERNEL);
+		}
 		if (!rdev->pm.power_state[state_index].clock_info)
-			return state_index;
+			goto out;
 		rdev->pm.power_state[state_index].num_clock_modes = 1;
 		rdev->pm.power_state[state_index].clock_info[0].voltage.type = VOLTAGE_NONE;
 		switch (frev) {
@@ -2243,8 +2246,15 @@ static int radeon_atombios_parse_power_table_1_3(struct radeon_device *rdev)
 			break;
 		}
 	}
+out:
+	/* free any unused clock_info allocation. */
+	if (state_index && state_index < num_modes) {
+		kfree(rdev->pm.power_state[state_index].clock_info);
+		rdev->pm.power_state[state_index].clock_info = NULL;
+	}
+
 	/* last mode is usually default */
-	if (rdev->pm.default_power_state_index == -1) {
+	if (state_index && rdev->pm.default_power_state_index == -1) {
 		rdev->pm.power_state[state_index - 1].type =
 			POWER_STATE_TYPE_DEFAULT;
 		rdev->pm.default_power_state_index = state_index - 1;
-- 
2.25.1

