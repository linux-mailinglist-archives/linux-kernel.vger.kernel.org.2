Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28728367393
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbhDUTna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhDUTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:43:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so42474050wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prbsc0FyNObzI+Wvj3P6FznlVAvE0zjRobacKBhitVA=;
        b=TA1TfJKHBEZIrBxpR53G5eOoISpEKxuSiMYvlHmHfvOn4KpnIsZBkWt5u5KBadT55G
         emnfZBDEEgeVmcit93tfkq3uOvwyIJreSWA0P4Y2NIJtZqiNbchrNomB+73rdUxKUwJD
         igfT4UVzD3jPXClgg/1jrNpgORohlP3faxxKubgEUa69hKZw9ptqE8SBB0z3KnZvJrbG
         GXSTFs2NAHSZ1+zE85j4+sqo63rTL2JmFsoyGdDiTnSE+1zawQe91Ivnqfn4S2jFMdxp
         cepJ1VAnZk4MBzvN3JOAOVJhZ77zsDUFPl8i5QXdEdzCDRA90HU4+kYWcJeEq/vrDpvL
         jb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prbsc0FyNObzI+Wvj3P6FznlVAvE0zjRobacKBhitVA=;
        b=GMLjZd+n7MVCBREJzO1SR0PnZpmqLMBuMBGqvCBJqlda+aT+7IM76EQANMJlbAdh26
         37k0e7pSIlIiTuFpNKzI7/7aWqjcBcgI3ZKgHL52Y+r9pWRgAdIP2rJbZ66/BRFzo4Ug
         JB6sdizwe1qItKTymhFELaUZRezQZf2c2Jwg//UVn9K5k+t8TPGxLJhyVeilTLkTi7Oe
         ddwAdtyW6uRkr9IGGV7TbKXTz3cIFvpb6Yw5Z/1zCGawVc7LKu9KMGd9ZYsgKyf5oOwr
         V+vIBwkvbyRg0imtH60tQD2BX6Of7S+mM9s1v9YXPTF8N4APBb7clIXmt0cx+Gs5aq3L
         OTGg==
X-Gm-Message-State: AOAM531T9pNQVfEc731+jcYqBDkKVHpNzc8yNxyGPRntGmpuazwuCZKJ
        JZ1Ab1fePH9CfV2Qflyh/aA=
X-Google-Smtp-Source: ABdhPJx6yLbiq5abH25qv20sKnGJQ9F1yfiFlHebIXRV8dHW84eJQOMVJKyF3fMyuhKVZ9695EzjGQ==
X-Received: by 2002:adf:d0c8:: with SMTP id z8mr29435342wrh.68.1619034173663;
        Wed, 21 Apr 2021 12:42:53 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id o4sm484163wrn.81.2021.04.21.12.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:42:53 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 1/3] drm: drm_atomic_uapi.c: Use tabs for code indents
Date:   Wed, 21 Apr 2021 20:42:47 +0100
Message-Id: <dc8286f5590fff609f924845fb622dd5f962a11b.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove space and use tabs for indent the code to follow the
Linux kernel coding conventions.
Problem found by checkpatch.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 268bb69c2e2f..438e9585b225 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -78,8 +78,8 @@ int drm_atomic_set_mode_for_crtc(struct drm_crtc_state *state,
 		drm_mode_convert_to_umode(&umode, mode);
 		state->mode_blob =
 			drm_property_create_blob(state->crtc->dev,
-		                                 sizeof(umode),
-		                                 &umode);
+						 sizeof(umode),
+						 &umode);
 		if (IS_ERR(state->mode_blob))
 			return PTR_ERR(state->mode_blob);
 
@@ -114,7 +114,7 @@ EXPORT_SYMBOL(drm_atomic_set_mode_for_crtc);
  * Zero on success, error code on failure. Cannot return -EDEADLK.
  */
 int drm_atomic_set_mode_prop_for_crtc(struct drm_crtc_state *state,
-                                      struct drm_property_blob *blob)
+				      struct drm_property_blob *blob)
 {
 	struct drm_crtc *crtc = state->crtc;
 
-- 
2.25.1

