Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE740345DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCWMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:17:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14847 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCWMQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:16:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4Vfk1Mj1z92vY;
        Tue, 23 Mar 2021 20:14:38 +0800 (CST)
Received: from hulk-robot-4.huawei.com (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 20:16:27 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <linux-graphics-maintainer@vmware.com>, <sroland@vmware.com>,
        <zackr@vmware.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/vmwgfx/vmwgfx_validation: Use flexible-array member instead of zero-length array
Date:   Tue, 23 Mar 2021 13:02:04 +0000
Message-ID: <20210323130204.45439-1-zou_wei@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppresses the following coccinelle warning:

drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:85:15-22: WARNING use flexible-array member instead

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index e7570f422400..f4837130d67b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -82,7 +82,7 @@ struct vmw_validation_res_node {
 	u32 reserved : 1;
 	u32 dirty : 1;
 	u32 dirty_set : 1;
-	unsigned long private[0];
+	unsigned long private[];
 };
 
 /**
-- 
2.17.1

