Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00AF377F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhEJJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:11:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46629 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhEJJLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:11:18 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14A99o012376794
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 02:09:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14A99o012376794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620637798;
        bh=beAV5QqQw13z3a3V26gN29HzDt0nTtbor9cCz+NydLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccV+pi95eQqunA8OBL4+i5UejQQ29IbB30wgAS5tXKhPbVSxF9TnoHxvLEJM1uWt4
         tOfqJZViR8DMhRYMALZrkbFo68TZW79yK1m7BMgOhasO7Q25gWDp/oB3Hh1vzNgjfv
         wQg48AOEv05bUsJF511HQVfFbCrao/0zI4vEXi7uiaHWhxunLv9+U2zK9vw2Xnl95x
         zufpLU+tTaaJxiQ1CL4clOd6TqiyC8PcfhMhbJkAfLWpzH7bcSxFibdvv4cDr34x82
         AtIPKi7TErBkQNO5HI2Jcz/3uw/i2h+ozAScSQaPjU9R7EKAR9PvfHuszuFo0CKJ4R
         ftwgCJ0VTdOug==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] x86/asm: have the __ASM_FORM macros handle commas in arguments
Date:   Mon, 10 May 2021 02:09:38 -0700
Message-Id: <20210510090940.924953-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510090940.924953-1-hpa@zytor.com>
References: <20210510090940.924953-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The __ASM_FORM macros are really useful, but in order to be able to
use them to define instructions via .byte directives breaks because of
the necessary commas. Change the macros to handle commas correctly.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/asm.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0603c7423aca..c80899ac0192 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -3,25 +3,24 @@
 #define _ASM_X86_ASM_H
 
 #ifdef __ASSEMBLY__
-# define __ASM_FORM(x)	x
-# define __ASM_FORM_RAW(x)     x
-# define __ASM_FORM_COMMA(x) x,
+# define __ASM_FORM(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
 #else
 #include <linux/stringify.h>
-
-# define __ASM_FORM(x)	" " __stringify(x) " "
-# define __ASM_FORM_RAW(x)     __stringify(x)
-# define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
+# define __ASM_FORM_RAW(x, ...)  	__stringify(x,##__VA_ARGS__)
+# define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
 #endif
 
 #ifndef __x86_64__
 /* 32 bit */
-# define __ASM_SEL(a,b) __ASM_FORM(a)
-# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
+# define __ASM_SEL(a,b)		__ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(a)
 #else
 /* 64 bit */
-# define __ASM_SEL(a,b) __ASM_FORM(b)
-# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
+# define __ASM_SEL(a,b)		__ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(b)
 #endif
 
 #define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
-- 
2.31.1

