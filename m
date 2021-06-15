Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4853A744A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFOCs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFOCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:48:55 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69558C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:46:51 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p14so959373ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HOnQVo+SWV1H037ZQ/Ye/PGWwO/+/ZmfPhIlu9wOFzQ=;
        b=Pn6LBDzCFlVrC5tuz8fdMSLA0HjWfz1US+FJjBB7jTX/aufzoPNc6EjedXxxY3BLMm
         f1gHqD2r7QzoTO/8zt6a6IKMk0pOk/rHbExmfnwH8S/kFT/dQavV3mAeyh6n3hZDwmMZ
         IWjGf9JK/AoOfUpQ6+dnwlZ5SN8MwCTEraPZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOnQVo+SWV1H037ZQ/Ye/PGWwO/+/ZmfPhIlu9wOFzQ=;
        b=ce/EyA0wfci4guEYouov8ix/JvSO/jpylBjx3HXNhniKTMkj3wC1AdcohHtkV6wpmV
         PPPuMcJhbmxIzjQlqkeE0Cc7kOOjuRVaiK5j2xSwbEEvZc5Mdz5cZdqbmYBGrCr81qU9
         KTYdFv4xJKk70TvypnYttPxbVx/KYCM0dgf76W1RmGyQmQSHdCwv7T6whYwigSbcYKx2
         yFEufTyPSNrqOrXhjvsACF/YXZpLVF2X3kmuANq0ArtP5ZIExMtGTOjLA0lkfJCdWWed
         XmfHCZYqpKynQ+dog8D5LiBzIUDKM+EvoRJglep5fMOPpecC3tYBwnGdP/rA0QSCytXv
         AGqw==
X-Gm-Message-State: AOAM533zTXQ70nRyh7M7g5cUxjc7amkwJw5xVW3vAOpPZLwo2CXW1H2L
        UJLfTpt7mCAin2rbbPJ7OC4VdPtwJRHEpg==
X-Google-Smtp-Source: ABdhPJwqctJ4sje6V13eMdiiU5VjjfvVBqRlbjJUu+6/rSMEDip5D7XD4vGAToI0HE9b5nehhcU7rQ==
X-Received: by 2002:a65:66cf:: with SMTP id c15mr14734452pgw.121.1623721635179;
        Mon, 14 Jun 2021 18:47:15 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id gk21sm13168157pjb.22.2021.06.14.18.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:47:14 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     elver@google.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v12 1/6] kasan: allow an architecture to disable inline instrumentation
Date:   Tue, 15 Jun 2021 11:47:00 +1000
Message-Id: <20210615014705.2234866-2-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210615014705.2234866-1-dja@axtens.net>
References: <20210615014705.2234866-1-dja@axtens.net>
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
 lib/Kconfig.kasan | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index cffc2ebbf185..935814f332a7 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -12,6 +12,15 @@ config HAVE_ARCH_KASAN_HW_TAGS
 config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
+# Sometimes an architecture might not be able to support inline instrumentation
+# but might be able to support outline instrumentation. This option allows an 
+# arch to prevent inline and stack instrumentation from being enabled.
+# ppc64 turns on virtual memory late in boot, after calling into generic code
+# like the device-tree parser, so it uses this in conjuntion with a hook in
+# outline mode to avoid invalid access early in boot.
+config ARCH_DISABLE_KASAN_INLINE
+	bool
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
2.27.0

