Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57693EEE73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhHQOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhHQOZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:25:29 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7CC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:24:56 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GptbB5bFtzQkBS;
        Tue, 17 Aug 2021 16:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1629210288; bh=bqU0U8k6MA
        yVMYLAvtiDEd0QQIuC94kk98+v0JeNwDQ=; b=H1wuJ1iQbFWyyB4k+azVBfeKcD
        42giK8T9TjpSadhWiAg5mWYy0TD5rA2+cLRXukbHyAQJ1TJYfZ+FRBHo0LYKjyRu
        Ht1c9mnaVqDQBLJk1cv3tsDUuZ7Hh1GBAvei8b6iqbHpK9X9q3TZUpPT1jvkpRpO
        6MmvvpwcCKY3XlhWZ66xmucaXPiKS5QaZJcciOkQJQbD1y1E3D2DxJG9s4aOppIs
        LTS+bHj7f3WEBnK1V+hD7NiCi1s4Wk9mtIVUXy2957wHg4rRkiBWYzTmYwO+wY0U
        kt4A1tJM0Uz8yk8bt9UuqttuSdEt5OasQ1gYc2rCkGSEroFrr++Jfz8UT1tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629210292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThDosbwQsgynlZbrGTbFx2gI7U2iAxLqr8oEIbJgqUw=;
        b=m/WR6djztv4QlxAj1qzXWXMySIUZUJTj7LQdFGckUZetjvcc7eydxrabN0bAEf6X3PidDP
        hOma50BzZWApVTB44I9+rThzgI+AnSp6GvDDjqxxkyiHps72c4nNKAD2T8/zm8ruazY14R
        Dek8SAmhno0S+qNRF6l4rvEVogc0ZGtJYYQcNqEbPabD7qO//WLRUfaYGy5qKONGH1HdZQ
        awUSN6C+237GbqK3nfPcMRiZpRev412GySilqwQINAsmvJrOfYTP9a1yPIXWQeI097lgDJ
        1Y6PvSMU9ljWz8F2tUBeAt0twRI1pItqEdcv2XuNbTNCtmH9o5GZFpNZFucELQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id ee66Lsf4LKQW; Tue, 17 Aug 2021 16:24:48 +0200 (CEST)
Date:   Tue, 17 Aug 2021 16:24:48 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>
Message-ID: <796036867.117557.1629210288168@office.mailbox.org>
In-Reply-To: <269701460.117528.1629210189833@office.mailbox.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
Subject: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings v2/v3/v4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: B0831184D
X-Rspamd-UID: e02cbe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new generic x86-64 CPU tunings introduced with recent versions of
gcc and clang, as documented in x86-64-psABI [1].

This is taken straight from graysky's CPU optimization patch with minor
modifications [2].

[1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
[2] https://github.com/graysky2/kernel_compiler_patch

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
 arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
 arch/x86/Makefile.cpu |  6 ++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d349b0..a2c872aa5a0b 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -294,6 +294,30 @@ config GENERIC_CPU
 	  Generic x86-64 CPU.
 	  Run equally well on all x86-64 CPUs.
 
+config GENERIC_CPU_V2
+	bool "Generic-x86-64-v2"
+	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
+	depends on X86_64
+	help
+	  Generic x86-64 CPU.
+	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.
+
+config GENERIC_CPU_V3
+	bool "Generic-x86-64-v3"
+	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
+	depends on X86_64
+	help
+	  Generic x86-64-v3 CPU with v3 instructions.
+	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
+
+config GENERIC_CPU_V4
+	bool "Generic-x86-64-v4"
+	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
+	depends on X86_64
+	help
+	  Generic x86-64 CPU with v4 instructions.
+	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.
+
 endchoice
 
 config X86_GENERIC
@@ -318,7 +342,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || MPSC
-	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
+	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU || GENERIC_CPU_V2 || GENERIC_CPU_V3 || GENERIC_CPU_V4
 	default "4" if MELAN || M486SX || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
index fb407ae94d90..f190feefe964 100644
--- a/arch/x86/Makefile.cpu
+++ b/arch/x86/Makefile.cpu
@@ -10,3 +10,9 @@ cflags-$(CONFIG_MCORE2) += \
 cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
 	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
 cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
+
+# New generic x86-64 CPU options.
+# Don't call the compiler, we have Kconfig compiler checks for these.
+cflags-$(CONFIG_GENERIC_CPU_V2) += -march=x86-64-v2
+cflags-$(CONFIG_GENERIC_CPU_V3) += -march=x86-64-v3
+cflags-$(CONFIG_GENERIC_CPU_V4) += -march=x86-64-v4
-- 
2.32.0
