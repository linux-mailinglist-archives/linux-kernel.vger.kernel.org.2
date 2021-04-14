Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85D35ECF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbhDNGL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:11:27 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:63129 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhDNGLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:11:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UVWVtYW_1618380657;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWVtYW_1618380657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:11:01 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     linux-graphics-maintainer@vmware.com
Cc:     sroland@vmware.com, zackr@vmware.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/vmwgfx: remove unused variable
Date:   Wed, 14 Apr 2021 14:10:51 +0800
Message-Id: <1618380651-112672-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:456:31: warning: variable ‘vcs’ set
but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9a89f65..9293dc1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -453,10 +453,9 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
 
 	if (!ret && new_fb) {
 		struct drm_crtc *crtc = state->crtc;
-		struct vmw_connector_state *vcs;
 		struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 
-		vcs = vmw_connector_state_to_vcs(du->connector.state);
+		vmw_connector_state_to_vcs(du->connector.state);
 	}
 
 
-- 
1.8.3.1

