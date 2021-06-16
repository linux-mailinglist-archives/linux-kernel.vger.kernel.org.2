Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAE3A8F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFPDXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFPDXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C57D613D3;
        Wed, 16 Jun 2021 03:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813677;
        bh=KDnBZ2GHbeI0IjN+6nTEJv7f76MsISUAkc+t+tLuGYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzjhJGz+SpVdoASezCgMOqvFDc6hpGx6dhaMfNT9d5C3EW5ZginQ8GoKPB++A3vcf
         mCA1iyMzMRD4kGdYNFop8UHd+LylSRGCEqS95/ANcsATNeBwu4cI8LBeryq3thgosO
         yQi1F9CVZYfIos9SGUQA4pGMvh1tSEYrWsTzooKVBHRnkbzwtgNVsOTfCgl4k/Opeo
         k9nMFSDm+g02ufFTu3JBOlCV0vuWSCC21abQU/0X6NWwkRU3SQNfncb11RtDGfxupu
         OdwaU/nM5Ufaa3K+4Rkyg59DyhQwst1aPszUA14M5pVv1r/xV38Hw5z+dLarYjPmW4
         DJrD1z+n9Btiw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/8] membarrier: Remove membarrier_arch_switch_mm() prototype in core code
Date:   Tue, 15 Jun 2021 20:21:08 -0700
Message-Id: <2d45c55c4fbbe38317ff625e2a2158b6fbe0dc2d.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier_arch_switch_mm()'s sole implementation and caller are in
arch/powerpc.  Having a fallback implementation in include/linux is
confusing -- remove it.

It's still mentioned in a comment, but a subsequent patch will remove
it.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/sched/mm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 24d97d1b6252..10aace21d25e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -350,13 +350,6 @@ extern void membarrier_exec_mmap(struct mm_struct *mm);
 extern void membarrier_update_current_mm(struct mm_struct *next_mm);
 
 #else
-#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
-static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
-					     struct mm_struct *next,
-					     struct task_struct *tsk)
-{
-}
-#endif
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
-- 
2.31.1

