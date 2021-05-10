Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E616337964E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhEJRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:46:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42871 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231680AbhEJRqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:46:44 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AHjGkE2449170
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 10:45:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AHjGkE2449170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620668728;
        bh=cWMxZxjmTF92DnjVgyipJF2aSu5WXHhpAFKNFH6AIwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8NTIcWgDQpG9GpBp6GU3R2pCW5ZUCMHN+aWCRymfDpKS3BcqRKnbZEFoYjCuGczk
         FvD4cigjY4eaAqcfBHuKlsiKe1EbLWGp7f1yfZwkkl6Y1Wa27OZxx+9HvadeZ5smI2
         YpCoo+72e5VroZUWL2ZVRsnezk+P6BImYV1jCkCMS6+UGkvCpKszfRDXVFHCJfMjAG
         K2SV8KClGXRZM/tZEPpodsnkQEQ7P+vxumChB4AEqHv6dM50lBpVSO4QmiixDNbyO7
         wspVbyUjdR9x50AQrhsgSL5RmSbl35mCsR9l69L3vPDV0DySnuKcdzOaaoqpsD/fNZ
         rnU3CGfMbnSAA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/6] x86/syscall: maximize MSR_SYSCALL_MASK
Date:   Mon, 10 May 2021 10:45:07 -0700
Message-Id: <20210510174509.3039991-5-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510174509.3039991-1-hpa@zytor.com>
References: <20210510174509.3039991-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

It is better to clear as many flags as possible when we do a system
call entry, as opposed to the other way around. The fewer flags we
keep, the lesser the possible interference between the kernel and user
space.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/kernel/cpu/common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c49a93..6cf697574661 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1773,10 +1773,16 @@ void syscall_init(void)
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
 #endif
 
-	/* Flags to clear on syscall */
+	/*
+	 * Flags to clear on syscall; clear as much as possible
+	 * to minimize user space-kernel interference.
+	 */
 	wrmsrl(MSR_SYSCALL_MASK,
-	       X86_EFLAGS_TF|X86_EFLAGS_DF|X86_EFLAGS_IF|
-	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
+	       X86_EFLAGS_CF|X86_EFLAGS_PF|X86_EFLAGS_AF|
+	       X86_EFLAGS_ZF|X86_EFLAGS_SF|X86_EFLAGS_TF|
+	       X86_EFLAGS_IF|X86_EFLAGS_DF|X86_EFLAGS_OF|
+	       X86_EFLAGS_IOPL|X86_EFLAGS_NT|X86_EFLAGS_RF|
+	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
 #else	/* CONFIG_X86_64 */
-- 
2.31.1

