Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754530B8B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBBHfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhBBHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:35:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CAC061573;
        Mon,  1 Feb 2021 23:34:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx20so1826549pjb.1;
        Mon, 01 Feb 2021 23:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ompRf8cfDRH36F3caoFFYG+tYZCSg50YdpkIE/hyJMw=;
        b=Zy5ftunn/tYYdnM+XyFaEA+A377YXR8PS1iLHZH6WHb0yYO4I0Gb6BYTQhcSP25m2r
         8m3TP94MfEV/40+M+S7HQcYlXswNIovQo5uvDlPMFhwyt1sCDQrVKZA2wRdNtzznpfFu
         wvvKmJJ0WOgz1MKBFH3145anoQyDMcExERONt5cdXrkkT2ct5rGhxnCyQybGOqT8hiNW
         BQweVybRGrw6s4STZUnnlPAhjdXzV+1vXhyb7fxPwuBwB627tPvdURDTR3y6Oubsfq4M
         2ZpQSGaQeXhtFCrzzAcyGpeWj+ypkmS3daTd+u5ohrPaUW5RMvdYE/HvL7FkBCviI5UO
         xYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ompRf8cfDRH36F3caoFFYG+tYZCSg50YdpkIE/hyJMw=;
        b=jXF72PeR65I0iTkyBx7Q1hkd2iRRJUByP2GWygoeUmUYSiMRp4qL11+2tkYNoFMk+c
         bBeeTttdekb31saKaVZbHlTM0V2CBlAeQ4XAa1shoGIq2brL3bFDXTCd81R0Kj4ffSNH
         0WfUhHkRG+wPPLnIp6N7Y2ItdRALTXrwBf8MJiywpWf7upj4DvdZM4Ro8UUFPrVEtufq
         hQCZF5KSC4sRiumMu9wDmIpIvXkJM2xCMjJ3CVhX5oExpkHt0k+tYybCMx6HmHzY69zG
         Ly0+BuMZKYKL+ykrzWZC36Wm8zSWGiaS7EW8d5PEhfkczNKmyV8I9mkBXPy3erTLb/gl
         u6mA==
X-Gm-Message-State: AOAM530xbpBHv0XaKY86djUXLq+IXS1VFuLSuYEcPC0zWVoZwgzn0jmS
        2PZUB+O09TTqbeL+KI8lWoq3kJuB+NABmAxi
X-Google-Smtp-Source: ABdhPJxubgvThdN3w0Do+rIfD5d52IfjQerNh2trcyjPIFIHaTiJs4qwGq8mCgL1ei0RSs7Y8awBNg==
X-Received: by 2002:a17:90a:1a0b:: with SMTP id 11mr2922498pjk.58.1612251269773;
        Mon, 01 Feb 2021 23:34:29 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o4sm1752029pjs.57.2021.02.01.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 23:34:29 -0800 (PST)
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
Subject: [PATCH v2 0/2] Add Unisoc iommu basic driver
Date:   Tue,  2 Feb 2021 15:32:56 +0800
Message-Id: <20210202073258.559443-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

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
 drivers/iommu/sprd-iommu.c                    | 581 ++++++++++++++++++
 4 files changed, 666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

