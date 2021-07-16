Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8003CB04C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhGPBOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:14:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15024 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGPBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:14:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQtR46G3WzZkts;
        Fri, 16 Jul 2021 09:08:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:11:51 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:11:50 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] drm/i915: Fix error return code in igt_vma_create()
Date:   Fri, 16 Jul 2021 09:11:12 +0800
Message-ID: <20210716011112.3305-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although 'err' has been initialized to -ENOMEM, but it will be reassigned
by the "err = create_vmas(...)" statement in the for loop. So that, the
value of 'err' may be zero when i915_gem_object_create_internal() or
mock_context() failed.

Fix to reassign 'err' before 'goto out'.

Fixes: e3c7a1c5377e ("drm/i915: Test creation of VMA")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/i915/selftests/i915_vma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index dd0607254a95..96771c341f29 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -156,7 +156,7 @@ static int igt_vma_create(void *arg)
 	IGT_TIMEOUT(end_time);
 	LIST_HEAD(contexts);
 	LIST_HEAD(objects);
-	int err = -ENOMEM;
+	int err;
 
 	/* Exercise creating many vma amonst many objections, checking the
 	 * vma creation and lookup routines.
@@ -166,8 +166,10 @@ static int igt_vma_create(void *arg)
 	for_each_prime_number(num_obj, ULONG_MAX - 1) {
 		for (; no < num_obj; no++) {
 			obj = i915_gem_object_create_internal(i915, PAGE_SIZE);
-			if (IS_ERR(obj))
+			if (IS_ERR(obj)) {
+				err = PTR_ERR(obj);
 				goto out;
+			}
 
 			list_add(&obj->st_link, &objects);
 		}
@@ -176,8 +178,10 @@ static int igt_vma_create(void *arg)
 		for_each_prime_number(num_ctx, 2 * BITS_PER_LONG) {
 			for (; nc < num_ctx; nc++) {
 				ctx = mock_context(i915, "mock");
-				if (!ctx)
+				if (!ctx) {
+					err = -ENOMEM;
 					goto out;
+				}
 
 				list_move(&ctx->link, &contexts);
 			}
-- 
2.25.1

