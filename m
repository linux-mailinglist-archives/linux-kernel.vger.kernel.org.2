Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6E443403
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhKBQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:55:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhKBQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:55:02 -0400
Date:   Tue, 2 Nov 2021 17:52:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635871946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bCJaAndOO/4NSmeYwxNL/qLhoa4w8he58KG9tEjlpvw=;
        b=dQdvQE+y1gD5dr3P04E2FvHdJB24twVjiPDqDHZCkaobEjGRin4ksCTd6bJJz5RZS4vNN1
        fFkbc1BSM5TIjs7cBPJsvPFrzEw9qQSJko8+C64lXATbNXuc/8Ml2aboi0ssU/0SazQkNb
        C4i9wx5rVpWRPT4XPvWUl0xmFK5O1jCWDdxMmBRjSPTEfYzDwiObwH31wNOUUDnsvjpLGQ
        JMtgZrQk9I7Q5PittMg0jV3jdbYVkaBxatSoCMZyW9Zd4E2lI5dHFi+TCC2/ppLQxQwabc
        kz13ukIiL5BXZB/lqwOaQi6SeoUf+0QdNGqGBl4o1gF4MIkIQwMGe/zY8+z95Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635871946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bCJaAndOO/4NSmeYwxNL/qLhoa4w8he58KG9tEjlpvw=;
        b=Zp3JV4lZ5qsNNfFTmiPwbBuYbuMm28Nn4ESQpe1JBEoYm46YEAznqCZFv0y3nvxJj6weaQ
        far0iFNOgUu3WLDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm: Include spinlock_t definition in pgtable.
Message-ID: <20211102165224.wpz4zyhsvwccx5p3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file provides forward declartion for pgd_lock but does not
include the header defining its type. This works since the definition of
spinlock_t is usually included somehow via printk.

By trying to avoid recursive includes on PREEMPT_RT I avoided the loop
in printk and as a consequnce kernel/intel.c failed to compile due to
missing type definition.

Include the needed definition for spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ecb..a34430b7af4a3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -22,6 +22,7 @@
 #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
 
 #ifndef __ASSEMBLY__
+#include <linux/spinlock.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
-- 
2.33.1

