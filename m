Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0789422BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhJEPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhJEPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:12:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FEC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:10:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so1187286pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QnKdMD67+rQVIo2b0/8Hr/i0O4OC/30heYtQ6dc/js=;
        b=MWGHadB5myjzG7hi7dEWEPb8pOcALr2pFYDh0ztFd5+60GiynIznraGmKCFLG9e1J/
         60NqPZOBhULuBWXwnucxJ/AWgtP8nKcV9vTLWvlpBYy6FbdRgHG+xKzEJFloyTLEUIs4
         QzOxy+kLAS/LJ3leSqgLOjJlx23/8zJ9MRXAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QnKdMD67+rQVIo2b0/8Hr/i0O4OC/30heYtQ6dc/js=;
        b=esEOGLVSm0jNxj494GtbcucOsNTv0/bxLeaNG/7+wMfNkyXnbRbsaJk2NZOOmUZNsP
         PsGBc65z2Xww3VOSc+uhETXdNTi1TC4DJFjXLKioAMOb9EEB6TUyKJ43S6AlwLj8gavp
         XvtcsHBNs/jAoZ05Z7gZAwqbDmm6b1SXrhtxnu5Vg1iT43e8NMX29lwvR8NclqkmVPBW
         06ErG1MRU8SUQSwrwxwTrjGeMZlaYAsYU57Jw6Hcfs+J+5hPQPIrRteAnJy64wCoj8Vm
         OgZYKmYcPdBeLWSYF5nCYOhQftigEd0rMHbvdv0puUSSb6s0oL/pb3d6tv0WljkJ6PHK
         xT9Q==
X-Gm-Message-State: AOAM531lKJt1DmR5EbIKztZHPpsWIcXSfdWhYmj5rARUG5Yk9D5nivNa
        akSLiXsq7hE6OXuhIZ32EO6iwg==
X-Google-Smtp-Source: ABdhPJzSVCahQti09JKEx8hW7Dg7wwwmo3seeZ5OZCLdMc6jbjcG482M1ZiVw+8V4Fx/bV899Alhjw==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id 12mr4467161pjl.89.1633446657910;
        Tue, 05 Oct 2021 08:10:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:68e6:d130:478e:edbd])
        by smtp.gmail.com with ESMTPSA id a15sm6280000pfg.53.2021.10.05.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:10:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Rodrigo.Siqueira@amd.com, ville.syrjala@linux.intel.com,
        Harry.Wentland@amd.com, khsieh@codeaurora.org, Jerry.Zuo@amd.com,
        alexander.deucher@amd.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: In connector_bad_edid() cap num_of_ext by num_blocks read
Date:   Tue,  5 Oct 2021 08:10:28 -0700
Message-Id: <20211005081022.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid>
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
---
This problem report came up in the context of a patch I sent out [1]
and this is my attempt at a fix. The problem predates my patch,
though. I don't personally know anything about DP compliance testing
and what should be happening here, nor do I apparently have any
hardware that actually reports a bad EDID. Thus this is just compile
tested. I'm hoping that someone here can test this and make sure it
seems OK to them.

 drivers/gpu/drm/drm_edid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 9b19eee0e1b4..ccfa08631c57 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1843,8 +1843,9 @@ static void connector_bad_edid(struct drm_connector *connector,
 	u8 num_of_ext = edid[0x7e];
 
 	/* Calculate real checksum for the last edid extension block data */
-	connector->real_edid_checksum =
-		drm_edid_block_checksum(edid + num_of_ext * EDID_LENGTH);
+	if (num_of_ext <= num_blocks - 1)
+		connector->real_edid_checksum =
+			drm_edid_block_checksum(edid + num_of_ext * EDID_LENGTH);
 
 	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
 		return;
-- 
2.33.0.800.g4c38ced690-goog

