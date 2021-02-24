Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC43240A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhBXPRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhBXOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:32:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5FC0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:29:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lr13so3377266ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkPYiJifZ6NjqdaAlKh8r0ZEb7/lpZhLA1+g+xqLQ6k=;
        b=Adr3QfiLJ4ecwddroM1gM9+FzQxbN1YrIojk5WMK1WW4YwMCLcjUcrKTl6UeVDwma1
         ExV3kP0nuHISqDUDYDI5V/zRI/JBxwvFdHiCg8wQlUch1v/7gJrsO5G30q/dn5CLiMZJ
         p8EPklUkrGIKlqxgIEOC6RLm5OHMTudfDPibA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkPYiJifZ6NjqdaAlKh8r0ZEb7/lpZhLA1+g+xqLQ6k=;
        b=uHkij33cd7kZv90sWEfayHGuZLtLP7MhjM3qFb/E/luhIvtg/+Ma4mbIHh+p0D1r4N
         K3sT3WoKxqWVNp/W0kLEdjMLHoRNRvn5I5gu/pczIs14JGNqf2bJup/qXDTR/akas/Az
         V1HdTY4XrHITBeUVh/VHeIPMHcpJJQE7Qnvo13WCIhgwCEUn41s1kciLK0e/4/FkXR4/
         JDZ9PbfiOfA3zW1oJ4LhEOH8qm2Zz5/1tMlLdFKL1VYfahhcQKs53+LlB0kiRI5xEuiB
         XQMdeujulBA5MXiMesMp3HzW5gSV8m8/RGI3PzSqBRR+C55ZVoGmzjLiKMCAbNnhhMPg
         AZ/w==
X-Gm-Message-State: AOAM533JuAO6aV7s/VpzAcXGbGVv1GG0wBZyeLW0v3v3QtI4DWVDc0hs
        WY1nqNCKafF4DktX/F1W9f0kqmolxLi3Eg==
X-Google-Smtp-Source: ABdhPJwj8Bf4OcKN6kgQxM8IOORDzBAVME9mSvbieZOyGDDmwkTFfeLr01pe/5JCl4iAV/9BocgiQA==
X-Received: by 2002:a17:906:4c99:: with SMTP id q25mr19324183eju.111.1614176979517;
        Wed, 24 Feb 2021 06:29:39 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id f1sm1493651ejt.21.2021.02.24.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:29:39 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH/RFC 1/2] init/initramfs.c: allow asynchronous unpacking
Date:   Wed, 24 Feb 2021 15:29:08 +0100
Message-Id: <20210224142909.2092914-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is primarily motivated by an embedded ppc target, where unpacking
even the rather modest sized initramfs takes 0.6 seconds, which is
long enough that the external watchdog becomes unhappy that it doesn't
get enough attention soon enough.

But normal desktops might benefit as well. On my mostly stock Ubuntu
kernel, my initramfs is a 26M xz-compressed blob, decompressing to
around 126M. That takes almost two seconds.

So add an initramfs_async= kernel parameter, allowing the main init
process to proceed to handling device_initcall()s without waiting for
populate_rootfs() to finish.

Should one of those initcalls need something from the initramfs (say,
a kernel module or a firmware blob), it will simply wait for the
initramfs unpacking to be done before proceeding, which should in
theory make this completely safe to always enable. But if some driver
pokes around in the filesystem directly and not via one of the
official kernel interfaces (i.e. request_firmware*(),
call_usermodehelper*) that theory may not hold - also, I certainly
might have missed a spot when sprinkling wait_for_initramfs().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../admin-guide/kernel-parameters.txt         | 12 +++++
 drivers/base/firmware_loader/main.c           |  2 +
 include/linux/initrd.h                        |  7 +++
 init/initramfs.c                              | 51 ++++++++++++++++++-
 init/main.c                                   |  1 +
 kernel/umh.c                                  |  2 +
 usr/Kconfig                                   | 10 ++++
 7 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0ac883777318..e9aca86d429b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1820,6 +1820,18 @@
 			initcall functions.  Useful for debugging built-in
 			modules and initcalls.
 
+	initramfs_async= [KNL] Normally, the initramfs image is
+			unpacked synchronously, before most devices
+			are initialized. When the initramfs is huge,
+			or on slow CPUs, this can take a significant
+			amount of time. Setting this option means the
+			unpacking is instead done in a background
+			thread, allowing the main init process to
+			begin calling device_initcall()s while the
+			initramfs is being unpacked.
+			Format: <bool>
+			Default set by CONFIG_INITRAMFS_ASYNC.
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
index 8db6f8c8030b..7c915a7b7e26 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -24,3 +24,10 @@ extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 
 void console_on_rootfs(void);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void _wait_for_initramfs(const char *caller);
+#define wait_for_initramfs() _wait_for_initramfs(__func__)
+#else
+static inline void wait_for_initramfs(void) { }
+#endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 55b74d7e5260..3a59fd323314 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -530,6 +530,43 @@ static int __init keepinitrd_setup(char *__unused)
 __setup("keepinitrd", keepinitrd_setup);
 #endif
 
+static bool __initdata initramfs_async = CONFIG_INITRAMFS_ASYNC;
+static int __init initramfs_async_setup(char *str)
+{
+	strtobool(str, &initramfs_async);
+	return 1;
+}
+__setup("initramfs_async=", initramfs_async_setup);
+
+static __initdata struct work_struct initramfs_wrk;
+static DECLARE_COMPLETION(initramfs_done);
+static bool initramfs_unpack_started;
+
+void _wait_for_initramfs(const char *caller)
+{
+	unsigned long start;
+
+	if (try_wait_for_completion(&initramfs_done))
+		return;
+	if (!initramfs_unpack_started) {
+		/*
+		 * Something before rootfs_initcall wants to access
+		 * the filesystem/initramfs. Probably a bug. Make a
+		 * note, avoid deadlocking the machine, and let the
+		 * caller's access fail as it used to.
+		 */
+		pr_warn_once("wait_for_initramfs() called by %s"
+			     " before rootfs_initcalls\n", caller);
+		return;
+	}
+
+	start = jiffies;
+	wait_for_completion(&initramfs_done);
+	pr_info("%s() waited %lu jiffies for initramfs_done\n",
+		caller, jiffies - start);
+}
+EXPORT_SYMBOL_GPL(_wait_for_initramfs);
+
 extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
@@ -602,7 +639,7 @@ static void __init populate_initrd_image(char *err)
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
-static int __init populate_rootfs(void)
+static void __init do_populate_rootfs(struct work_struct *w)
 {
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
@@ -637,6 +674,18 @@ static int __init populate_rootfs(void)
 	initrd_end = 0;
 
 	flush_delayed_fput();
+	complete_all(&initramfs_done);
+}
+
+static int __init populate_rootfs(void)
+{
+	initramfs_unpack_started = true;
+	if (initramfs_async) {
+		INIT_WORK(&initramfs_wrk, do_populate_rootfs);
+		schedule_work(&initramfs_wrk);
+	} else {
+		do_populate_rootfs(NULL);
+	}
 	return 0;
 }
 rootfs_initcall(populate_rootfs);
diff --git a/init/main.c b/init/main.c
index a626e78dbf06..fecdede7b85c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1534,6 +1534,7 @@ static noinline void __init kernel_init_freeable(void)
 
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
diff --git a/usr/Kconfig b/usr/Kconfig
index 2599bc21c1b2..56bb250458e4 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -32,6 +32,16 @@ config INITRAMFS_FORCE
 	  and is useful if you cannot or don't want to change the image
 	  your bootloader passes to the kernel.
 
+config INITRAMFS_ASYNC
+	bool "Unpack initramfs asynchronously"
+	help
+	  This option sets the default value of the initramfs_async=
+	  command line parameter. If that parameter is set, unpacking
+	  of initramfs (both the builtin and one passed from a
+	  bootloader) is done asynchronously. See
+	  <file:Documentation/admin-guide/kernel-parameters.txt> for
+	  details.
+
 config INITRAMFS_ROOT_UID
 	int "User ID to map to 0 (user root)"
 	depends on INITRAMFS_SOURCE!=""
-- 
2.29.2

