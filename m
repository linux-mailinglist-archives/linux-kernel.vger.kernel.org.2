Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9243B1A15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFWM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhFWM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:28:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF072C06114D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:26 -0700 (PDT)
Message-Id: <20210623121455.404880646@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kWvzMiCSpOyqgYOmKiL1zoGy0OnOopUpMNQHtzTBPHc=;
        b=mbBcMxzbh3YUNPoWnrGkBlUDjMmo763MivWrFrdVb6Kf0lbXFeMcmIx9iPSncLvCfWLPE9
        /l0PowpuqxZ2VBdugAEo34dDjawH0yB4NkA/DIDvhK8PY0eqaRmsG3an7nlY7O+ThIbbpE
        Kh2oj+MwzEa4aEEMrZQ/AX5roE3mvc30CwkKWoH5cYtIkPYbjrdYuoLHmreD2NCom1j7FH
        GcfYlSIGcYXKstcfHveX2wuyJnr6q/xX//cIKy2Vta7zvQFA/20tquHqMD63217LT4Prlv
        8PbrSDM2q23a57BOklgGiG7LGo9Lw0u4eCHZVMV8uI0zFE5TRhRR31wy+e/anA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kWvzMiCSpOyqgYOmKiL1zoGy0OnOopUpMNQHtzTBPHc=;
        b=tqQryc6oaDxI3b9Cz/OinDBfGgBYOQkDkXK692VxQqp1F/BlPv9wZ4al2oc5iuktQ+4s4j
        3yKTQgCA46NRBCAg==
Date:   Wed, 23 Jun 2021 14:02:08 +0200
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
Subject: [patch V4 41/65] x86/pkru: Provide pkru_get_init_value()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is disabled then the following
code fails to compile:

     if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
     	u32 pkru = READ_ONCE(init_pkru_value);
	..
     }

because init_pkru_value is defined as '0' which makes READ_ONCE() upset.

Provide an accessor macro to avoid #ifdeffery all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pkru.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -10,8 +10,10 @@
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
+#define pkru_get_init_value()	READ_ONCE(init_pkru_value)
 #else
 #define init_pkru_value	0
+#define pkru_get_init_value()	0
 #endif
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)

