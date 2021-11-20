Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB69C457EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhKTNFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhKTNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715E8C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d27so23201068wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdLMIbes6vehIzOK5aMJDTcUwd8mv1Zvexp2gWt7Ttk=;
        b=XkGfIlRAr3YjqieYTSL4RR3+rA0DhGXRyyF2cd+CH0UdOW+F309CotpIsbLV/2ksmP
         e4S4rEV/9ICt85sD2575fAltTCvh8ta56D+Aay3DaVKc/U7EdHsiIFyaWZAGXrEMKYVW
         kGzFVc05xW/gU3B3ZljnMaFvNlAusNdmdWxgBL6LCyes9hOOPnq9wp+kfFMPUa7S/6+i
         3acBQlRHb7RFmOU8kGgZ0eZGrzXgXAvFDxO4tqxnNH6dzpXr0xO1tvWquBHT5/wwqxxT
         vOKHIBSmkTSWLSY1EqNuFQzb7kP0FWLb8Afp1y+MJqCBEqia5m014vESwavk0yMZ/+xt
         DKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdLMIbes6vehIzOK5aMJDTcUwd8mv1Zvexp2gWt7Ttk=;
        b=S6zQGbFcOxILClbm6LzVF2qKWudX2YS5z03ZkyPKlkT+ZENn0AP0YCyozuUgZuKMpM
         WkcDpogzA2pMbxW6+rE00xsSOjqHrMqM/2KzaOnk+Oub/1CcqRkt86NBV0tmtrULmxGT
         5kEE6Qz/rvFMtmEj7dFAvVZedPw6NbwcPPaMSk7qE35JYHSe3j9WJI5LddoXFIUCDVNT
         f1Tx+I0CybnPQgcuThA9eRGoQbCxkPWTSfE5SVQ79JZmiwBUYyyK92eB/CZ5zCkmkI/j
         K7CL7b7xW2UadX90Q97xFrsyeXjcVBuaPJKZui+tJ0Vgmpm32i+c7hbzwGSoLUua8pj/
         2hpw==
X-Gm-Message-State: AOAM532TV3neW43ozSwtZaDsRB9Xch2yUzel6PV0R1xtu+UNC+SygxVq
        cK0oVna41T4jwLcoYvoxUYSOsVp4gemWag==
X-Google-Smtp-Source: ABdhPJy0ph25RNcAfj2e51xE+O+1YRJAhKFlviLd+8k0r58ROgDk7BZv/XcqVGd9m28hZwq3JO8o8Q==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr17816320wru.182.1637413294039;
        Sat, 20 Nov 2021 05:01:34 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:33 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 16/20] linux/compiler.h, linux/array_size.h: Move __must_be_array() into <linux/array_size.h>
Date:   Sat, 20 Nov 2021 14:01:00 +0100
Message-Id: <20211120130104.185699-18-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 drivers/gpu/drm/i915/i915_utils.h           | 3 +++
 drivers/net/can/usb/etas_es58x/es58x_core.h | 3 +++
 include/linux/array_size.h                  | 6 +++++-
 include/linux/compiler.h                    | 3 ---
 include/linux/overflow.h                    | 3 +++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 7a5925072466..f6fc1c72dfa7 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -25,6 +25,8 @@
 #ifndef __I915_UTILS_H
 #define __I915_UTILS_H
 
+
+#include <linux/array_size.h>
 #include <linux/list.h>
 #include <linux/overflow.h>
 #include <linux/sched.h>
@@ -32,6 +34,7 @@
 #include <linux/workqueue.h>
 #include <linux/sched/clock.h>
 
+
 struct drm_i915_private;
 struct timer_list;
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 826a15871573..a18f4215aeef 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -12,6 +12,8 @@
 #ifndef __ES58X_COMMON_H__
 #define __ES58X_COMMON_H__
 
+
+#include <linux/array_size.h>
 #include <linux/types.h>
 #include <linux/usb.h>
 #include <linux/netdevice.h>
@@ -21,6 +23,7 @@
 #include "es581_4.h"
 #include "es58x_fd.h"
 
+
 /* Driver constants */
 #define ES58X_RX_URBS_MAX 5	/* Empirical value */
 #define ES58X_TX_URBS_MAX 6	/* Empirical value */
diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index cba90f2248ef..c2b4fddba564 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -2,9 +2,13 @@
 #ifndef _LINUX_ARRAY_SIZE_H
 #define _LINUX_ARRAY_SIZE_H
 
-#include <linux/compiler.h>
+#include <linux/must_be.h>
+#include <linux/same_type.h>
 
 
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a)  __must_be(!__same_type((a), &(a)[0]))
+
 /**
  * ARRAY_SIZE - get the number of elements in array @a
  * @a: array to be sized
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 64d99335874d..9286310d4a8b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -254,9 +254,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)  __must_be(!__same_type((a), &(a)[0]))
-
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4669632bd72b..12c6f736bcd0 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -2,9 +2,12 @@
 #ifndef __LINUX_OVERFLOW_H
 #define __LINUX_OVERFLOW_H
 
+
+#include <linux/array_size.h>
 #include <linux/compiler.h>
 #include <linux/limits.h>
 
+
 /*
  * We need to compute the minimum and maximum values representable in a given
  * type. These macros may also be useful elsewhere. It would seem more obvious
-- 
2.33.1

