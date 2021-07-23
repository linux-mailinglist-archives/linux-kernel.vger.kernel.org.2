Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2908D3D42D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhGWVjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGWVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:39:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662BC061760
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u8so4872051plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/ASYPs7VaNj0QAq9RJIUt4E8PSy8bEnQSnLutDDnAs=;
        b=LmAU93//pDNmvmFTwSe/1GnGP6sp1nQdHxO2gkO/7FH0YMYybcbA1AXe5SdxrVfjSt
         OQu1KD8bqx/O+XMG2kRsRJlGehXevtwam5Mv4kjug55MLISGruvXzl4qZSYKUBmWqgUf
         Z51mHJ18ye7QfuTfLQ8UayZjOwPOtDbeOJqf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/ASYPs7VaNj0QAq9RJIUt4E8PSy8bEnQSnLutDDnAs=;
        b=dLFTmnuH5n0jwIetQ3QtpgOBY2L+dKNC6eoATMS2EyuMNO6CRdOOdcjjdzWDslbfzA
         vLNvIO8oUZtEpA1Cd5gs2OLNpxkZwwKY7qk+PtUGB0fcbYAiYPg4JL2IX7dc2QZ2yr1I
         1Fl/tIjq3AhCwL7bz9O0Y9CGKlyg6O5Gy3Wg6iTKcSlsc5ICrg6tuKPX0fgOMfUCwd/J
         SZACgx5zIPlixh/EpTLxPM0ErCMhKuIJq4JjMZzIHshXJaNBkxufPujxzLuroOk5jk5p
         PM6UHkqoxtv3n1hr4NtDm3fMm0EuRuvLiZsXggcKYSLOt1Zo+ALHvKVs7q8HIqk/8aL7
         aFlQ==
X-Gm-Message-State: AOAM530c3wP27lB4fROj3SBEhjnw95RNOcccj4VRe/HfUU0ke8XQLm4V
        y9vkkvEOUrB56oe50f7txSFaXf89FXTlR5ps
X-Google-Smtp-Source: ABdhPJyJq2+Kgi5Mz8/QLzQoMvgdwGERl4GxU8zVy4tP8BIhluaR4rA2Fdpr1WRNQRAeP3sGr/eqrA==
X-Received: by 2002:a63:fc02:: with SMTP id j2mr6853691pgi.235.1627078778184;
        Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm6646111pjd.29.2021.07.23.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 2/3] lib/test_stackinit: Allow building stand-alone
Date:   Fri, 23 Jul 2021 15:19:32 -0700
Message-Id: <20210723221933.3431999-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723221933.3431999-1-keescook@chromium.org>
References: <20210723221933.3431999-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3737; h=from:subject; bh=3lYzQ022kqofeiv8Bxt7mX9QNwglkjHSyWGR3RJjA7M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg+0B0h5Kxky4JEE+qagiTFCrCVbncY0VpuCZ+26tb Hyh3146JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPtAdAAKCRCJcvTf3G3AJmXREA CqKTlQGiMX7fbKVqtxQHoA8w+R1fnPSzpcyipP0/LRNzXhSEU2t4L4OewSofLyk6r8q+5efLnfbCpr eWZDvgl2cbAYrbHtFKqqmerusuYxt5Zn5Rlxt29pguPzNh/qkjxmFKdFOI6FqSne/Z+ukuBX7KpSFf KJHs+y3xefTotd6IR7vz45DzBPzXsmcKjhziAdGaIgv8UwgyXEDeBeBLjnNzoWbamukwlPmO4e6OOY EQXW94EmgaZ/v2tEDojJiBH5KHOlc1hx77h644IC3XbZOq0jJR5KznIsBpEfeSufnaCM0KH0PigwoJ PiunnpoNHnGoiQxFW/RNbSEvVVE5LHLmP0GLq1f97GPEVUdRc6Ntr56xtiivEF0qVSdVZNONUS9vhm zxLVb+XrQCyDOfl12ZTEVA4MpP3AiBVhYwLek5R2dUdT6XbjgScJW4NGx95fSekZordWO7bCKIRzHx 5VyiXxLhopj81NLDCAk5PMlfbgGtEExWtkjzRAGFoAQklBAU7BU7X1t1hhe5TzL2oFA/2Fy7lmXcd9 XR0lQNMoPGcafC3iGoimjij9YgqCxK+bYZLcfWZPOKc+q8t6WQFORHTlPLqMn4v+sLqwJu2lVk7mRk 6vH4Cw+aCoOpDPhA+ebQXJyieObFH/f8ULdDMFxvDxHI59+5MIe5mj1WJbcA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Especially now that GCC is developing the -ftrivial-auto-var-init
option[1], it's helpful to have a stand-alone userspace test for stack
variable initialization. Relicense to GPLv2+ (I am the only author),
provide stand-alone kernel macro stubs, and update comments for clarity.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2021-July/575198.html

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_stackinit.c | 71 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index 16b1d3a3a497..e2713b639873 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -1,8 +1,13 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Test cases for compiler-based stack variable zeroing via future
- * compiler flags or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
+ * Test cases for compiler-based stack variable zeroing via
+ * -ftrivial-auto-var-init={zero,pattern} or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
+ *
+ * External build example:
+ *	clang -O2 -Wall -ftrivial-auto-var-init=pattern \
+ *		-o test_stackinit test_stackinit.c
  */
+#ifdef __KERNEL__
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
@@ -10,6 +15,62 @@
 #include <linux/module.h>
 #include <linux/string.h>
 
+#else
+
+/* Userspace headers. */
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <errno.h>
+
+/* Linux kernel-ism stubs for stand-alone userspace build. */
+#define KBUILD_MODNAME		"stackinit"
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+#define pr_err(fmt, ...)	fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warn(fmt, ...)	fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_info(fmt, ...)	fprintf(stdout, pr_fmt(fmt), ##__VA_ARGS__)
+#define __init			/**/
+#define __exit			/**/
+#define __user			/**/
+#define noinline		__attribute__((__noinline__))
+#define __aligned(x)		__attribute__((__aligned__(x)))
+#ifdef __clang__
+# define __compiletime_error(message) /**/
+#else
+# define __compiletime_error(message) __attribute__((__error__(message)))
+#endif
+#define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		extern void prefix ## suffix(void) __compiletime_error(msg); \
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
+#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
+typedef uint8_t			u8;
+typedef uint16_t		u16;
+typedef uint32_t		u32;
+typedef uint64_t		u64;
+
+#define module_init(func)	static int (*do_init)(void) = func
+#define module_exit(func)	static void (*do_exit)(void) = func
+#define MODULE_LICENSE(str)	int main(void) {		\
+					int rc;			\
+					/* License: str */	\
+					rc = do_init();		\
+					if (rc == 0)		\
+						do_exit();	\
+					return rc;		\
+				}
+
+#endif /* __KERNEL__ */
+
 /* Exfiltration buffer. */
 #define MAX_VAR_SIZE	128
 static u8 check_buf[MAX_VAR_SIZE];
@@ -279,6 +340,10 @@ DEFINE_TEST(user, struct test_user, STRUCT, none);
 static int noinline __leaf_switch_none(int path, bool fill)
 {
 	switch (path) {
+		/*
+		 * This is intentionally unreachable. To silence the
+		 * warning, build with -Wno-switch-unreachable
+		 */
 		uint64_t var;
 
 	case 1:
-- 
2.30.2

