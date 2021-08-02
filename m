Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683A93DCFEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHBFN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhHBFN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:13:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F453C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 22:13:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so4058696pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 22:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7wErfJnemqmkpSnND/NJjt/B433jaaKWUYaUIOjwmY=;
        b=aByg+Q6kxHiBgEbKANwF6Aya22K0vI9SyTfdy0oTMbn1b8a6VooO9j4J8rw/Vtz6Pr
         dO1hI2FN/Bbi64ocPmV0G/e5+riudr2VIdougShkvoMEnAt/+yhBAIxA3fezDIdOdttK
         NZEuAVxZRoQJPr1lWqGGUag22Lt/yntSBMLOidWps7aEnkgdReTnTdE5grtQZZT6dKEl
         FPlC5UHuFrD6sg4NwvdUR88SN9myXpmcOX+ZUNBXuVFIXl3bTsBJWqouKasFGoAGdB3K
         bTD4rest4GpoWDv5qZX+LiypClA2CbGseOSgjCOxN2dbPByP0Sf7yK+Udrs08iomUj2x
         kLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7wErfJnemqmkpSnND/NJjt/B433jaaKWUYaUIOjwmY=;
        b=Nk8fZvdGwzRRjjOUe/tBOqNl2BqIsHAxwpdohrrSI2sB3IwG3P86ApPqBm4mkwdM6q
         I778K3yOXTh1eW2h2GFVoRPaAcWroYqGy1sISHktUvINK72v8XYRWG1/FNT6Oax1ey4M
         EJ0ifGYVHN4/iIhp24rdT9uHV51ju3Gy+Arll/bhKDav5F/kqtBwHv3oW5Vs6T75OPFw
         AV6BAhiTm2y7RJEpfMFBMa35oqcmUu/oLRjYMBPDOHKHKswY/G9L4Z3/g3A3YniGX3rV
         yvok45Ckw5QhX+LTlG5IkvCLna1kHNcWPKdeMk+bDUsfaZXygzAC2wLuRkQsF6/g3KAN
         HMSA==
X-Gm-Message-State: AOAM530joOAoO9VJOaXmauBbMFY6ShB5r7tvWUdFuExN92SC4eWKUjBX
        pjddWJbsr87Pu1l3cOvKYFUO
X-Google-Smtp-Source: ABdhPJyKbd2Yb3EMs9dE6dhoEizbQf3cMD3KGaacxcVEHi64txBJQY703z9mg1T953pzrJAz6d8iVg==
X-Received: by 2002:a17:90b:3704:: with SMTP id mg4mr15049978pjb.201.1627881194992;
        Sun, 01 Aug 2021 22:13:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e99:242f:6391:b1b4:1ad8:fbdf])
        by smtp.gmail.com with ESMTPSA id x26sm9947000pfm.77.2021.08.01.22.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 22:13:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/10] MHI patches for v5.15 - Take 1
Date:   Mon,  2 Aug 2021 10:42:45 +0530
Message-Id: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is the first round of MHI patches for v5.15. Most of the patches missed
v5.14 due to late submission, so sending them early now.

Summary:

1. Added a dedicated flag to the MHI client transfer APIs for inbound
buffer allocation by the MHI stack. This is required for some downlink
channels like QRTR that depends on pre-allocated buffers. Since the patch
modifies the MHI client drivers under "net/", Ack has been collected from
the netdev maintainer.

2. Added support for Cinterion MV31-W modem in pci_generic controller:
https://www.thalesgroup.com/en/markets/digital-identity-and-security/iot/iot-connectivity/products/iot-products/mv31-w-ultra-high

3. Rearranged the setting of BHI/BHIe offsets for better validation of the
register values read from MMIO.

4. Cleanup of the BHI/BHIe pointers by setting them to NULL to prevent access
after power down.

5. Added support for getting the MMIO register length from the controller
drivers. This helps in validation of the read offsets from MMIO registers
in the MHI stack.

6. Added the MMIO register length support in the controller drivers and
collected Acks from the maintainers.

7. With the help of above register length, added check for BHI/BHIe offsets
in the MHI core.

8. Used the DMA allocation APIs directly instead of using MHI specific APIs,
mhi_alloc_coherent() and mhi_free_coherent(). They were not doing anything
special other than calling the DMA allocation APIs.

9. Finally, a patch to improve the debug messages for the power up operation
by showing the current EE states.

Please consider merging!

Thanks,
Mani

Bhaumik Bhatt (8):
  bus: mhi: core: Set BHI/BHIe offsets on power up preparation
  bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
  bus: mhi: Add MMIO region length to controller structure
  ath11k: set register access length for MHI driver
  bus: mhi: pci_generic: Set register access length for MHI driver
  bus: mhi: core: Add range checks for BHI and BHIe
  bus: mhi: core: Replace DMA allocation wrappers with original APIs
  bus: mhi: core: Improve debug messages for power up

Loic Poulain (1):
  bus: mhi: Add inbound buffers allocation flag

ULRICH Thomas (1):
  bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI

 drivers/bus/mhi/core/boot.c           | 17 ++---
 drivers/bus/mhi/core/init.c           | 93 +++++++++++++++++----------
 drivers/bus/mhi/core/internal.h       | 22 +------
 drivers/bus/mhi/core/main.c           | 15 +++--
 drivers/bus/mhi/core/pm.c             | 34 +++-------
 drivers/bus/mhi/pci_generic.c         | 38 +++++++++++
 drivers/net/mhi/net.c                 |  2 +-
 drivers/net/wireless/ath/ath11k/mhi.c |  1 +
 drivers/net/wwan/mhi_wwan_ctrl.c      |  2 +-
 include/linux/mhi.h                   |  9 ++-
 net/qrtr/mhi.c                        |  2 +-
 11 files changed, 136 insertions(+), 99 deletions(-)

-- 
2.25.1

