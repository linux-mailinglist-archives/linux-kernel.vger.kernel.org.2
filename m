Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68E339971D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFCAni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:43:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:20968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCAna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:43:30 -0400
IronPort-SDR: txf5wyCbueocTYi+M56bZkxI5GmN/gYb2+P3CN9SIC67VRe1OQTWrAgsIPbBX/C07T84ZLzQvG
 WjLbmZk10frw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="202075165"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="202075165"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:46 -0700
IronPort-SDR: OxJF8Ua9Z2imFUH0gyNrbWEtQF8Rbg7NaK2nDBwa/a6xvvPOWkUG7ZB1eAmyF4p5G4d7331NtZ
 1EnieV4InCBQ==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="549686678"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 4/8] x86/tdx: Add arch_has_restricted_memory_access for TDX
Date:   Wed,  2 Jun 2021 17:41:29 -0700
Message-Id: <20210603004133.4079390-5-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtio the host decides whether the guest uses the DMA
API or not using the strangely named VIRTIO_F_ACCESS_PLATFORM
bit (which really indicates whether the DMA API is used or not)

For hardened virtio on TDX we want to enforce that that swiotlb is
always used, which requires using the DMA API.  While IO wouldn't
really work without the swiotlb, it might be possible that an
attacker forces swiotlbless IO to manipulate memory in the guest.

So we want to force the DMA API (which then forces swiotlb),
but without relying on the host.

There is already an arch_has_restricted_memory_acces hook for
this, which is currently used only by s390. Enable
the config option for the hook for x86 and enable it for TDX.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/Kconfig                 | 1 +
 arch/x86/mm/mem_encrypt_common.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1531a0f905ed..3d804fce31b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
 	select X86_MEM_ENCRYPT_COMMON
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index 24c9117547b4..2244d1f033ab 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -9,6 +9,7 @@
 
 #include <asm/mem_encrypt_common.h>
 #include <linux/dma-mapping.h>
+#include <linux/virtio_config.h>
 #include <linux/swiotlb.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
@@ -37,3 +38,9 @@ void __init mem_encrypt_init(void)
 		amd_mem_encrypt_init();
 }
 
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return is_tdx_guest();
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
+
-- 
2.25.4

