Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECD3A46DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFKQri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhFKQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4013C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:32 -0700 (PDT)
Message-Id: <20210611163113.982176939@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YKbxl0e2RP10fPzHFgLtW3AlH0ivwLUXrvNVA5njGrI=;
        b=DgpwVCFuQN0C5yx3zdFMJfe5LO3MhxxC0iRbcdW6QmTJNZZU2qJmh04Oa4FHyjSx/jRkUe
        celJ+NSpNRoDowtx/5GnpgFCwKfqeDuhhmL0TGmKH0jPq5nmMqfwHO4fBKHQLtPV3nu+Rc
        M01mcq8jrVb7Oe7okdcd9BqTkjY6mm7UIDjDXUPkKXfwZRNhuBxm5Y91LzzjaQuHW4HZTD
        Jeo1ENOJ+ihU/Y+9d3IM4cDKRjzXrdTsarCR0LxH2Vbj8Jhccwc6IOCG37mHJeG+zBr12t
        32LBe2Ted+vjivZ8KCDxynJqbJXaLJjD5QlE6DXLYNUj5JH+T7GhmBPjXYpb8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YKbxl0e2RP10fPzHFgLtW3AlH0ivwLUXrvNVA5njGrI=;
        b=xDM6jq934OZFMud600JvNfmKTVIAeLq3TvgzHL75SiMUnzoQKsas2rgMKAnNCFS6gpFKdW
        c3o8sjV5lN1fKCCg==
Date:   Fri, 11 Jun 2021 18:15:51 +0200
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
Subject: [patch 28/41] x86/cpu: Write the default PKRU value when enabling PKE
References: <20210611161523.508908024@linutronix.de>
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
@@ -479,6 +479,8 @@ static __always_inline void setup_pku(st
 	}
 
 	cr4_set_bits(X86_CR4_PKE);
+	/* Load the default PKRU value */
+	pkru_write_default();
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS

