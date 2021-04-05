Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9040D35470E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhDETSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhDETSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:18:06 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB26C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 12:18:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l9so4906063ils.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHLstFl2ku4bYCzz1WZkvX4oaw4PKWZ3DbDRoWQ+a5o=;
        b=gs7g7FNLclp85jxf6NJG2V2V4pjlyLLa6zhzNVE2zUDb4nZsY7AbQpqaurjeuM4FNW
         slAwYc/fSlBNYY7JmeHErixM0AavtryxP/2K/7ET9GLoMKkdsl4A7YBbdXr+el6Qditn
         /WjHUlF0wwiKqCVWpyVS3d/Gab5vBaC64ZFLie0pvzdvcDD45+svFQCzPCRJIWcnb6lZ
         wVZLPXEqq0aW9LG6dxALFfSEhsh/EZJTbGTa/yJr2bx8eU2cN8GzfqWJCGnpZwcx6kN+
         Bn7wVPwrEjz8xzJlHkzD8B6fesZj9i33Yb4xfl8qZMUn6EZnqrWNBVbjffoeCzYdlIDO
         podg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHLstFl2ku4bYCzz1WZkvX4oaw4PKWZ3DbDRoWQ+a5o=;
        b=bBGUhPq57+FMI3CLZSyw9Cx30ragRuLfB9ELiNPJ2Qy1E81KC3hK3k2nJQLH5loA5P
         nZ/MNzN9cnMsv/FahDtB5a7MmuhqBT1P0ZjV4SdVbE5oB8ZA4A/2hbJboALMESv0irAN
         UcnZEY0175KUCl/j0sIREzrM8iJZbUER1kIS+5x1CZHgyOomIFX/UHDb1bb0xIiUDOdz
         J4Rh3iaVYaeqC7l1aNhsy4gnUzwsW5/SH5wEWyM+2UtQ0+kJ6Qk6d28ReVx8UFHKImAK
         U8P0LmdPwAoBX9QKEVUriDfVpGU31AokACbqIPTxUwGbP8EvhUOXiKhF0MuKN4tZel6I
         SNFg==
X-Gm-Message-State: AOAM531SeqQmCrF6AeSrot4n4mD5vvqJQ8nGlscFjRnuvYCQKzjSxD2Z
        sSLeDDXNsoQZ2MnGyiKzlz61Qw==
X-Google-Smtp-Source: ABdhPJyI2ULQNtPuXaK5HRHUd17HveUSE+nrgkCeFiECbb6TP1xMihwUNeTtfQoHtCe+DEH63AcTKQ==
X-Received: by 2002:a92:c989:: with SMTP id y9mr5101467iln.173.1617650279473;
        Mon, 05 Apr 2021 12:17:59 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h12sm2510760ilh.32.2021.04.05.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 12:17:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     maz@kernel.org
Cc:     suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [GIT PULL] coresight: Add support for ETE and TRBE
Date:   Mon,  5 Apr 2021 13:17:57 -0600
Message-Id: <20210405191757.283122-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a354a64d91eec3e0f8ef0eed575b480fd75b999c:

  KVM: arm64: Disable guest access to trace filter controls (2021-03-24 17:26:38 +0000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git next-ETE-TRBE

for you to fetch changes up to 7885b4e43231048654c5a80c0a18844ce3185e64:

  dts: bindings: Document device tree bindings for Arm TRBE (2021-04-05 11:38:04 -0600)

----------------------------------------------------------------
Hi Marc,

As previously agreed, here are the changes to support CoreSight
ETE and TRBE components submitted here[1].

I draw your attention to these:

[PATCH v6 05/20] kvm: arm64: Handle access to TRFCR_EL1
[PATCH v6 06/20] kvm: arm64: Move SPE availability check to VCPU load
[PATCH v6 07/20] arm64: kvm: Enable access to TRBE support for host

They are KVM specific and will need an SoB tag.

Thanks,
Mathieu

[1]. https://lore.kernel.org/linux-arm-kernel/20210405164307.1720226-1-suzuki.poulose@arm.com/T/#t

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
      kvm: arm64: Handle access to TRFCR_EL1
      kvm: arm64: Move SPE availability check to VCPU load
      arm64: kvm: Enable access to TRBE support for host
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
