Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56B63C77B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhGMUSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:18:37 -0400
Received: from dliviu.plus.com ([80.229.23.120]:40030 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhGMUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:18:36 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 16:18:36 EDT
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 2673D4119B03;
        Tue, 13 Jul 2021 21:10:35 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Tue, 13 Jul 2021 21:10:35 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH] drm/amd/display: Fix 10bit 4K display on CIK GPUs
Date:   Tue, 13 Jul 2021 21:10:19 +0100
Message-Id: <20210713201019.59107-1-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at
30bpp for DCE-11.0.") doesn't seems to have fixed 10bit 4K rendering over
DisplayPort for CIK GPUs. On my machine with a HAWAII GPU I get a broken
image that looks like it has an effective resolution of 1920x1080 but
scaled up in an irregular way. Reverting the commit or applying this
patch fixes the problem on v5.14-rc1.

Fixes: 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at 30bpp for DCE-11.0.")
Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a6a67244a322e..1596f6b7fed7c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1062,7 +1062,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	 * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
 	 * did not show such problems, so this seems to be the exception.
 	 */
-	if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
+	if (plane_state->ctx->dce_version > DCE_VERSION_11_0)
 		pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
 	else
 		pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
-- 
2.32.0

