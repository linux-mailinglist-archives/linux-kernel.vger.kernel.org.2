Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A50F446A42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhKEVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKEVGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:06:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21CBC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s3GzurqiZlDrydhtZFIi3IJAbTjHLM1J2fOffymQHsg=; b=j0HJaohSEFpL3Gy8udWipTU3jl
        sZ2D8CpMb4uOxTy6yx3iQpIN4AMhvujbh/jIsURH8Hg79ZolXtalvld3NcroaVj1iYP57l/3+9JM+
        RaKsAvIO2cwgwqVyLF6Nnm9IOjnhX+qGc8qcO+kkywD1RG3/AnYRvyJCXPmS0t3Fzv6OfQ8iRibdV
        J2dsiokN7HssaaohkkT8YMWB+sdNdQKBeeKrd6yaPteqZSFvfSDPz4BFy4A3LLXPpjvgV9DcAnnd/
        PI0JFIt3lb/BmVkZ6KWrOz5h06rjWb0W2+aD0HnWDCN6UhGhCuIYPuvJMoy2nQ3n6ZCqhfMyHf9GB
        rrDx4y2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj6Hm-006pHM-SU; Fri, 05 Nov 2021 20:58:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7A119862D2; Fri,  5 Nov 2021 21:58:05 +0100 (CET)
Date:   Fri, 5 Nov 2021 21:58:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Message-ID: <20211105205805.GR174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org>
 <YYV1UeFeWUtnQ4jV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYV1UeFeWUtnQ4jV@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:17:53PM +0000, Sean Christopherson wrote:

> diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
> index 9e9ef47e988c..5e5113d2b324 100644
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h

> @@ -76,29 +75,24 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
>  		     "ja 3f\n\t"
> 
>  		     /*
> -		      * VMREAD failed.  Push '0' for @fault, push the failing
> -		      * @field, and bounce through the trampoline to preserve
> -		      * volatile registers.
> +		      * VMREAD failed, push the failing @field, and bounce
> +		      * through the trampoline to preserve volatile registers.
> +		      * If VMREAD faults, this will push -FAULT (see below).
>  		      */
> -		     "push $0\n\t"
> -		     "push %2\n\t"
> -		     "2:call vmread_error_trampoline\n\t"
> +		     "2: push %2\n\t"
> +		     "call vmread_error_trampoline\n\t"
> 
>  		     /*
>  		      * Unwind the stack.  Note, the trampoline zeros out the
> -		      * memory for @fault so that the result is '0' on error.
> +		      * memory for @field so that the result is '0' on error,
> +		      * hence the pop to %1, not %2.
>  		      */
> -		     "pop %2\n\t"
>  		     "pop %1\n\t"
>  		     "3:\n\t"
> 
> -		     /* VMREAD faulted.  As above, except push '1' for @fault. */
> -		     ".pushsection .fixup, \"ax\"\n\t"
> -		     "4: push $1\n\t"
> -		     "push %2\n\t"
> -		     "jmp 2b\n\t"
> -		     ".popsection\n\t"
> -		     _ASM_EXTABLE(1b, 4b)
> +		     /* VMREAD faulted.  As above, except push '-EFAULT' for @fault. */
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %1)
> +
>  		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
>  	return value;
>  }

A different option is something like the below; down side is that it
increases the amount of text, while your version decreases the amount of
useless text (the gunk between vmread and 3:, all of which should
ideally live out-of-line).

For now I'll stick with your patch.

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 9e9ef47e988c..99fc1f34fbd4 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -81,8 +81,8 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		      * volatile registers.
 		      */
 		     "push $0\n\t"
-		     "push %2\n\t"
-		     "2:call vmread_error_trampoline\n\t"
+		     "2: push %2\n\t"
+		     "call vmread_error_trampoline\n\t"
 
 		     /*
 		      * Unwind the stack.  Note, the trampoline zeros out the
@@ -90,14 +90,14 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		      */
 		     "pop %2\n\t"
 		     "pop %1\n\t"
-		     "3:\n\t"
+		     "jmp 3f\n\t"
 
-		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     ".pushsection .fixup, \"ax\"\n\t"
 		     "4: push $1\n\t"
-		     "push %2\n\t"
 		     "jmp 2b\n\t"
-		     ".popsection\n\t"
+
+		     "3:\n\t"
+
+		     /* VMREAD faulted.  As above, except push '1' for @fault. */
 		     _ASM_EXTABLE(1b, 4b)
 		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
 	return value;

