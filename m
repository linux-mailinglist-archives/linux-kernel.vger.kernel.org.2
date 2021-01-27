Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72B830684D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhA0Xys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhA0Xyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:54:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C120A64DD3;
        Wed, 27 Jan 2021 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611791645;
        bh=d4xr17u16cz8shwN/g5Ecr3v4lfFzT6qjsUiTE+aDIU=;
        h=From:To:Cc:Subject:Date:From;
        b=U0CQKxxFMolNr/qS6tw32+v/h0IAwsXXCMFyvZ08d26q09AyskmpJfi0uJPHs47QR
         IruicfOcW/1baNGq2Bc4qhFfryYaHpDYBkN8FR95DXpTNU5XUPFpEkHshO7ziKK1QY
         3ZHfw6JDUtXOPXsnYYSmMWAFL4rRpDKG1RCJ9WM5H5Hb/FmBquXroWgNi2zcsN/teP
         AOCp1S+AQceTpYcuoEUuPYok5zQqfn8ZfD78t2LMkNu+7bFVDfyDKT5/GYD7djRApu
         zpPxTEH/X0ac5dltTAZG+vUT5QwJ2P0yoeHLUEHqvoxd0wH7SAmDQt5YYdMxE95u5s
         8SrH9TqwYot1Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 0/6] tlb: Fix (soft-)dirty bit management & clean up API
Date:   Wed, 27 Jan 2021 23:53:41 +0000
Message-Id: <20210127235347.1402-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is version three of the patches I previously posted here:

v1:  https://lore.kernel.org/r/20201120143557.6715-1-will@kernel.org
v2:  https://lore.kernel.org/r/20201210121110.10094-1-will@kernel.org

The objective is to fix the lacklustre TLB invalidation on the clear_refs
path and then augment the mmu_gather API to make it more difficult to
abuse.

Although there are other patch series pending to address related issues, I
don't think this relatively straightforward set of fixes should be blocked
on them.

Will

Cc: Yu Zhao <yuzhao@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mohamed Alzayat <alzayat@mpi-sws.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org

--->8

Will Deacon (6):
  mm: proc: Invalidate TLB after clearing soft-dirty page state
  tlb: mmu_gather: Remove unused start/end arguments from
    tlb_finish_mmu()
  tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
  tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()
  tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
  x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables

 arch/ia64/include/asm/tlb.h     |  4 ++--
 arch/sparc/include/asm/tlb_64.h |  1 -
 arch/x86/include/asm/tlb.h      |  1 -
 arch/x86/kernel/ldt.c           | 10 ++++++++--
 fs/exec.c                       |  4 ++--
 fs/proc/task_mmu.c              |  9 +++++----
 include/asm-generic/tlb.h       |  6 ++++--
 include/linux/mm_types.h        |  7 +++----
 mm/hugetlb.c                    | 18 ++----------------
 mm/madvise.c                    | 12 ++++++------
 mm/memory.c                     |  8 ++++----
 mm/mmap.c                       |  8 ++++----
 mm/mmu_gather.c                 | 31 +++++++++++++++++--------------
 mm/oom_kill.c                   |  6 +++---
 14 files changed, 60 insertions(+), 65 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

