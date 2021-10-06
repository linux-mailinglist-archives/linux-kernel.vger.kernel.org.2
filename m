Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE934235D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhJFCbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:31:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:29:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 66so1084680pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz7y3ippQxa0H/IuFAdDEK40pN2B6QfqrRhf4vYPERM=;
        b=KBrSWdbI3+9YUBiU1Raqd+E73k5fETH6Wx8MhhYZlxXEarCjM3eOnFSkqoNTh3+iPr
         vTmlT9oGQNCFKIwrHDD/qAfjiYDZnMIVUgVS8X43EmPExAvS9/qtJPAwTC+wuJdYJSAd
         v8J2PfuDNk47zupaLUfcVAbaJWg+4esUpQFMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz7y3ippQxa0H/IuFAdDEK40pN2B6QfqrRhf4vYPERM=;
        b=QHVEnZkbNGclNQtp18a9PupuV6Uf2C2FEJpxAvSxbBwyKblcuo2i/N40M28UXjMn93
         ibzg1hNuvf9K1LX4TMPUSAJRaVF52uoPU6gSO+xRnMf3Uzg9xwwUiJf/wUDH3ECzeQg5
         GpS20ZREZycKiRF6a5pSsndP1/V0SMVHBSbqccWcdBnMlVdwoeR2TjJ9GqmaKr3k7nQ3
         VDeQ/a72hEH7zgRh9dDEAbhYUnvXFQrcw5+oDWzRZ0wpTtjwWVahJUXwcPbgX6bKeQma
         ZDwPGOig+PHbUvR35m/JBah4Ho6l4ZlXbT7Ap70NezKWxGZM/GJGeusAnQ6pmRxVvsFI
         hfCQ==
X-Gm-Message-State: AOAM532YuQk5Y3Tt+JQ7bKuCVelAhHP9eMSCxZbSi+K5JXLYzocvvUfg
        sAIKNmXq1bvXI7AmktBI4teOLsEV8VpVtw==
X-Google-Smtp-Source: ABdhPJz6xXzmXTGDKz/phC2NPCwms3/AsNl+Pj68f7tGHPEunhH0H+DHQZgn79rCUGho/WJx2PkiiA==
X-Received: by 2002:aa7:9d0b:0:b0:44c:62a6:8679 with SMTP id k11-20020aa79d0b000000b0044c62a68679mr13809829pfp.0.1633487369108;
        Tue, 05 Oct 2021 19:29:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:68e6:d130:478e:edbd])
        by smtp.gmail.com with ESMTPSA id z4sm19497744pfz.99.2021.10.05.19.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 19:29:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Rodrigo.Siqueira@amd.com, Jerry.Zuo@amd.com,
        alexander.deucher@amd.com, Harry.Wentland@amd.com,
        khsieh@codeaurora.org, ville.syrjala@linux.intel.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/edid: In connector_bad_edid() cap num_of_ext by num_blocks read
Date:   Tue,  5 Oct 2021 19:29:08 -0700
Message-Id: <20211005192905.v2.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid
corruption test") the function connector_bad_edid() started assuming
that the memory for the EDID passed to it was big enough to hold
`edid[0x7e] + 1` blocks of data (1 extra for the base block). It
completely ignored the fact that the function was passed `num_blocks`
which indicated how much memory had been allocated for the EDID.

Let's fix this by adding a bounds check.

This is important for handling the case where there's an error in the
first block of the EDID. In that case we will call
connector_bad_edid() without having re-allocated memory based on
`edid[0x7e]`.

Fixes: e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid corruption test")
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
This problem report came up in the context of a patch I sent out [1]
and this is my attempt at a fix. The problem predates my patch,
though. I don't personally know anything about DP compliance testing
and what should be happening here, nor do I apparently have any
hardware that actually reports a bad EDID. Thus this is just compile
tested. I'm hoping that someone here can test this and make sure it
seems OK to them.

Changes in v2:
- Added a comment/changed math to help make it easier to grok.

 drivers/gpu/drm/drm_edid.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 9c9463ec5465..0383d97c306f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1840,11 +1840,20 @@ static void connector_bad_edid(struct drm_connector *connector,
 			       u8 *edid, int num_blocks)
 {
 	int i;
-	u8 num_of_ext = edid[0x7e];
+	u8 last_block;
+
+	/*
+	 * 0x7e in the EDID is the number of extension blocks. The EDID
+	 * is 1 (base block) + num_ext_blocks big. That means we can think
+	 * of 0x7e in the EDID of the _index_ of the last block in the
+	 * combined chunk of memory.
+	 */
+	last_block = edid[0x7e];
 
 	/* Calculate real checksum for the last edid extension block data */
-	connector->real_edid_checksum =
-		drm_edid_block_checksum(edid + num_of_ext * EDID_LENGTH);
+	if (last_block < num_blocks)
+		connector->real_edid_checksum =
+			drm_edid_block_checksum(edid + last_block * EDID_LENGTH);
 
 	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
 		return;
-- 
2.33.0.800.g4c38ced690-goog

