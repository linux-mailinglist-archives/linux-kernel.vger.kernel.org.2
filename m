Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F943BB43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhJZT6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhJZT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:58:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E100C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:55:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso345148pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3u3OZ4ReGap6MDckDvaugP/Cyefq/GOGQ2Dr3PW7MJs=;
        b=Sd+uqLbKtPsfihKWibPSh+Vthxu9BWxk4OxlBXe0DYR0qZNBLTk8GR/JMMv65H775z
         uBP6RXj69v4ndnuV9Ho64/DHhV8TWopUx4v4kfS1/y7vh/VwyBD88rd+ZfnFsV1UDUbd
         eZnYG89vNrAXbA23+n7nFFgwATLLXaoOwyCcGMOzy8U2S1Z/4Zx/DH6fO4fz/d3Bp7Tn
         1mEvapRfDi75lefYas0z3odYfe8kYRN/4ppSdTN9D8qd+c3TvCNVJxxBhWtf9QldQmi0
         BoZRE1rihyzZ6tmAF+tvknWWoRbodIcPD8/pSpUY4qWdQfRLkjJ17cktYqipIQbhv44r
         uoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3u3OZ4ReGap6MDckDvaugP/Cyefq/GOGQ2Dr3PW7MJs=;
        b=EPczDZPN91keYpSFNUW+sRH/WViQ94l4D10B4hEeomxc1pOTmcz2HK3dg7dq6ldrlI
         jsdC+J+km/VbOWMX3CI0ZXjcpRW6G4zIzjj8t5p4E7LH1K/eC4+Pgnzlodd+5h4YmnyN
         ZIUJemT31+9IRgtE8lnWNKgBpeL55N6JZgPFPUQ4JdkI1iK9TL7qJiBZik6b0/0PwniH
         ycTQVcxAvn72E9Z/YuP8tJjUc2t3KdrqSM9YQ1CaRMGX3EIe8/CS1SWNhR603nmYeDXB
         vPNDDpgM+lm4bTL1qzRl2FE99EaInRBTMBTXgxoJb2JJUX8KmKrP8l0FZD/nXkHO21Sw
         uqCg==
X-Gm-Message-State: AOAM531CGIbHrqY7gMGI+tgUoBKLKf6QsgFRh4cus1+hrz3NwVA4H8kJ
        XRJ/C4n3anJC9dLL+6sdfhoaESDYgDrGpg==
X-Google-Smtp-Source: ABdhPJz9qlxOuNe8uV5I7zb6FzSByVwsw2dM925IB33016jxrkOWoPHcxHjPVwnJ891zk21AKY8r6A==
X-Received: by 2002:a17:90b:3e84:: with SMTP id rj4mr881768pjb.177.1635278147530;
        Tue, 26 Oct 2021 12:55:47 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p13sm18355848pgr.27.2021.10.26.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:55:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] Coresight changes for v5.16
Date:   Tue, 26 Oct 2021 13:55:45 -0600
Message-Id: <20211026195545.3951306-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16

for you to fetch changes up to 7cf0754113f7ed6fad999483e40d95985c987353:

  arm64: errata: Enable TRBE workaround for write to out-of-range address (2021-10-25 12:06:02 -0600)

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
