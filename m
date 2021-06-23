Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE23B1A16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhFWM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFWM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:28:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22BC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:29 -0700 (PDT)
Message-Id: <20210623121455.622983906@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8bNqn55/9FpzYwdYhLYJ1YHhSO8g4U3kMgFFLHLaBYo=;
        b=Nrw4UGzXYLN8h416qbB+NBo+iUDVRnGtlIwK/FZggICXMbChUpGNVH5lB0V2vi1Id9C5ie
        03UefEPbbo0kHzQs5y7Wn2N703eIgybcoCGbWLXzTJ7YJahX0/Lr3706QvBQpz+6ZPLmWO
        PjwrhYD0RO/Ztbc4y88jvLh/BG5SGx2Fg6ypnwyD9tImSF7M1awFCLGwlqg7k4lYIEx/Jv
        92No5qWBB7t98hOQ3dj5WGuYnRYlMMYMy1qVUbtVJ4pWc8QLiY9o4BkiO2gSSmHqlUTPcg
        sJzdbYJVfz3vtGUERwYCwJOzV1KFjaIQ15tlhBYr2i31VjuSJDKcdbu2YtyU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8bNqn55/9FpzYwdYhLYJ1YHhSO8g4U3kMgFFLHLaBYo=;
        b=L6U/0bHT9g4UNVa9mtEkx3VV9CJuZ6u0HJb6Gse6uHWINaGrz3dAfupnFoHrGKSiBI9HAz
        XwB8k2Q+QeSgxYBQ==
Date:   Wed, 23 Jun 2021 14:02:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 43/65] x86/cpu: Write the default PKRU value when enabling PKE
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of making the PKRU management more independent from XSTATES,
write the default PKRU value into the hardware right after enabling PKRU in
CR4. This ensures that switch_to() and copy_thread() have the correct
setting for init task and the per CPU idle threads right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -480,6 +480,8 @@ static __always_inline void setup_pku(st
 	}
 
 	cr4_set_bits(X86_CR4_PKE);
+	/* Load the default PKRU value */
+	pkru_write_default();
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS

