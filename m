Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79822375309
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhEFLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:30:55 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:20042 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhEFLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:30:52 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 9AE4DC201B5;
        Thu,  6 May 2021 19:29:51 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm/gma500: update comment of psb_spank()
Date:   Thu,  6 May 2021 19:28:51 +0800
Message-Id: <20210506112851.20315-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkhPH1ZMHk1OTB5JTEhMTkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6Fgw5Cz8PPEI5FjNMMTI5
        Nw8KC0lVSlVKTUlLSEtLTkJJSUlLVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0pINwY+
X-HM-Tid: 0a794170f2c9d976kuws9ae4dc201b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 5c209d8056b9 ("drm/gma500: psb_spank() doesn't need it's
own file"), accel_2d.c was deleted and psb_spank() was moved into
psb_drv.c. Fix the comment here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/gma500/psb_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 49afa577d442..d6e7c2c2c947 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -646,7 +646,7 @@ extern u32 psb_get_vblank_counter(struct drm_crtc *crtc);
 extern int psbfb_probed(struct drm_device *dev);
 extern int psbfb_remove(struct drm_device *dev,
 			struct drm_framebuffer *fb);
-/* accel_2d.c */
+/* psb_drv.c */
 extern void psb_spank(struct drm_psb_private *dev_priv);
 
 /* psb_reset.c */
-- 
2.25.1

