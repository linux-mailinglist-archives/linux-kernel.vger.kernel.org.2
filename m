Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3136740B7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhINTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhINTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:16:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4FC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:14:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso3066543pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNioXU0MaGQyZ5RIrwYsgFEeu2lEK50VeMha94pJwX4=;
        b=UAKO/UOiaU1PdKht7PRKzibqGkYgD0KbO9jsMrGya4DN6yCpz985EUHJRH/aJ+dFZy
         d4pHkAx+nm9Af7tvOJUvrb2hol2EvPP0ao7cK4fubZPZl7iI5qat4PKpZsncuY/DjHui
         lzghFTXEB3lwcoMeZVKL4MtiVxOEsCWZZu4Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNioXU0MaGQyZ5RIrwYsgFEeu2lEK50VeMha94pJwX4=;
        b=FbA47Bwmo7wZnwl6dOMNHbL+2uZVGHi2QmA0L3dwK/2LOm8AhrB7pWo9oFLRQZY2cU
         RCsg/GVixChJcUBgNMr0ETqqlC+qOeWUhVecdJRB7GmhYjIrp/KfKjojLFf9YzKJSPbS
         yMZqHfX7siNThlaIlIC2bbyu8Q8l5fL67jrBGr7fqQSF7smf1E0ZReO1OhZB5NaYOvoH
         YjHgm9+4kNv4zPj2az0C1rhU1yDpN2UAOM+W9RVRdC56A4Zu1w77qNMzx2DPBEVcGISf
         9tGB+md9rXJK5hw4/mPBblBJtNXu1zgEPx3CEGBaNc/tvsYSpe2b+TuGog+jZQa0qZfP
         p7Qg==
X-Gm-Message-State: AOAM532H17MQItJLfgVulZVf+mX2vx/N+YNZAmQG/y5z/9898g7MzgUn
        kBWjghsRmvCz4F65Q9t78GKmYexKqMqA0w==
X-Google-Smtp-Source: ABdhPJyI0mKpstT5jhiy8B2h3aJvoFwAGl1qSX+Q8TZdh3HNl/2QvRHQXqiqf8Ds36tXnifLp970sA==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr3813147pjb.172.1631646889515;
        Tue, 14 Sep 2021 12:14:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4sm11402339pff.11.2021.09.14.12.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:14:48 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:14:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if
 CC_HAS_AUTO_VAR_INIT_ZERO
Message-ID: <202109141214.630BB3A@keescook>
References: <20210914102837.6172-1-will@kernel.org>
 <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook>
 <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:53:38AM -0700, Nick Desaulniers wrote:
> Rather than create 2 new kconfigs with 1 new invocation of the
> compiler via cc-option, how about just adding an `ifdef
> CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
> `KBUILD_CFLAGS` in the top level Makefile?

v2:

diff --git a/Makefile b/Makefile
index 34a0afc3a8eb..72d165ffabdb 100644
--- a/Makefile
+++ b/Makefile
@@ -831,12 +831,12 @@ endif
 
 # Initialize all stack variables with a zero value.
 ifdef CONFIG_INIT_STACK_ALL_ZERO
-# Future support for zero initialization is still being debated, see
-# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
-# renamed or dropped.
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
+ifdef CONFIG_CC_IS_CLANG
+# https://bugs.llvm.org/show_bug.cgi?id=45497
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
+endif
 
 # While VLAs have been removed, GCC produces unreachable stack probes
 # for the randomize_kstack_offset feature. Disable it for all compilers.
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 90cbaff86e13..ded17b8abce2 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -23,13 +23,16 @@ config CC_HAS_AUTO_VAR_INIT_PATTERN
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
 config CC_HAS_AUTO_VAR_INIT_ZERO
+	# GCC ignores the -enable flag, so we can test for the feature with
+	# a single invocation using the flag, but drop it as appropriate in
+	# the Makefile, depending on the presence of Clang.
 	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
 
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
 	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
-	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
+	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at

-- 
Kees Cook
