Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55E742312C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhJEUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhJEUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:00:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76774C061749;
        Tue,  5 Oct 2021 12:59:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d20002fd498dc90ccb948.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2000:2fd4:98dc:90cc:b948])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06F001EC01CE;
        Tue,  5 Oct 2021 21:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633463946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qmxm7CefUtXt2Yw0nJkZhWFc7mEAr8RAL5qiQWAIgjQ=;
        b=aSGhz2XdrluOcHf5GknU/TWBcN0flEOQjeJ+D5kPaeDbADVwbC6pk4PyY+J0GZzENG3k0s
        VUsIEAaUAt5w+BYv27Ok+k01yDeAPUyxodBV6W2V2iCq0uh6vvHPe0onGuKhk3NqihuJ+k
        mijk1z8p0enA8ynnnDH9I2eoKZMMZSw=
Date:   Tue, 5 Oct 2021 21:59:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] x86: ia32.h: adjust comment for endif of
 CONFIG_IA32_EMULATION
Message-ID: <YVyuihupLwW3o0XR@zn.tnic>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
 <20210803113531.30720-10-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803113531.30720-10-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:35:31PM +0200, Lukas Bulwahn wrote:
> The content of the ia32 header is guarded by
> "ifdef CONFIG_IA32_EMULATION". The comment on the corresponding endif
> refers slightly mismatching to CONFIG_IA32_SUPPORT instead.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns:
> 
> IA32_SUPPORT
> Referencing files: arch/x86/include/asm/ia32.h
> 
> Adjust the comment on endif to the actual ifdef condition.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/x86/include/asm/ia32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged the last 4 into a single patch because they're trivial:

---
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 5 Oct 2021 21:48:30 +0200
Subject: [PATCH] x86: Fix misspelled Kconfig symbols

Fix misspelled Kconfig symbols as detected by
scripts/checkkconfigsymbols.py.

 [ bp: Combine into a single patch. ]

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210803113531.30720-7-lukas.bulwahn@gmail.com
---
 arch/x86/include/asm/ia32.h      | 2 +-
 arch/x86/include/asm/irq_stack.h | 2 +-
 arch/x86/include/asm/page_32.h   | 2 +-
 arch/x86/include/asm/uaccess.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 2c5f7861d373..fada857f0a1e 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -68,6 +68,6 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 #endif
 
-#endif /* !CONFIG_IA32_SUPPORT */
+#endif /* CONFIG_IA32_EMULATION */
 
 #endif /* _ASM_X86_IA32_H */
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c60808..8912492a78f1 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -58,7 +58,7 @@
  *     the output constraints to make the compiler aware that R11 cannot be
  *     reused after the asm() statement.
  *
- *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
+ *     For builds with CONFIG_UNWINDER_FRAME_POINTER, ASM_CALL_CONSTRAINT is
  *     required as well as this prevents certain creative GCC variants from
  *     misplacing the ASM code.
  *
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 94dbd51df58f..b13f8488ac85 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -43,7 +43,7 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* CONFIG_X86_3DNOW */
+#endif	/* CONFIG_X86_USE_3DNOW */
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be3df82..e7fc2c515e08 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -411,7 +411,7 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       [efault] "i" (-EFAULT), "0" (err))
 
-#endif // CONFIG_CC_ASM_GOTO_OUTPUT
+#endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
