Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7244F377393
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhEHSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEHSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 14:21:16 -0400
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B0CC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 11:20:14 -0700 (PDT)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id 0FAFA125A86; Sat,  8 May 2021 20:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1620498008;
        bh=eTcUQwqKOuKmD2QbJtpZOH7NjK31efH/FQy8a+iwiSA=;
        h=From:To:Cc:Subject:Date:From;
        b=K0/O/l0HDupx6iqKphG/jbvhXdPkdoWq7F3G03IJjHZA+y6wuZsieOFnklf5VZzQr
         sGY/8HAuupZyh5nA/b6X4q01GdI+TAZfabvSMDQtLbc3/JvcaU/Rb1F5AKWj6wVoEz
         WRAymVgkkWTea9XRksUcVJe8fA4kG+TtGy4j9Xaw=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:73:702:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 3BE5C125A80;
        Sat,  8 May 2021 20:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1620498003;
        bh=eTcUQwqKOuKmD2QbJtpZOH7NjK31efH/FQy8a+iwiSA=;
        h=From:To:Cc:Subject:Date:From;
        b=bxD2sC729WZWz4PWcg8D6L/D+rFjOl1PK7xdH1Dnxx+IoPpMimiHpPeGSCz9o9Uge
         AJ+QdvQRXxbtUif+1DbkVyBubb8HmQDV/GimrSLtPqsV7nJD+T2usK4aj1yuIUYthX
         AjNSFqwqVBW1aoAqjedKmoOg75HBkThKKNQ8R+JI=
From:   Rouven Czerwinski <rouven@czerwinskis.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@pengutronix.de, Rouven Czerwinski <rouven@czerwinskis.de>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove unused function dc_link_perform_link_training
Date:   Sat,  8 May 2021 20:19:51 +0200
Message-Id: <20210508181951.129548-1-rouven@czerwinskis.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not used anywhere, remove it. It was added in
40dd6bd376a4 ("drm/amd/display: Linux Set/Read link rate and lane count
through debugfs") and moved in fe798de53a7a ("drm/amd/display: Move link
functions from dc to dc_link"), but a user is missing.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 13 -------------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3fb0cebd6938..55c5cf2264b3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3553,19 +3553,6 @@ void dc_link_set_drive_settings(struct dc *dc,
 	dc_link_dp_set_drive_settings(dc->links[i], lt_settings);
 }
 
-void dc_link_perform_link_training(struct dc *dc,
-				   struct dc_link_settings *link_setting,
-				   bool skip_video_pattern)
-{
-	int i;
-
-	for (i = 0; i < dc->link_count; i++)
-		dc_link_dp_perform_link_training(
-			dc->links[i],
-			link_setting,
-			skip_video_pattern);
-}
-
 void dc_link_set_preferred_link_settings(struct dc *dc,
 					 struct dc_link_settings *link_setting,
 					 struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index fc5622ffec3d..45c927cd27ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -363,9 +363,6 @@ bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
 void dc_link_set_drive_settings(struct dc *dc,
 				struct link_training_settings *lt_settings,
 				const struct dc_link *link);
-void dc_link_perform_link_training(struct dc *dc,
-				   struct dc_link_settings *link_setting,
-				   bool skip_video_pattern);
 void dc_link_set_preferred_link_settings(struct dc *dc,
 					 struct dc_link_settings *link_setting,
 					 struct dc_link *link);
-- 
2.31.1

