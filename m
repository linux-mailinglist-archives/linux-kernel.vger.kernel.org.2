Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DE36E708
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhD2I3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhD2I3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:29:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDDC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:28:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h15so13656476wre.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6x4Akw5JZxFwVW3G0KORyG0GHwedOvVIOmuBwIoG0x4=;
        b=aXQBxinYpEiMFPypb8VYYxNrbRFkdOwJc/CY7tlT2Z1Pbo4EbeNCjPEaYqCPnwbC9s
         NAEuznt3COqJ6Yah7yun1AEEuStS1wzLecr0M73bEisrn9tV1UnWKS3gbV5cl5/Q16c9
         SNvZ4ngohtqdEcC7nmQ83E0fua1xtX8GLolKppCjO8uoKdCyXoHUepozBhUNzGIOBQ2g
         C9slS2p6eE+B8fd6HJ7EC7WIUktG/3g+/qjo0kpjtSLHkpDVC3zhocZBBJCKTY4bDT9u
         GXL+lPDhbbK3KgnTze1xd/GYBR8tg99RN5jc+W5iW9BgGKOmttvhfgBSqJiC1BiIOtnD
         sjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=6x4Akw5JZxFwVW3G0KORyG0GHwedOvVIOmuBwIoG0x4=;
        b=nF0/k5u9YxYsQ6retxR1kM0xROksCtnyz/Fdw9lSBzhknCjXGlLmFpWCtj/njuE/wc
         HLtRx3JNink2N3GFgsCBtewvP/rh94fWr2Lu7/PDwUR0NFdrXKIxH0yH+zfMsPRz5JFD
         sX+RSEbqc76Iu7S4ANM/XRCtLtAHyYwHb8gEtSSOUfEtsRGNPmqpMhOMaaqwTchEltSp
         8KjeQni7A2wdiMe+mxGjQrKHIiGNhpqm1dS1L/5VL6iEYQaUi3seiVmHMRTV2jp0kY+6
         1FIL14GQhwsgdiCpraIS74YhIuQXn/JiBqnJQFPg9Z050F9Mt0Zs7AlGadKO0JBzCPxh
         2qWA==
X-Gm-Message-State: AOAM532B0eLMd3Ohi602NqxpC4B7Tx6lJhiqKuMuBqz6bRcAG1Jyz1C1
        egIvxQjxJWyzlZrf7VHBXJ6vcCkaCOc=
X-Google-Smtp-Source: ABdhPJwgET5C0ivada559zYSoXx0Bj25QjocgAtkb0Lnhwnvh2QZ0M+hEaxw4CO6IX5/9hQjaAdoiA==
X-Received: by 2002:adf:c541:: with SMTP id s1mr41565868wrf.370.1619684902413;
        Thu, 29 Apr 2021 01:28:22 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id f6sm4322597wru.72.2021.04.29.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:28:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 29 Apr 2021 10:28:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [GIT PULL] x86/mm changes for v5.13
Message-ID: <20210429082819.GA2827959@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2021-04-29

   # HEAD: a500fc918f7b8dc3dff2e6c74f3e73e856c18248 Merge branch 'locking/core' into x86/mm, to resolve conflict

The x86 MM changes in this cycle were:

 - Implement concurrent TLB flushes, which overlaps the local TLB flush with the
   remote TLB flush. In testing this improved sysbench performance measurably by
   a couple of percentage points, especially if TLB-heavy security mitigations
   are active.

 - Further micro-optimizations to improve the performance of TLB flushes.

 Thanks,

	Ingo

------------------>
Nadav Amit (9):
      smp: Run functions concurrently in smp_call_function_many_cond()
      x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
      x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
      x86/mm/tlb: Flush remote and local TLBs concurrently
      x86/mm/tlb: Privatize cpu_tlbstate
      x86/mm/tlb: Do not make is_lazy dirty for no reason
      cpumask: Mark functions as pure
      x86/mm/tlb: Remove unnecessary uses of the inline keyword
      smp: Inline on_each_cpu_cond() and on_each_cpu()

Peter Zijlstra (1):
      smp: Micro-optimize smp_call_function_many_cond()


 arch/x86/hyperv/mmu.c                 |  10 +-
 arch/x86/include/asm/paravirt.h       |   6 +-
 arch/x86/include/asm/paravirt_types.h |   4 +-
 arch/x86/include/asm/tlbflush.h       |  48 ++++----
 arch/x86/include/asm/trace/hyperv.h   |   2 +-
 arch/x86/kernel/alternative.c         |   2 +-
 arch/x86/kernel/kvm.c                 |  11 +-
 arch/x86/kernel/paravirt.c            |   2 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 176 ++++++++++++++++------------
 arch/x86/xen/mmu_pv.c                 |  11 +-
 include/linux/cpumask.h               |   6 +-
 include/linux/smp.h                   |  50 +++++---
 include/trace/events/xen.h            |   2 +-
 kernel/smp.c                          | 212 ++++++++++++++--------------------
 kernel/up.c                           |  38 +-----
 16 files changed, 287 insertions(+), 295 deletions(-)
