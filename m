Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D91456E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhKSLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhKSLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w29so17599468wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psQU3rEGTNxJmCKHJWpCpYF0bTNqbwqz8XLokDlFPUQ=;
        b=f2i9KQiPzrP+eLrdf92mZCKOJy5JsHdN2BpU/Glc0H6vdPtUypH8eEG90mbyu8So+g
         9K7yaq+X3Xe6wC4c3McpDuF50LntjCJH+lE+EpXs2c0g11eR4X+xKgm5rCMWSaaPEVRp
         +v4MgZR8e/4vM/dnm9QuQaz2zjtF/wYEQIDz/PfHwqunryk/ZQ4cljWo8/uqnCL0fQJT
         FsABpKkmnzaY3qx/23MOO/Wo6fFAf3FYTsqLQSR0Hep645II415tOPJEnPJoXUYkKqWu
         tD/IPUYwICCKUmDAAWU65GzjkiRt5XceQuUzvbiXoZkbS8QrEn7fxOn3FFxWOexvagoe
         lE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psQU3rEGTNxJmCKHJWpCpYF0bTNqbwqz8XLokDlFPUQ=;
        b=ZcbOU6TqPkWYOB7varIROvIqGNIir521PGi58Eb1+E9NPwuRsq73XoYO4DlBs/btrw
         Bx1igCs/0Tbu0m2MXx7pK/FLI0LCw4OvGdRbupmTTNKhyGAeyVKBnr8lzgj0+Nmc5q1k
         QjgqALU1eLTmPMrh0RE2oSdz2C6sqXHHqG1E3r3RFGh4kPMRTtFH15wSz6wMQzVrMsby
         6FXUmfsAHX+4CLVowlk99Zwv4ttXV8jOqOYV9ZTH5WuEkl0BcByLHnykEp1+HiYl8+ok
         zPz1kXrpGYR38WUzwaAOTRbdT8+bHczPac5Ulujy/2s0WVWv+lI+G0pAZo0sK4t1QoTy
         6bBg==
X-Gm-Message-State: AOAM533JFfXKhMwQzwiVGABGagErzXliaeyIMHbc/szv0WQEJRO4vFZT
        EgW88505NZVwITUYpL2u8ZTmW6gBrcVcuw==
X-Google-Smtp-Source: ABdhPJwI4DJH/QksrlwXkD/m5IW6sizfdIXCIm3cvFflqT6jo2LQ/HPApzv6kp+ahoTq0wIZcwQiCg==
X-Received: by 2002:a5d:4563:: with SMTP id a3mr6654071wrc.130.1637321833966;
        Fri, 19 Nov 2021 03:37:13 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:13 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 04/17] linux/memberof.h: Move memberof() to separate header
Date:   Fri, 19 Nov 2021 12:36:32 +0100
Message-Id: <20211119113644.1600-5-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching files so used for the kernel,
such as <linux/stddef.h> or <linux/container_of.h>
forces 'make' to recompile most of the kernel.

Having those definitions in more granular files
helps avoid recompiling so much of the kernel.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 drivers/gpu/drm/i915/i915_utils.h       | 2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.h | 1 +
 include/linux/container_of.h            | 3 +--
 include/linux/memberof.h                | 9 +++++++++
 include/linux/virtio_config.h           | 1 +
 5 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/memberof.h

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 2e3ec28f4f1b..bb91e6763d34 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -25,8 +25,8 @@
 #ifndef __I915_UTILS_H
 #define __I915_UTILS_H
 
-#include <linux/container_of.h>
 #include <linux/list.h>
+#include <linux/memberof.h>
 #include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/types.h>
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.h b/drivers/gpu/drm/i915/intel_runtime_pm.h
index 6cb04bef62ad..72f5396eea70 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.h
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.h
@@ -6,6 +6,7 @@
 #ifndef __INTEL_RUNTIME_PM_H__
 #define __INTEL_RUNTIME_PM_H__
 
+#include <linux/memberof.h>
 #include <linux/types.h>
 
 #include "intel_wakeref.h"
diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 227418cb8c99..2f1eb5ddd20a 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -4,10 +4,9 @@
 
 #include <linux/build_bug.h>
 #include <linux/err.h>
+#include <linux/memberof.h>
 
 
-#define memberof(T, m)   (((T *) NULL)->m)
-
 #define typeof_member(T, m)	typeof(memberof(T, m))
 
 /**
diff --git a/include/linux/memberof.h b/include/linux/memberof.h
new file mode 100644
index 000000000000..3853c91d1fb2
--- /dev/null
+++ b/include/linux/memberof.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMBEROF_H
+#define _LINUX_MEMBEROF_H
+
+
+#define memberof(T, m)   (((T *) NULL)->m)
+
+
+#endif	/* _LINUX_MEMBEROF_H */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4fd659e26450..ddbd51208ce1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -4,6 +4,7 @@
 
 #include <linux/err.h>
 #include <linux/bug.h>
+#include <linux/memberof.h>
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
 #include <linux/compiler_types.h>
-- 
2.33.1

