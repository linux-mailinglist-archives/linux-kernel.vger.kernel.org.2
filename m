Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B433F6BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhHXWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhHXWze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:55:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9DBF61139;
        Tue, 24 Aug 2021 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629845689;
        bh=soYdqs0Qs7xCVvPch05cxgy1fyh2lip8GCF4qssf2PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIYXerymKENVREB2YJr0myqfiT+haL9C5Kk2wzNPhXo/BAjH8MM2i+/kGyW1v3jZr
         g5RZ8cCWNXVnFD2zQ4K53bgZbKVfygJ1UjrLWmHHQ0SHKYWG0WQyJgvCgIlbK7R0IB
         wROIp6NwWMuDFgWhdCjBpDIEw9ByiO4YoT/Yl2XiFNqd5bf+8N0UTyM/0UuiUPlTeD
         nsJu5bixEpR4ux0D3P2lqz9vPUVHFhU4QGT6GBI7XteNt7Cigab2BmWYYWv24hJ3w1
         Y1RYNWAm52byXpxddb/K3PWdHwOC7SNUdm8Y2x6mBkv6z5RBWQCRejbbezXR9zHr6u
         yuast6MJAW/9w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/3] drm/i915/selftests: Always initialize err in igt_dmabuf_import_same_driver_lmem()
Date:   Tue, 24 Aug 2021 15:54:26 -0700
Message-Id: <20210824225427.2065517-3-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824225427.2065517-1-nathan@kernel.org>
References: <20210824225427.2065517-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:127:13: warning:
variable 'err' is used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
        } else if (PTR_ERR(import) != -EOPNOTSUPP) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:138:9: note:
uninitialized use occurs here
        return err;
               ^~~
drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:127:9: note: remove
the 'if' if its condition is always true
        } else if (PTR_ERR(import) != -EOPNOTSUPP) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:95:9: note:
initialize the variable 'err' to silence this warning
        int err;
               ^
                = 0

The test is expected to pass if i915_gem_prime_import() returns
-EOPNOTSUPP so initialize err to zero in this case.

Fixes: cdb35d1ed6d2 ("drm/i915/gem: Migrate to system at dma-buf attach time (v7)")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index 532c7955b300..4a6bb64c3a35 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -128,6 +128,8 @@ static int igt_dmabuf_import_same_driver_lmem(void *arg)
 		pr_err("i915_gem_prime_import failed with the wrong err=%ld\n",
 		       PTR_ERR(import));
 		err = PTR_ERR(import);
+	} else {
+		err = 0;
 	}
 
 	dma_buf_put(dmabuf);
-- 
2.33.0

