Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06AE390E89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEZC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:57:27 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60429 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhEZC50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:57:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ua7ThRY_1621997753;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ua7ThRY_1621997753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 10:55:54 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Fix kernel-doc
Date:   Wed, 26 May 2021 10:55:48 +0800
Message-Id: <1621997748-127963-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in sdma_v5_2.c kernel-doc comment
to remove a warning found by clang_w1.

drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:528: warning: expecting prototype
for sdma_v_0_ctx_switch_enable(). Prototype was for
sdma_v5_2_ctx_switch_enable() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 240596b..db79ee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -512,7 +512,7 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v_0_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable the DMA MEs context switch.
-- 
1.8.3.1

