Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52A31A5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhBLTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBLTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:53:40 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:53:00 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t13so349879pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=i9bXYkYkNrS/myxp10YTd6xQPzarqSevtONWXeGJPlg=;
        b=CEPFGAAZTn1YBSHByUfgpcddUlDuB43hOXZpOdPUc+0zn3cxDCWnpYIBMPOElNPPLW
         cIPJ2hF4x195i6fCSs1CWIpOMlYYJx0hpXRU4Y1ennrFKXBMgYS/5gSl11abA8hXM3Uj
         WvhElyaTAr+5YhBuMjzBs5fMk+8yHPmuKFDhw7ZoQ0GrBmRAI5pj7oW8bwI6ARh0Kn1/
         v5VwKf+p3vFo+qcUs9UykjlqnA56+Ki4Oczm93zCXA2zfa7ovKXRoJjTaAWyyLCs75x8
         2ZgJ7qMogVu4vu8BBfJUCJ7YD/G5dEJuhNLufGQQAyJG/8STZNwx0DCPBUl+WixZl4le
         yh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=i9bXYkYkNrS/myxp10YTd6xQPzarqSevtONWXeGJPlg=;
        b=Fc+tYkPC1QALxn36SmLH1uqvyf3HaQUFtsi2z8Z5+9kTWBvGP+e9HJT1Hb9IQripRN
         JBKHgNdD/y6U0cIf8Miikg0PFYVVs96Zbk6Kllq10OZv5VWl5U8p6XTNSNpHQDLygHrT
         wAAyteQ43Y/Cpd8d+UwKyX0vM6d66LA5S5cgxG6THoIYsGsdVhiX5SJuFI/K55jsfSlS
         kSSLH9HBT7mP+feMjAZen/7iIxnaBxvuT1FFP8dndG7PI1+w5byO9FIgHsVr5wTU09CE
         ha6Qz3TtC8vDjDHh2di27vLkLhEZ9nDKZW+sQkiH+lXUEyf07f2YUDt8WUUMAGm/fj6p
         OqUQ==
X-Gm-Message-State: AOAM532wOpBxindRIFACvpThWJbkBVKFV4XQfr6PMQkGOVaLf8FVKC5m
        I04qGQKbh0uikUkUxknBROS5HB2xyl9q
X-Google-Smtp-Source: ABdhPJzcLNW+FrrZp7ZKnrKVr8H5UQftS7u7Nn5TK/9khzHO3nQj/KyeiMBomoDzHkeCk9/NPtm2JLlrp5NX
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:8cad:e5dd:2b3c:2e84])
 (user=jiancai job=sendgmr) by 2002:a62:3852:0:b029:1da:7238:1cb1 with SMTP id
 f79-20020a6238520000b02901da72381cb1mr4445517pfa.11.1613159579252; Fri, 12
 Feb 2021 11:52:59 -0800 (PST)
Date:   Fri, 12 Feb 2021 11:52:53 -0800
In-Reply-To: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com>
Message-Id: <20210212195255.1321544-1-jiancai@google.com>
Mime-Version: 1.0
References: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2] ARM: Implement Clang's SLS mitigation
From:   Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
-mharden-sls=all, which mitigates the straight-line speculation
vulnerability, speculative execution of the instruction following some
unconditional jumps. Notice -mharden-sls= has other options as below,
and this config turns on the strongest option.

all: enable all mitigations against Straight Line Speculation that are implemented.
none: disable all mitigations against Straight Line Speculation.
retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
blr: enable the mitigation against Straight Line Speculation for BLR instructions.

Link: https://reviews.llvm.org/D93221
Link: https://reviews.llvm.org/D81404
Link: https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2

Suggested-by: Manoj Gupta <manojgupta@google.com>
Suggested-by: Nathan Chancellor  <nathan@kernel.org>
Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Jian Cai <jiancai@google.com>
---

Changes v1 -> v2:
 Update the description and patch based on Nathan and David's comments. 

 arch/arm/Makefile          | 4 ++++
 arch/arm64/Makefile        | 4 ++++
 security/Kconfig.hardening | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4aaec9599e8a..11d89ef32da9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -48,6 +48,10 @@ CHECKFLAGS	+= -D__ARMEL__
 KBUILD_LDFLAGS	+= -EL
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
 #
 # The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
 # later may result in code being generated that handles signed short and signed
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 90309208bb28..ca7299b356a9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -34,6 +34,10 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 269967c4fc1b..9266d8d1f78f 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -121,6 +121,13 @@ choice
 
 endchoice
 
+config HARDEN_SLS_ALL
+	bool "enable SLS vulnerability hardening"
+	def_bool $(cc-option,-mharden-sls=all)
+        help
+          Enables straight-line speculation vulnerability hardening
+	  at highest level.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.30.0.478.g8a0d178c01-goog

