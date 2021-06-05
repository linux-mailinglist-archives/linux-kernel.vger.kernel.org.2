Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BBC39C827
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFEMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:33:29 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:47144 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:33:28 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 3D8DF380100;
        Sat,  5 Jun 2021 20:31:39 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Solomon Chiu <solomon.chiu@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Daniel Kolesa <daniel@octaforge.org>,
        Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove no need variable
Date:   Sat,  5 Jun 2021 05:30:59 -0700
Message-Id: <20210605123137.8800-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQk0aGVZISBlKGEseSE0fHUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6UTo4Dz8TCQkLIR8KD0NR
        TDQaFBVVSlVKTUlJQ0JNSUJCQ0lCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJQkNPNwY+
X-HM-Tid: 0a79dc284e00d994kuws3d8df380100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove no need variable, just return the DC_OK

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index f962b905e79e..7daadb6a5233 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1266,8 +1266,6 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 
 static enum dc_status dcn10_patch_unknown_plane_state(struct dc_plane_state *plane_state)
 {
-	enum dc_status result = DC_OK;
-
 	enum surface_pixel_format surf_pix_format = plane_state->format;
 	unsigned int bpp = resource_pixel_format_to_bpp(surf_pix_format);
 
@@ -1279,7 +1277,7 @@ static enum dc_status dcn10_patch_unknown_plane_state(struct dc_plane_state *pla
 		swizzle = DC_SW_64KB_S;
 
 	plane_state->tiling_info.gfx9.swizzle = swizzle;
-	return result;
+	return DC_OK;
 }
 
 struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
-- 
2.31.0

