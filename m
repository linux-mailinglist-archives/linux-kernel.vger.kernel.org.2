Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867E9436B94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhJUT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhJUT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D9C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:54:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d9so1598135pfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcS8bbhskcuqX8GVfAbpnHbwNDrvmLq+rqAWrOVM9lI=;
        b=L+FcixtzsXJDLtnIg36G3Irwlyfvc8bA787ySj/Q05tZq3xT8aUK5zeUAtvD7MtTg9
         jsl1++y+VopTt4nSQhEah8GfiD2O8vubjlWK+L4xpIL7Vb1lxXYSsL21m3Ieg6Jz15HP
         NvFRmwltvdZZUc/JD1iyRbUeIK2BYXQAmHB9fOuQXw5tSDCKNEuOx2UUcmLRkn5QoAck
         TYW5zrHi/uC+lkKxTpA4phtuGp+9tqkkMMADgc+VHkwJyrYxHSGoLbBjR4Q2OgjJsmOA
         73mcv78pVzn8R7CrkOXIsSug6zNj8YBwPLFxqumdEzkbWTwNnL0Z9yP0K4KAdtU13cGA
         2Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcS8bbhskcuqX8GVfAbpnHbwNDrvmLq+rqAWrOVM9lI=;
        b=6XcZTyS7MoYRz3Nn6QLmD+1LdEOoP4fDSZRwY/yn5z68KtmTYZlEt3S8pwg8sVkn4V
         X4BNI+/k/hew3K4Gbz+aDngAGC3/4IjKHwzxrf2WuWcrT8z044gid+f+5QsnTvTr/Kkc
         wv3/CfPF7ksN3jm0SR0exvLhijfQKDc+kuVCOtMIa6ajIHLLU5s9vF5lWsNA/E6YVOKR
         rwFJFaVOHdrJJ6GoYpC6Z4mHBfFqLB1sbtRbm1rz5TFZBIrr98ZqfBPJ4HlH9giydwUt
         OK8Ben1M+EXAJZnz2BBKeC3wqHBnoXcah0JKyXWS61FY+O8NZI6HtpAZ6DP4/KiMHxXX
         mr4g==
X-Gm-Message-State: AOAM530ouHcUtl+lcgWyPquI9DK0mos8L/8C96n/sLYSU1QPt7OW1tvt
        38kF+W0NNRzZ9wdP3WX4TbA=
X-Google-Smtp-Source: ABdhPJz3bY2ItMBqVLKJfjL1FqVvimBucwFEt+xIpcw3N5x3a824VsfnVBK60Y/ZSrYY//In0exxOQ==
X-Received: by 2002:a63:2484:: with SMTP id k126mr5905030pgk.297.1634846077549;
        Thu, 21 Oct 2021 12:54:37 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v8sm6883407pjd.7.2021.10.21.12.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:54:37 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH] mm: use correct VMA flags when freeing page-tables
Date:   Thu, 21 Oct 2021 05:23:22 -0700
Message-Id: <20211021122322.592822-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Consistent use of the mmu_gather interface requires a call to
tlb_start_vma() and tlb_end_vma() for each VMA. free_pgtables() does not
follow this pattern.

Certain architectures need tlb_start_vma() to be called in order for
tlb_update_vma_flags() to update the VMA flags (tlb->vma_exec and
tlb->vma_huge), which are later used for the proper TLB flush to be
issued. Since tlb_start_vma() is not called, this can lead to the wrong
VMA flags being used when the flush is performed.

Specifically, the munmap syscall would call unmap_region(), which unmaps
the VMAs and then frees the page-tables. A flush is needed after
the page-tables are removed to prevent page-walk caches from holding
stale entries, but this flush would use the flags of the VMA flags of
the last VMA that was flushed. This does not appear to be right.

Use tlb_start_vma() and tlb_end_vma() to prevent this from happening.
This might lead to unnecessary calls to flush_cache_range() on certain
arch's. If needed, a new flag can be added to mmu_gather to indicate
that the flush is not needed.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 12a7b2094434..056fbfdd3c1f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -412,6 +412,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
+		tlb_start_vma(tlb, vma);
+
 		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
@@ -429,6 +431,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
 		}
+
+		tlb_end_vma(tlb, vma);
 		vma = next;
 	}
 }
-- 
2.25.1

