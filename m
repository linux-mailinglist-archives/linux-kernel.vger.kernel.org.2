Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B482B3318D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCHUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhCHUqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:46:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FCF164DF5;
        Mon,  8 Mar 2021 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615236371;
        bh=fJsMy6YyZc0GKNaInkxN1wNn9x/iFUp/YIamYo3r9jI=;
        h=From:To:Cc:Subject:Date:From;
        b=GstGoT78JFxcmwrLZvbduyxRkkzi3fBn4/2ug3/IqmAiiXC/qScbn1IB1l4LQTSe3
         BhDMTGvLDckABUwk1+MnssjPMYdAkU0PTrrmwQhtkyw+r1qbuJM6NSejids/mj5rAi
         Kiq+/4VbA0+8LDY5mhc1/LZi9wwCa1w+ge388GTUqcIL3yH3YGjPL48trvXCRQPzUR
         qRO6rLigtFBI3biLv9xYgKuqbQv3cpF271T/R8oj0piQYywprrJ3OYm5/mhf0HkJmU
         FAP4uGMpwOwnkIwV3GWJflWEa8TVwjW9EE8m0hQtYUvsVXpFxZOwL1W8Vc9waTyYN0
         +6L6Qlp6gZrag==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philip Yang <philip.yang@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [variant b] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
Date:   Mon,  8 Mar 2021 21:45:49 +0100
Message-Id: <20210308204606.2634726-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using 'imply AMD_IOMMU_V2' does not guarantee that the driver can link
against the exported functions. If the GPU driver is built-in but the
IOMMU driver is a loadable module, the kfd_iommu.c file is indeed
built but does not work:

x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_bind_process_to_device':
kfd_iommu.c:(.text+0x516): undefined reference to `amd_iommu_bind_pasid'
x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_unbind_process':
kfd_iommu.c:(.text+0x691): undefined reference to `amd_iommu_unbind_pasid'
x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_suspend':
kfd_iommu.c:(.text+0x966): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0x97f): undefined reference to `amd_iommu_set_invalid_ppr_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0x9a4): undefined reference to `amd_iommu_free_device'
x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_resume':
kfd_iommu.c:(.text+0xa9a): undefined reference to `amd_iommu_init_device'
x86_64-linux-ld: kfd_iommu.c:(.text+0xadc): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xaff): undefined reference to `amd_iommu_set_invalid_ppr_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xc72): undefined reference to `amd_iommu_bind_pasid'
x86_64-linux-ld: kfd_iommu.c:(.text+0xe08): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xe26): undefined reference to `amd_iommu_set_invalid_ppr_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xe42): undefined reference to `amd_iommu_free_device'

Change the 'imply' to a weak dependency that still allows compiling
in all other configurations but disallows the configuration that
causes a link failure.

Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it conditional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index f02c938f75da..d01dba2af3bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -6,7 +6,7 @@
 config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
 	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
-	imply AMD_IOMMU_V2 if X86_64
+	depends on AMD_IOMMU_V2=y || DRM_AMDGPU=m
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	select DRM_AMDGPU_USERPTR
-- 
2.29.2

