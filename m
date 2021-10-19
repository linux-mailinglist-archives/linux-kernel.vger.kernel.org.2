Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB3433F23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhJSTUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhJSTUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:20:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD43A60EE2;
        Tue, 19 Oct 2021 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634671100;
        bh=gQ8mFwkO2LHy0BaSGZp8wy9fYbOMNeZ+u2d3mSVXVjc=;
        h=From:To:Cc:Subject:Date:From;
        b=YWX3iEMh3xVmNbS9D1V3gsCoaa9IpyGzVbxWcU7EVHqorf7b24KMocLmkT4Z9R/Qd
         YVCGGboYxN6f0gksXEAQfzaaLhwb+K6WmHpWqfhuGvRTtXcFU+t3WsKC1Qvz/gHwQl
         3KmarBccafeAP/R9LAGYymZpJQs3w6IuY0s8cwHXgGMkCSGtjeh0ApmWJUjboJA37V
         hWno2+j8UKNCggoOpcuX6L6/YGG8b9w16pgQY+aXB/bIYlVaAF4SuTytjp/8XoAbX+
         zczigJtCvQZIaB4DO7cHmEqivd+/glA34CP50uvUvycp3Te57VIvxQl0hhPLsGjleI
         UNiEAc5bG0S+w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SUBMITTED 20200529] drm/selftests/mm: reduce per-function stack usage
Date:   Tue, 19 Oct 2021 21:18:06 +0200
Message-Id: <20211019191815.3159266-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The check_reserve_boundaries() function has a large array on the stack,
over 500 bytes. It gets inlined into __igt_reserve, which has multiple
other large structures as well but stayed just under the stack size
warning limit of 1024 bytes until one more member got added to struct
drm_mm_node, causing a warning:

drivers/gpu/drm/selftests/test-drm_mm.c:371:12: error:
stack frame size of 1032 bytes in function '__igt_reserve' [-Werror,-Wframe-larger-than=]

As far as I can tell, this is not nice but will not be called from
a context that is already low for the kernel stack, so just annotate
the inner function as noinline_for_stack to ensure that each function
by itself stays under the warning limit.

Fixes: 0cdea4455acd ("drm/mm: optimize rb_hole_addr rbtree search")
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://lore.kernel.org/all/20200529201534.474853-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This happens rather rarely, I just ran into it again and found my
old patch.
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index b768b53c4aee..76973c72855e 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -324,9 +324,8 @@ static bool expect_reserve_fail(struct drm_mm *mm, struct drm_mm_node *node)
 	return false;
 }
 
-static bool check_reserve_boundaries(struct drm_mm *mm,
-				     unsigned int count,
-				     u64 size)
+static noinline_for_stack bool
+check_reserve_boundaries(struct drm_mm *mm, unsigned int count, u64 size)
 {
 	const struct boundary {
 		u64 start, size;
-- 
2.29.2

