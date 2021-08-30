Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7C3FB396
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhH3KHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbhH3KHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:07:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:06:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eb14so11549350edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/ScTPc3ER8rBFcp+FO12BRhj4mI9lEcmEwpkznnBTb4=;
        b=mFd7hO2LpgdSs2T1l4SZMqil7xScV0wNi5GsadSgxS+3UA74/VPveBLeEOpac1e3sQ
         /uhQ0LvBo8V5WEi/VcbtIjKGnj5lbOTPk09cbZYab3v0jGabuqIhiZM+7gYHXcTltiwa
         DS4dUMwhZNuUm7WpBPaoOoBaBrjVayqvsWw+FQ6l+vHVLquNrpcD12iwZua6rpRCN8uG
         793n89feUs7JENcku+UV+3ceRjufcs9RebftqO3ua/sovS2KRQ1aUICroubMRu4dzlYp
         hudjasdDe/u7dEBWFEmO1kiwvtWK367iAZWGde7P3fJflAgPdWmAWhHxStwe2gMJDtLf
         6bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=/ScTPc3ER8rBFcp+FO12BRhj4mI9lEcmEwpkznnBTb4=;
        b=AYdFYsokhzAX0fHNSZXV1VCxLrTRWMkAQTuy3aAt/ZOU7QZNlaTUhxiZCMhmPildUS
         xVLpubbMEZCSMNeJsmsHo/PRWG3Ar4cEeGE+foH2C2vev8zkComd9fdltch5dXLG2SoX
         qADHbiEKSx8QEUbXAySM2ay17/OtxsFZx+Q/B/I4EtpPPhBoiGDZlPJVBj7Nd67sGDcA
         GXLZ2h+f52vlgITdQUprQUUfQRv2/7mCXOVLXCovm8j7j+2sN+DdNUV2ukUKA2w+JBOX
         /OcU8MufQFBGbjGEaXfZpOJMEDYjN6MhZWG0sY9UG7Ndpx2II4asrBnhtskeduWlZM5G
         WArA==
X-Gm-Message-State: AOAM5334gq8evCCNa0wAFcBfyw5ESoVpMPeaV/lcJmyeyFoaqeGdp0D8
        8ePpuZZFGfec7+BTlnvPOmtbJGbOqV8=
X-Google-Smtp-Source: ABdhPJwFYhBYkC17NTdc1oNZvtGj9v6BiYEyAjmmR5BgRIFdWsfg2w/LbbbtlWTHT7qM+3nHVeZC+w==
X-Received: by 2002:a05:6402:c9:: with SMTP id i9mr22712685edu.76.1630318003652;
        Mon, 30 Aug 2021 03:06:43 -0700 (PDT)
Received: from gmail.com (0526ECFD.dsl.pool.telekom.hu. [5.38.236.253])
        by smtp.gmail.com with ESMTPSA id f1sm7349656edq.89.2021.08.30.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:06:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 30 Aug 2021 12:06:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v5.15
Message-ID: <YSytsSM2mOcpGHJq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-08-30

   # HEAD: 6a371bafe613b7746c3d3ac486bdb3035f77e029 perf/x86/amd/ibs: Add bitfield definitions in new <asm/amd-ibs.h> header

Perf events changes for v5.15 are:

 - Add support for Intel Sapphire Rapids server CPU uncore events
 - Allow the AMD uncore driver to be built as a module
 - Misc cleanups and fixes

 Thanks,

	Ingo

------------------>
Alexander Antonov (1):
      perf/x86/intel/uncore: Fix IIO cleanup mapping procedure for SNR/ICX

Colin Ian King (1):
      perf/x86: Remove unused assignment to pointer 'e'

Kan Liang (15):
      perf/x86/intel/uncore: Add Sapphire Rapids server framework
      perf/x86/intel/uncore: Add Sapphire Rapids server CHA support
      perf/x86/intel/uncore: Add Sapphire Rapids server IIO support
      perf/x86/intel/uncore: Add Sapphire Rapids server IRP support
      perf/x86/intel/uncore: Add Sapphire Rapids server M2PCIe support
      perf/x86/intel/uncore: Add Sapphire Rapids server PCU support
      perf/x86/intel/uncore: Add Sapphire Rapids server IMC support
      perf/x86/intel/uncore: Add Sapphire Rapids server M2M support
      perf/x86/intel/uncore: Add Sapphire Rapids server UPI support
      perf/x86/intel/uncore: Add Sapphire Rapids server M3UPI support
      perf/x86/intel/uncore: Add Sapphire Rapids server MDF support
      perf/x86/intel/uncore: Add alias PMU name
      perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()
      perf/x86/intel/uncore: Support IIO free-running counters on Sapphire Rapids server
      perf/x86/intel/uncore: Support IMC free-running counters on Sapphire Rapids server

Kim Phillips (5):
      perf/amd/uncore: Simplify code, use free_percpu()'s built-in check for NULL
      perf/amd/uncore: Clean up header use, use <linux/ include paths instead of <asm/
      x86/cpu: Add get_llc_id() helper function
      perf/amd/uncore: Allow the driver to be built as a module
      perf/x86/amd/ibs: Add bitfield definitions in new <asm/amd-ibs.h> header

Sebastian Andrzej Siewior (2):
      perf/x86/intel: Replace deprecated CPU-hotplug functions
      perf/hw_breakpoint: Replace deprecated CPU-hotplug functions


 .../testing/sysfs-bus-event_source-devices-uncore  |  13 +
 arch/x86/events/Kconfig                            |  10 +
 arch/x86/events/amd/Makefile                       |   5 +-
 arch/x86/events/amd/ibs.c                          |  23 +-
 arch/x86/events/amd/uncore.c                       |  40 +-
 arch/x86/events/core.c                             |   4 +-
 arch/x86/events/intel/core.c                       |   8 +-
 arch/x86/events/intel/pt.c                         |   4 +-
 arch/x86/events/intel/uncore.c                     |  45 +-
 arch/x86/events/intel/uncore.h                     |   4 +
 arch/x86/events/intel/uncore_discovery.c           |  42 +-
 arch/x86/events/intel/uncore_discovery.h           |  21 +
 arch/x86/events/intel/uncore_snbep.c               | 583 ++++++++++++++++++++-
 arch/x86/include/asm/amd-ibs.h                     | 132 +++++
 arch/x86/include/asm/processor.h                   |   2 +
 arch/x86/kernel/cpu/amd.c                          |   2 +-
 arch/x86/kernel/cpu/common.c                       |   6 +
 kernel/events/hw_breakpoint.c                      |   4 +-
 18 files changed, 858 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
 create mode 100644 arch/x86/include/asm/amd-ibs.h
