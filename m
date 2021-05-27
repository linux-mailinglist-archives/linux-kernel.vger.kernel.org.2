Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0623A392E77
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhE0NAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhE0NA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:00:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0603C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:58:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v12so2286916plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kA+3MDeoUW6g7BAIQhmMZU6jpRRh7iFmQAMuxd9InLo=;
        b=N/RAF9cNvTcRd3iZmeYm87pVaO7FRy7mf9/WxIyCft3/KEf6OSpP1KzfVNdxCB6y/v
         f9rFlfhM52r7diCBgVLUZz2KQytMc21laqchIO1r5VInxr59Sd+7C4c0jiL2C5LzFLDG
         Gn+MKH5XFhuZrfNlpbnQvXijnbOOZUN/Rm2WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kA+3MDeoUW6g7BAIQhmMZU6jpRRh7iFmQAMuxd9InLo=;
        b=JnfYb5HKty+VKdhqU/CJ4xvayk3w/vgJZb5Fknlne3O1Z5QLg3d10oih7GwvwTFB6A
         xptXEe9KtbnsZaHRPZ4WfD9EfgSFupwfwLi1dym1iGWCh+nuxD+VcHYxyM/eoq+ZWu6c
         FmN0HUp/wzfjv+myX+hZ5MJl8oQAjbit28ttVNVEqjib7bVueUbrsL1uDuQuGeY097pQ
         c45ek/mWe9+vLxAYhsgDRFti9GXaZlzHaFBeiMwDckuzhnsg8ZtrTlVeZ9qW+uo0xg7p
         Us5aMcjUMNy+DxgkdErsZxH39hly4zviaPBDbpP760rAXx06zWM0TaJ1eS/gwuK2T2+S
         EGAQ==
X-Gm-Message-State: AOAM533AzolnT93zkfBEd8VKA0nZsBZqWP+p4LTva2toP43ukn42yxXr
        BW2EBOCjXOrnmhgz2jhjXXlOZQ==
X-Google-Smtp-Source: ABdhPJxa0KAbUWt2GVQAhxJJasbt6KcrMvbewz9fOfHqfZGpT+rFwlvdT6CpO+Xk/o30NYlBhsWhJg==
X-Received: by 2002:a17:90a:b22:: with SMTP id 31mr9588913pjq.179.1622120335442;
        Thu, 27 May 2021 05:58:55 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
        by smtp.gmail.com with UTF8SMTPSA id e7sm2084005pfl.171.2021.05.27.05.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 05:58:54 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v8 00/15] Restricted DMA
Date:   Thu, 27 May 2021 20:58:30 +0800
Message-Id: <20210527125845.1852284-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements mitigations for lack of DMA access control on
systems without an IOMMU, which could result in the DMA accessing the
system memory at unexpected times and/or unexpected addresses, possibly
leading to data leakage or corruption.

For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
not behind an IOMMU. As PCI-e, by design, gives the device full access to
system memory, a vulnerability in the Wi-Fi firmware could easily escalate
to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
full chain of exploits; [2], [3]).

To mitigate the security concerns, we introduce restricted DMA. Restricted
DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
specially allocated region and does memory allocation from the same region.
The feature on its own provides a basic level of protection against the DMA
overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system needs
to provide a way to restrict the DMA to a predefined memory region (this is
usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).

[1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
[1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
[2] https://blade.tencent.com/en/advisories/qualpwn/
[3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
[4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132

v8:
- Fix reserved-memory.txt and add the reg property in example.
- Fix sizeof for of_property_count_elems_of_size in
  drivers/of/address.c#of_dma_set_restricted_buffer.
- Apply Will's suggestion to try the OF node having DMA configuration in
  drivers/of/address.c#of_dma_set_restricted_buffer.
- Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
- Add error message for PageHighMem in
  kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
  rmem_swiotlb_setup.
- Fix the message string in rmem_swiotlb_setup.

v7:
Fix debugfs, PageHighMem and comment style in rmem_swiotlb_device_init
https://lore.kernel.org/patchwork/cover/1431031/

v6:
Address the comments in v5
https://lore.kernel.org/patchwork/cover/1423201/

v5:
Rebase on latest linux-next
https://lore.kernel.org/patchwork/cover/1416899/

v4:
- Fix spinlock bad magic
- Use rmem->name for debugfs entry
- Address the comments in v3
https://lore.kernel.org/patchwork/cover/1378113/

v3:
Using only one reserved memory region for both streaming DMA and memory
allocation.
https://lore.kernel.org/patchwork/cover/1360992/

v2:
Building on top of swiotlb.
https://lore.kernel.org/patchwork/cover/1280705/

v1:
Using dma_map_ops.
https://lore.kernel.org/patchwork/cover/1271660/

Claire Chang (15):
  swiotlb: Refactor swiotlb init functions
  swiotlb: Refactor swiotlb_create_debugfs
  swiotlb: Add DMA_RESTRICTED_POOL
  swiotlb: Add restricted DMA pool initialization
  swiotlb: Add a new get_io_tlb_mem getter
  swiotlb: Update is_swiotlb_buffer to add a struct device argument
  swiotlb: Update is_swiotlb_active to add a struct device argument
  swiotlb: Bounce data from/to restricted DMA pool if available
  swiotlb: Move alloc_size to find_slots
  swiotlb: Refactor swiotlb_tbl_unmap_single
  dma-direct: Add a new wrapper __dma_direct_free_pages()
  swiotlb: Add restricted DMA alloc/free support.
  dma-direct: Allocate memory from restricted DMA pool if available
  dt-bindings: of: Add restricted DMA pool
  of: Add plumbing for restricted DMA pool

 .../reserved-memory/reserved-memory.txt       |  36 ++-
 drivers/gpu/drm/i915/gem/i915_gem_internal.c  |   2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c         |   2 +-
 drivers/iommu/dma-iommu.c                     |  12 +-
 drivers/of/address.c                          |  25 ++
 drivers/of/device.c                           |   3 +
 drivers/of/of_private.h                       |   5 +
 drivers/pci/xen-pcifront.c                    |   2 +-
 drivers/xen/swiotlb-xen.c                     |   2 +-
 include/linux/device.h                        |   4 +
 include/linux/swiotlb.h                       |  41 ++-
 kernel/dma/Kconfig                            |  14 +
 kernel/dma/direct.c                           |  63 +++--
 kernel/dma/direct.h                           |   9 +-
 kernel/dma/swiotlb.c                          | 242 +++++++++++++-----
 15 files changed, 362 insertions(+), 100 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

