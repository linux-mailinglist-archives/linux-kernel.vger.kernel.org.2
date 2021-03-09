Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9693330C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhCIVR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhCIVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:17:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8981DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:17:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m9so23260323edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hn0dlz8t9Po4LYnzuYLJe9kWApviDtM6924H6QEDndU=;
        b=LYOgfnXgyu4ICnVzrp+TDBm+otnKfJ9lzNZDkPAQ3PTmL52CBEzaCijkGdJ1sd6UIu
         norMg38T0AcgNQYJOinEiVjcrv0KuuvoJOpRjzH0VDUUYHIYNWcwRWpEd42CXCHpF+B6
         +hTmMFGMHLVb8LUQxio7TJed6taEFxSEIEzYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hn0dlz8t9Po4LYnzuYLJe9kWApviDtM6924H6QEDndU=;
        b=NIzeVIpvOvsPw86MG3UIEJHZfMH3G1TGI1IMvLP0cHctYIVqteWq5ev7kMEyCqroBV
         wpE+A9Zwjyw3w5JpmF0LpJS5ydAabzSeBCIh7R01Q7PjCHBsUK5HFpaoFr6p0CbJqetu
         wFg+Xji3tVG9IiQcfP1OownxvTajbeirMvFjSBuw+3v7mlvuce3LlL+6cmLneIio09+4
         hlCUzf07fqh2IQCP11n96L9J+rTapvsJYUYJ1wU+OKFpgxxAdCRXLmZXIXFjrncmxbPI
         86nwcszY1zEDg9GWUaSURb0CeGwOXUojXFIkZfqINKfjjVfuU8lrgLbBhvYv9PwSiY7V
         YdTA==
X-Gm-Message-State: AOAM533Dndtk/2I1PEqEXYbObPR1vwxr1OnIJqFwKa4TuSidCc+EmTbR
        5el5FlmSA6AnonCnpdvPrPXOew==
X-Google-Smtp-Source: ABdhPJxtsOC3oA8CUOcHN36hZpRtH/iFAWt64GsOzSZ729L4D5ba6S77H4udIonMfmEDvMPlJkk42Q==
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr6420251edr.342.1615324625322;
        Tue, 09 Mar 2021 13:17:05 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id n26sm5205725eds.22.2021.03.09.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:17:04 -0800 (PST)
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
Subject: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
Date:   Tue,  9 Mar 2021 22:16:59 +0100
Message-Id: <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is primarily motivated by an embedded ppc target, where unpacking
even the rather modest sized initramfs takes 0.6 seconds, which is
long enough that the external watchdog becomes unhappy that it doesn't
get attention soon enough. By doing the initramfs decompression in a
worker thread, we get to do the device_initcalls and hence start
petting the watchdog much sooner.

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

Normal desktops might benefit as well. On my mostly stock Ubuntu
kernel, my initramfs is a 26M xz-compressed blob, decompressing to
around 126M. That takes almost two seconds:

[    0.201454] Trying to unpack rootfs image as initramfs...
[    1.976633] Freeing initrd memory: 29416K

Before this patch, or with initramfs_async=0, these lines occur
consecutively in dmesg. With initramfs_async=1, the timestamps on
these two lines is roughly the same as above, but with 172 lines
inbetween - so more than one cpu has been kept busy doing work that
would otherwise only happen after the populate_rootfs() finished.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../admin-guide/kernel-parameters.txt         | 12 ++++++
 drivers/base/firmware_loader/main.c           |  2 +
 include/linux/initrd.h                        |  2 +
 init/initramfs.c                              | 41 ++++++++++++++++++-
 init/main.c                                   |  1 +
 kernel/umh.c                                  |  2 +
 usr/Kconfig                                   | 10 +++++
 7 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..fda9f012c42b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1825,6 +1825,18 @@
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
index d677e8e717f1..d33bd98481c2 100644
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
 
+static bool initramfs_async = IS_ENABLED(CONFIG_INITRAMFS_ASYNC);
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
@@ -693,6 +702,36 @@ static int __init populate_rootfs(void)
 	initrd_end = 0;
 
 	flush_delayed_fput();
+}
+
+static ASYNC_DOMAIN_EXCLUSIVE(initramfs_domain);
+static async_cookie_t initramfs_cookie;
+
+void wait_for_initramfs(void)
+{
+	if (!initramfs_async)
+		return;
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
+	if (initramfs_async)
+		initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
+							 &initramfs_domain);
+	else
+		do_populate_rootfs(NULL, 0);
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
diff --git a/usr/Kconfig b/usr/Kconfig
index 8bbcf699fe3b..0f167c9f7eb9 100644
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

