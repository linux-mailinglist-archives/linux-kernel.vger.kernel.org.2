Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21DC33A164
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhCMV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhCMVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:25:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15702C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:25:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jt13so60071921ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1m+vgEhVjBqMf8BdxsIAq93AqkgHHWpfZDcnyCKhm0=;
        b=NvEYrhi534k3gv+VnirpDyxcSy83Zh0dh24vTjFgoLKe09nbFH+LEBfSkEQbZaa/nI
         lEmsmUefhOV3NcZuMJZLNiZXfvaqpPhouP+P+h4aBCAXagvep0XZ42+m5s9il/2qEMct
         1RNqPrebUyikwgLqnpl3LP8tUkXzCdHyosgDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1m+vgEhVjBqMf8BdxsIAq93AqkgHHWpfZDcnyCKhm0=;
        b=f84XOzG5tiBF7DKGQvRwz8Kpv21V5cp0A9GBqmeCS9S0krqjtUtBDmTUmUdeTiKK1q
         O4bRhlG/j/AVFfGVVQ7igvlOngZM1ghMql1HLSYbm32Eets/ZVYhvvHTRpcrlF2GX5Rs
         +UVs0+Cxp+oUZuHdeq6uC23XJmhGHIzTm77zN6qUi5vXsk8A/TLOa7W4Om/FVRGPquvA
         9vndeeH0Nrfv3hRD6iJ++61kaa42T7BiqmFjatvRG1UkPE9QG7YhqJzcmlo8k/Xlj8gS
         5hOcTDuwO3NRPnVRZ6CwLszXxTWCSrCi7ZzlyDnTeP89cTBQyAdSw8dP4Tay/oLZTsuN
         yc3A==
X-Gm-Message-State: AOAM530iRigX5sT3T3hzjciNXX705YS4JtldY6l/eaJCcPNVboGZRYhx
        tr28H9x3Jd21U0jjDUYoQyO5Sg==
X-Google-Smtp-Source: ABdhPJzx54eHT+eSuRa3U16s4U1ehkQFAHdwXIVS/xwyz7xWnWhH1PFy/8Rp+KrYdzKee3QXQORgBw==
X-Received: by 2002:a17:906:2b9a:: with SMTP id m26mr15349999ejg.526.1615670733802;
        Sat, 13 Mar 2021 13:25:33 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gr16sm4827997ejb.44.2021.03.13.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 13:25:33 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
Date:   Sat, 13 Mar 2021 22:25:27 +0100
Message-Id: <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the boot process doesn't actually need anything from the
initramfs, until of course PID1 is to be executed. So instead of doing
the decompressing and populating of the initramfs synchronously in
populate_rootfs() itself, push that off to a worker thread.

This is primarily motivated by an embedded ppc target, where unpacking
even the rather modest sized initramfs takes 0.6 seconds, which is
long enough that the external watchdog becomes unhappy that it doesn't
get attention soon enough. By doing the initramfs decompression in a
worker thread, we get to do the device_initcalls and hence start
petting the watchdog much sooner.

Normal desktops might benefit as well. On my mostly stock Ubuntu
kernel, my initramfs is a 26M xz-compressed blob, decompressing to
around 126M. That takes almost two seconds:

[    0.201454] Trying to unpack rootfs image as initramfs...
[    1.976633] Freeing initrd memory: 29416K

Before this patch, these lines occur consecutively in dmesg. With this
patch, the timestamps on these two lines is roughly the same as above,
but with 172 lines inbetween - so more than one cpu has been kept busy
doing work that would otherwise only happen after the
populate_rootfs() finished.

Should one of the initcalls done after rootfs_initcall time (i.e.,
device_ and late_ initcalls) need something from the initramfs (say, a
kernel module or a firmware blob), it will simply wait for the
initramfs unpacking to be done before proceeding, which should in
theory make this completely safe.

But if some driver pokes around in the filesystem directly and not via
one of the official kernel interfaces (i.e. request_firmware*(),
call_usermodehelper*) that theory may not hold - also, I certainly
might have missed a spot when sprinkling wait_for_initramfs(). So
there is an escape hatch in the form of an initramfs_async= command
line parameter.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../admin-guide/kernel-parameters.txt         | 12 ++++++
 drivers/base/firmware_loader/main.c           |  2 +
 include/linux/initrd.h                        |  2 +
 init/initramfs.c                              | 38 ++++++++++++++++++-
 init/main.c                                   |  1 +
 kernel/umh.c                                  |  2 +
 6 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..861374df0414 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1825,6 +1825,18 @@
 			initcall functions.  Useful for debugging built-in
 			modules and initcalls.
 
+	initramfs_async= [KNL]
+			Format: <bool>
+			Default: 1
+			This parameter controls whether the initramfs
+			image is unpacked asynchronously, concurrently
+			with devices being probed and
+			initialized. This should normally just work,
+			but as a debugging aid, one can get the
+			historical behaviour of the initramfs
+			unpacking being completed before device_ and
+			late_ initcalls.
+
 	initrd=		[BOOT] Specify the location of the initial ramdisk
 
 	initrdmem=	[KNL] Specify a physical address and size from which to
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 78355095e00d..4fdb8219cd08 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -15,6 +15,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/initrd.h>
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
@@ -504,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	if (!path)
 		return -ENOMEM;
 
+	wait_for_initramfs();
 	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
 		size_t file_size = 0;
 		size_t *file_size_ptr = NULL;
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 85c15717af34..1bbe9af48dc3 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -20,8 +20,10 @@ extern void free_initrd_mem(unsigned long, unsigned long);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 extern void __init reserve_initrd_mem(void);
+extern void wait_for_initramfs(void);
 #else
 static inline void __init reserve_initrd_mem(void) {}
+static inline void wait_for_initramfs(void) {}
 #endif
 
 extern phys_addr_t phys_initrd_start;
diff --git a/init/initramfs.c b/init/initramfs.c
index d677e8e717f1..af27abc59643 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/async.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -541,6 +542,14 @@ static int __init keepinitrd_setup(char *__unused)
 __setup("keepinitrd", keepinitrd_setup);
 #endif
 
+static bool __initdata initramfs_async = true;
+static int __init initramfs_async_setup(char *str)
+{
+	strtobool(str, &initramfs_async);
+	return 1;
+}
+__setup("initramfs_async=", initramfs_async_setup);
+
 extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
@@ -658,7 +667,7 @@ static void __init populate_initrd_image(char *err)
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
-static int __init populate_rootfs(void)
+static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
@@ -693,6 +702,33 @@ static int __init populate_rootfs(void)
 	initrd_end = 0;
 
 	flush_delayed_fput();
+}
+
+static ASYNC_DOMAIN_EXCLUSIVE(initramfs_domain);
+static async_cookie_t initramfs_cookie;
+
+void wait_for_initramfs(void)
+{
+	if (!initramfs_cookie) {
+		/*
+		 * Something before rootfs_initcall wants to access
+		 * the filesystem/initramfs. Probably a bug. Make a
+		 * note, avoid deadlocking the machine, and let the
+		 * caller's access fail as it used to.
+		 */
+		pr_warn_once("wait_for_initramfs() called before rootfs_initcalls\n");
+		return;
+	}
+	async_synchronize_cookie_domain(initramfs_cookie + 1, &initramfs_domain);
+}
+EXPORT_SYMBOL_GPL(wait_for_initramfs);
+
+static int __init populate_rootfs(void)
+{
+	initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
+						 &initramfs_domain);
+	if (!initramfs_async)
+		wait_for_initramfs();
 	return 0;
 }
 rootfs_initcall(populate_rootfs);
diff --git a/init/main.c b/init/main.c
index 53b278845b88..64253b181a84 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1538,6 +1538,7 @@ static noinline void __init kernel_init_freeable(void)
 
 	kunit_run_all_tests();
 
+	wait_for_initramfs();
 	console_on_rootfs();
 
 	/*
diff --git a/kernel/umh.c b/kernel/umh.c
index 3f646613a9d3..61f6b82c354b 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -27,6 +27,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/initrd.h>
 
 #include <trace/events/module.h>
 
@@ -107,6 +108,7 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
+	wait_for_initramfs();
 	retval = kernel_execve(sub_info->path,
 			       (const char *const *)sub_info->argv,
 			       (const char *const *)sub_info->envp);
-- 
2.29.2

