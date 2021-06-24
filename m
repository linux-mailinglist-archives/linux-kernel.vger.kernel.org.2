Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E53B258F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFXDnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFXDnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:43:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B86C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i6so4041396pfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sf2vC4DdejXn0TlyY78AewZhU0SgkUPuFBMazAbHZK4=;
        b=D8DjGwJUlXIO0TVrSG/ZeVvUPW8wAHpUnKMSvZFVHtop5C+89pYkyv+sH9hOpbRZu/
         WeLrxWQk1TD4sCKNOKHTSyfqskGq5aaadsGnRaaDJz85jHEwhsY8ctxHqy/R1FXCJjVi
         YVLEC05DAfejjr8edszhWUuY6dHt2hgNoOS5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sf2vC4DdejXn0TlyY78AewZhU0SgkUPuFBMazAbHZK4=;
        b=qDWHPIxi0VaOUZMSFgP8gUFewJFHk+g+6wpqP4CDCI2rANlHHMrS4DlBomeVSX7N4M
         76erMziNgVDdsP/lOy4lJTJ8kdWGfrtj1R4hlLQ6iztkbe6tmymOYv8+3+9bdWWHbqxK
         2sra5mD21CW00+gJMSiLPYAShmqUjf/3tFa4CzEhX+8RN/Y/nOaJP+Yz00qL9y89wunz
         JadoJD6Zbmw65omD4RDcg6OnOoL0+P7um1CxAEdSXabE+ozI8S+8TFdA9KVKO8XV7Vug
         fkbRNk26IUJVPUxOJ1805Mtn15HwUj2+dR3RWz4uozhOnXDMF6VUvFZJ3auhhDJFaAxP
         MjJQ==
X-Gm-Message-State: AOAM530akeLUAyZMyuCvNNMz+Fv1hjdjRU3ysd+3yletaTE/IEmawg07
        HqJUTpv4KLFkHwDPmxc0CRanC7U1SkAXPw==
X-Google-Smtp-Source: ABdhPJxwUXidQSW66Cd7hfNHu9m1OdS3iDnW9VrYoHaD9hKo1tsw6JFDwPcDmznjLKOpOobVgqPCDg==
X-Received: by 2002:a05:6a00:138f:b029:304:2af5:1e12 with SMTP id t15-20020a056a00138fb02903042af51e12mr3014900pfg.5.1624506060335;
        Wed, 23 Jun 2021 20:41:00 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id p6sm6789262pjh.24.2021.06.23.20.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:41:00 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v16 1/4] kasan: allow an architecture to disable inline instrumentation
Date:   Thu, 24 Jun 2021 13:40:47 +1000
Message-Id: <20210624034050.511391-2-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624034050.511391-1-dja@axtens.net>
References: <20210624034050.511391-1-dja@axtens.net>
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

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/Kconfig.kasan | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cffc2ebbf185..c3b228828a80 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -12,6 +12,13 @@ config HAVE_ARCH_KASAN_HW_TAGS
 config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
+config ARCH_DISABLE_KASAN_INLINE
+	bool
+	help
+	  An architecture might not support inline instrumentation.
+	  When this option is selected, inline and stack instrumentation are
+	  disabled.
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
@@ -130,6 +137,7 @@ config KASAN_OUTLINE
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	help
 	  Compiler directly inserts code checking shadow memory before
 	  memory accesses. This is faster than outline (in some workloads
@@ -141,6 +149,7 @@ endchoice
 config KASAN_STACK
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	default y if CC_IS_GCC
 	help
 	  The LLVM stack address sanitizer has a know problem that
@@ -154,6 +163,9 @@ config KASAN_STACK
 	  but clang users can still enable it for builds without
 	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
 	  to use and enabled by default.
+	  If the architecture disables inline instrumentation, stack
+	  instrumentation is also disabled as it adds inline-style
+	  instrumentation that is run unconditionally.
 
 config KASAN_SW_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
-- 
2.30.2

