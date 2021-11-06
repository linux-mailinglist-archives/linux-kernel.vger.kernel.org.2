Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA7446D01
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 09:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhKFIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 04:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhKFIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 04:33:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC04C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jqj3XnNC6AI4qWVi+KOh7dQ0dvYOdMogW1IFuJxwAD0=; b=F6CGG/imjp36xvtSWdDWed+gKS
        HTEGnYW/JzapM2uHEM8TNoj8iWO6P4rpgsU5hTxd/wPPK7q0XvD3dToFmgy13M3QGHbMwWZ/ogQKn
        E6Eygpn970nj0A1a4d2DI5xPFA9bjKUDOnVrMBkASJ0jTCMaKBlyr/fziXWy7MA7TcALZu+vX6WGu
        rSevKu08bg3BlPvA7eIpVmHDheuxMbeBTAM8Z4+u2/BdvPCY+b/D8x4qqpEb/mWUuYDA4RD7YUR8C
        OGwF1z1f8i8cMm53oYKExzrCWtKMSG37xksPyjP4wqg9mJ3L/LgSXPYBH/ZIxiGv/RyCjqapoAfvW
        jo+rOepw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjH3a-0077Ep-37; Sat, 06 Nov 2021 08:28:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 437E79862D2; Sat,  6 Nov 2021 09:28:08 +0100 (CET)
Date:   Sat, 6 Nov 2021 09:28:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Message-ID: <20211106082808.GS174703@worktop.programming.kicks-ass.net>
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

> And hopefully this entire mess will
> go away before that happens, as the trampoline shenanigans are needed
> only because the minimum compiler version doesn't guarantee support for
> asm goto with outputs.

We can at least have those who use sane compilers get sane code..

Something like this, right?

--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -70,6 +70,31 @@ static __always_inline unsigned long __v
 {
 	unsigned long value;
 
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+
+	asm_volatile_goto("1: vmread %[field], %[output]\n\t"
+			  "jna %l[do_fail]\n\t"
+
+			  _ASM_EXTABLE(1b, %l[do_exception])
+
+			  : ASM_CALL_CONSTRAINT, [output] "=r" (value)
+			  : [field] "r" (field)
+			  : "cc"
+			  : do_fail, do_exception);
+
+	return value;
+
+do_fail: __cold;
+	WARN_ONCE(1, "kvm: vmread failed: field=%lx\n", field);
+	pr_warn_ratelimited("kvm: vmread failed: field=%lx\n", field);
+	return 0;
+
+do_exception: __cold;
+	kvm_spurious_fault();
+	return 0;
+
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 	asm volatile("1: vmread %2, %1\n\t"
 		     ".byte 0x3e\n\t" /* branch taken hint */
 		     "ja 3f\n\t"
@@ -94,7 +119,10 @@ static __always_inline unsigned long __v
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %1)
 
 		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
+
 	return value;
+
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 }
 
 static __always_inline u16 vmcs_read16(unsigned long field)
