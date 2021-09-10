Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3940723A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhIJUBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:01:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45387 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232347AbhIJUAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:00:49 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18AJxIMg517265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 12:59:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18AJxIMg517265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631303968;
        bh=74rbdo5FDm4GT5p8GTPN1ulsTmu28cxhyReiv3yjfOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nU6YGVkdpBVY6dm+6K9b+Le3P+bnFB078fJb5gcZJZwrNIC6bHdyivIs+5738uEsU
         kjS2wC2lndTv5NkJpfVdiI+abbPM0H5Dw7G+Axv2N8ZuWZ5svZ9HiEDGLnXTyLAs4n
         V1gdPCCiTA80W9myIDvAmHYYCpj4hpjuZ1raJlMoupEr3lTushALmTOtQrnt59SB5L
         y1YHLk2ZpXrehlOvd2OFHeU7Ts9q7eW7znds/8J5OwQWXNpZSL5KMv89vStLFRUKJ1
         dnY3ww1r+95CPvg+/zkjvhHDwsDOShq8+blfaWOQVyC6CAtpxfe0AjVn15JR62XwZL
         pLfZh64BKhvHA==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86 mailing list <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH v3 1/2] x86/asm: add _ASM_RIP() macro for x86-64 (%rip) suffix
Date:   Fri, 10 Sep 2021 12:59:09 -0700
Message-Id: <20210910195910.2542662-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910195910.2542662-1-hpa@zytor.com>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210910195910.2542662-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references where one doesn't want gcc
to possibly use a register indirection as it may in the case of an "m"
constraint.

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

