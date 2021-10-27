Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0115543D1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbhJ0Tyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhJ0Tyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:54:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:52:27 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l186so3999493pge.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSeqm2vFVgD0HsDYrqeR0xtWPQ5r0M1XHRu+rF4K7d8=;
        b=bryM6u/8Tef5/jCCnk6o5l6gfH5RHYrSd1LCAAgsfJlGUiDxXBzaIypwDPv4NPTRp8
         g7k86a1+mSPMeAPVGl+8xKEr1r0fq2y6+s0BFMHL0Z7A7FB6smqfWRXtPO1grvrkShYG
         jRrNroQxGdmRXLFg/rAdj/s3n6UdVVHKa9rIBs94a9/2SBjNNx/7ge1C0jn+CyPwDRbq
         MixqdvM6NQZJNLDvYQktosmJxJp+4BV9UCqCoimlkJfg67j60fRpIzriXld5Ba7+v/Ap
         /VEwvSPsytDMXszkNzmdyTwPhQy6bdRVPF/MPEIgndg7QqdKNDfVhEW1Sf1rbB71t7Dn
         EHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSeqm2vFVgD0HsDYrqeR0xtWPQ5r0M1XHRu+rF4K7d8=;
        b=Zu6jB8cbVaDSbLizt9HNedt/U7LV/sg/u46x/6s13gz0qsoyISfkXqHBILd4lPzctF
         fnaGEcfk8juR3xhkE3w6NcAW7HqKbrkrg4xTUo7I58Gjs9qxI/ZkuNlrKSqK2iOs4K92
         VH0sost8OWgSqbUw80nh81kXDpDcJX8Rrcscz7RK0PxHoEaBJhQoGOnjSKXUtJJ6mGjr
         BAEiSriY7YO/bAcDEfeDwbab84vaxDXy7C56PENrM5VpFjQNBQ+6F9jLPJtDglpNPYBA
         PrDJwQNh8o1qlfnwvmchvmU1JYO/wRosm2zUatdxlSwjxze5jN/g+agcRketnTK/bzAi
         muhg==
X-Gm-Message-State: AOAM533XgMh8Fx1/mSD83TFNIGg4gh4xOYryuvRPYXi1NxhwSlUj82wf
        +kS5Ej+5EzPo+HZjaCTiylBBdUrPmUHmaQ==
X-Google-Smtp-Source: ABdhPJyLEYAoib3Y6ZBD2HwcZVwzxz0Dq07uLW47IEE7HFMgHVbdNLYRkWMaOecw8v93qYfdoHq3uw==
X-Received: by 2002:a63:9212:: with SMTP id o18mr25778861pgd.392.1635364347024;
        Wed, 27 Oct 2021 12:52:27 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x9sm5050899pjp.50.2021.10.27.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:52:25 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL v3] Coresight changes for v5.16
Date:   Wed, 27 Oct 2021 13:52:24 -0600
Message-Id: <20211027195224.4005465-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16.v3

for you to fetch changes up to 561ced0bb90a4be298b7db5fb54f29731d74a3f6:

  arm64: errata: Enable TRBE workaround for write to out-of-range address (2021-10-27 11:46:06 -0600)

----------------------------------------------------------------
Coresight changes for v5.16

- A new option to make coresight cpu-debug capabilities available as early
as possible in the kernel boot process.

- Make trace sessions more enduring by coping with scenarios where events
are scheduled on CPUs that can't reach the selected sink.

- A set of improvement to make the TMC-ETR driver more efficient.

- Enhancements to the TRBE driver to correct several errata.

- An enhancement to make the AXI burts size configurable for TMC devices
that can't work with the default value.

- A fix in the CTI module to use the correct device when calling
pm_runtime_put()

- The addition of the Kryo-5xx device to the list of support ETMs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

----------------------------------------------------------------
Brian Norris (1):
      coresight: cpu-debug: Control default behavior via Kconfig

James Clark (1):
      coresight: Don't immediately close events that are run on invalid CPU/sink combos

Leo Yan (5):
      coresight: tmc-etr: Add barrier after updating AUX ring buffer
      coresight: tmc-etf: Add comment for store ordering
      coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
      coresight: Update comments for removing cs_etm_find_snapshot()
      coresight: tmc-etr: Speed up for bounce buffer in flat mode

Suzuki K Poulose (28):
      arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
      arm64: errata: Add detection for TRBE overwrite in FILL mode
      arm64: errata: Add workaround for TSB flush failures
      arm64: errata: Add detection for TRBE write to out-of-range
      coresight: etm4x: Save restore TRFCR_EL1
      coresight: etm4x: Use Trace Filtering controls dynamically
      coresight: etm-pmu: Ensure the AUX handle is valid
      coresight: trbe: Ensure the format flag is always set
      coresight: trbe: Drop duplicate TRUNCATE flags
      coresight: trbe: Unify the enabling sequence
      coresight: trbe: irq handler: Do not disable TRBE if no action is needed
      coresight: trbe: Fix handling of spurious interrupts
      coresight: trbe: Do not truncate buffer on IRQ
      coresight: trbe: End the AUX handle on truncation
      coresight: trbe: Prohibit trace before disabling TRBE
      coresight: trbe: Fix incorrect access of the sink specific data
      coresight: trbe: Defer the probe on offline CPUs
      coresight: trbe: Add a helper to calculate the trace generated
      coresight: trbe: Add a helper to pad a given buffer area
      coresight: trbe: Decouple buffer base from the hardware base
      coresight: trbe: Allow driver to choose a different alignment
      coresight: trbe: Add infrastructure for Errata handling
      coresight: trbe: Workaround TRBE errata overwrite in FILL mode
      coresight: trbe: Add a helper to determine the minimum buffer size
      coresight: trbe: Make sure we have enough space
      coresight: trbe: Work around write to out of range
      arm64: errata: Enable workaround for TRBE overwrite in FILL mode
      arm64: errata: Enable TRBE workaround for write to out-of-range address

Tanmay Jagdale (2):
      dt-bindings: coresight: Add burst size for TMC
      coresight: tmc: Configure AXI write burst size

Tao Zhang (2):
      coresight: cti: Correct the parameter for pm_runtime_put
      coresight: etm4x: Add ETM PID for Kryo-5XX

 Documentation/arm64/silicon-errata.rst             |  12 +
 .../devicetree/bindings/arm/coresight.txt          |   5 +
 arch/arm64/Kconfig                                 | 111 +++++
 arch/arm64/include/asm/barrier.h                   |  16 +-
 arch/arm64/include/asm/cputype.h                   |   4 +
 arch/arm64/kernel/cpu_errata.c                     |  64 +++
 arch/arm64/tools/cpucaps                           |   3 +
 drivers/hwtracing/coresight/Kconfig                |  13 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   2 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |   2 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  56 ++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 101 +++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   9 +-
 .../coresight/coresight-self-hosted-trace.h        |  33 ++
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  21 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  10 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  52 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   6 +-
 drivers/hwtracing/coresight/coresight-trbe.c       | 534 +++++++++++++++++----
 20 files changed, 905 insertions(+), 154 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-self-hosted-trace.h
