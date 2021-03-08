Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35E533124D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCHPeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCHPeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 480D265208;
        Mon,  8 Mar 2021 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615217644;
        bh=6ZFTD883CvBSmMqN/Qn0YcbtxAfTIp2pR0HqlUwwxUk=;
        h=From:To:Cc:Subject:Date:From;
        b=qcjdMkkOzYpyZlVyeCTa4QwDG22pfrIIAUHqaDOST/To4vn2qSsht+isxl6/P1Rbw
         ZUuwUFXOwb3aknq5pmSWo0M3uqK7Bzl+XzmI9E1Fn1px9xB90Jf4zoWOfLcGDoRAjq
         zviCOGwGSfY/CnNEtANwWZf8dh+L7I3e2VwWW3D3hjcHjT3pOltzNSi7QBXf4+zkv4
         3YCjFFNFqq21AUCf5U7U3srByanSbiZSXUHrpp3NJt4SnJE2gDGPkdg9shd83khhti
         UGzHU0OaYx03XjAAeTZrlGDXSvGnn3vGuFjx21cp4Z5lSVA1ThpKbUykvN1J9uXkgi
         bxFSO9367lE2g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Philip Yang <philip.yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
Date:   Mon,  8 Mar 2021 16:33:50 +0100
Message-Id: <20210308153359.2513446-1-arnd@kernel.org>
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

Use a stronger 'select' instead.

Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it conditional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index f02c938f75da..91f85dfb7ba6 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -5,8 +5,9 @@
 
 config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
-	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
-	imply AMD_IOMMU_V2 if X86_64
+	depends on DRM_AMDGPU && ((X86_64 && IOMMU_SUPPORT && ACPI) || ARM64 || PPC64)
+	select AMD_IOMMU if X86_64
+	select AMD_IOMMU_V2 if X86_64
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	select DRM_AMDGPU_USERPTR
-- 
2.29.2

