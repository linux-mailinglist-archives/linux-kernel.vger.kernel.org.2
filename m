Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95342D08F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhJNCoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNCoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:44:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE120C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x4so3134314pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW8XCIeIeYrdlOb1ZarORXLPpqtbURryzGPGlwjnyHI=;
        b=ewqlgzauj8v3/fH2C4jFtb9CERAHLe+frilxffMXj9puV07vHNyOxaZ7hxjJkdGkkA
         vy4u8blFLS2lIr6L1j0+E6tlAYRfzeboaGh914vvtb55JUcHiQrfcDfiRpGX1gkQdVer
         OTjCiM/Nizdxfv4qDG/0VYd1FIlTlJcuqZVKep/CNaNOb+ns7s4068v0pcMom1EeR+N9
         /pOCFiiv5ZOMaRai/YIdZBiKadL5kXnhEfsXGbeZ2zfAHVrvQTkfZ6GoUbJjRcwDSGOW
         abe4Zw7R1fjVnBdXYF1awAGcAO55gKA/WK0a0U4zwRHGeFBBY01nLm0kTh2TT3GZRdLI
         2eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW8XCIeIeYrdlOb1ZarORXLPpqtbURryzGPGlwjnyHI=;
        b=mtgPosda9cFnwQuM033vpXisyMdrUkYF7hOWDGvuhenQ9C3KayauTs8ce2DcvzUNlj
         ceRVD54F6Dfmgehn9xF57bHTKfKHg7yJqCeVkxJSEE80y1lxIPhlpOxYhJekOjSKYW1D
         eVOIZuVNNbNErd+K7fVKhJ6m4i7jwSqwxI6TRM/ASvcurkBHIuIl8o1RJSZdCcvj2gQ2
         wQ5RVXRH1A6mAEZhR371Hkrx0+gOh34XRppvG/LhX+msFgsawVMshTKS4O3o+6MZWJwN
         iiVeUnGtnnIEhu3xZw7mbnhL0SaKRFGXiidRSJSneFmjQv4t+n7iX5qQ9JhTw5X1f/zW
         6U2g==
X-Gm-Message-State: AOAM530iURyOL2Oxq2lK7bVHifDI/bHGR/uEUxPIZiFwbPQXxThrJ5pY
        XWoRJo/zjXQv7rl+BM9T3g==
X-Google-Smtp-Source: ABdhPJykR01YldoWb1AVKlZxFUw/plpEy+PT1HfAokp7fgk120udLXyPbD3R4SHBGnnS40Yles/qxg==
X-Received: by 2002:a17:903:22cc:b0:13e:fa73:6fef with SMTP id y12-20020a17090322cc00b0013efa736fefmr2771601plg.25.1634179328296;
        Wed, 13 Oct 2021 19:42:08 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m28sm818403pgl.9.2021.10.13.19.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:42:07 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCHv3 0/4] watchdog_hld cleanup and async model for arm64
Date:   Thu, 14 Oct 2021 10:41:51 +0800
Message-Id: <20211014024155.15253-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hard lockup detector is helpful to diagnose unpaired irq enable/disable.
But the current watchdog framework can not cope with arm64 hw perf event
easily.

On arm64, when lockup_detector_init()->watchdog_nmi_probe(), PMU is not
ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
integrated with the driver model and cpuhp. Hence it is hard to push the
initialization of armv8_pmu_driver_init() before smp_init().

But it is easy to take an opposite approach by enabling watchdog_hld to
get the capability of PMU async. 
The async model is achieved by expanding watchdog_nmi_probe() with
-EBUSY, and a re-initializing work_struct which waits on a
wait_queue_head.

In this series, [1-2/4] are trivial cleanup. [3-4/4] is for this async
model.

v2 -> v3:
    check the delay work waken up and flush the work before __initdata is free.
    improve the commit log of [4/4]
    rebase to v5.15-rc5

v1 > v2:
    uplift the async model from hard lockup layer to watchdog layter.
The benefit is simpler code, the drawback is re-initialize means wasted
alloc/free.
    
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Pingfan Liu (3):
  kernel/watchdog: trival cleanups
  kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup
    detector event
  kernel/watchdog: Adapt the watchdog_hld interface for async model

Sumit Garg (1):
  arm64: Enable perf events based hard lockup detector

 arch/arm64/Kconfig               |  2 ++
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/perf_event.c   | 11 ++++--
 arch/arm64/kernel/watchdog_hld.c | 36 +++++++++++++++++++
 arch/sparc/kernel/nmi.c          |  8 ++---
 drivers/perf/arm_pmu.c           |  5 +++
 include/linux/nmi.h              | 11 +++++-
 include/linux/perf/arm_pmu.h     |  2 ++
 kernel/watchdog.c                | 62 ++++++++++++++++++++++++++++----
 kernel/watchdog_hld.c            |  5 ++-
 10 files changed, 129 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.31.1

