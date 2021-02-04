Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAA30ED19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhBDHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhBDHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:14:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820DC061786;
        Wed,  3 Feb 2021 23:14:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x9so1275716plb.5;
        Wed, 03 Feb 2021 23:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cITwC79ldFMQgyusgEuHXGzdOsMzB7KooQOa1cAsbsI=;
        b=e3Lx4YFecALYTc75eXFh0jJT2hLv/Ecj8VjgNwcJqJlk7r/Ibtsq4muJXPwemL2DaH
         aPznsk5ijZg6NTjCW31k7YCfokLRHxii24uVWm35lN9hqROee0DQX8hpZRTrmp07i3Iy
         OAy7J5TrebcmL0zLvQLVKtExkXUwUIW7p+JKSbdvyRzZDrSCFP0zJGzJ4ZETTc+I86R0
         xMj+r3VDQ+THnMS8Y/+wZHjDSDMh7wO2Ygxi6d3ww0El7SwntaHvFxAWDtKUhj+XRKbw
         cKGncdr3fSNv8cIVz+E2IkL+Xhk4W5YRAQNwPLJFvBLm7plzqum1w9DkcWke5spNhhzg
         rjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cITwC79ldFMQgyusgEuHXGzdOsMzB7KooQOa1cAsbsI=;
        b=if6cqTd39W/MEhvUYQ+U0I5CYwVxUQxFrtIqoFVEg4EpKfGuU6QXSHA1m0aoh+ledy
         9Ms8ymEsqT+UzXIkQEydIzPl3B69M2pUBRi9u6Id6F2e+tFsZ6+a0IAwctm69yxm64hc
         DB1MQ3y8gbwdNNeCtP/6dzG0z4pZYHlS3vYx6OClkn0NQPBK7T2tMKGiiLdEMB59O+pB
         luBBvNVZ4a9f/i/7siK2jJ2abhoSB6oA2F0pK0xujsYDZhl3f4WzEyhPQ6CDSmLOEx5+
         71n6r7sBCqc0jbkxlGcMkVzN13yumEz+WkFMcU6+VAw8BWF2Ra7f3kgis2/axnTIesm8
         R3Og==
X-Gm-Message-State: AOAM5328IP94g4SdqPd/R+M0OUNVFcWe1keSGvbRd/slRavuF2R1DtRX
        8fh/i3oEvPXYhVGeBTG7Y+Q=
X-Google-Smtp-Source: ABdhPJxfYQJ5QrlYlB4H/jE8kCSwX4bQXMNS5VhU1kvbCqCw53ncVd7SVkgYhkKa7g2RZEUJ3hMWkQ==
X-Received: by 2002:a17:902:bf07:b029:e1:763e:b3a3 with SMTP id bi7-20020a170902bf07b02900e1763eb3a3mr7112363plb.39.1612422857763;
        Wed, 03 Feb 2021 23:14:17 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h4sm4578855pfo.187.2021.02.03.23.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:14:16 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v4 0/2] Add Unisoc IOMMU basic driver
Date:   Thu,  4 Feb 2021 15:14:02 +0800
Message-Id: <20210204071404.891098-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since v3:
* Rebased on iommu/next, and fixed compile error reported by kernel test robot <lkp@intel.com>;
* %s/iommu/IOMMU/ properly in the whole patchset.

Changes since v2:
* Added a WARN and return 0 if an invalid iova was passed to sprd_iommu_iova_to_phys();
* Changed the name of sprd_iommu_write();
* Revised CONFIG_SPRD_IOMMU help graph in Kconfig.
* Revised comments for the struct sprd_iommu_device;
* Converted to use "GPL" instread of "GPL v2", they are same as license-rules.rst shows.

Changes since v1:
* Fixed compile errors reported by kernel test robot <lkp@intel.com>.
* Changed to use syscon to get mapped registers for iommu and media devices to avoid double map issue.
* Addressed Robin's comments:
- Added including offset in the returned physical address if the input virtual address isn't page-aligned;
- Added platform_device_put() after calling of_find_device_by_node();
- Removed iommu register offset from driver, it will be defined as the cell of DT reference to syscon phandle;
- Removed multi compatible strings which are not needed;
- Added comments for the function sprd_iommu_clk_enable();
- Added clocks property in bindings;
- Set device_driver.suppress_bind_attrs to disable unbind the devices via sysfs;
- A few trivial fixes.

Changes since RFC v2:
* Addressed Robin's comments:
- Add COMPILE_TEST support;
- Use DMA allocator for PTE;
- Revised to avoid resource leak issue;
- Added ->iotlb_sync implemented;
- Moved iommu group allocation to probe;
- Changed some function names to make them sprd specific;
* Added support for more iommu instance;

Changes since RFC v1:
* Rebased on v5.11-rc1;
* Changed sprd-iommu to tristate;
* Removed check for args_count of iommu OF node, since there's no args
  for sprd-iommu device node;
* Added another IP version (i.e. vau);
* Removed unnecessary configs selection from CONFIG_SPRD_IOMMU;
* Changed to get zeroed pages.

Chunyan Zhang (2):
  dt-bindings: iommu: add bindings for sprd IOMMU
  iommu: add Unisoc IOMMU basic driver

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  72 +++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 599 ++++++++++++++++++
 4 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

