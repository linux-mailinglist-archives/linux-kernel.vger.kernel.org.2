Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35804325001
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhBYMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233585AbhBYMxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:53:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCA7864F11;
        Thu, 25 Feb 2021 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614257587;
        bh=QCiGi85fr9DFYHiTlbvSudt58MY7c/cO+LSTBCt1zIs=;
        h=From:To:Cc:Subject:Date:From;
        b=l5ZUYTfXS2EGUsILj+mBWQ0aXkivB0bbPsOsL5UM/Ww6tuslziEvuaXA2yUuSx1jQ
         UgVQImLsMcXJbunGtJMORCSt8Za/+7sapzbEiIjX7gFN2SavTPbIywYmwhL/1mgrQ+
         Rk2SF7G2nNFaWYtLFv3JzxlPN85RY9SqfwRSNCkgn7UtzVrcoUZ0iAVpGtJji/fnYi
         mcCgtJYLJbyakXMm18B0clCZ9qQ02gg7pP0XYGiGysna5tzyrfAHTqJG/Gt4vgk3lq
         VkFWXWeJ9RJXdWkLUR+J1cBnMDUASUwaf3QfrLigFQqBJ5+/QPtfF/KWQZ6dU62i1s
         O8/odlO8exDcA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/pci: rework AGP dependency
Date:   Thu, 25 Feb 2021 13:52:38 +0100
Message-Id: <20210225125301.1723047-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I noticed a warning from 'nm' when CONFIG_TRIM_UNUSED_KSYMS is set
and IS_REACHABLE(CONFIG_AGP) is false:

drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.o: no symbols

I later found this is completely harmless and we should find a way
to suppress the warning, but at that point I had already done a
cleanup patch to address this instance.

It turns out this code could be improved anyway, as the current version
behaves unexpectedly when AGP is a loadable module but nouveau is built-in
itself, in which case it silently omits agp support.

A better way to handle this is with a Kconfig dependency that requires
AGP either to be disabled, or forces nouveau to be a module for AGP=m.
With this change, the compile-time hack can be removed and lld no
longer warns.

Fixes: 340b0e7c500a ("drm/nouveau/pci: merge agp handling from nouveau drm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/Kbuild                 | 1 +
 drivers/gpu/drm/nouveau/Kconfig                | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c  | 2 --
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h  | 9 +++++----
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
index 60586fb8275e..173b8d9d85e3 100644
--- a/drivers/gpu/drm/nouveau/Kbuild
+++ b/drivers/gpu/drm/nouveau/Kbuild
@@ -15,6 +15,7 @@ nouveau-y := $(nvif-y)
 #- code also used by various userspace tools/tests
 include $(src)/nvkm/Kbuild
 nouveau-y += $(nvkm-y)
+nouveau-m += $(nvkm-m)
 
 # DRM - general
 ifdef CONFIG_X86
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 278e048235a9..90276a557a70 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -2,6 +2,7 @@
 config DRM_NOUVEAU
 	tristate "Nouveau (NVIDIA) cards"
 	depends on DRM && PCI && MMU
+	depends on AGP || !AGP
 	select IOMMU_API
 	select FW_LOADER
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
index 174bdf995271..a400c680cf65 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: MIT
-nvkm-y += nvkm/subdev/pci/agp.o
+nvkm-$(CONFIG_AGP) += nvkm/subdev/pci/agp.o
 nvkm-y += nvkm/subdev/pci/base.o
 nvkm-y += nvkm/subdev/pci/pcie.o
 nvkm-y += nvkm/subdev/pci/nv04.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
index 385a90f91ed6..86c9e1d658af 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 #include "agp.h"
-#ifdef __NVKM_PCI_AGP_H__
 #include <core/option.h>
 
 struct nvkm_device_agp_quirk {
@@ -172,4 +171,3 @@ nvkm_agp_ctor(struct nvkm_pci *pci)
 
 	pci->agp.mtrr = arch_phys_wc_add(pci->agp.base, pci->agp.size);
 }
-#endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
index ad4d3621d02b..041fe1fbf093 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
@@ -1,15 +1,14 @@
-/* SPDX-License-Identifier: MIT */
-#include "priv.h"
-#if defined(CONFIG_AGP) || (defined(CONFIG_AGP_MODULE) && defined(MODULE))
 #ifndef __NVKM_PCI_AGP_H__
 #define __NVKM_PCI_AGP_H__
 
+/* SPDX-License-Identifier: MIT */
+#include "priv.h"
+#if IS_ENABLED(CONFIG_AGP)
 void nvkm_agp_ctor(struct nvkm_pci *);
 void nvkm_agp_dtor(struct nvkm_pci *);
 void nvkm_agp_preinit(struct nvkm_pci *);
 int nvkm_agp_init(struct nvkm_pci *);
 void nvkm_agp_fini(struct nvkm_pci *);
-#endif
 #else
 static inline void nvkm_agp_ctor(struct nvkm_pci *pci) {}
 static inline void nvkm_agp_dtor(struct nvkm_pci *pci) {}
@@ -17,3 +16,5 @@ static inline void nvkm_agp_preinit(struct nvkm_pci *pci) {}
 static inline int nvkm_agp_init(struct nvkm_pci *pci) { return -ENOSYS; }
 static inline void nvkm_agp_fini(struct nvkm_pci *pci) {}
 #endif
+
+#endif
-- 
2.29.2

