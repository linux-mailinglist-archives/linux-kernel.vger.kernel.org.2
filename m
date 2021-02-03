Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6A30D5E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhBCJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhBCJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:08:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CEFC06174A;
        Wed,  3 Feb 2021 01:07:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 8so8740060plc.10;
        Wed, 03 Feb 2021 01:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlWrFn/TSCs6U2fJNlgqQGt6rx/LlAU4ePBPMQXyuj4=;
        b=BoeBXegHPtpfm1J6JIqhLbXQZbMnDJ1K0LIEg6EmgpUPSVJoeW3bDSdHkMw08nBgnx
         CT/yT4PZAKKoKN/Rs9JZEe9UcYYW7agC3luIWAD5/NsyPLog1Vt9+WCVB4V3pAwio2yv
         pEZr5EqE3k26IKBPz0DrtcEh8fScLp1RHByEDFAXjW0q34BPj4zqZDA7hBsIquZ3w8f3
         r5ncp3g7cLOBaYymEIEStumGJ0KY8LycKgF4hLhJPdqcEZgW1bEp0vjSi41CZ8poeyvr
         7SsK+dB4FW1LtE0QoUbe1ZN+kB+Mxr6oBlySMxE7gdNSFBEhsZxqxFhO1HuqXoFkK196
         rkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlWrFn/TSCs6U2fJNlgqQGt6rx/LlAU4ePBPMQXyuj4=;
        b=FhV+uh16fh/jlQv/D45k36vz42/L6yKTIfVFhykowlNrarm3cmONcivhyIqSmO55ct
         EkcJDQlPzt5eOySb+inutRnCFiksS03g4zGYoxvqyD1ngQolRwzr/oVwNQxbmz+qCm8j
         Bpck7STDLwqiHndkzK6KaZ6Sg62BZWWlyfr+DGZHNkcbgKBc0xaHicBJoRyHmXCZVpfp
         uwMmTFTGmgE70TdSwNeVb95rYOaBud0GopZSlVvtpMXjWx60rxmluIxQbnyTnZkPZ4ce
         xe5ibpJ8LScq29uSyf3wXBZNXA5AzlL8PIWuhX6yOx0zKIZ5a/pY7vd9LJcVUIgpYH2g
         EeBA==
X-Gm-Message-State: AOAM531C6v9AGAmpiMnCRceEvIZMJQXvzTRn2N6e0aD32PyGInTF+h7J
        7bzYsx6eWlsFwjVk0PGkJBE=
X-Google-Smtp-Source: ABdhPJzk5sUgntpfAW2isz8JD3HlK8ruAhrrayyoG3um2jd4JvwT9MPXOJFEL2QSOLqYLaPD+bnTBQ==
X-Received: by 2002:a17:902:6b45:b029:e0:7a3:a8c with SMTP id g5-20020a1709026b45b02900e007a30a8cmr2303023plt.1.1612343266293;
        Wed, 03 Feb 2021 01:07:46 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y12sm1586403pfp.166.2021.02.03.01.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:07:45 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 0/2] Add Unisoc iommu basic driver
Date:   Wed,  3 Feb 2021 17:07:25 +0800
Message-Id: <20210203090727.789939-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

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
  dt-bindings: iommu: add bindings for sprd iommu
  iommu: add Unisoc iommu basic driver

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  72 +++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 600 ++++++++++++++++++
 4 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

