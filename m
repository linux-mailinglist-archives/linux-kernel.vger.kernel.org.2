Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45501379652
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhEJRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:47:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36475 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhEJRqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:46:45 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AHjGkD2449170
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 10:45:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AHjGkD2449170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620668728;
        bh=bGapOFI3jJjg4DaQVvj//BCsrNlWKEqvqlwR5LuvAto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+uh0y5robEX/TyE7TKGFWF2rjDFbVh5MHlj0KAyr9HUxKoiQFASx02HoTTxudjfr
         1LBans60tXheZeDf/DnZJasEHOo/A3AmWHN36tak9CBfbjRCMzVR4Lg6S8tTnQJ9ax
         nctAWK6uk35U6BdZBv6tIA2hZwQxtcdIEcwXkpkD4A2xkEDcZDM4C2kOtTcOE0qLu0
         LWivE2kwxPMfIARIL5PFdPdf5WgTl7wGIpcmWznSvTBxzD2fCZie/NC+XlgdAEOhR2
         /4yLV6WFYwSNW3/DwAsaZ35pFzbTAYDO/53CoSmOXXZJG/jV5Kv8xesfYBxHqD2fyT
         iIG5TRIv6bemg==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/6] x86/syscall: unconditionally prototype {ia32,x32}_sys_call_table[]
Date:   Mon, 10 May 2021 10:45:06 -0700
Message-Id: <20210510174509.3039991-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510174509.3039991-1-hpa@zytor.com>
References: <20210510174509.3039991-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Even if these APIs are disabled, and the arrays therefore do not
exist, having the prototypes allows us to use IS_ENABLED() rather than

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

