Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D9355EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbhDFWou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 18:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhDFWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:44:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 15:44:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso287313pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydQPVFsDk2iufZP8Pwk0+yoCaEl+JPOZbz8HSe06cBU=;
        b=P9dhD0CQtilqryljLatmB/B3ObijoycWGtgs6GE7UPvcFnjhZGJzwYmEiqz7raJjgv
         e3elELphv/6K2kjkXcQ6US60Zcrtid1gTZkepHhaA0Zar1hw0Tdx0iMtMQ37BaVfrjnK
         AwxsfU8tFep58TDdTO5+xeSXhbtIGcFIzwbg2TKnw8Nr306gHfA6N/FO/8QcdHabZUTu
         ihsamGKwAosVCRCXQbY82Nfh/rK4VGYIygCrvwWKNrjbH7+xirDc3n4rntItRY/eqXIa
         SmgamR4r+Kvvz+yP6/8MCeYreNXg5IowaX+pKGxLW64MIxsKbhtnIpGqi+pGoVwekSis
         V3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydQPVFsDk2iufZP8Pwk0+yoCaEl+JPOZbz8HSe06cBU=;
        b=kUa4npVBRqFbeVfjpfzISIKtm4G9ONw84nF1POBmDXF3tNA7tujAlItkw8DtiES7fo
         EZp9VVz4KxLUNGlIKCdFZCb7aXa7WvGF4aphNeg9eNwHyoIZ85s5YbgZzisoahJTKees
         ZW+dO+Sgnfj5B3EPZscoBLfakHHXXqdRFG2NH/rxVgNQFUjGgVN8dtFxL/J6/6FLIvHp
         nSXLrI2/ch8ArTKUAIjnCiViQFBc0iS1vT5YVLxo3kyfVwHWltk9bJ8FVKWCh/hu+la9
         ftKn8ehPBxCjVOHJZ1/0jTJu2W6/mvCeSVdGWpU1KVZAT29CbWZ0LFP47Ybbo7Gn/ny4
         nakQ==
X-Gm-Message-State: AOAM530IlQe6ByUBF2K9b05g+eoB0bw11u5jtpso3qnsY956dtui4lxd
        htGJkrOK5PDZ8Ioowx2PVqyo2A==
X-Google-Smtp-Source: ABdhPJwtLtQX7kcsTyuHRf4E/4KZRByEV2n9JQaZBRjQwRoIlWTqjoo6FXFbxpOGb725pX7mCVT+HA==
X-Received: by 2002:a17:90a:66c5:: with SMTP id z5mr392494pjl.172.1617749079098;
        Tue, 06 Apr 2021 15:44:39 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g3sm18620914pfk.186.2021.04.06.15.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:44:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     maz@kernel.org
Cc:     suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        coresight@lists.linaro.org
Subject: [GIT PULL v2] coresight: Add support for ETE and TRBE
Date:   Tue,  6 Apr 2021 16:44:37 -0600
Message-Id: <20210406224437.330939-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a354a64d91eec3e0f8ef0eed575b480fd75b999c:

  KVM: arm64: Disable guest access to trace filter controls (2021-03-24 17:26:38 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git next-ETE-TRBE

for you to fetch changes up to 4fb13790417a7bf726f3867a5d2b9723efde488b:

  dts: bindings: Document device tree bindings for Arm TRBE (2021-04-06 16:05:38 -0600)

----------------------------------------------------------------
Anshuman Khandual (5):
      arm64: Add TRBE definitions
      coresight: core: Add support for dedicated percpu sinks
      coresight: sink: Add TRBE driver
      Documentation: coresight: trbe: Sysfs ABI description
      Documentation: trace: Add documentation for TRBE

Suzuki K Poulose (15):
      perf: aux: Add flags for the buffer format
      perf: aux: Add CoreSight PMU buffer formats
      arm64: Add support for trace synchronization barrier
      KVM: arm64: Handle access to TRFCR_EL1
      KVM: arm64: Move SPE availability check to VCPU load
      arm64: KVM: Enable access to TRBE support for host
      coresight: etm4x: Move ETM to prohibited region for disable
      coresight: etm-perf: Allow an event to use different sinks
      coresight: Do not scan for graph if none is present
      coresight: etm4x: Add support for PE OS lock
      coresight: ete: Add support for ETE sysreg access
      coresight: ete: Add support for ETE tracing
      dts: bindings: Document device tree bindings for ETE
      coresight: etm-perf: Handle stale output handles
      dts: bindings: Document device tree bindings for Arm TRBE

 .../ABI/testing/sysfs-bus-coresight-devices-trbe   |   14 +
 Documentation/devicetree/bindings/arm/ete.yaml     |   75 ++
 Documentation/devicetree/bindings/arm/trbe.yaml    |   49 +
 Documentation/trace/coresight/coresight-trbe.rst   |   38 +
 MAINTAINERS                                        |    2 +
 arch/arm64/include/asm/barrier.h                   |    1 +
 arch/arm64/include/asm/el2_setup.h                 |   13 +
 arch/arm64/include/asm/kvm_arm.h                   |    2 +
 arch/arm64/include/asm/kvm_host.h                  |    8 +
 arch/arm64/include/asm/sysreg.h                    |   50 +
 arch/arm64/kernel/hyp-stub.S                       |    3 +-
 arch/arm64/kvm/arm.c                               |    2 +
 arch/arm64/kvm/debug.c                             |   35 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c                 |   56 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |    1 +
 arch/arm64/kvm/sys_regs.c                          |    1 +
 drivers/hwtracing/coresight/Kconfig                |   24 +-
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-core.c       |   29 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  119 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  161 ++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   19 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   83 +-
 drivers/hwtracing/coresight/coresight-platform.c   |    6 +
 drivers/hwtracing/coresight/coresight-priv.h       |    3 +
 drivers/hwtracing/coresight/coresight-trbe.c       | 1157 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h       |  152 +++
 include/linux/coresight.h                          |   13 +
 include/uapi/linux/perf_event.h                    |   13 +-
 29 files changed, 2053 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
 create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
