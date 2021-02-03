Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686F530D965
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhBCMAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhBCMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:00:39 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CCC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:59:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s23so15938178pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaxU8G6b68GEdEbXS6bZDEyMoHhbuYhFSTBo6L7+8wc=;
        b=VmzeA/6jTeJHl92Ui+bW8jMnWfBJzOz2tWH7ZG/ltLwUUaY3jql12q4I/LUKW84XrX
         SPm285KUxoURFjo+ZFPZtM2ObLr6nzqErBg4pInHV8eJKHAdqJtRup8+irCG03feIu97
         pmByKUqzPo0Z1/NZpO9hGbdKuv156j4xyd0Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaxU8G6b68GEdEbXS6bZDEyMoHhbuYhFSTBo6L7+8wc=;
        b=ggEiB+moORwV9s4EaMy/VCbVjJrwEbgwg6W7ZXaofiTxyOZfizik9BRdLtxIUBmWLF
         757ahj62Peunca3Q6tnnpwUTqHV0xQFt5jY9wg9cEGrNWRNkqBEj2JGB5Oj3QGdEYGXS
         fnwaliZOOGDnlOtBC91NeoWtcI/2G/47mggZ+HVNEgaVPqay04GCSXo2unb3v4nN2rrn
         W7cmrRV1iosbXqPCJn2WEtRVJoRVP0wbqQvOoKkPCgkxQQ31fIjJxuRHrJj+Pi+7/s28
         RI+309usLeVlnfq47j8iUN1wuJ6aTYKSrpbEEJuB9wqYUMIWSIdauRsPCwHho6F/Ivi4
         iGhQ==
X-Gm-Message-State: AOAM532jCegrGUA5bDwUGpW6vlsjo666W/LABk3x6dTweyk+4qsTrnnI
        SonhkKNMmSFO9CNHT3VhYNN0LAkiTpFjOQ==
X-Google-Smtp-Source: ABdhPJzJQ+HrkRqBl3GdIZ8HA1RDMTKlHsN8nxwZJJ2++D58biICNAHrnytqbZjJk0+WJgDowTrAZQ==
X-Received: by 2002:a62:a204:0:b029:1c3:fb27:16f3 with SMTP id m4-20020a62a2040000b02901c3fb2716f3mr2777075pff.61.1612353599093;
        Wed, 03 Feb 2021 03:59:59 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id p2sm2491813pgl.19.2021.02.03.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 03:59:58 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 1/6] kasan: allow an architecture to disable inline instrumentation
Date:   Wed,  3 Feb 2021 22:59:41 +1100
Message-Id: <20210203115946.663273-2-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203115946.663273-1-dja@axtens.net>
References: <20210203115946.663273-1-dja@axtens.net>
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
index cffc2ebbf185..4f4d3fb8733d 100644
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
@@ -141,6 +145,7 @@ endchoice
 config KASAN_STACK
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on !ARCH_DISABLE_KASAN_INLINE
 	default y if CC_IS_GCC
 	help
 	  The LLVM stack address sanitizer has a know problem that
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

