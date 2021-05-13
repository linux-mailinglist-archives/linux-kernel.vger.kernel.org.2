Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6780237F376
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEMHSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:18:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3740 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhEMHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:18:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgjYn4F6wzqSTn;
        Thu, 13 May 2021 15:13:33 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 15:16:51 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm: correct function name drm_legacy_ctxbitmap_flush()
Date:   Thu, 13 May 2021 15:19:18 +0800
Message-ID: <20210513071918.1728535-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 kernel build warning:

  drivers/gpu/drm/drm_context.c:136: warning: expecting prototype for drm_ctxbitmap_flush(). Prototype was for drm_legacy_ctxbitmap_flush() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/drm_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index c99be950bf17..acbec1ddd583 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -124,7 +124,7 @@ void drm_legacy_ctxbitmap_cleanup(struct drm_device * dev)
 }
 
 /**
- * drm_ctxbitmap_flush() - Flush all contexts owned by a file
+ * drm_legacy_ctxbitmap_flush() - Flush all contexts owned by a file
  * @dev: DRM device to operate on
  * @file: Open file to flush contexts for
  *
-- 
2.25.1

