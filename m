Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF353B59BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhF1HcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhF1HcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:32:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:29:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id df12so24350280edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Awr1lH4tjOQYO7QBDJDoZyTR6TxHdHKn3kd9Ae+1q8s=;
        b=qXjQiw3ImqOvKqHmhla+ngkhHc/Kuq2iEoTsEsZmxeLCanLXURkHKlqMDevm4Uu8a6
         z9SpMMU9Wn6m0ZRTO+U1HBCzVf9cDdh0MXuEgmmQETBjLZaPXZiseHeaFF9o3ZHIq28f
         5VgL7AZ94O7GC8YVLjLPeqDD077/ZaPh/eX5TTnb31NeMnV50WDQ3nQbPgZnVI/SLF8e
         QdiIwuOrbhpFRCouIKouWMFWwDreXQIzf7yxJAkCdzjFEjeKojIjfeny6HCBM8LwKj5H
         +lq33oPUF7syVDx9tptTTvIHCT5IQiYMxm7bofc4Vh+QX6nmo20N43Yf7NarIkTyLhoV
         w0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Awr1lH4tjOQYO7QBDJDoZyTR6TxHdHKn3kd9Ae+1q8s=;
        b=g4/3OK5mOOZXBujOCyi643YHl0BDRgVZfeABfYCkj3w8CGh8facKFxIR53WRm6T4Ta
         WeoTuRbxDTRtaq9jf95TGURQ7hsPtuN4kYlu958xCe+fp1tBvaUfmfrvVUtXc5OyH209
         UqGA12qEwbnH0s+pnXUD21rrfiSRG3gmN4BhxWHSDcg/F4Qet2R8gwIzrt3a9/H65kCn
         sH7mVm1tDdmykzxxmJVBDCEVGwiS9SRHpli0unvvN9LXxg7m7uWhvLG5VpNzjZqCc66W
         s3uhc+8/Lo/4ehJY1YTNGET+e8uZgWDEiis5nw50PolSN3kJVFTxfz93+QuRLraFii83
         1X+w==
X-Gm-Message-State: AOAM533eMLm7XkRTPAjJCt1kW5DjgTJu49QWaeOwjsKhOkHz9BwwEjkC
        AXeCqG3PPRxC1oIFQ5lPUb4=
X-Google-Smtp-Source: ABdhPJyQNSbKnrDqR7fh6dBTQPKysSyjM9qZk7JXDDODGOuZntq0KgYOcH9GN51RLXmTuZzeNhQnJg==
X-Received: by 2002:a50:ccd8:: with SMTP id b24mr31153425edj.386.1624865372902;
        Mon, 28 Jun 2021 00:29:32 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id v13sm9365661edl.47.2021.06.28.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:29:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:29:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v5.14
Message-ID: <YNl6Wukqdm2FnAsZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cleanups git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2021-06-28

   # HEAD: 1d3156396cf6ea0873145092f4e040374ff1d862 x86/sgx: Correct kernel-doc's arg name in sgx_encl_release()

Misc cleanups & removal of obsolete code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Borislav Petkov (3):
      x86/asm: Simplify __smp_mb() definition
      x86/alternative: Align insn bytes vertically
      x86/setup: Document that Windows reserves the first MiB

ChenXiaoSong (1):
      x86/sgx: Correct kernel-doc's arg name in sgx_encl_release()

Hubert Jasudowicz (1):
      doc: Remove references to IBM Calgary

Ingo Molnar (1):
      x86: Fix leftover comment typos

Mike Rapoport (2):
      x86/setup: Remove CONFIG_X86_RESERVE_LOW and reservelow= options
      x86/crash: Remove crash_reserve_low_1M()

Pavel Skripkin (1):
      x86/alternatives: Make the x86nops[] symbol static


 Documentation/admin-guide/kernel-parameters.txt |  5 ---
 Documentation/x86/x86_64/boot-options.rst       | 31 +----------------
 arch/x86/Kconfig                                | 29 ----------------
 arch/x86/hyperv/hv_init.c                       |  2 +-
 arch/x86/include/asm/barrier.h                  |  7 ++--
 arch/x86/include/asm/crash.h                    |  6 ----
 arch/x86/include/asm/sgx.h                      |  2 +-
 arch/x86/include/asm/stackprotector.h           |  2 +-
 arch/x86/kernel/alternative.c                   |  6 ++--
 arch/x86/kernel/cpu/sgx/encl.c                  |  2 +-
 arch/x86/kernel/crash.c                         | 13 -------
 arch/x86/kernel/kprobes/core.c                  |  2 +-
 arch/x86/kernel/setup.c                         | 45 ++++++-------------------
 arch/x86/kvm/mmu/mmu.c                          |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c                      |  2 +-
 15 files changed, 24 insertions(+), 132 deletions(-)
