Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A494456E69
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKSLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhKSLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5964C06175E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7252603wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3clzLNfg5xHosDfnGl6o8FHox4hJTJBQfvcHoNjogw=;
        b=FZkApWF7U/akT49BTBcVhfUpOGm186Gw2w9hJT1ALr4wxyoVPSSPxQ20ew9vXzmxZw
         V41vs9JUDSOpKE7sNNWM3eKDHaDOKoRAOh2MAdKlA1ALEWnTxWpU6fh+hxHU/+pzYwwa
         kMCotQhVYsMG1d4842dSqdgHP3FcDQdhNCoEM3G64i560ELcuWS6s+qxmHIFc0V42ZDU
         tCP6ht+6zGWVDFoNGXl9ZU/mk6/+Ud118wgM43MPQZUNANWCh8gPSG6SuvLj/e4o/Dj3
         NXdCr9ZcBfcQGXu6ipJ1/Aed9IUFPJ/ilAs9SnTFrMz7pShziwD/Amqar2zGE8W0wA6i
         wOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3clzLNfg5xHosDfnGl6o8FHox4hJTJBQfvcHoNjogw=;
        b=i0YsSed+0+c/z9iqRPuDutoAFPSNWxACfAXsuOdsd41+snqcWiAU0SwMw6NxGawpTU
         TO65PBbKgN6WJkFoZ5hFO7vItbhjXQzxVEtH4I4Cj0n7oiIXrf3nlfkk6z4+eT2E+gq1
         73+rgZ1X377h244BF2AsOPsxJMdv9mg/iJN8MMqBiifnyjZS9xMHYacAfKdD5RbPwg3E
         vA6m2HD7nHUjecvJfR3L7MGU5CR6IaokiLUQcvkIZbeOXASKiU5lK//WOs+Hsv6rsTwn
         UFBVsvN0zbawrTCadTwsAPyTZp4ChgWnZ+KR5hU5qCCxQlRqtZYhO8Yx7R4eCvtW9xAM
         Z7qA==
X-Gm-Message-State: AOAM532od2gvC1A7mscA7lwlbs5WUOUNuUissI7DIYMeoGyJTET2PVDd
        jt7JpxPYkOk9MwY67QzK1CUWrr2gYkCB7w==
X-Google-Smtp-Source: ABdhPJxViWXe6trewTlgLfeo7loTIBTlI3dyrvPfYikrhBkcP2Qv71QKqOK31xxSoYFyNsM6V5wRuw==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr6098783wmq.34.1637321843478;
        Fri, 19 Nov 2021 03:37:23 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:23 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 16/17] linux/array_size.h: Move ARRAY_SIZE(arr) to a separate header
Date:   Fri, 19 Nov 2021 12:36:44 +0100
Message-Id: <20211119113644.1600-17-alx.manpages@gmail.com>
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
 include/linux/array_size.h                    | 15 +++++++++++++++
 include/linux/clk-provider.h                  |  1 +
 include/linux/counter.h                       |  1 +
 include/linux/genl_magic_func.h               |  1 +
 include/linux/hashtable.h                     |  1 +
 include/linux/kernel.h                        |  7 +------
 include/linux/kfifo.h                         |  1 +
 include/linux/kvm_host.h                      |  1 +
 include/linux/moduleparam.h                   |  3 +++
 include/linux/mtd/rawnand.h                   |  1 +
 include/linux/netfilter.h                     |  1 +
 include/linux/pagemap.h                       |  1 +
 include/linux/phy.h                           |  1 +
 include/linux/pinctrl/machine.h               |  1 +
 include/linux/property.h                      |  1 +
 include/linux/rcupdate_wait.h                 |  1 +
 include/linux/regmap.h                        |  1 +
 include/linux/skmsg.h                         |  2 ++
 include/linux/string.h                        |  1 +
 include/linux/surface_aggregator/controller.h |  1 +
 20 files changed, 37 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/array_size.h

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
new file mode 100644
index 000000000000..4f62840f808a
--- /dev/null
+++ b/include/linux/array_size.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ARRAY_SIZE_H
+#define _LINUX_ARRAY_SIZE_H
+
+#include <linux/compiler.h>
+
+
+/**
+ * ARRAY_SIZE - get the number of elements in array @arr
+ * @arr: array to be sized
+ */
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
+
+#endif  /* _LINUX_ARRAY_SIZE_H */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f59c875271a0..f6860d22d1ab 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
+#include <linux/array_size.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b7d0a00a61cf..f7f6f2e50390 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,6 +6,7 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/array_size.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 939b1a8f571b..e3b5bd816bcd 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -2,6 +2,7 @@
 #ifndef GENL_MAGIC_FUNC_H
 #define GENL_MAGIC_FUNC_H
 
+#include <linux/array_size.h>
 #include <linux/build_bug.h>
 #include <linux/genl_magic_struct.h>
 
diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..09c5f1522b06 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_HASHTABLE_H
 #define _LINUX_HASHTABLE_H
 
+#include <linux/array_size.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 77755ac3e189..1437bfaadec5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
+#include <linux/array_size.h>
 #include <linux/stdarg.h>
 #include <linux/align.h>
 #include <linux/limits.h>
@@ -39,12 +40,6 @@
 #define READ			0
 #define WRITE			1
 
-/**
- * ARRAY_SIZE - get the number of elements in array @arr
- * @arr: array to be sized
- */
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 86249476b57f..ef0e4b979ba0 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -36,6 +36,7 @@
  * to lock the reader.
  */
 
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f89a516f3a39..67dfcf9dd166 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -3,6 +3,7 @@
 #define __KVM_HOST_H
 
 
+#include <linux/array_size.h>
 #include <linux/types.h>
 #include <linux/hardirq.h>
 #include <linux/list.h>
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 962cd41a2cb5..4a6eb8ce7c94 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -2,10 +2,13 @@
 #ifndef _LINUX_MODULE_PARAMS_H
 #define _LINUX_MODULE_PARAMS_H
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
+
+#include <linux/array_size.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
 #include <linux/kernel.h>
 
+
 /* You can override this manually, but generally this should match the
    module name. */
 #ifdef MODULE
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b2f9dd3cbd69..cdb8e92db7ec 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_MTD_RAWNAND_H
 #define __LINUX_MTD_RAWNAND_H
 
+#include <linux/array_size.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/flashchip.h>
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 3fda1a508733..11a01c1fcc3c 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_NETFILTER_H
 #define __LINUX_NETFILTER_H
 
+#include <linux/array_size.h>
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/net.h>
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1a0c646eb6ff..529282a85cb3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -5,6 +5,7 @@
 /*
  * Copyright 1995 Linus Torvalds
  */
+#include <linux/array_size.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/list.h>
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 96e43fbb2dd8..ca86f7990751 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -11,6 +11,7 @@
 #ifndef __PHY_H
 #define __PHY_H
 
+#include <linux/array_size.h>
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index e987dc9fd2af..6c264dd0e163 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -11,6 +11,7 @@
 #ifndef __LINUX_PINCTRL_MACHINE_H
 #define __LINUX_PINCTRL_MACHINE_H
 
+#include <linux/array_size.h>
 #include <linux/bug.h>
 
 #include <linux/pinctrl/pinctrl-state.h>
diff --git a/include/linux/property.h b/include/linux/property.h
index 88fa726a76df..add29cf6c0c4 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -10,6 +10,7 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..a321404eeec0 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -6,6 +6,7 @@
  * RCU synchronization types and methods:
  */
 
+#include <linux/array_size.h>
 #include <linux/rcupdate.h>
 #include <linux/completion.h>
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e3c9a25a853a..e039cd815fc1 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -10,6 +10,7 @@
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
  */
 
+#include <linux/array_size.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 46e76f4ff0de..2f1bdc81fafb 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_SKMSG_H
 #define _LINUX_SKMSG_H
 
+#include <linux/array_size.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/offsetofend.h>
@@ -14,6 +15,7 @@
 #include <net/tcp.h>
 #include <net/strparser.h>
 
+
 #define MAX_MSG_FRAGS			MAX_SKB_FRAGS
 #define NR_MSG_FRAG_IDS			(MAX_MSG_FRAGS + 1)
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 555b6f00c73d..88324a05c34a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
+#include <linux/array_size.h>
 #include <linux/compiler.h>	/* for inline */
 #include <linux/NULL.h>
 #include <linux/types.h>	/* for size_t */
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index 74bfdffaf7b0..9a355c38132c 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
 #define _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
 
+#include <linux/array_size.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/types.h>
-- 
2.33.1

