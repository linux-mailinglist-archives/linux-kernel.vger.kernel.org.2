Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1243590FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 02:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhDIAj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 20:39:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16054 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 20:39:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGfMp5N0mzPpG8;
        Fri,  9 Apr 2021 08:36:54 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 08:39:34 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>, <eric@anholt.net>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH] drm/vc4: Fix PM reference leak in vc4_vec_encoder_enable()
Date:   Fri, 9 Apr 2021 08:38:55 +0800
Message-ID: <20210409003855.56606-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_get_sync will increment pm usage counter even it failed.Thus a
pairing decrement is needed.
Change pm_runtime_get_sync to pm_runtime_resume_and_get for keeping usage counter
balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/gpu/drm/vc4/vc4_vec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index bd5b8eb58b18..924e03050dd4 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -403,7 +403,7 @@ static void vc4_vec_encoder_enable(struct drm_encoder *encoder)
 	struct vc4_vec *vec = vc4_vec_encoder->vec;
 	int ret;
 
-	ret = pm_runtime_get_sync(&vec->pdev->dev);
+	ret = pm_runtime_resume_and_get(&vec->pdev->dev);
 	if (ret < 0) {
 		DRM_ERROR("Failed to retain power domain: %d\n", ret);
 		return;

