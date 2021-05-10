Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3F379739
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhEJSzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:55:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51483 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232997AbhEJSyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:47 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNlf2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNlf2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672812;
        bh=P8t3wf3nLfOPpY+3vG59p58r3EB3Eqvf9YkTqO0Ycag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIoNi8W2+tSLPvpKu+g0wwTHQNxo0hIRnTo5Twnkz9wUtGLDdV8k9Gn9qIyliPkNq
         jYQA4rCzmPIm7MXAWeoLVquGH6nol311GL3Qwsybk86IVTU4koC7XHBKtCYcuxWM6V
         xedCKI5UfqRniS1nzSEQ+anr9h3Iu3llJma6LYRODBv4FHrrNpLpDvhS5PDRbLjthL
         Y4DM/pncheBNejpQq/TZnvC6xwTY9EzGBlANrdAdZ1g+UxBjHiaUtPCtetdGyeGTJq
         hUcP6MReWhhb+oKAh8VZVHr661F+DhgKbjVNcB53ZAHDB+OuREW5cQSJzLpyICf/eA
         7OIXYByLZKAyw==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 3/7] x86/syscall: unconditionally prototype {ia32,x32}_sys_call_table[]
Date:   Mon, 10 May 2021 11:53:12 -0700
Message-Id: <20210510185316.3307264-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510185316.3307264-1-hpa@zytor.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Even if these APIs are disabled, and the arrays therefore do not
exist, having the prototypes allows us to use IS_ENABLED() rather than
using #ifdefs.

If something ends up trying to actually *use* these arrays a linker
error will ensue.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/syscall.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 4e20054d7533..f6593cafdbd9 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -21,13 +21,12 @@ extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
 #define ia32_sys_call_table sys_call_table
-#endif
-
-#if defined(CONFIG_IA32_EMULATION)
+#else
+/*
+ * These may not exist, but still put the prototypes in so we
+ * can use IS_ENABLED().
+ */
 extern const sys_call_ptr_t ia32_sys_call_table[];
-#endif
-
-#ifdef CONFIG_X86_X32_ABI
 extern const sys_call_ptr_t x32_sys_call_table[];
 #endif
 
-- 
2.31.1

