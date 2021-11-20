Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45211457E93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhKTNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbhKTNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A5C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d5so23229779wrc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCJDVWp+LfUeimuBNI1TZC92dSp6pVADr+qyLRrwQ5M=;
        b=YmSEtXKBkH7vwyD4Qw4kuzd9vtRvFKrEnvz1eUCiQ/46cAe8ZdmA65ovgSMY+vQT9P
         FsO+9EZZ9YP3YjPlF3R7M4oKNflfsRATpS2xA2GgmV4b5bD4xv9Qnlo2L3eOgZCVx2yN
         X05Sct6RteSU1yPtjwCB2d85cG/XijUFLmPV9D3fe6BmXXhT8ZA6+w7pfRkB4fxCa7ED
         aCTAV9aYDXvxqbx24sNVdkIzDPr6wdc1rvhBfUa21jrwLv0SIXzvat9akW1PtEf8v60l
         IdXXkcN2faAFukxF/ALeGlIyxsMgy7rna+R6g2bH6ucaWuBVw6p4dyeM6grzSXNqDWus
         pS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCJDVWp+LfUeimuBNI1TZC92dSp6pVADr+qyLRrwQ5M=;
        b=1MD84cLM90k4I54Uwbd89oA+HDH8GQkC5tdjmd0wLkyvhatUAViBuAC+zSjur+psU3
         wVa6OT1buT0hLqoLsf5HL7UHIpHbssLLw1wFAvHyyFRrj0f2ebmAyX4bWsHY/bEs1+gG
         kDLPb2W56Xif/0/zOfZYoAJnszjX82vAAmW5OSKVOYt9u8GjSCxh7IODoHzto0oJKQHA
         HqaJIfeem8Xw9Nq/9XbDzD5k+c+91kLfdw4klVlcs92LbQhumwuxN/eZuhwck0rnN0UL
         ZI4VWUYMla8v1r99HBRv5AfdS85SjTFTUiA23FIngbOpdgBZrol/I9SKHa65ir8Qfs+W
         DTPQ==
X-Gm-Message-State: AOAM531yQePAE4hx4mW7Sbf/z8Uj4T11pUmNjLhMbr9acWCt11uzNjD0
        WosUDjWdUkf3kFqzPLEJKzWZs/paURgAwA==
X-Google-Smtp-Source: ABdhPJx1qxV1UCVvhYLsgMMcLoWM54Pu72mAp83J527fkT0P5UVOt2AoblLXquot26f5kCRGf7P+aw==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr18291365wrz.127.1637413280073;
        Sat, 20 Nov 2021 05:01:20 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:19 -0800 (PST)
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
Subject: [PATCH v2 02/20] linux/stddef.h, linux/sizeof_field.h: Split sizeof_field() into a separate header
Date:   Sat, 20 Nov 2021 14:00:45 +0100
Message-Id: <20211120130104.185699-3-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/sizeof_field.h> from <linux/stddef.h> for compatibility.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/sizeof_field.h | 15 +++++++++++++++
 include/linux/stddef.h       |  9 +--------
 2 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/sizeof_field.h

diff --git a/include/linux/sizeof_field.h b/include/linux/sizeof_field.h
new file mode 100644
index 000000000000..15dc10fce8f3
--- /dev/null
+++ b/include/linux/sizeof_field.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SIZEOF_FIELD_H
+#define _LINUX_SIZEOF_FIELD_H
+
+
+/**
+ * sizeof_field() - Report the size of a struct field in bytes
+ *
+ * @T: The structure containing the field of interest
+ * @m: The field (member) to return the size of
+ */
+#define sizeof_field(T, m)  sizeof((((T *)0)->m))
+
+
+#endif  /* _LINUX_SIZEOF_FIELD_H */
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 41217710788e..1be2c71c1e85 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -6,6 +6,7 @@
 #include <uapi/linux/stddef.h>
 
 #include <linux/offsetof.h>
+#include <linux/sizeof_field.h>
 
 
 #undef NULL
@@ -16,14 +17,6 @@ enum {
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

