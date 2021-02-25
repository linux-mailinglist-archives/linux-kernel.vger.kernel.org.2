Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95E332501B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBYNBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhBYNAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:00:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9868364F1F;
        Thu, 25 Feb 2021 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614257979;
        bh=iC4xPAAEf5Q25zrpO9QDpQdb8NdCLLgIwAsn5EyY2y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1/8xkLkE0hSUhWick6mrwsZPeS4qyH3hqUYvsD4+gKdKfmRkNpu+3ZT8vDztt8q2
         QPER5uBGs9Vj8iCXDOO+kPIkXeWTnrURYYH7CyjhJqvnP7atg04ZsmPZIVe/IlEx83
         BCPsxK41NpvtI5zv3XVnSWDpnc3A6Uz14t2/f/QET26v7D5FA7hA679LPLs2BJAPbg
         Bury2yiPBIAVQsjP5nIIsC5JFBQlZkwIrEIMmVhjCEDbmarsEbIjTCJgRBu8+M0Pn3
         QR3xhVbPUFODfYfqf65HE1Mh/VbnzbOQQaYB+L8mZVYikWhE7yRmozXkZrMhnB9CPO
         F+vrmJ0JpCQzQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Max Uvarov <muvarov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] of/fdt: Append bootloader arguments when CMDLINE_EXTEND=y
Date:   Thu, 25 Feb 2021 12:59:21 +0000
Message-Id: <20210225125921.13147-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210225125921.13147-1-will@kernel.org>
References: <20210225125921.13147-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig help text for CMDLINE_EXTEND is sadly duplicated across all
architectures that implement it (arm, arm64, powerpc, riscv and sh), but
they all seem to agree that the bootloader arguments will be appended to
the CONFIG_CMDLINE. For example, on arm64:

  | The command-line arguments provided by the boot loader will be
  | appended to the default kernel command string.

This also matches the behaviour of the EFI stub, which parses the
bootloader arguments first if CMDLINE_EXTEND is set, as well as the
out-of-tree CMDLINE_EXTEND implementation in Android.

However, the behaviour in the upstream fdt code appears to be the other
way around: CONFIG_CMDLINE is appended to the bootloader arguments.

Fix the code to follow the documentation by moving the cmdline
processing out into a new function, early_init_dt_retrieve_cmdline(),
and copying CONFIG_CMDLINE to the beginning of the cmdline buffer rather
than concatenating it onto the end.

Cc: Max Uvarov <muvarov@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Fixes: 34b82026a507 ("fdt: fix extend of cmd line")
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/fdt.c | 64 +++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a..83b9d065e58d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1033,11 +1033,48 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 	return 0;
 }
 
+static int __init cmdline_from_bootargs(unsigned long node, void *dst, int sz)
+{
+	int l;
+	const char *p = of_get_flat_dt_prop(node, "bootargs", &l);
+
+	if (!p || l <= 0)
+		return -EINVAL;
+
+	return strlcpy(dst, p, min(l, sz));
+}
+
+/* dst is a zero-initialised buffer of COMMAND_LINE_SIZE bytes */
+static void __init early_init_dt_retrieve_cmdline(unsigned long node, char *dst)
+{
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
+		/* Copy CONFIG_CMDLINE to the start of destination buffer */
+		size_t idx = strlcpy(dst, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+
+		/* Check that we have enough space to concatenate */
+		if (idx + 1 >= COMMAND_LINE_SIZE)
+			return;
+
+		/* Append the bootloader arguments */
+		dst[idx++] = ' ';
+		cmdline_from_bootargs(node, &dst[idx], COMMAND_LINE_SIZE - idx);
+	} else if (IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		/* Just use CONFIG_CMDLINE */
+		strlcpy(dst, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+	} else if (IS_ENABLED(CONFIG_CMDLINE_FROM_BOOTLOADER)) {
+		/* Use CONFIG_CMDLINE if no arguments from bootloader. */
+		if (cmdline_from_bootargs(node, dst, COMMAND_LINE_SIZE) <= 0)
+			strlcpy(dst, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+	} else {
+		/* Just use bootloader arguments */
+		cmdline_from_bootargs(node, dst, COMMAND_LINE_SIZE);
+	}
+}
+
 int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data)
 {
 	int l;
-	const char *p;
 	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
@@ -1047,30 +1084,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 		return 0;
 
 	early_init_dt_check_for_initrd(node);
-
-	/* Retrieve command line */
-	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
-		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
-
-	/*
-	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-	 * is set in which case we override whatever was found earlier.
-	 */
-#ifdef CONFIG_CMDLINE
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(data, " ", COMMAND_LINE_SIZE);
-	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#else
-	/* No arguments from boot loader, use kernel's  cmdl*/
-	if (!((char *)data)[0])
-		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif /* CONFIG_CMDLINE */
-
+	early_init_dt_retrieve_cmdline(node, data);
 	pr_debug("Command line is: %s\n", (char *)data);
 
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
-- 
2.30.1.766.gb4fecdf3b7-goog

