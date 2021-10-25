Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E304B43A464
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhJYUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbhJYUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:24:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598BC0F4A64
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:03:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id o133so11848032pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mcs5vQnZemwL/yhebtb4R9NFZ6s7O1Ip2dYBwCX38M8=;
        b=AaIdlbHIw+wNNVllPn6wf3TyeiahLOGzHkUHd2BpRL6aOntr4Hd3WtwSpBQuKFFEGH
         MaP4WDbJwa8CR1y25/EtncHJJxgOPwF9TOGsHXSKUIRsg1cQ55lIZujMvR6ojHRb32jR
         ilkAkiCDlyY6v4vSHhBXcf+47/4JPIxLZtmcpaS63QLNwrsv+COccXafxrCKi9goKyf6
         KbsqstGBeeurBoqQcH4wtN/Z4czf33JbVtVVkHTtLZaCOt9dfYD7rLU9rD3q14KcB2Nz
         on5eHlq/il/cApf2lQN3l5FNxRoLSp3xwp4fQ4aWLg8HWT1CDYM9K3j2ouNNFNBFSyCq
         M8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mcs5vQnZemwL/yhebtb4R9NFZ6s7O1Ip2dYBwCX38M8=;
        b=JOSso/qXohb/qRhV/Io+6NSCD+Hq5NhfapTd+WKCmDAAF0W4YxsCyZrYEdeQr1G03G
         ur66F7cX0lafVUjMi7Vv/dfHQUN5SjGuOnIiKwH5XpOlBAMUXOl0smz7qzn1Tlacl+XQ
         MfNSSX0znK/g5EFEIzWcGpimMPJTMiPhOhkHc7ys9c77trCw7rkS0V9eeYwVX85koXTy
         zXPlLpRyxqYkF9QaRZH/dbmGLxj35iHjuVNAAKK7tIZp6uj9RsgJJ22Bw6Lmuue8ScCO
         bYo1OrHUEU/ITt4WT33/PTqfG+zAydno++Ut0Qe1tcAMURUeDM4QmQZkMr1EOx3ZjoUM
         vXzg==
X-Gm-Message-State: AOAM530uDxL1xxdMpS5MPfDQAG/gkHJ8jIvITrbUxu5qhyBDgk+kgkGT
        t1ql+GDUQbci96JyENiJEX/nhA==
X-Google-Smtp-Source: ABdhPJzgIAvFGA6Nnj57WI3lx7bJafJQVYGjKQiNYDm2agbTuRRRgbHu29o+WMJoULcVAUzrMawf7g==
X-Received: by 2002:aa7:8d44:0:b0:47b:ee6c:5ca4 with SMTP id s4-20020aa78d44000000b0047bee6c5ca4mr9046473pfe.49.1635192215014;
        Mon, 25 Oct 2021 13:03:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x16sm6496357pff.186.2021.10.25.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:03:33 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Coresight subsystem for v5.16
Date:   Mon, 25 Oct 2021 14:03:32 -0600
Message-Id: <20211025200332.3901607-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/v5.16-next

for you to fetch changes up to 7cf0754113f7ed6fad999483e40d95985c987353:

  arm64: errata: Enable TRBE workaround for write to out-of-range address (2021-10-25 12:06:02 -0600)

----------------------------------------------------------------
Hi Greg,

Please consider these for the next merge window.  Also let me know if there
is any modifications I can do to this pull request to make things easier
on your side.

Thanks,
Mathieu

Included herein:

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
