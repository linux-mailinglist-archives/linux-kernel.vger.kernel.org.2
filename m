Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F413F34AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhHTTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhHTTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629487876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uykJqgkE+kPdNzBqUQrrrtd5PWdUlHLOHNNK2Rgle2A=;
        b=EnjvErLzWe+fnvCudZv6SvnHyGwnxpBJDJcWb6K0sY+9IZjLMZGIKDdYHHaJ5/GbgPIihm
        TXtSKs/Rxpj8lutTcpfyi3jriOFMJzyriNNSKu3rTHR+kurpcKs/twxz6Gh46IG1AMBS8Q
        9OIJ2LafaR0DIS5J9NNuAvrs6IsU5vM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-r_lKyvIrPg-a5Y2Bh18D1g-1; Fri, 20 Aug 2021 15:31:12 -0400
X-MC-Unique: r_lKyvIrPg-a5Y2Bh18D1g-1
Received: by mail-ot1-f72.google.com with SMTP id w4-20020a9d63840000b02905175db63035so5212639otk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uykJqgkE+kPdNzBqUQrrrtd5PWdUlHLOHNNK2Rgle2A=;
        b=XGmHhkbrIeyM9iKA9cn26OX8gi8bsCz/vQ66/YQC8PIhs416qgqgS3PXWoQbLNfC7I
         8ae3vhvizCVSwOTVFrEO2b5tMhbMiueAk8v1wIR5q+8oanqbewrZVsUhU95qY3KYgQP/
         1hDnTVlhYij/FRfB7ve7Ka02kpjGAKL18ebsTd9YfMoTWAjHVgbdmJhR4Ai+YejnEeXz
         bdnDzPgNcfLVhOyuXK/AsoRhsKnwotkVEkWdvy+1POzsV/+phsnZvWvUBWVMtYJGI/SE
         +DeoJng2cMdJ6Pov0nuppoaq3C79wTE7vycW0i9LyLh7CzpJTQm5pAw7e0TmSAors/ty
         DuMQ==
X-Gm-Message-State: AOAM531qzwIpVpNW9HQutBxyDa32dYjnakwPWWZMErNOkg7a/I4/+1Ps
        hNUVhZ4puj6FT1PT8xM4orj5sOQ7iHMzMy/3+ybpeCgQ9OZ8T4JNLVHtkuAtGEJxPn+uAj+DmoX
        29frX9KlB847UBRBCeWzHVs32
X-Received: by 2002:a4a:98b0:: with SMTP id a45mr17633886ooj.22.1629487871036;
        Fri, 20 Aug 2021 12:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo5IXxqhXQmEbioUfJ8VlpiVbWmwbWE3cGa9PLFAiwMkrcD+w3j7LenOCU+iFvQH/62qfLkg==
X-Received: by 2002:a4a:98b0:: with SMTP id a45mr17633869ooj.22.1629487870837;
        Fri, 20 Aug 2021 12:31:10 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id 65sm1534521ooc.2.2021.08.20.12.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:31:10 -0700 (PDT)
Date:   Fri, 20 Aug 2021 12:31:07 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
Message-ID: <20210820193107.omvshmsqbpxufzkc@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820192224.ytrr6ybuuwegbeov@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:22:28PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 24, 2021 at 11:41:00AM +0200, Peter Zijlstra wrote:
> > The asm_cpu_bringup_and_idle() function is required to push the return
> > value on the stack in order to make ORC happy, but the only reason
> > objtool doesn't complain is because of a happy accident.
> > 
> > The thing is that asm_cpu_bringup_and_idle() doesn't return, so
> > validate_branch() never terminates and falls through to the next
> > function, which in the normal case is the hypercall_page. And that, as
> > it happens, is 4095 NOPs and a RET.
> > 
> > Make asm_cpu_bringup_and_idle() terminate on it's own, by making the
> > function it calls as a dead-end. This way we no longer rely on what
> > code happens to come after.
> > 
> > Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks reliable")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Looks right.  Only problem is, with my assembler I get this:
> 
>   arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable instruction
> 
> Because gas insists on jumping over the page of nops...
> 
> 0000000000000000 <asm_cpu_bringup_and_idle>:
>        0:	e8 00 00 00 00       	callq  5 <asm_cpu_bringup_and_idle+0x5>
> 			1: R_X86_64_PLT32	cpu_bringup_and_idle-0x4
>        5:	e9 f6 0f 00 00       	jmpq   1000 <xen_hypercall_set_trap_table>
>        a:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>       11:	00 00 00 00 
>       15:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>       1c:	00 00 00 00 
>       20:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>       27:	00 00 00 00 
>       2b:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>       32:	00 00 00 00 
>       36:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>       3d:	00 00 00 00 

Here's a fix:

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/xen: Move hypercall_page to top of the file

Because hypercall_page is page-aligned, the assembler inexplicably adds
an unreachable jump from after the end of the previous code to the
beginning of hypercall_page.

That confuses objtool, understandably.  It also creates significant text
fragmentation.  As a result, much of the object file is wasted text
(nops).

Move hypercall_page to the beginning of the file to both prevent the
text fragmentation and avoid the dead jump instruction.

$ size /tmp/head_64.before.o /tmp/head_64.after.o
   text	   data	    bss	    dec	    hex	filename
  10924	 307252	   4096	 322272	  4eae0	/tmp/head_64.before.o
   6823	 307252	   4096	 318171	  4dadb	/tmp/head_64.after.o

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/xen/xen-head.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index cb6538ae2fe0..488944d6d430 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -20,6 +20,23 @@
 #include <xen/interface/xen-mca.h>
 #include <asm/xen/interface.h>
 
+.pushsection .text
+	.balign PAGE_SIZE
+SYM_CODE_START(hypercall_page)
+	.rept (PAGE_SIZE / 32)
+		UNWIND_HINT_FUNC
+		.skip 31, 0x90
+		ret
+	.endr
+
+#define HYPERCALL(n) \
+	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
+	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
+#include <asm/xen-hypercalls.h>
+#undef HYPERCALL
+SYM_CODE_END(hypercall_page)
+.popsection
+
 #ifdef CONFIG_XEN_PV
 	__INIT
 SYM_CODE_START(startup_xen)
@@ -64,23 +81,6 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
 #endif
 #endif
 
-.pushsection .text
-	.balign PAGE_SIZE
-SYM_CODE_START(hypercall_page)
-	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		ret
-	.endr
-
-#define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
-	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
-#include <asm/xen-hypercalls.h>
-#undef HYPERCALL
-SYM_CODE_END(hypercall_page)
-.popsection
-
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
-- 
2.31.1

