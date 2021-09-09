Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811E4405BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhIIRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:02:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55728 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237081AbhIIRCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:02:40 -0400
Received: from zn.tnic (p200300ec2f0e45006cc97a4fa336fa6e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4500:6cc9:7a4f:a336:fa6e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FFFF1EC02DD;
        Thu,  9 Sep 2021 19:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631206884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w4Y8bFgD3thTTfS6Bs/DTyzow70iN97zN1ZeyQrqs70=;
        b=h9luuAqhcse44qP4s0R93oA2rvlPQ1+CMt4zScWRJ5kscAXvjSEVa/KlrCEqHlKvjtP3e5
        YYWXzJMK5j427cdHrs8NIrhLLetRd+kuS5UkiiF2teC6pYfKhSaXWLMD4BDmoU1w6jGni5
        x7U74azrkGokYpctJGoL8+HUi6fYQXs=
Date:   Thu, 9 Sep 2021 19:01:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in
 static_cpu_has()
Message-ID: <YTo92+0ruBlkcaDf@zn.tnic>
References: <20210908171716.3340120-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908171716.3340120-1-hpa@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 10:17:16AM -0700, H. Peter Anvin (Intel) wrote:

> Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in static_cpu_has()

"pessimize" huh? :)

Why not simply

"Do not waste registers in the pre-initialization case... "

?

> gcc will sometimes manifest the address of boot_cpu_data in a register
> as part of constant propagation. When multiple static_cpu_has() are
> used this may foul the mainline code with a register load which will
> only be used on the fallback path, which is unused after
> initialization.

So a before-after thing looks like this here:

before:

ffffffff89696517 <.altinstr_aux>:
ffffffff89696517:       f6 05 cb 09 cb ff 80    testb  $0x80,-0x34f635(%rip)        # ffffffff89346ee9 <boot_cpu_data+0x69>
ffffffff8969651e:       0f 85 fc 3e fb ff       jne    ffffffff8964a420 <intel_pmu_init+0x14e7>
ffffffff89696524:       e9 ee 3e fb ff          jmp    ffffffff8964a417 <intel_pmu_init+0x14de>
ffffffff89696529:       f6 45 6a 08             testb  $0x8,0x6a(%rbp)
ffffffff8969652d:       0f 85 45 b9 97 f7       jne    ffffffff81011e78 <intel_pmu_lbr_filter+0x68>
ffffffff89696533:       e9 95 b9 97 f7          jmp    ffffffff81011ecd <intel_pmu_lbr_filter+0xbd>
ffffffff89696538:       41 f6 44 24 6a 08       testb  $0x8,0x6a(%r12)
ffffffff8969653e:       0f 85 d3 bc 97 f7       jne    ffffffff81012217 <intel_pmu_store_lbr+0x77>
ffffffff89696544:       e9 d9 bc 97 f7          jmp    ffffffff81012222 <intel_pmu_store_lbr+0x82>
ffffffff89696549:       41 f6 44 24 6a 08       testb  $0x8,0x6a(%r12)

after:

ffffffff89696517 <.altinstr_aux>:
ffffffff89696517:       f6 04 25 e9 6e 34 89    testb  $0x80,0xffffffff89346ee9
ffffffff8969651e:       80 
ffffffff8969651f:       0f 85 fb 3e fb ff       jne    ffffffff8964a420 <intel_pmu_init+0x14e7>
ffffffff89696525:       e9 ed 3e fb ff          jmp    ffffffff8964a417 <intel_pmu_init+0x14de>
ffffffff8969652a:       f6 04 25 ea 6e 34 89    testb  $0x8,0xffffffff89346eea
ffffffff89696531:       08 
ffffffff89696532:       0f 85 37 b9 97 f7       jne    ffffffff81011e6f <intel_pmu_lbr_filter+0x5f>
ffffffff89696538:       e9 89 b9 97 f7          jmp    ffffffff81011ec6 <intel_pmu_lbr_filter+0xb6>
ffffffff8969653d:       f6 04 25 ea 6e 34 89    testb  $0x8,0xffffffff89346eea
ffffffff89696544:       08 
ffffffff89696545:       0f 85 b5 bc 97 f7       jne    ffffffff81012200 <intel_pmu_store_lbr+0x70>
ffffffff8969654b:       e9 bb bc 97 f7          jmp    ffffffff8101220b <intel_pmu_store_lbr+0x7b>
ffffffff89696550:       f6 04 25 ea 6e 34 89    testb  $0x8,0xffffffff89346eea

so you're basically forcing an immediate thing.

And you wanna get rid of the (%<reg>) relative addressing and force it
to be rip-relative.

> Explicitly force gcc to use immediate (rip-relative) addressing for

Right, the rip-relative addressing doesn't happen here:

--- /tmp/before	2021-09-09 18:18:28.693009433 +0200
+++ /tmp/after	2021-09-09 18:19:06.285009113 +0200
@@ -1,5 +1,5 @@
-# ./arch/x86/include/asm/cpufeature.h:179: 	asm_volatile_goto(
-# 179 "./arch/x86/include/asm/cpufeature.h" 1
+# ./arch/x86/include/asm/cpufeature.h:184: 	asm_volatile_goto(
+# 184 "./arch/x86/include/asm/cpufeature.h" 1
 	# ALT: oldinstr2
 661:
 	jmp 6f
@@ -29,12 +29,12 @@
 	
 6652:
 .popsection
-.section .altinstr_aux,"ax"
+.pushsection .altinstr_aux,"ax"
 6:
- testb $1,boot_cpu_data+62(%rip)	#, MEM[(const char *)&boot_cpu_data + 62B]
+ testb $1,boot_cpu_data+62	#,
  jnz .L99	#
  jmp .L100	#
-.previous
+.popsection
 
 # 0 "" 2


.vminstr_aux even on an allyesconfig build is solely immediate
addressing in the TEST insn.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
