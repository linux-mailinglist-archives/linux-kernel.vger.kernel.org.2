Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B8306851
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhA0Xzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhA0Xz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:55:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21BE764DD6;
        Wed, 27 Jan 2021 23:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611791659;
        bh=mxiaCobhkjpW2w1MMWXxj64WTjRY88UbBuz6FY0NUY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dn5FD06aIXNLNL1uxfeEmMn4arTcGVY9NmjF7uJ++cK8Yo3oTmbj4K5fG78etCgHM
         +PwFQOwklT9YUZyGGhyamrD8w8SNZRSH+MJKywvxiPSYZ5R4T2OkIqQpyOzbIdnFtD
         ku+LAMT8Vxrf+dzDfWJczpQ29qYVS4znS5A828/kh76T2P5vIWRL9Kp3MNXk+3NR+Y
         Dp1qHE1raaO13Wx7TkkL5zyZWxNSkPUcQojcwOe5xsQFM/+9w7GtwxjvUp/kQIzI5H
         4OvnCd3rgKeTXcZhG2wl+rG5PTDAy3PGm7fT4/ktdnNdDJ62kcQas3QPIyeC2DvSYN
         +0FrMoccwb29w==
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
Subject: [PATCH v3 5/6] tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
Date:   Wed, 27 Jan 2021 23:53:46 +0000
Message-Id: <20210127235347.1402-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210127235347.1402-1-will@kernel.org>
References: <20210127235347.1402-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __tlb_remove_tlb_entry() is not defined by the architecture then
we provide an empty definition in asm-generic/tlb.h.

Remove the redundant empty definitions for sparc64 and x86.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/include/asm/tlb_64.h | 1 -
 arch/x86/include/asm/tlb.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index e841cae544c2..779a5a0f0608 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -24,7 +24,6 @@ void flush_tlb_pending(void);
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #define tlb_flush(tlb)	flush_tlb_pending()
 
 /*
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 820082bd6880..1bfe979bb9bc 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -4,7 +4,6 @@
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
-- 
2.30.0.365.g02bc693789-goog

