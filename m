Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA12377A68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhEJDOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:14:04 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:39324 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhEJDOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:14:01 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 475DEE01DC;
        Mon, 10 May 2021 11:12:55 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bernard Zhao <bernard@vivo.com>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: fix warning "using plain integer as NULL pointer"
Date:   Sun,  9 May 2021 20:12:27 -0700
Message-Id: <20210510031250.5303-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx0eHlZMS0pCGUwZGB1CSklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCI6OBw*Lz8TDT8rDxkvTBUX
        SzEKFB1VSlVKTUlLTUpNSExNS05LVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJTExPNwY+
X-HM-Tid: 0a7954436d742c17kusn475dee01dc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1195:41: warning: Using plain integer as NULL pointer
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1348:32: warning: Using plain integer as NULL pointer

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index df7f3d3afd8b..cc5cceae80f4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1196,7 +1196,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
 		if (DPU_FORMAT_IS_YUV(fmt))
 			_dpu_plane_setup_csc(pdpu);
 		else
-			pdpu->csc_ptr = 0;
+			pdpu->csc_ptr = NULL;
 	}
 
 	_dpu_plane_set_qos_lut(plane, fb);
@@ -1349,7 +1349,7 @@ static void dpu_plane_reset(struct drm_plane *plane)
 	/* remove previous state, if present */
 	if (plane->state) {
 		dpu_plane_destroy_state(plane, plane->state);
-		plane->state = 0;
+		plane->state = NULL;
 	}
 
 	pstate = kzalloc(sizeof(*pstate), GFP_KERNEL);
-- 
2.31.0

