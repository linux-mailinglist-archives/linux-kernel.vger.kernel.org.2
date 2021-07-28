Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99003D8F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhG1Nru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhG1NrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:47:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DFC061384
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:46:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q2so3157653ljq.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbWIYXYlrIPDpsel0NzGQa0M/lKslwVGPnq1gOvws3s=;
        b=O+3cJ5Ny3Jt5pm3gKn6uFapk06ecZ8zmNJJFkasy6gvYmV+/PvmCc1EWKbi47JA4wM
         iI07bBX2++Uks7vTfNMXJZoXQEb2GBTWyR87oodpuyLh9jFjkRb1pzXJhHbQ8X843pV3
         zT/aYQ248Wy5t/D5obB9CytgSfYQWf//T61JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbWIYXYlrIPDpsel0NzGQa0M/lKslwVGPnq1gOvws3s=;
        b=K6kHgJXjQQbbagSNW7GESZLAhQlkhq0oz+oAoQ20tpd0EEs2FKreFBgcH+oAPtQhuh
         FNp7KuEmjYGn9qV43L9xqTClrpJPwQoZNyZvHylSfBqC8mwnLJtr2K03WengoB0rPR3Q
         SOGHu4GVeCb6UYjGKDyB1e5IKtWbNEiwJToTea+8cWeJmh6bholik1ZrRWZLejD3jaMB
         Q1bF+LGAuwMGY///0Jr47eztnJkEXnxGAZ87891GLXzgnB/QdOGqUc6y1ebFt5TsLWNI
         5nZFcJH0G9qMoW+4znij5WCbhKHgNGGZ+x83E6uD1kOVvQPzw4Wbgukb5pDB750lWSge
         N2qg==
X-Gm-Message-State: AOAM530OfOphgfr6vpm1AEAUh2kg3qNcRVgOXB/LfmOst9TNiartUfvC
        mvaZEfWdJloC3F8jFrjJOdnMSg==
X-Google-Smtp-Source: ABdhPJwQYbSnMyafZuFr56LBbsjZEKxOPiGV0sH9yHwQ9Mx0aBeLbbpNtiwIWEO3aFIywmWGnaMvEQ==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr18513447ljh.208.1627480002943;
        Wed, 28 Jul 2021 06:46:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q10sm8624lfm.5.2021.07.28.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:46:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init: move usermodehelper_enable() to populate_rootfs()
Date:   Wed, 28 Jul 2021 15:46:37 +0200
Message-Id: <20210728134638.329060-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, usermodehelper is enabled right before PID1 starts going
through the initcalls. However, any call of a usermodehelper from a
pure_, core_, postcore_, arch_, subsys_ or fs_ initcall is futile, as
there is no filesystem contents yet.

Up until commit e7cb072eb988 ("init/initramfs.c: do unpacking
asynchronously"), such calls, whether via some request_module(), a
legacy uevent "/sbin/hotplug" notification or something else, would
just fail silently with (presumably) -ENOENT from
kernel_execve(). However, that commit introduced the
wait_for_initramfs() synchronization hook which must be called from
the usermodehelper exec path right before the kernel_execve, in order
that request_module() et al done from *after* rootfs_initcall()
time (i.e. device_ and late_ initcalls) would continue to find a
populated initramfs as they used to.

Any call of wait_for_initramfs() done before the unpacking has been
scheduled (i.e. before rootfs_initcall time) must just return
immediately [and let the caller find an empty file system] in order
not to deadlock the machine. I mistakenly thought, and my limited
testing confirmed, that there were no such calls, so I added a
pr_warn_once() in wait_for_initramfs(). It turns out that one can
indeed hit request_module() as well as kobject_uevent_env() during
those early init calls, leading to a user-visible warning in the
kernel log emitted consistently for certain configurations.

We could just remove the pr_warn_once(), but I think it's better to
postpone enabling the usermodehelper framework until there is at least
some chance of finding the executable. That is also a little more
efficient in that a lot of work done in umh.c will be elided. However,
it does change the error seen by those early callers from -ENOENT to
-EBUSY, so there is a risk of a regression if any caller care about
the exact error value.

Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 init/initramfs.c   | 2 ++
 init/main.c        | 1 -
 init/noinitramfs.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..a842c0544745 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
+#include <linux/umh.h>
 
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
@@ -727,6 +728,7 @@ static int __init populate_rootfs(void)
 {
 	initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
 						 &initramfs_domain);
+	usermodehelper_enable();
 	if (!initramfs_async)
 		wait_for_initramfs();
 	return 0;
diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..d5c5542fe142 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1387,7 +1387,6 @@ static void __init do_basic_setup(void)
 	driver_init();
 	init_irq_proc();
 	do_ctors();
-	usermodehelper_enable();
 	do_initcalls();
 }
 
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index 3d62b07f3bb9..d1d26b93d25c 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -10,6 +10,7 @@
 #include <linux/kdev_t.h>
 #include <linux/syscalls.h>
 #include <linux/init_syscalls.h>
+#include <linux/umh.h>
 
 /*
  * Create a simple rootfs that is similar to the default initramfs
@@ -18,6 +19,7 @@ static int __init default_rootfs(void)
 {
 	int err;
 
+	usermodehelper_enable();
 	err = init_mkdir("/dev", 0755);
 	if (err < 0)
 		goto out;
-- 
2.31.1

