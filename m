Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45D8379733
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhEJSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:54:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48999 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231817AbhEJSyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:45 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNlh2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNlh2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672813;
        bh=7zzEAq64ESXNZfItBhsP50MWC9r1d0W8O+dRebRph+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeoiRRl+6P7oiCCIaSrV6dZBlRCIdE1JGNKUn2AvIZtKIhPNtJDMIX0gV/hL0Hxyk
         bTLPpY0nzTl4sS2DCpsMoDVxRd1Km6S/7V1KfC56U2/xvgKylR60TQt0U2FUOiWGnW
         EAYUcLp+A1EJKC+DXM0kt1vdmVI9YONSjYWTX64RQ6RhyNK7Imh1Ks9tfIlAETZyZs
         btc2SUZ4tSbC3k5IzmKkPLHb62XZl1fziTMg9ouoHejfFsHJEWAFisbdOiWe2Hytsz
         YNxsaDHdQNhbk2yvtEulHAjei/v1V0EdEq4kz9DYqQMUEZkHDNf6ND+nd+rhT2TYvA
         bcgoEW9wh2LGg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 5/7] x86/entry: split PUSH_AND_CLEAR_REGS into two submacros
Date:   Mon, 10 May 2021 11:53:14 -0700
Message-Id: <20210510185316.3307264-6-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510185316.3307264-1-hpa@zytor.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

PUSH_AND_CLEAR_REGS, as the name implies, performs two functions:
pushing registers and clearing registers. They don't necessarily have
to be performed in immediate sequence, although all current users
do. Split it into two macros for the case where that isn't desired;
the FRED enabling patchset will eventually make use of this.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/calling.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 7436d4a74ecb..a4c061fb7c6e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,7 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -90,7 +90,9 @@ For 32-bit we have the following conventions - kernel is built with
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
+.endm
 
+.macro CLEAR_REGS
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -112,6 +114,11 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+	CLEAR_REGS
+.endm
+
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
-- 
2.31.1

