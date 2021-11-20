Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92D457E96
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhKTNEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbhKTNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD61C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so23137432wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wY+RvBZhM8z7hwU8AbHkFFRcpZxj2XoW6AuKi4QRJlk=;
        b=csKUwF/OlhkHvvk6t23hXWIWspnNjMv7oOAk1k1xxfT2BzymyN/vvdRF7ETmP9ebco
         ag/919p7j03I9k2V69hfKi8h0Jp36iIyDZcMYTPbwJIyssHgnxI0i3lRduDBgyBSKiE6
         wVo+P2qR4F6/bRra9Wc9xcewgQC8+xag4U+5dhcZ5iOpbSzgJHnDfpBZCck5ldR0OmG+
         mc1dN5vaX0BmVrUZlR+k1eIvgzX/O66zTtW10dL7gbx05jyT3R44B/HKu0AtGKBLKJdE
         MIKCnPpzuxOqxkdBwvoMCWBPidCZjqYNRFtxCOZHNxUTa57XzH6u6wFibsTV5e76Hnzh
         jEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wY+RvBZhM8z7hwU8AbHkFFRcpZxj2XoW6AuKi4QRJlk=;
        b=5Lp0tRKSdSs8rnZF6NMAIF65rrUZC+1mWvuq535Dk6Xc7kqr7/z3Exzb5WrgMCK882
         aR39lG/EE39OrlKYSlvL3TgSkj9FLnnm5EZ8Cs1arywqZVOM4nOEANhlZ3ccGic7Cj1k
         LGZT5UpFhbwCE+RvVcV/FHZARCedOP7QLHphoIQaDMbxGh/6+n0qO9K4octF0xz9f8Jb
         No5np9hrWzraxqG6pVy8EjDy/tPk8bDXSk1Q6+ObqQNVSOK/Fh4ADgj3lfsYEwiqaAOa
         z5gdCOumIOqkS6l4wJAL7ivHxbH74Xwr/XbC0bd53rzP30NAKfz7yPU2koz/N4QnMxuH
         0EyA==
X-Gm-Message-State: AOAM5304fIcBzDSRjASaSBvlE44HDjxUD5LFFsM1Ce4HJEHTTR/qlOVr
        qz5s9Dxo3hXiwmBF0YXgzL/QyXbtpUR2Xg==
X-Google-Smtp-Source: ABdhPJwA4L28inL0iXhjd+6nKKR4j5PxHSSt829lLIKJTqzAAUyhZCbWZBmfukUonPWKzLpiFtm/Lw==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr17080632wrs.437.1637413282678;
        Sat, 20 Nov 2021 05:01:22 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:22 -0800 (PST)
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
Subject: [PATCH v2 05/20] linux/container_of.h, linux/typeof_member.h: Split typeof_member() into a separate header
Date:   Sat, 20 Nov 2021 14:00:48 +0100
Message-Id: <20211120130104.185699-6-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/typeof_member.h> from <linux/container_of.h> for compatibility.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h  | 3 ++-
 include/linux/typeof_member.h | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/typeof_member.h

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 2f4944b791b8..220990db7b61 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -2,10 +2,11 @@
 #ifndef _LINUX_CONTAINER_OF_H
 #define _LINUX_CONTAINER_OF_H
 
+
 #include <linux/build_bug.h>
 #include <linux/err.h>
+#include <linux/typeof_member.h>
 
-#define typeof_member(T, m)	typeof(((T*)0)->m)
 
 /**
  * container_of - cast a member of a structure out to the containing structure
diff --git a/include/linux/typeof_member.h b/include/linux/typeof_member.h
new file mode 100644
index 000000000000..1f3bfb3c17d2
--- /dev/null
+++ b/include/linux/typeof_member.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TYPEOF_MEMBER_H
+#define _LINUX_TYPEOF_MEMBER_H
+
+
+#define typeof_member(T, m)  typeof(((T *)0)->m)
+
+
+#endif	/* _LINUX_TYPEOF_MEMBER_H */
-- 
2.33.1

