Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24653A42AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFKNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:05:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:05:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623416597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uFUbL6Bqwrw8F+Pmfa3gHeI4c2aZHwPJArh/9c/kGto=;
        b=KDmgbzbIx5perlrYB8x2MlK2Zkt0nxM50tGGIwY9AqUujNIyGzRmCA1J/gdQCnoteMt4z3
        0LcdKh0o041b/bonFCnxkJdCqIUZ3g3Sirt/LIvwIoafM1emNfL6rc2g1Fx1Zs6V/KCZTs
        TKTSdAzag00qaUpEUmZvpI4FIEo/BXzVhs9ohKIfed7mXecmrjLWq17sJhnG9rxab6iJaW
        HKyoB+65n1/sio42ornahqx2qSTmisqK0iEa+Ssg2tihRh7M0Gnt+o6JrBe9N43IgH/w4X
        gi4/yeRuHuZQJYGyHXgkr1Z+wZLJcJnSfJZEZmNwd8PJ8L07iPq/fQ2tJ5A7qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623416597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uFUbL6Bqwrw8F+Pmfa3gHeI4c2aZHwPJArh/9c/kGto=;
        b=6QOEdRXGAdFExQWRFF/1ER8T6xipqKf0o4ZHuTDo5USa4X/ivDb+cODur80x8bFh6fC++6
        LybFeIiuRSEcgrDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] perf/x86/intel/lbr: Zero the xstate buffer on allocation
Date:   Fri, 11 Jun 2021 15:03:16 +0200
Message-ID: <87wnr0wo2z.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XRSTORS requires a valid xstate buffer to work correctly. XSAVES does not
guarantee to write a fully valid buffer according to the SDM:

  "XSAVES does not write to any parts of the XSAVE header other than the
   XSTATE_BV and XCOMP_BV fields."

XRSTORS triggers a #GP:

  "If bytes 63:16 of the XSAVE header are not all zero."

It's dubious at best how this can work at all when the buffer is not zeroed
before use.

Allocate the buffers with __GFP_ZERO to prevent XRSTORS failure.

Fixes: ce711ea3cab9 ("perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR context switch")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/events/intel/lbr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -731,7 +731,8 @@ void reserve_lbr_buffers(void)
 		if (!kmem_cache || cpuc->lbr_xsave)
 			continue;
 
-		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
+		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache,
+							GFP_KERNEL | __GFP_ZERO,
 							cpu_to_node(cpu));
 	}
 }
