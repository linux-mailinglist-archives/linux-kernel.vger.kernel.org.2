Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49473348D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCYJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:48:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:48:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx7so1636490edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CU5aVwO4hOksRXJAS6rMMVaEFRlnvSKQOotnYJMxE14=;
        b=IMO46dz1d0HsuvWoLbGPuZCVchugXStTPnECL4PZFBDYPCj/UrGrZcMudrRUkEXTEB
         rtisFYROWxSBTxlyzvmvgJnn6Mn+X+vjzQyNPeEo2tw5A3Xaq+k+4Y4vkQhktX03bBX0
         qiClEiWlO+YhLLb4ItXgPwkno0lDBMwV21X0BUaEl+5MkiDCqDDI0Gl3H0u/ne+D0FfL
         87HaoPNh0V4FtQay+53cS/dZcMHXP2uRSXR43YtCROtgSBH3GmuNDILF0JgIIkaAmj9j
         ZKtGZbpB67lhX8GO/rNUkdiRrJUQcVkMG3QK3JN5i42/nh951gfTxKSLz8jq7y/H7byL
         Sp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CU5aVwO4hOksRXJAS6rMMVaEFRlnvSKQOotnYJMxE14=;
        b=a9f/GPXLa3qDRzUyb5OVg4qVWhey6+HmO/TwIacsxUQ3bXZM7U5Dj/ZsX2u1ma4Fwu
         BcUtfdudZ7aPp1tcAGrqWRHMZpOEl49PIuTnnRL5BII7S+b+a73+1fx0nmEt2x/aJbZE
         Rr4iqlI4Ag5edobn2AUB65UAGQG1wDjkfdIjWh34ukgDqL5bTaK+G0LdTvgc1O2AXeLk
         RtjtGUBB6lPq8Cf9fz1dr724olzEW0BtNSfYFDDR2Konw+JnVGcjdXyBnPwxp/iyi/iv
         8E6wW8hw79TWOrWqZFfdvIep7WfTxFJ6fxLiaAQuj6x/JxZdVabwvHe9dXoWBky2qo85
         9iPg==
X-Gm-Message-State: AOAM533A0oDuNnLin5jkQQeFMW0iqOqHromvzF5azS6xog6SIJqT0CUh
        EbQ/HJ5q030eJKbGqSfbpEvt2w==
X-Google-Smtp-Source: ABdhPJz1ZAjDVKR+dTVzswPMaI1j4qGh228Q0GARWAV4LDHA/bqkczDeqVxue+PevorUnYoPNGT6cA==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr8467375eds.102.1616665706900;
        Thu, 25 Mar 2021 02:48:26 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b4sm2161596eja.47.2021.03.25.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 02:48:26 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kgdbts: Switch to do_sys_openat2() for breakpoint testing
Date:   Thu, 25 Mar 2021 09:48:07 +0000
Message-Id: <20210325094807.3546702-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdbts can get stuck waiting for do_sys_open() to be called
in some of the current tests. This is because C compilers often
automatically inline this function, which is a very thin wrapper around
do_sys_openat2(), into some of its callers. gcc-10 does this on (at least)
both x86 and arm64.

We can fix the test suite by placing the breakpoints on do_sys_openat2()
instead since that isn't (currently) inlined. However do_sys_openat2() is
a static function so we cannot simply use an addressof. Since we are
testing debug machinery it is acceptable to use kallsyms to lookup a
suitable address because this is more or less what kdb does in the same
circumstances. Re-implement lookup_addr() to be based on kallsyms rather
than function pointers.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    So less than a week ago I said I had nothing pending for kgdbts.
    That was entirely true when I said it... but then this came up.

 drivers/misc/kgdbts.c | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 945701bce5536..2679374ca8361 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -92,6 +92,7 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/sched/task.h>
+#include <linux/kallsyms.h>

 #include <asm/sections.h>

@@ -200,21 +201,30 @@ static noinline void kgdbts_break_test(void)
 	v2printk("kgdbts: breakpoint complete\n");
 }

-/* Lookup symbol info in the kernel */
+/*
+ * This is a cached wrapper for kallsyms_lookup_name().
+ *
+ * The cache is a big win for several tests. For example it more the doubles
+ * the cycles per second during the sys_open test. This is not theoretic,
+ * the performance improvement shows up at human scale, especially when
+ * testing using emulators.
+ *
+ * Obviously neither re-entrant nor thread-safe but that is OK since it
+ * can only be called from the debug trap (and therefore all other CPUs
+ * are halted).
+ */
 static unsigned long lookup_addr(char *arg)
 {
-	unsigned long addr = 0;
-
-	if (!strcmp(arg, "kgdbts_break_test"))
-		addr = (unsigned long)kgdbts_break_test;
-	else if (!strcmp(arg, "sys_open"))
-		addr = (unsigned long)do_sys_open;
-	else if (!strcmp(arg, "kernel_clone"))
-		addr = (unsigned long)kernel_clone;
-	else if (!strcmp(arg, "hw_break_val"))
-		addr = (unsigned long)&hw_break_val;
-	addr = (unsigned long) dereference_function_descriptor((void *)addr);
-	return addr;
+	static char cached_arg[KSYM_NAME_LEN];
+	static unsigned long cached_addr;
+
+	if (strcmp(arg, cached_arg)) {
+		strscpy(cached_arg, arg, KSYM_NAME_LEN);
+		cached_addr = kallsyms_lookup_name(arg);
+	}
+
+	return (unsigned long)dereference_function_descriptor(
+			(void *)cached_addr);
 }

 static void break_helper(char *bp_type, char *arg, unsigned long vaddr)
@@ -310,7 +320,7 @@ static int check_and_rewind_pc(char *put_str, char *arg)

 	if (arch_needs_sstep_emulation && sstep_addr &&
 	    ip + offset == sstep_addr &&
-	    ((!strcmp(arg, "sys_open") || !strcmp(arg, "kernel_clone")))) {
+	    ((!strcmp(arg, "do_sys_openat2") || !strcmp(arg, "kernel_clone")))) {
 		/* This is special case for emulated single step */
 		v2printk("Emul: rewind hit single step bp\n");
 		restart_from_top_after_write = 1;
@@ -619,14 +629,14 @@ static struct test_struct do_kernel_clone_test[] = {
  */
 static struct test_struct sys_open_test[] = {
 	{ "?", "S0*" }, /* Clear break points */
-	{ "sys_open", "OK", sw_break, }, /* set sw breakpoint */
+	{ "do_sys_openat2", "OK", sw_break, }, /* set sw breakpoint */
 	{ "c", "T0*", NULL, get_thread_id_continue }, /* Continue */
-	{ "sys_open", "OK", sw_rem_break }, /*remove breakpoint */
-	{ "g", "sys_open", NULL, check_and_rewind_pc }, /* check location */
+	{ "do_sys_openat2", "OK", sw_rem_break }, /*remove breakpoint */
+	{ "g", "do_sys_openat2", NULL, check_and_rewind_pc }, /* check location */
 	{ "write", "OK", write_regs, emul_reset }, /* Write registers */
 	{ "s", "T0*", emul_sstep_get, emul_sstep_put }, /* Single step */
-	{ "g", "sys_open", NULL, check_single_step },
-	{ "sys_open", "OK", sw_break, }, /* set sw breakpoint */
+	{ "g", "do_sys_openat2", NULL, check_single_step },
+	{ "do_sys_openat2", "OK", sw_break, }, /* set sw breakpoint */
 	{ "7", "T0*", skip_back_repeat_test }, /* Loop based on repeat_test */
 	{ "D", "OK", NULL, final_ack_set }, /* detach and unregister I/O */
 	{ "", "", get_cont_catch, put_cont_catch },

base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
--
2.29.2

