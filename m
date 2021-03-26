Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35B34AB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCZPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12DC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=djmWkR6lOqPkY3zhHdUz/MQiNDxiEx1+lLXUwlEkDcw=; b=qd+R1dmiHQucQgoYeFhRJd6Yo9
        5pIKKDOAeUo8/ufnmFej7abqRuhlhzmjnoojAkWppXAV6h5tDHydfqxwvH4xsEfDd8jSZ1k0WrL16
        J6FHmgMD5A4hLxZovO0Vctxxeyws7S1htINSvE2OD8UKHmP4W8Wb97MUx0sHc8gsKHRMOHrDJs/au
        EyoDWOe/GKSpnFJ8WNuzTY+rvWBDELbacZ81s+itdGU2tA1LzTU/8CvUZFhItatGt+HfiUDG68QDU
        OdLm6U6sW2Y4vtQasOuNi54SlrFp0EuVzK7IWJvzLtMkNFKcfrarkuM/kA7ZZD4p+FszZpTFoOKIP
        cmemvkzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9X-003s02-5a; Fri, 26 Mar 2021 15:13:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8454D3060C5;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3147A2BAC2E3F; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151259.379242587@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 01/16] x86: Add insn_decode_kernel()
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to decode kernel instructions; there's no point in
endlessly repeating those last two arguments.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/insn.h        |    2 ++
 arch/x86/kernel/alternative.c      |    2 +-
 arch/x86/kernel/cpu/mce/severity.c |    2 +-
 arch/x86/kernel/kprobes/core.c     |    4 ++--
 arch/x86/kernel/kprobes/opt.c      |    2 +-
 arch/x86/kernel/traps.c            |    2 +-
 tools/arch/x86/include/asm/insn.h  |    4 +++-
 7 files changed, 11 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -150,6 +150,8 @@ enum insn_mode {
 
 extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
+#define insn_decode_kernel(_insn, _ptr) insn_decode((_insn), (_ptr), MAX_INSN_SIZE, INSN_MODE_KERN)
+
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1160,7 +1160,7 @@ static void text_poke_loc_init(struct te
 	if (!emulate)
 		emulate = opcode;
 
-	ret = insn_decode(&insn, emulate, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, emulate);
 
 	BUG_ON(ret < 0);
 	BUG_ON(len != insn.length);
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -225,7 +225,7 @@ static bool is_copy_from_user(struct pt_
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
 		return false;
 
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -279,7 +279,7 @@ static int can_probe(unsigned long paddr
 		if (!__addr)
 			return 0;
 
-		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
+		ret = insn_decode_kernel(&insn, (void *)__addr);
 		if (ret < 0)
 			return 0;
 
@@ -316,7 +316,7 @@ int __copy_instruction(u8 *dest, u8 *src
 			MAX_INSN_SIZE))
 		return 0;
 
-	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(insn, dest);
 	if (ret < 0)
 		return 0;
 
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -324,7 +324,7 @@ static int can_optimize(unsigned long pa
 		if (!recovered_insn)
 			return 0;
 
-		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
+		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
 		if (ret < 0)
 			return 0;
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -504,7 +504,7 @@ static enum kernel_gp_hint get_kernel_gp
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
 		return GP_NO_HINT;
 
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -150,6 +150,8 @@ enum insn_mode {
 
 extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
+#define insn_decode_kernel(_insn, _ptr) insn_decode((_insn), (_ptr), MAX_INSN_SIZE, INSN_MODE_KERN)
+
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
 {


