Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE67389886
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhESVXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:23:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33339 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhESVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:42 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1Ed4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1Ed4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459332;
        bh=XOgTt/mBuEZ+uV89tStLvmmy0bfAE5L/fc5xFERnK2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aH5XZztXrMcSwVNOk3EPWIICT3MlLis4no0kQVBd0JWPHKJGhOflW5Mj394jaAmcZ
         dz+3L4BoV6eexJNf7Z1XKME0WBnv0ZAbMpJR871Do3YNXHybbsx0533/q29EGVTntB
         3eMboN16wk9MCXwu21SavlC6tNPjiGwRWknf9DzEKP44+pXrEYcYN2t89GxSDEUSgx
         Sy/Ybw3rLAnWjGIiRl4vGbPeJehXKIye0uyFp/C0pt1G+ouDmm/NKwtNWz6lTtgtot
         Y774RJgKeDmx7pq+k8OR/b6XNuyF01+zTNLDANnVOwgfxHANoQzJV3YlMDqoaWzllg
         Fh/iLSYNZb0YA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/8] x86/desc: add native_[ig]dt_invalidate() to <asm/desc.h>
Date:   Wed, 19 May 2021 14:21:51 -0700
Message-Id: <20210519212154.511983-6-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519212154.511983-1-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com>
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
 arch/x86/include/asm/desc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index b8429ae50b71..400c17862870 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -224,6 +224,26 @@ static inline void store_idt(struct desc_ptr *dtr)
 	asm volatile("sidt %0":"=m" (*dtr));
 }
 
+static inline void native_gdt_invalidate(void)
+{
+	const struct desc_ptr invalid_gdt = {
+		.address = 0,
+		.size = 0
+	};
+
+	native_load_gdt(&invalid_gdt);
+}
+
+static inline void native_idt_invalidate(void)
+{
+	const struct desc_ptr invalid_idt = {
+		.address = 0,
+		.size = 0
+	};
+
+	native_load_idt(&invalid_idt);
+}
+
 /*
  * The LTR instruction marks the TSS GDT entry as busy. On 64-bit, the GDT is
  * a read-only remapping. To prevent a page fault, the GDT is switched to the
-- 
2.31.1

