Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A8425D25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhJGUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 16:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhJGUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:24:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CB1C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iFfb36heb1Xp0rc1qf/DNK3t0gf0dV0IKh/PpKDQeRs=; b=Dw7oQ2k1EKObaQAcRyeGwT/wRV
        En6bWFGQjQoCLmVJ3d+0GbZ/k8xoJfLLSeDlFtmyzyVZhrA7AlrfpTEgIzgjZRKPrWIxPoHdoztYp
        wORzGZmzm3Q+djkFyD82slzRQevx7CFgZUuGq1oOQq2FUlx+rjWegKhmeBZSSViglxePRLGGUwZeG
        GTqIYkkotaTMQVHKY6mCw0EgdRSKblMWpuSBax4/7uCNOhL0xVB3n18gAsMwNP47AR8Amx7r19f+7
        VKBqIQYt+6GtY7AQEHBKolPF9AfLUYheiLVYAZ1e+tcYycgW7eTGETODf7+lbv7heXe0fCRYZSJ1V
        bh1XmLlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYZu0-008XiL-SC; Thu, 07 Oct 2021 20:22:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4204F981261; Thu,  7 Oct 2021 22:22:04 +0200 (CEST)
Date:   Thu, 7 Oct 2021 22:22:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     herbert@gondor.apana.org.au, tianjia.zhang@linux.alibaba.com,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org
Subject: [RFC] crypto/sm4: Fix objtool/libelf warning
Message-ID: <20211007202204.GT174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

objtool is yielding the obscure libelf warning:

  vmlinux.o: warning: objtool: elf_update: invalid section entry size

Which I tracked down to section:

  [3023] .rodata.cst164    PROGBITS        0000000000000000 1ab501e0 000154 a4  AM  0   0 16

Which has a section size of 0x154 (340) and an entry size of 0xa4 (164).
An obvious mis-match.

From there, git-grep quickly yields:

  arch/x86/crypto/sm4-aesni-avx-asm_64.S:.section .rodata.cst164, "aM", @progbits, 164
  arch/x86/crypto/sm4-aesni-avx2-asm_64.S:.section        .rodata.cst164, "aM", @progbits, 164

So those files create this .rodata section with an explicit entry size,
but then don't respect it themselves. Removing the entry size makes the
warning go away, but I can't tell if that's right or not, given there is
zero clue as to why that entry size was specified to begin with.

Please explain...

---
diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
index 18d2f5199194..d089cccf4db7 100644
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -78,7 +78,7 @@
 	vpxor tmp0, x, x;
 
 
-.section	.rodata.cst164, "aM", @progbits, 164
+.section	.rodata.cst164, "aM", @progbits
 .align 16
 
 /*
diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
index d2ffd7f76ee2..a0f7541c2246 100644
--- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@ -93,7 +93,7 @@
 	vpxor tmp0, x, x;
 
 
-.section	.rodata.cst164, "aM", @progbits, 164
+.section	.rodata.cst164, "aM", @progbits
 .align 16
 
 /*
