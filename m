Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242435D7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDMG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:26:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16537 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhDMG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:26:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKFsn2jLxzNvMR;
        Tue, 13 Apr 2021 14:23:25 +0800 (CST)
Received: from [10.174.177.246] (10.174.177.246) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 14:26:09 +0800
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
From:   Kemeng Shi <shikemeng@huawei.com>
Subject: [PATCH] x86: Accelerate copy_page with non-temporal in X86
Message-ID: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
Date:   Tue, 13 Apr 2021 14:25:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.246]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using AEP with dax_kmem drvier, and AEP is export as a NUMA node in
my system. I will move cold pages from DRAM node to AEP node with
move_pages system call. With old "rep movsq', it costs 2030ms to move
1 GB pages. With "movnti", it only cost about 890ms to move 1GB pages.
I also test move 1GB pages from AEP node to DRAM node. But the result is
unexpected. "rep movesq" cost about 372 ms while "movnti" cost about
477ms. As said in X86 , "movnti" could avoid "polluting the caches" in
this situaction. I don't know if it's general result or just happening
in my machine. Hardware information is as follow:
CPU:
Intel(R) Xeon(R) Gold 6266C CPU @ 3.00GHz
DRAM:
Memory Device
        Array Handle: 0x0035
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 64 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM130 J40
        Bank Locator: _Node1_Channel3_Dimm0
        Type: DDR4
        Type Detail: Synchronous Registered (Buffered)
        Speed: 2933 MT/s
        Manufacturer: Samsung
        Serial Number: 03B71EB0
        Asset Tag: 1950
        Part Number: M393A8G40MB2-CVF
        Rank: 2
        Configured Memory Speed: 2666 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V
        Memory Technology: DRAM
        Memory Operating Mode Capability: Volatile memory
        Firmware Version: 0000
        Module Manufacturer ID: Bank 1, Hex 0xCE
        Module Product ID: Unknown
        Memory Subsystem Controller Manufacturer ID: Unknown
        Memory Subsystem Controller Product ID: Unknown
        Non-Volatile Size: None
        Volatile Size: 64 GB
        Cache Size: None
        Logical Size: None
AEP:
Memory Device
        Array Handle: 0x0035
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 128 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM131 J41
        Bank Locator: _Node1_Channel3_Dimm1
        Type: Logical non-volatile device
        Type Detail: Synchronous Non-Volatile LRDIMM
        Speed: 2666 MT/s
        Manufacturer: Intel
        Serial Number: 00006803
        Asset Tag: 1949
        Part Number: NMA1XXD128GPS
        Rank: 1
        Configured Memory Speed: 2666 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V
        Memory Technology: Intel persistent memory
        Memory Operating Mode Capability: Volatile memory
	Byte-accessible persistent memory
        Firmware Version: 5355
        Module Manufacturer ID: Bank 1, Hex 0x89
        Module Product ID: 0x0556
        Memory Subsystem Controller Manufacturer ID: Bank 1, Hex 0x89
        Memory Subsystem Controller Product ID: 0x097A
        Non-Volatile Size: 126 GB
        Volatile Size: None
        Cache Size: None
        Logical Size: None
Memory dimm topoloygy:
AEP
 |
DRAM	DRAM	DRAM
 |       |       |
 |-------|-------|
	CPU
 |-------|-------|
 |       |       |
DRAM	DRAM	DRAM

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 arch/x86/lib/copy_page_64.S | 73 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index 2402d4c489d2..69389b4aeeed 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -14,7 +14,8 @@
  */
 	ALIGN
 SYM_FUNC_START(copy_page)
-	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
+	ALTERNATIVE_2 "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD, \
+                      "jmp copy_page_nt", X86_FEATURE_XMM2
 	movl	$4096/8, %ecx
 	rep	movsq
 	ret
@@ -87,3 +88,73 @@ SYM_FUNC_START_LOCAL(copy_page_regs)
 	addq	$2*8, %rsp
 	ret
 SYM_FUNC_END(copy_page_regs)
+
+SYM_FUNC_START_LOCAL(copy_page_nt)
+	subq	$2*8,	%rsp
+	movq	%rbx,	(%rsp)
+	movq	%r12,	1*8(%rsp)
+
+	movl    $(4096/64)-5, %ecx
+	.p2align 4
+.LoopNT64:
+	decl	%ecx
+
+	movq	0x8*0(%rsi), %rax
+	movq	0x8*1(%rsi), %rbx
+	movq	0x8*2(%rsi), %rdx
+	movq	0x8*3(%rsi), %r8
+	movq	0x8*4(%rsi), %r9
+	movq	0x8*5(%rsi), %r10
+	movq	0x8*6(%rsi), %r11
+	movq	0x8*7(%rsi), %r12
+
+	prefetcht0 5*64(%rsi)
+
+	movnti	%rax, 0x8*0(%rdi)
+	movnti	%rbx, 0x8*1(%rdi)
+	movnti	%rdx, 0x8*2(%rdi)
+	movnti	%r8,  0x8*3(%rdi)
+	movnti	%r9,  0x8*4(%rdi)
+	movnti	%r10, 0x8*5(%rdi)
+	movnti	%r11, 0x8*6(%rdi)
+	movnti	%r12, 0x8*7(%rdi)
+
+	leaq	64(%rdi), %rdi
+	leaq	64(%rsi), %rsi
+	jnz     .LoopNT64
+
+	movl	$5, %ecx
+	.p2align 4
+.LoopNT2:
+	decl	%ecx
+
+	movq	0x8*0(%rsi), %rax
+	movq	0x8*1(%rsi), %rbx
+	movq	0x8*2(%rsi), %rdx
+	movq	0x8*3(%rsi), %r8
+	movq	0x8*4(%rsi), %r9
+	movq	0x8*5(%rsi), %r10
+	movq	0x8*6(%rsi), %r11
+	movq	0x8*7(%rsi), %r12
+
+	movnti	%rax, 0x8*0(%rdi)
+	movnti	%rbx, 0x8*1(%rdi)
+	movnti	%rdx, 0x8*2(%rdi)
+	movnti	%r8,  0x8*3(%rdi)
+	movnti	%r9,  0x8*4(%rdi)
+	movnti	%r10, 0x8*5(%rdi)
+	movnti	%r11, 0x8*6(%rdi)
+	movnti	%r12, 0x8*7(%rdi)
+
+	leaq	64(%rdi), %rdi
+	leaq	64(%rsi), %rsi
+	jnz	.LoopNT2
+
+	movq	(%rsp), %rbx
+	movq	1*8(%rsp), %r12
+	addq	$2*8, %rsp
+
+	sfence
+
+	ret
+SYM_FUNC_END(copy_page_nt)
-- 
2.23.0

