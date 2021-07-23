Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6113D424D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhGWVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:00:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhGWVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627076435; x=1658612435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mh2H2AqgX7zCMJmvVV14kJPveSdfSaOx1iNS29W3dS0=;
  b=dsnxNfr3FThXvDmU/uSClNtSrEBvX5pqe2Lsb1vdAJj4m8tX2utldZpv
   4lab3liCWKjJGoEgJS1Helikq2WBzF4aVlBGoHemH9DwRkhu0VzVkjqTg
   TQrxYaA3Qwk1bJ0y2AehW6hUq0TPxRYlni+/tAampKUfkULsieLgs1eDm
   RVm2btDRK+q+2IZyb3zbF6Rfg/9OEyMu2bfbalNsvl4+zGbSVoRuoNk1J
   4Vz8kMqxECJvcMR9GLXAxza2HsVT4q9luotVXeXu+Hf/bNVN8VvofHB01
   CankbsuuTa4rZvSf8bpeljg/Q4WGjgNZBtUxobkWfaMpqo0QLm/JPF2QY
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; 
   d="scan'208";a="279198449"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:35 +0800
IronPort-SDR: MQwxW3GIn+2mR9Jg/P1JPzictIUalmQFiMnUAuTiu+BtpljLy7z70anbmQyinRfDG5a25IKRfP
 xTzdFw6f1sHi1VHjbAVI52//Hv5TbfOlYr1Szq7qLNrkeIPIDO18M6W1bUAtFAfGL5OTq3Aje7
 6LS7qmPKQA0FQbZflGDSxICcl8U22fspy2UfOlH00HysA5Ob4oFASUREhueRupeB5hEyHw/zlE
 H6Z0TTNIOS0w/vvm38lQ11/6I4TfJmjRQ+ydTurzKIrXp6o6zG2hQRsSEj18iMieBDkg/tzcLL
 YnySNNQ8kDu6+7uOTnA+E16S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:16:43 -0700
IronPort-SDR: S4LhvUQ74NR2pVUEi2iTWK2rF8yj17ZaeIV3WL/BXkS6QFGmU8kh/4TeJIUSHlFaNwOsG1NQAn
 xppqY2Z9lrhrzfXSczZj+czih/cqibkinofktm7F6aEhMYJnPYQWxN/sknVi5xcjOpJVosupM2
 O42MX0dNi1Y+YMpbypuzOq4wGPiD/5HaOupgAhHRmSXp+gEce2HrJ/hdPg24Yln6P6Cbd2XCa6
 c1XNQeTqq0mai1j7h7sDxqR9fQFKgHDHx+clem2xb0gcj9Mh5q3l6kf8xgR9idp/ttiMgjWziv
 /HY=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:35 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
Date:   Fri, 23 Jul 2021 14:40:26 -0700
Message-Id: <20210723214031.3251801-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V privilege specification doesn't define an IOMMU or any method modify
PMA attributes or PTE entries to allow non-coherent mappings yet. In
the beginning, this approach was adopted assuming that most of the RISC-V
platforms would support full cache-coherent IO. Here is excerpt from the
priv spec section 3.6.5

"In RISC-V platforms, the use of hardware-incoherent regions is discouraged
due to software complexity, performance, and energy impacts."

While some of the RISC-V platforms adhere to the above suggestion, not all
platforms can afford to build to fully cache-coherent I/O devices. To
address DMA for non-coherent I/O devices, we need to mark a region of memory
as non-cacheable. Some of the platforms rely on a fixed region of uncached
memory that is remapped to the system memory while some other modify
the PTE entries to achieve that.

The patch3 solves the issue for the fist use case by using a global
pool of memory that is reserved for DMA. The device access the reserved area
of the region while corresponding CPU address will be from uncached region
As the uncached region is remapped to the beginning of the system ram, both
CPU and device get the same view.

To facilitate streaming DMA APIs, patch 1 introduces a set of generic
cache operations. Any platform can use the generic ops to provide platform
specific cache management operations. Once the standard RISC-V CMO extension
is available, it will also use these generic ops.

To address the second use case, Page Based Memory Attribute (PBMT) extension
is proposed. Once the extension is in good shape, we can leverage that
using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
option. We will probably need another arch specific hooks to know if the
platform supports direct remap at runtime. For RISC-V, it will check the
presence of PBMT extension while other arch function will simply return true
if DIRECT_REMAP is enabled. This is required as arious different config
(DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
unified kernel image can boot on all RISC-V platforms.

This patch series depends on Christoph's global pool support series[1].
Tested on Qemu, HiFive unleashed and beagleV. This series is also available
at [2]. 
This series also solves the non-coherent DMA support on beagleV but requires
additional beagleV specific patches[3] which will be upstreamed soon.


[1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html 
[2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
[3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global

Atish Patra (5):
RISC-V: Implement arch_sync_dma* functions
of: Move of_dma_get_range to of_address.h
dma-mapping: Enable global non-coherent pool support for RISC-V
dma-direct: Allocate dma pages directly if global pool allocation
fails
RISC-V: Support a new config option for non-coherent DMA

arch/riscv/Kconfig                       |  8 +++
arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
arch/riscv/mm/Makefile                   |  1 +
arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
drivers/of/of_private.h                  | 10 ----
include/linux/of_address.h               | 12 +++++
kernel/dma/coherent.c                    | 49 +++++++++++++++---
kernel/dma/direct.c                      |  7 ++-
8 files changed, 152 insertions(+), 20 deletions(-)
create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
create mode 100644 arch/riscv/mm/dma-noncoherent.c

--
2.31.1

