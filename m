Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50156405FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348841AbhIIXSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:18:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57553 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234743AbhIIXSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:18:33 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 189NGtkD254001
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Sep 2021 16:16:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 189NGtkD254001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631229417;
        bh=um8aeCfl6b9E+G9YaI17v2BeFtCJRFzEbr9r+28x1bU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W9DHJYR6P8ex4XsXLT/g29un+MoNFvdlMF3YTA0YsYdQM16sR0UQxsThV4KyOIXUY
         qshi90Hzl3HqIcUCWpu5SXAoT8EhYOKbEjMWuumJ4AlVbki2pBGPcRHY3dTfeqskpC
         HaYGqZD/LCF68NhIK8/DpXMpNgm3jZhjU9TjxL/pmRk94cShI9WuAgPsxLjrKbKt3D
         YJ4i9Ox8TurF8NOM5QQo9NDK/rEFGLxMNn63GqVnr1QirVYPz2uM2xWnMTKK3EFyao
         eQVMuqTjuaUmGr7pPP+5ZOBSCzuSAt/Gc8vcrS+h+yMWQlRiySJMVC/Qjel6wgrfCY
         25gFsq+5rKjOw==
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
 <9fdb04b1-dbb8-069d-f5ef-d4e8c0f2a83e@zytor.com>
 <f84c2b3c-a880-502f-4f51-4624b3800a05@zytor.com>
 <638f3b2b-aff9-72e5-3a5d-fff5ef6b88fc@zytor.com>
 <f76296d5-8d95-cf3d-b800-3f6b2e2d21fb@linux.alibaba.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <43f7935a-e9d9-7bb9-372b-079d638205d8@zytor.com>
Date:   Thu, 9 Sep 2021 16:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f76296d5-8d95-cf3d-b800-3f6b2e2d21fb@linux.alibaba.com>
Content-Type: multipart/mixed;
 boundary="------------B5BB011F5117831604F431EB"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B5BB011F5117831604F431EB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Come to think about it, I think it would be better if we were to 
incorporate the X86_BUG_NULL_SEG null segment load in into the main 
native_load_gs_index() code while we are swapgs'd anyway. This 
simplifies the code further, and should avoid calling 
native_load_gs_index() twice if this bug is enabled.

(This is the traps.c code only; removing the now unnecessary instances 
is left as an exercise for the reader...)

	-hpa

--------------B5BB011F5117831604F431EB
Content-Type: text/x-patch; charset=UTF-8;
 name="traps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="traps.diff"

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..5de423a24777 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -671,6 +671,48 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 }
 
 #ifdef CONFIG_X86_64
+
+/*
+ * Reload the %gs selector for user space (setting GS_BASE) with
+ * exception handling: if the selector is invalid, set %gs to NULL.
+ *
+ * selector: new selector
+ *
+ * This function is noinstr as it must not be instrumented.
+ */
+noinstr void native_load_gs_index(unsigned int selector)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+again:
+	native_swapgs();
+
+	if (static_cpu_has_bug(X86_BUG_NULL_SEG)) {
+		if (likely(selector <= 3))
+			asm volatile("mov %[seg],%%gs"
+				     : : [seg] "rm" (__USER_DS));
+	}
+
+	asm_volatile_goto("1: mov %[seg],%%gs\n"
+			  _ASM_EXTABLE(1b, %l[bad_seg])
+			  : : [seg] "rm" (selector)
+			  : : bad_seg);
+
+	alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
+	native_swapgs();
+	local_irq_restore(flags);
+	return;
+
+bad_seg:
+	/*
+	 * Invalid selector, set %gs to null (0).
+	 */
+	selector = 0;
+	goto again;
+}
+
 /*
  * Help handler running on a per-cpu (IST or entry trampoline) stack
  * to switch to the normal thread stack if the interrupted code was in

--------------B5BB011F5117831604F431EB--
