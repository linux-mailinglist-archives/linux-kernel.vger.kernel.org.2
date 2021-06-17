Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDCB3AAC92
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFQGmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhFQGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:42:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso5528253pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhcxQma+NItwG5Mp37m/KF4tp14MA8dMkKZlGGIww7w=;
        b=NX/qvxr8dhuE37o1z5sgt2XG3iamjEnXiWs3Cjuob6iS4N7i54VKlfizgYe8xGGkPG
         ECD5YCGaTs51KaCl4epayh0dHJ+o8LndpifLgVU7jrsZXsK+fxf956QA+f9kaEQexM97
         ESKPsh4uIbJJ1pXHDwjoTPF3Wsz2Knn+hfVYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhcxQma+NItwG5Mp37m/KF4tp14MA8dMkKZlGGIww7w=;
        b=KW5NXjn0tuqBhL2U2yGkc10yWZIC2G/+06ikQCCvZmzGWd4qTzPlICe2m2mdu3hnPh
         VYKkNf/1DtTH7/znysUG7R9OSxnHBINQI9ap3KcIUd5yE2YyiE0I5dW24VhvTshOyQgd
         lHh4+X/KN4FAG8jOX/dUKcXjBM2W18RT+4sXeDKxgmCbrWZdPF0ydQUXo+zNARopaxVc
         BHWm/NNZykZ4fjamYRnHL7OIrbaZxsy2VeD+x16owubni1u+LKmawwVtlwenOyjB5mWH
         S6FenoJHug+Ar+i5s3Sts82/GsmZ59qOuqeFCgAzPxQUVHHproNXYpw6gHre7p+Mg5fH
         Z3wQ==
X-Gm-Message-State: AOAM532Xr/IHTkPSIIkb7CASd5wRTNwqHynfYPKizvZHA2tbjpP7WArl
        3kJa1D6BbcI9PXuIDASD/4d27MzrMVWkSQ==
X-Google-Smtp-Source: ABdhPJzfeN5byN4YxzyNu/GjCulyBlU25iQrctXCoCFZvJ5L0B+A23QQj4gHY87HwYK24nhSnOkqEg==
X-Received: by 2002:a17:90b:38ca:: with SMTP id nn10mr4147573pjb.127.1623912008754;
        Wed, 16 Jun 2021 23:40:08 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id d12sm3987316pfo.113.2021.06.16.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 23:40:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v14 1/4] kasan: allow an architecture to disable inline instrumentation
Date:   Thu, 17 Jun 2021 16:39:53 +1000
Message-Id: <20210617063956.94061-2-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617063956.94061-1-dja@axtens.net>
References: <20210617063956.94061-1-dja@axtens.net>
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

