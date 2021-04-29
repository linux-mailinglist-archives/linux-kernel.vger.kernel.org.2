Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901FE36E338
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhD2CXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:23:37 -0400
Received: from mail-m176218.qiye.163.com ([59.111.176.218]:29114 "EHLO
        mail-m176218.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2CXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:23:35 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 22:23:34 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m176218.qiye.163.com (Hmail) with ESMTPA id 71C04320154;
        Thu, 29 Apr 2021 10:13:30 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/i915: Use might_alloc()
Date:   Wed, 28 Apr 2021 19:13:27 -0700
Message-Id: <20210429021327.57944-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUweT1YdTk8eTEMeGU0dGEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6PQw4Sz8PDkkSOh8eECEf
        GTQaCh5VSlVKTUpCTU1JT0pLQkxDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFKQ0lINwY+
X-HM-Tid: 0a791b671397d978kuws71c04320154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This maybe uses lockdep through the fs_reclaim annotations.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/i915/i915_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 9165971c3c47..7e1aa540aa0d 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -928,7 +928,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp)
 	u32 seqno;
 	int ret;
 
-	might_sleep_if(gfpflags_allow_blocking(gfp));
+	might_alloc(gfp);
 
 	/* Check that the caller provided an already pinned context */
 	__intel_context_pin(ce);
-- 
2.31.0

