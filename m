Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057FC3F8488
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbhHZJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhHZJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:30:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DBC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:29:29 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m6-20020ac807c6000000b0029994381c5fso1404996qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EYQCvWaSOAoZfGoi/+7YMUDNib2TjNJAY1W234CWDnA=;
        b=rYQm+h3uOmjt8Qq8qEwiUduzIY8eHzycw8u3wdyV+FmaNn9HCZxhN5Vu2jTQeAXDtI
         FSe/cyVR5PmCG5N5PQ9d1CZlxi4AVFtSunOifs/dpNvOO1rq+xySsaI5BPX604itMgwY
         DLiDD9G209a/PAjTOqtY5NbnrkSUZRg65uHN14ttUGa5lotlaY0T6NsLLuVQH7MW09JW
         q4O8LaMQ9PI8AB90D5j081qhbMNgieWXNoBuGYBPMlhxELjmJbR8KYRpteA5hANi8f8f
         gouK3+gcd3yUvPvdu0U8AiWpZ4wwofFksRZuiEEyy8i+Shq35akBOK6cxXInARsMQbT+
         FdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EYQCvWaSOAoZfGoi/+7YMUDNib2TjNJAY1W234CWDnA=;
        b=L4jgKLosn1+JlOPI4kShf5LsGRMJXEse2imG89dXv6lGopWzZ9umltENhQp2feq7O4
         E4iQtOUvKmAUAENS2fPlhenqu9XdoDiysrO2FYIelSbhhvPyAwWgVUefpVfJGjjKzgdG
         VXDBAGtZH1ZPgDinBUyI+lS1Ku78HC+jZnrw6jJBeBTTYuCp/9SNDBHoobycGhxOFMkZ
         nO92N4Gy9S9KV49+TGguRnsovdOis0iFuvQ5W/smET794pTiVvPNFgCSWSaYtNgJF1XX
         aUKCwHfuW7bNq4htYD9Fslbqrmj71aELQLf6RuIACEWhe6tP1d0wxWeCAjel2O3XLE2w
         00nQ==
X-Gm-Message-State: AOAM532Cj2NHPzHOhZAybmvo57XI/nIo02bb0fYSLz6UJhlcXC5/BmP6
        dtid00hxoUzQLMyQXH7VfvzrT38xC0rzSw==
X-Google-Smtp-Source: ABdhPJwk9Nz9+Ki7HD7mEP9RBjDA9+hL9ifFnr6I0W+Sk0NqibIGohMPAM6P1mlDX6oQ1bGQr7VFPEJVYdMw0g==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:63b:ba74:2193:40c])
 (user=woodylin job=sendgmr) by 2002:a05:6214:5094:: with SMTP id
 kk20mr3099143qvb.3.1629970168601; Thu, 26 Aug 2021 02:29:28 -0700 (PDT)
Date:   Thu, 26 Aug 2021 17:28:54 +0800
Message-Id: <20210826092854.58694-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] ANDROID: staging: add userpanic-dev driver
From:   Woody Lin <woodylin@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Woody Lin <woodylin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add char device driver 'userpanic-dev' that exposes an interface to
userspace processes to request a system panic with customized panic
message.

Signed-off-by: Woody Lin <woodylin@google.com>
---
 drivers/staging/android/Kconfig         |  12 +++
 drivers/staging/android/Makefile        |   1 +
 drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 drivers/staging/android/userpanic-dev.c

diff --git a/drivers/staging/android/Kconfig b/drivers/staging/android/Kconfig
index 70498adb1575..b1968a1ee821 100644
--- a/drivers/staging/android/Kconfig
+++ b/drivers/staging/android/Kconfig
@@ -14,6 +14,18 @@ config ASHMEM
 	  It is, in theory, a good memory allocator for low-memory devices,
 	  because it can discard shared memory units when under memory pressure.
 
+config USERPANIC_CHARDEV
+	bool "User-panic device interface"
+	help
+	  Say Y here to use user-panic device for user space processes to
+	  request a system panic with customized panic message.
+
+	  A char device '/dev/userspace_panic' is created by this driver
+	  when selecting 'Y'. User processes can request panic and attach
+	  customized panic message and title by ioctl(CRASH_INFO). Later any
+	  panic handler can collect the panic message to build debugging
+	  reports.
+
 endif # if ANDROID
 
 endmenu
diff --git a/drivers/staging/android/Makefile b/drivers/staging/android/Makefile
index e9a55a5e6529..851efb3435ac 100644
--- a/drivers/staging/android/Makefile
+++ b/drivers/staging/android/Makefile
@@ -2,3 +2,4 @@
 ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_ASHMEM)			+= ashmem.o
+obj-$(CONFIG_USERPANIC_CHARDEV)	+= userpanic-dev.o
diff --git a/drivers/staging/android/userpanic-dev.c b/drivers/staging/android/userpanic-dev.c
new file mode 100644
index 000000000000..b9a0f0c01826
--- /dev/null
+++ b/drivers/staging/android/userpanic-dev.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* userpanic-dev.c
+ *
+ * User-panic Device Interface
+ *
+ * Copyright 2021 Google LLC
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/miscdevice.h>
+
+struct userpanic_crash_info {
+	void __user *title_uaddr;
+	void __user *msg_uaddr;
+};
+
+#define CRASH_INFO		(_IOW('U', 179, struct userpanic_crash_info))
+
+static int do_userpanic(const char *title, const char *msg)
+{
+	const size_t msgbuf_sz = PAGE_SIZE;
+	char *msgbuf;
+
+	msgbuf = kmalloc(msgbuf_sz, GFP_KERNEL);
+	if (!msgbuf)
+		return -ENOMEM;
+
+	pr_emerg("User process '%.*s' %d requesting kernel panic\n",
+		 sizeof(current->comm), current->comm, current->pid);
+	if (msg)
+		pr_emerg("   with message: %s\n", msg);
+
+	/* Request panic with customized panic title. */
+	snprintf(msgbuf, msgbuf_sz, "U: %s: %s", current->comm, title);
+	panic(msgbuf);
+	kfree(msgbuf);
+	return -EFAULT;
+}
+
+static long userpanic_device_ioctl(struct file *file, u_int cmd, u_long arg)
+{
+	struct userpanic_crash_info crash_info;
+	char *title;
+	char *msg = NULL;
+	int ret;
+
+	switch (cmd) {
+	case CRASH_INFO:
+		if (copy_from_user(&crash_info, (void __user *)arg, sizeof(crash_info)))
+			return -EFAULT;
+
+		if (!crash_info.title_uaddr)
+			return -EINVAL;
+
+		title = strndup_user(crash_info.title_uaddr, PAGE_SIZE);
+		if (IS_ERR(title)) {
+			pr_err("failed to strndup .title_uaddr: %d\n", PTR_ERR(title));
+			return -EINVAL;
+		}
+
+		if (crash_info.msg_uaddr) {
+			msg = strndup_user(crash_info.msg_uaddr, PAGE_SIZE);
+			if (IS_ERR(msg)) {
+				kfree(title);
+				pr_err("failed to strndup .msg_uaddr: %d\n", PTR_ERR(msg));
+				return -EINVAL;
+			}
+		}
+
+		ret = do_userpanic(title, msg);
+		kfree(msg);
+		kfree(title);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations userpanic_device_fops = {
+	.owner          = THIS_MODULE,
+	.unlocked_ioctl = userpanic_device_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
+};
+
+static struct miscdevice userpanic_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name  = "userspace_panic",
+	.fops  = &userpanic_device_fops,
+};
+
+static int __init userspace_panic_dev_init(void)
+{
+	int ret;
+
+	ret = misc_register(&userpanic_device);
+	if (ret)
+		pr_err("misc_register failed for userspace_panic device\n");
+
+	return ret;
+}
+
+device_initcall(userspace_panic_dev_init);
+
+MODULE_DESCRIPTION("User-panic interface device driver");
+MODULE_AUTHOR("Woody Lin <woodylin@google.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.33.0.rc2.250.ged5fa647cd-goog

