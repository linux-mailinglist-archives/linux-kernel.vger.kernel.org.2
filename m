Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF830AE60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhBARtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhBARsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612201633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=yk00FlwWFm90o409vB6K5EHrhKgUKKVXLLYEECsPgp8=;
        b=fKKWi25KV38WQGOSasT1E+sO6kPT5snlOEbtbhBFF/Oh7OOD8tndU3DkdsauXV8yIFwtvM
        cCtE5sWc5AcsXQfrh+M6Y9ecNJkMNdU6Yqoh5HSduEDKK6d8QENx/tLTkdCXnN44xPJerp
        AM75CeFysE5yvUoIkci8Z49DlhPktXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-7QJfHJ25NfeR8DE7yi8iMQ-1; Mon, 01 Feb 2021 12:47:11 -0500
X-MC-Unique: 7QJfHJ25NfeR8DE7yi8iMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B4E804011;
        Mon,  1 Feb 2021 17:47:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91C355D9DC;
        Mon,  1 Feb 2021 17:46:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  1 Feb 2021 18:47:08 +0100 (CET)
Date:   Mon, 1 Feb 2021 18:46:49 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v4 2/4] x86: mv TS_COMPAT from asm/processor.h to
Message-ID: <20210201174649.GA17880@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201174555.GA17819@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TS_COMPAT back to asm/thread_info.h, close to TS_I386_REGS_POKED.

It was moved to asm/processor.h by b9d989c7218a ("x86/asm: Move the
thread_info::status field to thread_struct"), then later 37a8f7c38339
("x86/asm: Move 'status' from thread_struct to thread_info") moved the
'status' field back but TS_COMPAT was forgotten.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/processor.h   | 9 ---------
 arch/x86/include/asm/thread_info.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b5534b..c66df6368909 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -552,15 +552,6 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	*size = fpu_kernel_xstate_size;
 }
 
-/*
- * Thread-synchronous status.
- *
- * This is different from the flags in that nobody else
- * ever touches our thread-synchronous status, so we don't
- * have to worry about atomic accesses.
- */
-#define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
-
 static inline void
 native_load_sp0(unsigned long sp0)
 {
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0d751d5da702..c2dc29e215ea 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -205,6 +205,15 @@ static inline int arch_within_stack_frames(const void * const stack,
 
 #endif
 
+/*
+ * Thread-synchronous status.
+ *
+ * This is different from the flags in that nobody else
+ * ever touches our thread-synchronous status, so we don't
+ * have to worry about atomic accesses.
+ */
+#define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
+
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED	0x0004	/* regs poked by 32-bit ptracer */
 #endif
-- 
2.25.1.362.g51ebf55

