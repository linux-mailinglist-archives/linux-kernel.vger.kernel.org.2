Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6142D6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhJNKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhJNKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:08:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67586C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXX7HENgf1FWhjqppxsdTbzDKYUOzSWPxKDSGrXHbc0=; b=MZPOErPO4LCjT6Rzr1NjQBpvmi
        p2oEnnTAgVRf6rL5x3UDrC5L0XA0ymk3PwqzVAs1y5z8MVCUkf9nPxkxeSJxfuVJflUVZTruPuQD/
        7BKRKLhuTW7aBI5bonlPU6DCRei4lbb8XeO88WL32ZwIx731ZGAAtmhbPXr479DSDzyRbxeKZUKqZ
        18daqzbhH0N4bG2ItYlKTpLBlzqj0j0VZ33+MpmDi3utvi5hiLmrvF2SSLhlpewPpF7914IExKPGv
        X27OT8CU5YzP5Psmw8U0kRV9lPrdo9b6WBcFZh5X8FYzUZqjpUQyxAIfvhtJi9nMUO0iMmCoMyv9h
        ah/HKuCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maxcS-009oUZ-3c; Thu, 14 Oct 2021 10:05:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 144F130031A;
        Thu, 14 Oct 2021 12:05:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F021D20A958D5; Thu, 14 Oct 2021 12:05:46 +0200 (CEST)
Date:   Thu, 14 Oct 2021 12:05:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWgA+vbWCdGLZhq5@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <98fdd068-d1c3-1f8c-18b7-13c3909ed9ca@citrix.com>
 <YWb3TdmyPK7GwBP4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWb3TdmyPK7GwBP4@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:12:13PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 03:38:27PM +0100, Andrew Cooper wrote:
> > On 13/10/2021 13:22, Peter Zijlstra wrote:

> > > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > > +{
> > > +	void (*target)(void);
> > > +	int reg, i = 0;
> > > +
> > > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > > +		return -1;
> > > +
> > > +	target = addr + insn->length + insn->immediate.value;
> > > +	reg = (target - &__x86_indirect_thunk_rax) /
> > > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > 
> > This is equal measures beautiful and terrifying.
> 
> Thanks! :-)

Would something like this appease people? If the toolchain can mess this
up everything is broken.

That makes the symtab looks like:

(and arguably, that array symbol could be local)

...
35: 0000000000000000   512 NOTYPE  GLOBAL DEFAULT    4 __x86_indirect_thunk_array
36: 0000000000000000    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rax
37: 0000000000000020    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rcx
38: 0000000000000040    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rdx
39: 0000000000000060    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rbx
40: 0000000000000080    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rsp
41: 00000000000000a0    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rbp
42: 00000000000000c0    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rsi
43: 00000000000000e0    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_rdi
44: 0000000000000100    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r8
45: 0000000000000120    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r9
46: 0000000000000140    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r10
47: 0000000000000160    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r11
48: 0000000000000180    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r12
49: 00000000000001a0    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r13
50: 00000000000001c0    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r14
51: 00000000000001e0    17 FUNC    GLOBAL DEFAULT    4 __x86_indirect_thunk_r15


---
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -30,7 +30,7 @@
 
 	.align 32
 
-SYM_FUNC_START(__x86_indirect_thunk_\reg)
+SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
@@ -55,10 +55,16 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
+	.align 32
+SYM_CODE_START(__x86_indirect_thunk_array)
+
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+	.align 32
+SYM_CODE_END(__x86_indirect_thunk_array)
+
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
