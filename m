Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7059E333131
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhCIVnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhCIVnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:43:11 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF267C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:43:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id l7so10381552pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8B+TI2ljrjIAGoG2RdRj4gE9w9WbKxchx8DXaJn5Ui8=;
        b=B+YVHQykoUKo/84JBRqf2taJxNkvoR3h/xHiwuWVZPWtvPUuIKHLZrmpSpgh/Kjsr+
         ZLGPtMIVy5G9SB0bStvEOZ5wssR0qJGsKIUTWMCiMDchjrHdU4QYbm/+AP7atg6dqz8I
         SNULNTYBNdoInlpqHUsBUJuHT5/aZTEFeNGzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8B+TI2ljrjIAGoG2RdRj4gE9w9WbKxchx8DXaJn5Ui8=;
        b=kA80kkbKbs4p+n2d4TRr6Oz7ctPgxfD6G2A3872Olhe768sXiCV3IvcrDN5PxAwrDj
         5DXCziA8q9mJBNeicJ08mn6rfShdUBj/hwnwX/Ja3OlU7IIYqAbz0vViUJJ/4zl1Eix+
         Zf4mSUxp/egc3BuMjDgrM3sxopAe0K0Aoar8Z2jYYq6JZNWql2cZeKSK0iImtrZ13MsP
         d7lwO5b2ZvzOC+8gPPO4KMehTOtk29e1AlbnW8jQQFMAo0F53OPXAiPjqFVIqcfOX6Sm
         x3A1qYi62TyaJvAScbjvMR/flIhhtQ3BwNGtteGW90AvRUyjAOZR3N2SPjw54xEpigIS
         1xKw==
X-Gm-Message-State: AOAM5302YE78Z+bQ4oW55dmVmGyTNbGkCYfAS1/ealHCcHPJSGNz+Ku5
        bhZpHo6uGRG1h2JvwiFONHJMHQ==
X-Google-Smtp-Source: ABdhPJwDEZt4HsJYCPAO/hKVfuBRLIAx9UGXKG+K9UyVuDvSK9N5uemw3WHAwwMJqmSvMAkwDOlEtg==
X-Received: by 2002:a63:db57:: with SMTP id x23mr10704884pgi.432.1615326191286;
        Tue, 09 Mar 2021 13:43:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id il6sm3550028pjb.56.2021.03.09.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:43:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 2/7] jump_label: Provide CONFIG-driven build state defaults
Date:   Tue,  9 Mar 2021 13:42:56 -0800
Message-Id: <20210309214301.678739-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309214301.678739-1-keescook@chromium.org>
References: <20210309214301.678739-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=73472045d5d9db41a0abdff057f03f8d5fac6646; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=jNlGnJHaf6m7Hp53arzPhV1aLM4PJz/v+5ZYK3JqA/s=; p=ugkbC9pkmjvHuu7AHPV/hFDaWx06QijpAk87L8pMr40=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBH6+MACgkQiXL039xtwCa2UxAAgjF MUwiQyPV2kKbnkLNuK+WcErNu8CNPTgLa8SZoTRxE2MkJJ8aHZt0cV/ufuXUmiYRuF34Dz8SL7+dE cRM5gf1jBFvD1eGwjIeMhgnDK6h4D2KWWbqf+fiSP0GyiBrgZ9xiiwGNui20FAjEIdEyHnu78hpIh 40hVgGFfRw8rrhX8hVMJGuhGefIFo6p56PRMUYJrypXEkVtn4rX4JCXSk0AzyCodpD0BkKKZFqpml mVIhMOwLE/AGMavf3mSWnEGu1V/rolBLokPg+fnGjEEtCYqdf+4poo1BQ5bDsxRFG4S8heHYN/OrW GQZdygkyKFwdPkuWH/pYql3gPWrH4iaUX/Za+JTNJUyS14yJTVIME8gaBJyt3Cp0qNRtOlq7PIvG6 iEv7fYs1XeM2C8fC9lZCHZDTpG3AExLifbA7M2CKPylraihXTJqkkATUePskVY9rMGktiuGECsHFQ zkRurZDp4GoyT/J+FzpXTAGHjMIll+hL/VE9awpXfqYsVgpfhB2lI5aO+1HpcKI5cCirFxc5nTZXb gqXwcS3HmcUDm4pSYqyJLmhIrR4+qP5TSYuZjMTUKP8V7kXlHXmBTrXU9+d5RptapTsAxFn4fwXj9 YmvarOr6C3Bykxp7PL4bm7pvHpPGYy1zZ5VDOstYKSa2ZJXl63cwLTiv2PBiDlfI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Choosing the initial state of static branches changes the assembly
layout (if the condition is expected to be likely, inline, or unlikely,
out of line via a jump). A few places in the kernel use (or could be
using) a CONFIG to choose the default state, so provide the
infrastructure to do this and convert the existing cases (init_on_alloc
and init_on_free) to the new macros.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20200324220641.GT2452@worktop.programming.kicks-ass.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/jump_label.h | 19 +++++++++++++++++++
 include/linux/mm.h         | 12 ++----------
 mm/page_alloc.c            | 12 ++----------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d92691262f51..05f5554d860f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b3317d91ee8e..bf341a9bfe46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2871,11 +2871,7 @@ static inline void kernel_poison_pages(struct page *page, int numpages) { }
 static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 #endif
 
-#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-DECLARE_STATIC_KEY_TRUE(init_on_alloc);
-#else
-DECLARE_STATIC_KEY_FALSE(init_on_alloc);
-#endif
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
 	if (static_branch_unlikely(&init_on_alloc))
@@ -2883,11 +2879,7 @@ static inline bool want_init_on_alloc(gfp_t flags)
 	return flags & __GFP_ZERO;
 }
 
-#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
-DECLARE_STATIC_KEY_TRUE(init_on_free);
-#else
-DECLARE_STATIC_KEY_FALSE(init_on_free);
-#endif
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
 	return static_branch_unlikely(&init_on_free);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f2d474a844cf..267c04b8911d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,18 +167,10 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
-#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-DEFINE_STATIC_KEY_TRUE(init_on_alloc);
-#else
-DEFINE_STATIC_KEY_FALSE(init_on_alloc);
-#endif
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
 
-#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
-DEFINE_STATIC_KEY_TRUE(init_on_free);
-#else
-DEFINE_STATIC_KEY_FALSE(init_on_free);
-#endif
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
 static bool _init_on_alloc_enabled_early __read_mostly
-- 
2.25.1

