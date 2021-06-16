Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5973A94A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhFPIFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhFPIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:05:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:02:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k5so1252953pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhcxQma+NItwG5Mp37m/KF4tp14MA8dMkKZlGGIww7w=;
        b=hJE2AePhitLJVg38bm97ceVZi5FIj9UG7cAFa6I89qpLoHOqs1eZo/sgHrTjHCz5vc
         Z0OB2QrJBz1ePSDeeTBoNAwwTmCWMao+fbzv6i6nf+j/nn2Z/6pH2J/atzq4c7e26OtD
         9Ge5u0WlHxE6DHdxeFWDpzw27Ij3DBzy52+fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhcxQma+NItwG5Mp37m/KF4tp14MA8dMkKZlGGIww7w=;
        b=WXLN4yurDvcQjmxjHZCkGWqpVYppLKfS7UCJFcIRIauH6Boa+wgnqkD1+wNUWJ+Gwm
         v8jzohmiTVjiggOdOzCuKogADaas99SkowqeT3GuDXVlfyM3l6lOvRI3vIQE7aWRH+qw
         2bGcb1a5pbyJjEzjuhQ18rx26rOBuQT0D15umSGC9lSzL9w19JlarnKKM3Qv0GQSjfUm
         HvIutePPHUTBfUKjmYfdM14dhaRpYpGQdxZVmjZRuOG2LFztFI1dFwh8443kdWdBWFfv
         srtqOL+hl0qdsb296VjKgzLG08t2jnBtipGxp4CIRCw0n5BkESAlolGWwjgoEwUkVbWK
         lpmA==
X-Gm-Message-State: AOAM5300mswye0f9QPw00suFi1n20XSI7cE2sWpb8+b1VOg/1Uc9JUSZ
        noT/Orurg89unvluiJwKnM2SHwZZxWFIMw==
X-Google-Smtp-Source: ABdhPJylA3muk5yAlLrF6ZcVpEMYtRnxGVKqGdGUGSYY+nWAMfaRgU5cUbiR3WYP/UOF26ki7J90ZQ==
X-Received: by 2002:a17:90a:708a:: with SMTP id g10mr9621854pjk.108.1623830573897;
        Wed, 16 Jun 2021 01:02:53 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id v15sm1595449pgf.26.2021.06.16.01.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:02:53 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v13 1/3] kasan: allow an architecture to disable inline instrumentation
Date:   Wed, 16 Jun 2021 18:02:42 +1000
Message-Id: <20210616080244.51236-2-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616080244.51236-1-dja@axtens.net>
References: <20210616080244.51236-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For annoying architectural reasons, it's very difficult to support inline
instrumentation on powerpc64.*

Add a Kconfig flag to allow an arch to disable inline. (It's a bit
annoying to be 'backwards', but I'm not aware of any way to have
an arch force a symbol to be 'n', rather than 'y'.)

We also disable stack instrumentation in this case as it does things that
are functionally equivalent to inline instrumentation, namely adding
code that touches the shadow directly without going through a C helper.

* on ppc64 atm, the shadow lives in virtual memory and isn't accessible in
real mode. However, before we turn on virtual memory, we parse the device
tree to determine which platform and MMU we're running under. That calls
generic DT code, which is instrumented. Inline instrumentation in DT would
unconditionally attempt to touch the shadow region, which we won't have
set up yet, and would crash. We can make outline mode wait for the arch to
be ready, but we can't change what the compiler inserts for inline mode.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/Kconfig.kasan | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cffc2ebbf185..cb5e02d09e11 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -12,6 +12,15 @@ config HAVE_ARCH_KASAN_HW_TAGS
 config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
+config ARCH_DISABLE_KASAN_INLINE
+	bool
+	help
+	  Sometimes an architecture might not be able to support inline
+	  instrumentation but might be able to support outline instrumentation.
+	  This option allows an architecture to prevent inline and stack
+	  instrumentation from being enabled.
+
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
@@ -130,6 +139,7 @@ config KASAN_OUTLINE
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	help
 	  Compiler directly inserts code checking shadow memory before
 	  memory accesses. This is faster than outline (in some workloads
@@ -141,6 +151,7 @@ endchoice
 config KASAN_STACK
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	default y if CC_IS_GCC
 	help
 	  The LLVM stack address sanitizer has a know problem that
@@ -154,6 +165,9 @@ config KASAN_STACK
 	  but clang users can still enable it for builds without
 	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
 	  to use and enabled by default.
+	  If the architecture disables inline instrumentation, this is
+	  also disabled as it adds inline-style instrumentation that
+	  is run unconditionally.
 
 config KASAN_SW_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
-- 
2.30.2

