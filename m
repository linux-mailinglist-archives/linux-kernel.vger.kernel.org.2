Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2337F386
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEMHZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:25:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2659 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhEMHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:24:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fgjkw3b0QzlbYq;
        Thu, 13 May 2021 15:21:28 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 15:23:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH -next 2/4] drm/radeon: correct function name radeon_cs_parser_fini()
Date:   Thu, 13 May 2021 15:25:57 +0800
Message-ID: <20210513072559.1731410-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513072559.1731410-1-yangyingliang@huawei.com>
References: <20210513072559.1731410-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 kernel build warning:

  drivers/gpu/drm/radeon/radeon_cs.c:417: warning: expecting prototype for cs_parser_fini(). Prototype was for radeon_cs_parser_fini() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 48162501c1ee..80a3bee933d6 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -405,7 +405,7 @@ static int cmp_size_smaller_first(void *priv, const struct list_head *a,
 }
 
 /**
- * cs_parser_fini() - clean parser states
+ * radeon_cs_parser_fini() - clean parser states
  * @parser:	parser structure holding parsing context.
  * @error:	error number
  * @backoff:	indicator to backoff the reservation
-- 
2.25.1

