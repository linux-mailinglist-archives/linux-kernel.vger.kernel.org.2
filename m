Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234B53ACEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhFRPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:24:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhFRPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:22 -0400
Message-Id: <20210618143449.407190772@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8bNqn55/9FpzYwdYhLYJ1YHhSO8g4U3kMgFFLHLaBYo=;
        b=S4/oJ0N3WI3dsw9XkJQu5eN9VpAb3BDrSgbpXzBmGEeAh5xYvTdUUxdoJ8SKF5OWx76sA6
        0cQxf8EdbtXpNB2C7zNCQF2QjW0rrxZ+tT2kr3VXghVu/AhPDCzyFSpRAEgN00nJuCeBiz
        nKIt26oIw2GiT96COJx+aSoxCCS8MsyqozrufNQxJJZNUqnZcq0NbRIaJivQx5L3A19I2b
        7gmK+e+Xu5/AorlrQOM9RYmxe1MAm0XIlkfWBQM4pBACgvcuPbxdfTst9ZAD2je4xQtMnz
        zGGTd8Cu11adiU08JFBys/IfDVT1TwKd/GgNusv3Uh5jzDFaf4Ry+Tik7SbLmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8bNqn55/9FpzYwdYhLYJ1YHhSO8g4U3kMgFFLHLaBYo=;
        b=MwRkoqV6ghsetRg8uqnYat8tqDGMUTqijg55aKoijUfDjIWLfXjM41rvjY3YXQeYhzR+ay
        NCxVNteVxPH5SmBA==
Date:   Fri, 18 Jun 2021 16:19:07 +0200
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
Subject: [patch V3 44/66] x86/cpu: Write the default PKRU value when enabling PKE
References: <20210618141823.161158090@linutronix.de>
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

