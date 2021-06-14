Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8E3A6C23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhFNQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhFNQkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35CC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:33 -0700 (PDT)
Message-Id: <20210614155357.567131213@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8bNqn55/9FpzYwdYhLYJ1YHhSO8g4U3kMgFFLHLaBYo=;
        b=KgEFffgwBJqMOqSJ1ZSofsAEQjQGYxtI5t+Hy8QmmaEDya052DYa+ctwZ/mxpbckfLRm1v
        go+jy5nezpE1DeR435olXaDWXIxfCoDnPX/IB7ZFwwoyEqXy27Y8TrPF9nbzXbfLydj/L2
        j17uM+IIom9NrO04BOJPRdyZSzEYiiV6K2ZwTy0wtMdBWRQDU522NFJM7TVqqSKRBHWh39
        bPV18YASBhawiSfcSBQ3wBSCQNtUW9aTPyu/ptrUWv0397eA1kRWOBnCeKexQnZIzKfsIP
        pz5JJMgR2xQ3DqG8acaHUHtpTNwojRUWZezInf/wZIo8k8EHWiXsGhiq7VAGoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8bNqn55/9FpzYwdYhLYJ1YHhSO8g4U3kMgFFLHLaBYo=;
        b=yCR8VRtJBfr8hVfkr4tWkQNmO53PxAOX6WfeNU258+PnFXI8AeFTCAJ+aagvfNa2tGhP5u
        y19Q0Q8L7iswYICQ==
Date:   Mon, 14 Jun 2021 17:44:46 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 38/52] x86/cpu: Write the default PKRU value when enabling PKE
References: <20210614154408.673478623@linutronix.de>
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

