Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D231457E94
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbhKTNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKTNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E814C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d5so23229820wrc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvnMcVzqsJomac+c5bPVU0U/lP5KZnQNqNbzt61DL0c=;
        b=jmYNl+132iS91vDenW3H5rJcXOmj4SfgAYrhLimq3j8y102gqoHjz+9S5ubzGMA43D
         MmW4+dB3OjGFmh5wsQce5I+aKZpx+4GHuItrbncdqnfXCkENKIGEL7WfQfMPNUgZL5GK
         RIbssylBCeNUe4yGkv7ngTokENVkIEsoEDdS8CROavcSR9/7gdPMcjOhUCjAMExHOrEX
         GNz40qj+EzXNMc4qGJ+qv5pKnfamC2ZA1N3X5oS+TZAtyRW2TyuDE067aI7Hmoz/tOkn
         5toUWzoE8bm0bxoFsaOlNtNrbLgfBogJlwDQsnYuSiD1e6hPn/l3pCV73XS1R0yJ5pvt
         m2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvnMcVzqsJomac+c5bPVU0U/lP5KZnQNqNbzt61DL0c=;
        b=4//gFFlhrMVmHG49yDLfJpnuZ+zmDZInlu6397W5XLoHMQz5jpPeirFxWknsNWdkll
         mhOR5wKIGGuy38cfyZ1vFCMRhEskXCEhC0YphypzGTQKiwgWl9+dzwwUiPMyPIbgFCPg
         OnEo3A/QKdORwGKjqJkPt4IKePspUPaSCrUVlJ1Sb5jFLgPCbQ1UBE4B//PhDZwn/zLD
         TvskgEJijUSwOcPE85cXXZMAZtNH1zLsVhEAclwgquSR10wtmvkZryp25RKfvMX51kMK
         hgT1AzrhJofkQjaLQ9wgUu8xlFWliqirAODcios4n8kZ9cPxNAOoXL7yWR4guMQN+5ad
         q9jQ==
X-Gm-Message-State: AOAM530ND8YsD0EHrzDFHr/YDYgmd5AG4A+iK8nv5v8a23onUUTZaiMc
        t3XO+O7UOWSWYd1NMAtCZX+7XyfoCm/htA==
X-Google-Smtp-Source: ABdhPJxBOiFpKdxbSUTahvKZuvooXmnZaHlkJGBLjlidkyX9pHClLarguUCX0d2qk/dEofadPQVxZg==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr17415676wrm.288.1637413280980;
        Sat, 20 Nov 2021 05:01:20 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:20 -0800 (PST)
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
Subject: [PATCH v2 03/20] linux/stddef.h, linux/offsetofend.h: Split offsetofend() into a separate header
Date:   Sat, 20 Nov 2021 14:00:46 +0100
Message-Id: <20211120130104.185699-4-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/offsetofend.h> from <linux/stddef.h> for compatibility.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/offsetofend.h | 19 +++++++++++++++++++
 include/linux/stddef.h      | 10 +---------
 2 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/offsetofend.h

diff --git a/include/linux/offsetofend.h b/include/linux/offsetofend.h
new file mode 100644
index 000000000000..20fe2905629d
--- /dev/null
+++ b/include/linux/offsetofend.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OFFSETOFEND_H
+#define _LINUX_OFFSETOFEND_H
+
+
+#include <linux/offsetof.h>
+#include <linux/sizeof_field.h>
+
+
+/**
+ * offsetofend() - Report the offset of a struct field within the struct
+ *
+ * @T: The type of the structure
+ * @m: The member within the structure to get the end offset of
+ */
+#define offsetofend(T, m)  (offsetof(T, m) + sizeof_field(T, m))
+
+
+#endif  /* _LINUX_OFFSETOFEND_H */
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 1be2c71c1e85..c2e7e5051ef3 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -6,6 +6,7 @@
 #include <uapi/linux/stddef.h>
 
 #include <linux/offsetof.h>
+#include <linux/offsetofend.h>
 #include <linux/sizeof_field.h>
 
 
@@ -17,15 +18,6 @@ enum {
 	true	= 1
 };
 
-/**
- * offsetofend() - Report the offset of a struct field within the struct
- *
- * @TYPE: The type of the structure
- * @MEMBER: The member within the structure to get the end offset of
- */
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
-
 /**
  * struct_group() - Wrap a set of declarations in a mirrored struct
  *
-- 
2.33.1

