Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA842C3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhJMOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJMOom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 563DD61165;
        Wed, 13 Oct 2021 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136159;
        bh=qtuN71F2mOeUcWHCNSmjSBO9j7CrGEvPuhdVjbtcEXM=;
        h=From:To:Cc:Subject:Date:From;
        b=PppLkcWhmQMcUsDDMZNYA8XJrYgHKJLduHy/K88ME/Rl7/Oy6OzjH1AXPu8ZGw1rx
         U/K90vZksfK4Vr7V+9fO7RiAAIRIYIPBg/7OwnQdtoT/vv1r+u7CnY1zngjfUdmUoh
         LvJpTK6Ho9VhFrlRg8RlPQ6XUQzfnH62rEFbAemXw4Oao2Ai1Jlpj5qigFo/2/95Eq
         7dIm4kCpSm4wSG/08bDTshWYW1H7En6dS/Yj0m7IlA/Phwlc/K5NtPnaGz/H2/97ku
         Il7tXcn4HoL6PpUHaxfVPp0bnviOI26xIfuNQf5Obak5VhxTZuYyFbFEm+W1W4TW6K
         e6JAOmADkm6Vg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Jaehyun Chung <jaehyun.chung@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Felipe <Felipe.Clark@amd.com>, Felipe Clark <felclark@amd.com>,
        Derek Lai <Derek.Lai@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix apply_degamma_for_user_regamma() warning
Date:   Wed, 13 Oct 2021 16:42:07 +0200
Message-Id: <20211013144234.2224358-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It appears that the wrong argument was removed in this call:

drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c: In function 'apply_degamma_for_user_regamma':
drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1694:36: error: implicit conversion from 'enum <anonymous>' to 'enum dc_transfer_func_predefined' [-Werror=enum-conversion]
 1694 |         build_coefficients(&coeff, true);

Fixes: 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 64a38f08f497..4cb6617059ae 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1691,7 +1691,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, true);
+	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.29.2

