Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5A41B57B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhI1R63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbhI1R62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:58:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E43C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:56:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13b2007486680f97542e69.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:7486:680f:9754:2e69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 619B21EC0754;
        Tue, 28 Sep 2021 19:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632851806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JMNtVFM1EHS/txM8jM+h25VQUgsyuR4/LB9uwpoXsrQ=;
        b=Osqrx06Ws9vZlEK8Hz5uMdRhGxYjqYK350UBHPeD9rRx2SrXf8svEdCSAMtLP7y46juqiM
        NjbcD+10SzPHBvIWPbx25QgoIMexQRg9G73MhU0BIxpG+1s3zj8y+/fuQlOMQPEBmdQ8ZR
        VievoaubnyikszaLTDtqUwrxdWuhi9w=
Date:   Tue, 28 Sep 2021 19:56:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
Message-ID: <YVNXWJEeGOqxXIjf@zn.tnic>
References: <163265189226.178609.9712455554034472888.tglx@xen13>
 <163265189517.178609.6605494600326137493.tglx@xen13>
 <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
 <YVC4zz1vCskBMb6I@zn.tnic>
 <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 12:10:50PM -0700, Linus Torvalds wrote:
> So every architecture uses that <asm-generic/unaligned.h> and is happy
> about it.

Ok, how does that look?

It looks pretty straight-forward to me but WTH do I know?!

Anyway, it builds and boots fine in a guest here so it must be perfect.

---
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index c565def611e2..d49ea843b915 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -13,34 +13,22 @@
 #endif
 #include <asm/inat.h> /*__ignore_sync_check__ */
 #include <asm/insn.h> /* __ignore_sync_check__ */
+#include <asm/unaligned.h> /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 
 #include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
 
-#define leXX_to_cpu(t, r)						\
-({									\
-	__typeof__(t) v;						\
-	switch (sizeof(t)) {						\
-	case 4: v = le32_to_cpu(r); break;				\
-	case 2: v = le16_to_cpu(r); break;				\
-	case 1:	v = r; break;						\
-	default:							\
-		BUILD_BUG(); break;					\
-	}								\
-	v;								\
-})
-
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r = get_unaligned((t *)(insn)->next_byte); (insn)->next_byte += sizeof(t); r; })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
+	({ get_unaligned((t *)(insn)->next_byte + n); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 797699462cd8..be59e17e75dc 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,34 +13,22 @@
 #endif
 #include "../include/asm/inat.h" /* __ignore_sync_check__ */
 #include "../include/asm/insn.h" /* __ignore_sync_check__ */
+#include "../include/asm-generic/unaligned.h" /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 
 #include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
 
-#define leXX_to_cpu(t, r)						\
-({									\
-	__typeof__(t) v;						\
-	switch (sizeof(t)) {						\
-	case 4: v = le32_to_cpu(r); break;				\
-	case 2: v = le16_to_cpu(r); break;				\
-	case 1:	v = r; break;						\
-	default:							\
-		BUILD_BUG(); break;					\
-	}								\
-	v;								\
-})
-
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r = get_unaligned((t *)(insn)->next_byte); (insn)->next_byte += sizeof(t); r; })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
+	({ get_unaligned((t *)(insn)->next_byte + n); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
new file mode 100644
index 000000000000..47387c607035
--- /dev/null
+++ b/tools/include/asm-generic/unaligned.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copied from the kernel sources to tools/perf/:
+ */
+
+#ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
+#define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
+#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
+
+#endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
+
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
