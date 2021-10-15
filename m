Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF23F42E9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhJOHRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:17:03 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:7401 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234395AbhJOHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:17:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Us6A02c_1634282083;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Us6A02c_1634282083)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 15:14:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, emma@anholt.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/v3d: nullify pointer se with a NULL
Date:   Fri, 15 Oct 2021 15:14:41 +0800
Message-Id: <1634282081-72255-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a plain integer is being used to nullify the pointer
struct v3d_submit_ext *se. Use NULL instead. Cleans up sparse
warnings:
drivers/gpu/drm/v3d/v3d_gem.c:777:53: warning: Using plain integer as
NULL pointer
drivers/gpu/drm/v3d/v3d_gem.c:1010:45: warning: Using plain integer as
NULL pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index e47ae40..c7ed2e1 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -774,7 +774,7 @@ void v3d_job_put(struct v3d_job *job)
 
 	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
 		ret = v3d_job_init(v3d, file_priv, (void *)&clean_job, sizeof(*clean_job),
-				   v3d_job_free, 0, 0, V3D_CACHE_CLEAN);
+				   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
 		if (ret)
 			goto fail;
 
@@ -1007,7 +1007,7 @@ void v3d_job_put(struct v3d_job *job)
 		goto fail;
 
 	ret = v3d_job_init(v3d, file_priv, (void *)&clean_job, sizeof(*clean_job),
-			   v3d_job_free, 0, 0, V3D_CACHE_CLEAN);
+			   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
 	if (ret)
 		goto fail;
 
-- 
1.8.3.1

