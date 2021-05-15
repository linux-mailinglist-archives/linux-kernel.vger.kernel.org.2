Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286873814FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhEOBpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:45:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35017 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234798AbhEOBpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:45:34 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1i7al3212185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:44:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1i7al3212185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621043056;
        bh=Pp3H4wowDSakYjyqaCVoE74o+aiaxAZ5r2kcK+Y7ACE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ1+CJ+o906g8q8XKq+iMMKIiGlfxMfyItoiqXknHkJq5Yi9kbhvKmvw5wIrCkgYB
         3HVB1HlNdbNKWAVtoO025tRw+M7r1On1jbTDi0f890q3egLjpYV8QSrN7BtHj7G/hH
         B0HS73GJnL/hBydtltWBgfyDLymmGGHP/1uUnkP/W9i7yiJHPgJJO3NNgV/1OXrDS/
         wvDrovmuHHgEHfASNCRhE5UShD3n96QVmSglLyidO+E9X202+eKpyyR1OMotrulcMK
         39/IkUe9MxU0UGn2uWIrcfXxTNy2LKH4phj61gcc2uu+1PaJPo3qOhjAXqH+ubkNXh
         yyh9VPL/z++eg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/9] x86/desc: add native_[ig]dt_invalidate() to <asm/desc.h>
Date:   Fri, 14 May 2021 18:43:57 -0700
Message-Id: <20210515014400.2999028-6-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515014400.2999028-1-hpa@zytor.com>
References: <20210515014400.2999028-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

In some places, we want the native forms of descriptor table
invalidation. Rather than open-coding them, add explicitly native
functions to invalidate the GDT and IDT.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/desc.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index b8429ae50b71..aa366b2bbc41 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -224,6 +224,21 @@ static inline void store_idt(struct desc_ptr *dtr)
 	asm volatile("sidt %0":"=m" (*dtr));
 }
 
+static const struct desc_ptr __invalid_gdt_idt_ptr __maybe_unused = {
+	.address = 0,
+	.size = 0
+};
+
+static inline void native_gdt_invalidate(void)
+{
+	native_load_gdt(&__invalid_gdt_idt_ptr);
+}
+
+static inline void native_idt_invalidate(void)
+{
+	native_load_idt(&__invalid_gdt_idt_ptr);
+}
+
 /*
  * The LTR instruction marks the TSS GDT entry as busy. On 64-bit, the GDT is
  * a read-only remapping. To prevent a page fault, the GDT is switched to the
-- 
2.31.1

