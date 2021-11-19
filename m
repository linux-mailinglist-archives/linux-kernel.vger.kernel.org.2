Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44357456E66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhKSLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbhKSLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A9C061758
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w29so17600152wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qx8bziHTfXiqh3qmpOE3CbTcfc1G9wnEQjJyyNx0isk=;
        b=lGk0LdZl+IpGs0OPRCjbmsM6EyRoc9NjocfQzEVf5SMD11vMe5ugsYrkgVBtRpHz6o
         da4IiratqBDZNWil28+cHQYSzSLbuVREAzpcIYDkreCWQYdLM2rCX5uWg6c88Mzy4yju
         EKnsP9vwGoJ4eJL9BNHEmot0VM5qMhNNcdcTOTdWfdtQgWqB+iEfxO/gArBz04k/gNn1
         gZG866GvOKvWfDw7QgsMi5AYx0Tk8YZLsl7AcojlakWEo/YuU1PfB7aPDk/+CT++dfOd
         5azD2tv18GE085i6YqC87apImmW5jc7ASW0fD3gRbjzDGLWxPU9tlkVNv6A1+Dc7LJjE
         IecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qx8bziHTfXiqh3qmpOE3CbTcfc1G9wnEQjJyyNx0isk=;
        b=dWpQV2iTOmWI1mh+iVD4NWjDyNNetuj0GK5DDYL40hllarcwiAVOgyVmHZxA2Z4QVw
         O2ZWGVEVdpd8sGd7Gjlp2Xt+ul4j2LYjlAYE+9zy42dTjtUKQUhq8SyodTRXAztJvVPs
         hOHfRuUQO4WuapeozItCsj6B3MI0WFUPeibjIQmm268xq0gxi0u0SPzsU2ZMAontJvcq
         BLyMIZucDe2n7EBFhOpcApnLiLICGUPa8vrX1BueDKydlPWTQOS+E4EBNZjVp2pI9N9k
         hLi58noIyIfdfpYgtmmWjKkQ2H/lg18CVWYCv/3V6Ui83Ttn7SeWRi7GWHKr4bgTbbt0
         cXAA==
X-Gm-Message-State: AOAM532VMToHdZSn2/TfWqiUXKHPB2K5g6nI+HccRDDkjTjhFjObspp9
        GlsR3teeEe8XXSHlA8a0WblKtZ3z0L5fQA==
X-Google-Smtp-Source: ABdhPJxEa8QXLbcoPWjmX0/qXFnzcuIuxMwaR3xGsIRUCZveI1+IQ5wYleNmmgDS4SzXjcJh6HAoPA==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr6669623wrs.276.1637321841182;
        Fri, 19 Nov 2021 03:37:21 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:20 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 13/17] linux/sizeof_field.h: Move sizeof_field(T, m) to a separate header
Date:   Fri, 19 Nov 2021 12:36:41 +0100
Message-Id: <20211119113644.1600-14-alx.manpages@gmail.com>
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
 include/linux/efi.h              |  1 +
 include/linux/filter.h           |  1 +
 include/linux/kvm_host.h         |  1 +
 include/linux/phy_led_triggers.h |  1 +
 include/linux/sizeof_field.h     | 14 ++++++++++++++
 include/linux/slab.h             |  1 +
 include/linux/stddef.h           |  9 +--------
 7 files changed, 20 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/sizeof_field.h

diff --git a/include/linux/efi.h b/include/linux/efi.h
index dbd39b20e034..47aecde48326 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -25,6 +25,7 @@
 #include <linux/reboot.h>
 #include <linux/uuid.h>
 #include <linux/screen_info.h>
+#include <linux/sizeof_field.h>
 
 #include <asm/page.h>
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 3b6bd782e1d6..ebb0ae480533 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -18,6 +18,7 @@
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
 #include <linux/offsetof.h>
+#include <linux/sizeof_field.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 289778b9e6fa..f89a516f3a39 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -30,6 +30,7 @@
 #include <linux/nospec.h>
 #include <linux/notifier.h>
 #include <linux/offsetof.h>
+#include <linux/sizeof_field.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
diff --git a/include/linux/phy_led_triggers.h b/include/linux/phy_led_triggers.h
index 5c4d7a755101..86581b985161 100644
--- a/include/linux/phy_led_triggers.h
+++ b/include/linux/phy_led_triggers.h
@@ -10,6 +10,7 @@ struct phy_device;
 
 #include <linux/leds.h>
 #include <linux/phy.h>
+#include <linux/sizeof_field.h>
 
 #define PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE	11
 
diff --git a/include/linux/sizeof_field.h b/include/linux/sizeof_field.h
new file mode 100644
index 000000000000..7ff541cb21af
--- /dev/null
+++ b/include/linux/sizeof_field.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SIZEOF_FIELD_H
+#define _LINUX_SIZEOF_FIELD_H
+
+/**
+ * sizeof_field() - Report the size of a struct field in bytes
+ *
+ * @TYPE: The structure containing the field of interest
+ * @MEMBER: The field to return the size of
+ */
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+
+
+#endif  /* _LINUX_SIZEOF_FIELD_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 61cb3191566f..c2bd24c60803 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
+#include <linux/sizeof_field.h>
 
 
 /*
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 6ab0f57eccde..5c9aedb5e6ad 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/stddef.h>
 #include <linux/NULL.h>
 #include <linux/offsetof.h>
+#include <linux/sizeof_field.h>
 
 
 enum {
@@ -12,14 +13,6 @@ enum {
 	true	= 1
 };
 
-/**
- * sizeof_field() - Report the size of a struct field in bytes
- *
- * @TYPE: The structure containing the field of interest
- * @MEMBER: The field to return the size of
- */
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-
 /**
  * offsetofend() - Report the offset of a struct field within the struct
  *
-- 
2.33.1

