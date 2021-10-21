Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85230436B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJUTzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:55:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1904C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om14so1282332pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TR1T6zOrAlzQbQbzWioCnGERHhFMAtdNyRA0+55dPpg=;
        b=Lv4rh9Fwt7a1dDy1pd5bz6+KAW/2dFR/tGUjA0sYoP5Tiy1n1iFPnjWYJzxYej3LkV
         8jjrE6Q0v/9QlaaW+I8nn9KEaZwHnF+SmrC+MLEkXXRBwwbcBNrqNlRZZIsLq2gHXSIl
         n1Ud8+FsW4wfFg5HQRjwwP7cwQfPhUJuEIgG9XbbQotEhZQIV+05Zrz9TEek3nZfQNZC
         iIghwaEkThKQlPgPZd8oALawLB6BH62vDdawAQewuSwEg+1DJfHnC6Vlq0ch+btat6T/
         ooxffoJdWMLe3q277QEeQhAe0GN6HjirBtTUtbcDA6ZLMHd15iz4wCJGi/pFUpPGMMPa
         VNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TR1T6zOrAlzQbQbzWioCnGERHhFMAtdNyRA0+55dPpg=;
        b=VZe6DctSsFJ024++VhzfzAkXR1J1BKMSB6t34M6MkYFZm1RBRMW5IOfEhcm9COPROk
         3KuwnJ/GaMJVhPyVSHdsenCpqyQo686ndiRKYf5PbAhrjlDMY22SAeGZ6am8h//o7kxz
         OkEuAaK+AtexWdS7VFqjoj+qgtDp3NBVA9AaMuAMjvNnkWZDDOaPfEbi54h5Zf+GqUdK
         bmoBaNRbRV3xw/9Q242iAcwpTI2A9BAYy6u6AtVNAnI10zf/ZY4nBglwYOuGtX+y/Wvq
         UsPgCPII+T1OshmcBTUZqGOPVzLaZw9SUmrBlJH4A2htiEDcQBCuJSMXoR+2h8JgN8I4
         BwHg==
X-Gm-Message-State: AOAM530B8v+912NzdLhaXEnxkUsUPM9i2/yb3pd+hQrxslx0TAQykXpW
        f616zpZNZd02HJSHmeM+uP8=
X-Google-Smtp-Source: ABdhPJx7eKqqB+m2EpgtEJGAakQ0CuFFpBpcqmZQWX3IiNBBr1ZBR2aHZiUgLlWDTG0/gYBxUJwFhw==
X-Received: by 2002:a17:90b:1242:: with SMTP id gx2mr9168584pjb.152.1634845966177;
        Thu, 21 Oct 2021 12:52:46 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n202sm7098078pfd.160.2021.10.21.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:52:45 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v2 0/5] mm/mprotect: avoid unnecessary TLB flushes
Date:   Thu, 21 Oct 2021 05:21:07 -0700
Message-Id: <20211021122112.592634-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

This patch-set is intended to remove unnecessary TLB flushes. It is
based on feedback from v1 and several bugs I found in v1 myself.

Basically, there are 3 optimizations in this patch-set:
1. Avoiding TLB flushes on change_huge_pmd() that are only needed to
   prevent the A/D bits from changing.
2. Use TLB batching infrastructure to batch flushes across VMAs and
   do better/fewer flushes.
3. Avoid TLB flushes on permission demotion.

Andrea asked for the aforementioned (2) to come after (3), but this
is not simple (specifically since change_prot_numa() needs the number
of pages affected).

There are many changes from v1 to v2 so consider the change log as
partial.

v1->v2:
* Wrong detection of permission demotion [Andrea]
* Better comments [Andrea]
* Handle THP [Andrea]
* Batching across VMAs [Peter Xu]
* Avoid open-coding PTE analysis
* Fix wrong use of the mmu_gather()

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org

Nadav Amit (5):
  x86: Detection of Knights Landing A/D leak
  mm: avoid unnecessary flush on change_huge_pmd()
  x86/mm: check exec permissions on fault
  mm/mprotect: use mmu_gather
  mm/mprotect: do not flush on permission promotion

 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/pgtable.h       |  8 +++
 arch/x86/include/asm/pgtable_types.h |  2 +
 arch/x86/include/asm/tlbflush.h      | 80 +++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c          |  5 ++
 arch/x86/mm/fault.c                  | 11 +++-
 fs/exec.c                            |  6 +-
 include/asm-generic/tlb.h            | 14 +++++
 include/linux/huge_mm.h              |  5 +-
 include/linux/mm.h                   |  5 +-
 include/linux/pgtable.h              |  5 ++
 mm/huge_memory.c                     | 22 ++++---
 mm/mprotect.c                        | 94 +++++++++++++++-------------
 mm/pgtable-generic.c                 |  8 +++
 mm/userfaultfd.c                     |  6 +-
 15 files changed, 215 insertions(+), 57 deletions(-)

-- 
2.25.1

