Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB5405F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbhIIWJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:09:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43815 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhIIWJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:09:57 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 189M8Rx2240627
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 Sep 2021 15:08:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 189M8Rx2240627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631225319;
        bh=Yj10jMDgE21CotwexBht+qnc1+Xh+HUHPDT1ZPipEPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvVu4vEWnWsYTT3cwGpzthFC0DVuAe5+LKeMg7QI8WfMVpY4y0/AyzubR3TV29R+b
         LSjfRWTcOQt19FFYCIfl56BxiUeSMtnatJlTXhSC5S9IxEw3/fJaGN6C85WwL/6eV/
         IVAB65IA391BPvb1/zrfCOo54ANqWH/NGL0C5Y9yWE3Sa/krxUEpE2UfqbVQKMbgPk
         9WDpUxzj5JDrriVg82UN8HpQDU92eUQ6uXGVeKY6z7yfGCFTm5L73Ed8CNynXtpHZF
         jjcO4tDSVlCYtkQ8lPXFnroLsj0irSO20W9AlylTkQoMZcmkX3kStRTWBKVeQDbxvW
         KOFo6QIPz/9Kw==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH v2 1/2] x86/asm: add _ASM_RIP() macro for x86-64 (%rip) suffix
Date:   Thu,  9 Sep 2021 15:08:17 -0700
Message-Id: <20210909220818.417312-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909220818.417312-1-hpa@zytor.com>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210909220818.417312-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references using e.g. an "i" constraint
where one doesn't want gcc to possibly use a register indirection as
it may in the case of an "m" constraint.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/asm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ad3da9a7d97..c5a19ccda0fe 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,11 +6,13 @@
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
 # define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
 # define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
 # define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
@@ -49,6 +51,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 
-- 
2.31.1

