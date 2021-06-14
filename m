Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6243A6F77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhFNTyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:54:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhFNTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:54:07 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lssct-0001Pu-7p
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 19:52:03 +0000
Received: by mail-ed1-f70.google.com with SMTP id f12-20020a056402150cb029038fdcfb6ea2so20805676edw.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g40NCw0isARf17PrJeRDjNgvRyngtExig+wrg1pV/+w=;
        b=iaU7LXl/ygHY0KyIJjfoamAMfjzv9sxz+7O22NQpil75KYqtdycjWpyV231Fl6b4zt
         45qo+LyrYO0HDhrcSBt+fSOQfpjYxWTON33JwHr5RQd7HebiDtMtV/hyX9O5BX/fzvvC
         QTTXIvlDi4dKqwTnujZpy3yr7kIH0FOA1qvwvFdNrYoQKMLxXFfnxEVruY9zL9MlRBZ3
         CqK2UAvJFww0bZs/FXJ2gjjO67QzBXXWrYB+WJOyE68Klt8gDreXhk0hi7LAIL/1rf8D
         6rwdLoKvLljMm78NHnm5xeE949UtjnHHvWNxhcDZ1/5A6VxWkHfqg+7qKPIvtc2Mnj1U
         phqg==
X-Gm-Message-State: AOAM532dxPweCvLs9ROwZwUBGJDl90BTIgCblghS4hrdXeG0lXc2QTmj
        PSgD2yZ13SI7lKGyKtVvJFzFJ3tkcEcTFbrkbC/chOl9jhIM5CzwzQH4O10LMQjn4E4/V+YSYeK
        RSgv1OV/Kg6itxdK25y/z3IBVArK/a5v6vjUcQawnfA==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr19077458edr.317.1623700322986;
        Mon, 14 Jun 2021 12:52:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtT26zZF3miJH40zsNZX/PUVK61FfjtTB6IRaEhDKtCcrAFxyAPayK97nBxMkXlr8L+QTojA==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr19077436edr.317.1623700322784;
        Mon, 14 Jun 2021 12:52:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id cx7sm9795335edb.65.2021.06.14.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:52:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] memory: Tegra for v5.14, part two
Date:   Mon, 14 Jun 2021 21:52:00 +0200
Message-Id: <20210614195200.21657-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

Tegra got quite big rework this cycle.  The last piece comes from Thierry,
however it depends on one patch in Will's tree.  Since the last Thierry's
patches depend both on that one patch and other memory controller drivers
changes, they are here.

Best regards,
Krzysztof


The following changes since commit 393d66fd2cacba3e6aa95d7bb38790bfb7b1cc3a:

  memory: tegra: Implement SID override programming (2021-06-03 21:50:43 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.14-2

for you to fetch changes up to 2c1bc371268862a991a6498e1dddc8971b9076b8:

  iommu/arm-smmu: Use Tegra implementation on Tegra186 (2021-06-11 08:44:53 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.14 - Tegra SoC, part two

Second set of changes for Tegra SoC memory controller drivers,
containing patchset from Thierry Reding:

"The goal here is to avoid early identity mappings altogether and instead
postpone the need for the identity mappings to when devices are attached
to the SMMU. This works by making the SMMU driver coordinate with the
memory controller driver on when to start enforcing SMMU translations.
This makes Tegra behave in a more standard way and pushes the code to
deal with the Tegra-specific programming into the NVIDIA SMMU
implementation."

This pulls a dependency from Will Deacon (ARM SMMU driver) and contains
further ARM SMMU driver patches to resolve complex dependencies between
different patchsets.  The pull from Will contains only one patch
("Implement ->probe_finalize()").  Further work in Will's tree might
depend on this patch, therefore patch was applied there.

On the other hand, this ("Implement ->probe_finalize()") patch is also a
dependency for ARM SMMU driver changes for Tegra.  These changes,
bringing seamless transition from the firmware framebuffer to the OS
framebuffer, depend on earlier Tegra memory controller driver patches.

----------------------------------------------------------------
Dan Carpenter (1):
      memory: tegra: Delete dead debugfs checking code

Krzysztof Kozlowski (1):
      Merge branch 'for-thierry/arm-smmu' of https://git.kernel.org/pub/scm/linux/kernel/git/will/linux into for-v5.14/tegra-mc

Thierry Reding (5):
      iommu/arm-smmu: Implement ->probe_finalize()
      dt-bindings: arm-smmu: Add Tegra186 compatible string
      iommu/arm-smmu: tegra: Detect number of instances at runtime
      iommu/arm-smmu: tegra: Implement SID override programming
      iommu/arm-smmu: Use Tegra implementation on Tegra186

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 11 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |  3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c       | 90 +++++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 13 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  1 +
 drivers/memory/tegra/tegra124-emc.c                |  4 -
 drivers/memory/tegra/tegra20-emc.c                 |  4 -
 drivers/memory/tegra/tegra210-emc-core.c           |  4 -
 drivers/memory/tegra/tegra30-emc.c                 |  4 -
 9 files changed, 96 insertions(+), 38 deletions(-)
