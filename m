Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3D456E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhKSLkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhKSLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22245C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d5so17691743wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsuGRr8zvATFO0MOaS5p9HWFCBggU3kNzCT/TmmZKSI=;
        b=jLLskqfTN5X/ykPdVIEhK98AmOhVNLC0pv5TxYwPxqGt9Q/dDocArN85OsDorL0uor
         JRphFQ9MCKYL6ZXNzVuvp675u3XUIxJ1MYZ0zSxczOgBoEgLEXniZjETUQrDpPw5cPmJ
         03abdQvfOhgmdEIjUSiQTA+fMmqTaxbbQqokKuN7pzl/W3tCbZbB9Em7yuEifioGwafh
         /0iYOCNnAS5F8j6+FGDCiMXhm8jcgHrum25gE3/SYtUU7DVWsLZItd3Oo0iJK+mNhCVV
         cPfSRo/5XE32PmHirbmCkaj8pWSYELyS5pVMNGl3VShjIbZ6rZUTYOngNMRmwlvkJ0vm
         AEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsuGRr8zvATFO0MOaS5p9HWFCBggU3kNzCT/TmmZKSI=;
        b=0A30nOlO2kY0uk3So+xiYQxeik22vJh6UUC5kLd99FLy0+Yuo90NkGaiKKwHA+hVQy
         ePoD9mcL9eELJexao7EaBBJWrVfU7SzlOPsWBAeR71AiRyXv6MLqCH4/3vk7NbPo4kTm
         hLuG8PzquMUBxH2ey39J0MCQWYqflhUa7hBGcIrMyrbOE5ufTz5Jgwox3BtqgB1n9DXA
         s5lOKX0t9Ozp81Aj0Tn9d5zrphctBtP1EXje+jnnJjNweyAaFF6nDz8Ba5MxqqTXCSx5
         5cozZbeIpPn0UXX83JpxWMCtvnOXukAO0u7Yr1oZxG9LUtqDCCf0sLrAmiL3sd53ZPyZ
         hjlg==
X-Gm-Message-State: AOAM531um80fC+cnQCrULHl01K/WmuiT+sG9+4oXQmmS6eJnZXruMuPi
        mMz/qVirXDC9S9QQnCb7L22GFoq3tMbbjw==
X-Google-Smtp-Source: ABdhPJw1nYdkAsF9SMEVNCtCDbhnVIK29qrhcKyw9GcVYkDvY79E+yMj+4UuJ9BfVaPsmPw9Bjs88g==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr6604174wri.222.1637321834658;
        Fri, 19 Nov 2021 03:37:14 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:14 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 05/17] linux/typeof_member.h: Move typeof_member() to a separate header
Date:   Fri, 19 Nov 2021 12:36:33 +0100
Message-Id: <20211119113644.1600-6-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching files so used for the kernel,
forces 'make' to recompile most of the kernel.

Having those definitions in more granular files
helps avoid recompiling so much of the kernel.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 drivers/gpu/drm/i915/i915_sw_fence.c |  1 +
 drivers/platform/x86/wmi.c           |  1 +
 fs/proc/inode.c                      |  1 +
 include/linux/container_of.h         |  2 --
 include/linux/typeof_member.h        | 11 +++++++++++
 include/linux/virtio_config.h        |  1 +
 kernel/kallsyms.c                    |  1 +
 7 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/typeof_member.h

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index c589a681da77..911ad08978b2 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -8,6 +8,7 @@
 #include <linux/dma-fence.h>
 #include <linux/irq_work.h>
 #include <linux/dma-resv.h>
+#include <linux/typeof_member.h>
 
 #include "i915_sw_fence.h"
 #include "i915_selftest.h"
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c34341f4da76..5daadcafd808 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -33,6 +33,7 @@
 #include <linux/uuid.h>
 #include <linux/wmi.h>
 #include <linux/fs.h>
+#include <linux/typeof_member.h>
 #include <uapi/linux/wmi.h>
 
 MODULE_AUTHOR("Carlos Corbacho");
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 599eb724ff2d..e73e55e8dad4 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/mount.h>
 #include <linux/bug.h>
+#include <linux/typeof_member.h>
 
 #include <linux/uaccess.h>
 
diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f1eb5ddd20a..082188b5cd29 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -7,8 +7,6 @@
 #include <linux/memberof.h>
 
 
-#define typeof_member(T, m)	typeof(memberof(T, m))
-
 /**
  * container_of - cast a member of a structure out to the containing structure
  * @ptr:	the pointer to the member.
diff --git a/include/linux/typeof_member.h b/include/linux/typeof_member.h
new file mode 100644
index 000000000000..38aa030d86d2
--- /dev/null
+++ b/include/linux/typeof_member.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TYPEOF_MEMBER_H
+#define _LINUX_TYPEOF_MEMBER_H
+
+#include <linux/memberof.h>
+
+
+#define typeof_member(T, m)	typeof(memberof(T, m))
+
+
+#endif	/* _LINUX_TYPEOF_MEMBER_H */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index ddbd51208ce1..ff1752441e5d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -8,6 +8,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
 #include <linux/compiler_types.h>
+#include <linux/typeof_member.h>
 #include <uapi/linux/virtio_config.h>
 
 struct irq_affinity;
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3011bc33a5ba..3bf04d89d72c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -29,6 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/typeof_member.h>
 
 /*
  * These will be re-linked against their real values
-- 
2.33.1

