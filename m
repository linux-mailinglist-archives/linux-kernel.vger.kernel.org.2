Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF943ED375
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhHPL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:59:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14209 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhHPL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:59:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GpCNJ10b6z1CXNj;
        Mon, 16 Aug 2021 19:58:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 19:58:29 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 16 Aug
 2021 19:58:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <thomas.hellstrom@linux.intel.com>
Subject: [PATCH -next] drm/i915: pass correct pointer to PTR_ERR()
Date:   Mon, 16 Aug 2021 20:04:20 +0800
Message-ID: <20210816120420.693002-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'obj' is tested by IS_ERR(), we should pass it to PTR_ERR().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index ffae7df5e4d7..88531d06811e 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -102,7 +102,7 @@ static int igt_dmabuf_import_same_driver_lmem(void *arg)
 	obj = __i915_gem_object_create_user(i915, PAGE_SIZE, &lmem, 1);
 	if (IS_ERR(obj)) {
 		pr_err("__i915_gem_object_create_user failed with err=%ld\n",
-		       PTR_ERR(dmabuf));
+		       PTR_ERR(obj));
 		err = PTR_ERR(obj);
 		goto out_ret;
 	}
@@ -156,7 +156,7 @@ static int igt_dmabuf_import_same_driver(struct drm_i915_private *i915,
 					    regions, num_regions);
 	if (IS_ERR(obj)) {
 		pr_err("__i915_gem_object_create_user failed with err=%ld\n",
-		       PTR_ERR(dmabuf));
+		       PTR_ERR(obj));
 		err = PTR_ERR(obj);
 		goto out_ret;
 	}
-- 
2.25.1

