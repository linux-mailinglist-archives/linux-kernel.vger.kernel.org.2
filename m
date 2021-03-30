Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798C034ECB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhC3PgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:36:21 -0400
Received: from mengyan1223.wang ([89.208.246.23]:33078 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232245AbhC3Pfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:46 -0400
Received: from xry111-X57S1.. (unknown [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 7A01465C16;
        Tue, 30 Mar 2021 11:35:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1617118546;
        bh=6hwekqUNLmFAHbwCnBsnIYIhL6K9vbJddnyV52qZ7VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBlcto603Rok3cEFYhm+DEkFAOXJLWxwbTWKUvDacKdmmlPPi99UjPLQpwNY9uELa
         rQoqFqjkzJQNlD8EHsHyT1kLO64kI6myoGEWZ9K/ukUGdUKFnXPXxoPpWO9cCKD/W2
         PcTT5e87isMm+fGzRrdVUmRUoIUa8pOpYrNFSn6DGvCqPjgGl5eog21zKpi0qDk/u/
         d92bwRKT9QiO/Tw+MotqRjLAoJcXj7BNM4ZYHjZBx8fyYGeDS7p2PWkHDUT572wT8I
         0IqM09myjwXWy4fz4pUxmdjIb5vwDbRRuCaarJXDD68/Ys599aePbmJ6ezPEwU6y+j
         rgXaZ19r+Syzg==
From:   =?UTF-8?q?X=E2=84=B9=20Ruoyao?= <xry111@mengyan1223.wang>
To:     amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?X=E2=84=B9=20Ruoyao?= <xry111@mengyan1223.wang>
Subject: [PATCH 2/2] drm/amdgpu: check alignment on CPU page for bo map
Date:   Tue, 30 Mar 2021 23:33:34 +0800
Message-Id: <20210330153334.44570-3-xry111@mengyan1223.wang>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210330153334.44570-1-xry111@mengyan1223.wang>
References: <20210330153334.44570-1-xry111@mengyan1223.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page table of AMDGPU requires an alignment to CPU page so we should
check ioctl parameters for it.  Return -EINVAL if some parameter is
unaligned to CPU page, instead of corrupt the page table sliently.

Signed-off-by: Xi Ruoyao <xry111@mengyan1223.wang>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc4d6ae71476..a01c158bc29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2198,8 +2198,8 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 
 	/* validate the parameters */
-	if (saddr & AMDGPU_GPU_PAGE_MASK || offset & AMDGPU_GPU_PAGE_MASK ||
-	    size == 0 || size & AMDGPU_GPU_PAGE_MASK)
+	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
+	    size == 0 || size & ~PAGE_MASK)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
@@ -2264,8 +2264,8 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	int r;
 
 	/* validate the parameters */
-	if (saddr & AMDGPU_GPU_PAGE_MASK || offset & AMDGPU_GPU_PAGE_MASK ||
-	    size == 0 || size & AMDGPU_GPU_PAGE_MASK)
+	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
+	    size == 0 || size & ~PAGE_MASK)
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
-- 
2.31.1

