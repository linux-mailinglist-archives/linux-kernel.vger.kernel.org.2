Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76C341FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhCSOlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCSOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:41:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3248C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j25so6040215pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydwegfj06jUtcG1bKMw1Rb3csKPSe8+eJN43gEYqDtE=;
        b=CWsyw4mBVYYeByo2NmAV258BnfafVcVIoZvhJvhi6CNHCf+F9cnaxudDwiLQtI/tdx
         7QZM8TZBam/tGkDvyQEtIFfXOt24Z5+pMalET8WYuKJ5MIN7UC9Ehz9bJTHW5/v8sRoY
         xHUySAj/MPui5Z8chx1OrAVZIrdBn1g5vsACk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydwegfj06jUtcG1bKMw1Rb3csKPSe8+eJN43gEYqDtE=;
        b=UipL1ynXdNT9Big9/mQKRBT2Y60TOpBF6q+v892nyfdNBasTmSKAF9JMrw6d1zm6K9
         veiUaC9zrspgVIhrRxlyQvlgW43BfD5fAYOAw0tmr7LN1IN3b+bJN8zNZShMkqd+8+4L
         D8EuGCG/3pVTH8esnbWiErGOuFL4HovZK3FklM4z/EvDoK0D5KBznJP+2w9E2C361NTB
         1Z22y9EB8KBlSHKdLTQxjVJwl5MyWk4ofmewFUAOrtUncEa1sL6RPpcrBBFuktDE5uuk
         S805nKR/TqEu88n+dTNmnBQYUQD8Ua5vIDKYYud4kPUD+Yt0CN5xj9Lt6dC4owaxRhUT
         dEfw==
X-Gm-Message-State: AOAM533NqwiIeslCBBnfsFU6glpGZ0mkGSOfqd8BwmYj6oJxTuQFmvlF
        jHioiio/xj1MKyNDBRWDzbH5z0H6+y8kew==
X-Google-Smtp-Source: ABdhPJx8jC6sFzPVzCCBeAE55Npits4PhLlsXPXK2kY5DhbeqW460kQQ2vJrsrniRqiY86+J6PWQiw==
X-Received: by 2002:a63:181c:: with SMTP id y28mr11211891pgl.175.1616164868280;
        Fri, 19 Mar 2021 07:41:08 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-674e-5c6f-efc9-136d.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:674e:5c6f:efc9:136d])
        by smtp.gmail.com with ESMTPSA id v13sm5242767pfu.54.2021.03.19.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:41:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v11 1/6] kasan: allow an architecture to disable inline instrumentation
Date:   Sat, 20 Mar 2021 01:40:53 +1100
Message-Id: <20210319144058.772525-2-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For annoying architectural reasons, it's very difficult to support inline
instrumentation on powerpc64.

Add a Kconfig flag to allow an arch to disable inline. (It's a bit
annoying to be 'backwards', but I'm not aware of any way to have
an arch force a symbol to be 'n', rather than 'y'.)

We also disable stack instrumentation in this case as it does things that
are functionally equivalent to inline instrumentation, namely adding
code that touches the shadow directly without going through a C helper.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/Kconfig.kasan | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cffc2ebbf185..7e237dbb6df3 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -12,6 +12,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
 config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
+config ARCH_DISABLE_KASAN_INLINE
+	def_bool n
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
@@ -130,6 +133,7 @@ config KASAN_OUTLINE
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	help
 	  Compiler directly inserts code checking shadow memory before
 	  memory accesses. This is faster than outline (in some workloads
@@ -142,6 +146,7 @@ config KASAN_STACK
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	default y if CC_IS_GCC
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
@@ -154,6 +159,9 @@ config KASAN_STACK
 	  but clang users can still enable it for builds without
 	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
 	  to use and enabled by default.
+	  If the architecture disables inline instrumentation, this is
+	  also disabled as it adds inline-style instrumentation that
+	  is run unconditionally.
 
 config KASAN_SW_TAGS_IDENTIFY
 	bool "Enable memory corruption identification"
-- 
2.27.0

