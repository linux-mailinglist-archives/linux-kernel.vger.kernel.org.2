Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1414E32E4E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCEJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCEJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:32:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBD0C061574;
        Fri,  5 Mar 2021 01:32:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o6so1605712pjf.5;
        Fri, 05 Mar 2021 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlaOlPxH8Zhtxoq9sQT2kqVDB3VTC2lAkFE3uKaCSs0=;
        b=l9zC5NxXiCZPKfyavKoqgPEuKb/8RgMHLiiAPqENWvDj50ekCI9sFM2AsQ7c+sFMJX
         sfEJ9qY5Y/C7xKhzqObiw4eK3jZfm5eWM1FjxWBUOJZLAvYaAmkvdeq2NBMHLywUHtVY
         7dIfvcnXm3X8okewZuBqUyYWDLSRymOMlILXQqlOFv7w/A0jcB0zc43is/HZTwVnPnf5
         ygAC2dz52JSQrAkTAA7X8Ir59b3te3tesx7DTl8EDItlrbd3f1C4HVkPvJZtaL+t+6EF
         nwk72iDQ7ajE4ujKe3TUBAPUmVNjl7OhJa1aRWWVIpDuDV2EEtvStyaDhPfOz3nXaTPd
         HOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlaOlPxH8Zhtxoq9sQT2kqVDB3VTC2lAkFE3uKaCSs0=;
        b=e0FAzxsU3Qm39RvAuqcXy1mj/1OnsBRMJAZFNqufwerU4tW/uVPz/xI36tquuU5l1A
         uE80bn6TjcRatbvMcl2MWPrCnDfjU9BdQAuUy007s6FKHcSoxr7VsQz4KrmazpR4Qqcd
         FKi9G463Ibj2RSwD1EbVH5G6g8kWxtntNrIzQ/lLruHR1GNMILb68oTYO/CsH02vWC/p
         A83OFiRbhcrseW5mt/cY1iw+a1idItLfkPVUiJqKsLzoyZ5vIa0oGZAnGuJDVfVhpIxh
         /Hz0KktuTOA8GR+ma2pSPYvEPBKRdLIRWzqWw1+I1X+sqnNe8amiPmvxUWnF66qNz0lJ
         TUDQ==
X-Gm-Message-State: AOAM5302sGCjntY8jqEELZ8Nj4k5b5wZoX06p6X5krdFVcs/Re7Lk0Ml
        afn+9aMXBxsrkWeCHj+2HCM=
X-Google-Smtp-Source: ABdhPJxwaZiAt9xWzko57VylfxIb4L8IF71cfnxEDaKk95zKhLLEFv/627CqdtqbrJaREDsl3Ylv+Q==
X-Received: by 2002:a17:90a:34cc:: with SMTP id m12mr9128555pjf.232.1614936755648;
        Fri, 05 Mar 2021 01:32:35 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f3sm1873967pfe.25.2021.03.05.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:32:35 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 0/2] Add Unisoc IOMMU basic driver
Date:   Fri,  5 Mar 2021 17:32:14 +0800
Message-Id: <20210305093216.201897-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since v4 (https://lkml.org/lkml/2021/2/4/85):
* Rebased on v5.12-rc1;
* Dropped using syscon node for mapping registers according to Rob's comments.

Changes since v3 (https://lkml.org/lkml/2021/2/3/161):
* Rebased on iommu/next, and fixed compile error reported by kernel test robot <lkp@intel.com>;
* %s/iommu/IOMMU/ properly in the whole patchset.

Changes since v2 (https://lkml.org/lkml/2021/2/2/106):
* Added a WARN and return 0 if an invalid iova was passed to sprd_iommu_iova_to_phys();
* Changed the name of sprd_iommu_write();
* Revised CONFIG_SPRD_IOMMU help graph in Kconfig.
* Revised comments for the struct sprd_iommu_device;
* Converted to use "GPL" instread of "GPL v2", they are same as license-rules.rst shows.

Changes since v1 (https://lkml.org/lkml/2021/1/21/563):
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

Changes since RFC v2 (https://lkml.org/lkml/2021/1/8/277):
* Addressed Robin's comments:
- Add COMPILE_TEST support;
- Use DMA allocator for PTE;
- Revised to avoid resource leak issue;
- Added ->iotlb_sync implemented;
- Moved iommu group allocation to probe;
- Changed some function names to make them sprd specific;
* Added support for more iommu instance;

Changes since RFC v1 (https://lkml.org/lkml/2020/12/23/209):
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

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  57 ++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 577 ++++++++++++++++++
 4 files changed, 647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

