Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B2359F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhDIMwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:52:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16558 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:52:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGydx5wLDz1BGYF;
        Fri,  9 Apr 2021 20:50:13 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 20:52:16 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH -next] drm/i915/display: remove redundant NULL check
Date:   Fri, 9 Apr 2021 20:51:51 +0800
Message-ID: <20210409125151.9520-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/gpu/drm/i915/display/intel_psr.c:1530:29-31: WARNING
 !A || A && B is equivalent to !A || B

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 32d3d56259c2..4cec6b4d7fb9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1526,8 +1526,7 @@ void intel_psr_wait_for_idle(const struct intel_crtc_state *new_crtc_state)
 		u32 psr_status;
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (!intel_dp->psr.enabled ||
-		    (intel_dp->psr.enabled && intel_dp->psr.psr2_enabled)) {
+		if (!intel_dp->psr.enabled || intel_dp->psr.psr2_enabled) {
 			mutex_unlock(&intel_dp->psr.lock);
 			continue;
 		}
-- 
2.31.1

