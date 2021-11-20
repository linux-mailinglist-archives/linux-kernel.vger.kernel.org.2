Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D60457EA0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhKTNE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhKTNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C38C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so9634644wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2lfsA3Fvpb/Cxby+cdskfb6kT3yvG/CQtySJQgLxnI=;
        b=j8UFZ+mOX4jGvZK6Pgd5WqG/D6PLItPIr6A0ETY0HJLLG6ONm5ISOe9MlcPwTMD1jX
         EE+eXPOSc07PEqQLTZE43IzzkKIb2QcRG7ziOk2w7AhukVfP3nGtHEIv6JhHKaKuTMS2
         mUuUIAERDdFHa58LZomJdWhbbnmKi8kPpHzv3plnmcl9owsESGELLwDfyolc62suD8/c
         yyuWDS5dyXh9nqksODuiDbnvDALXNvxaXuQ4yMqQrfy4flcA9hL0wIOO1nh2P2vhCDz6
         eCJuv/PKqayLH9WB00KBul5ed0C0RpnJHAgpi+Jk32FXQOcsYerXOs7ZYjl3uOtYhYky
         aaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2lfsA3Fvpb/Cxby+cdskfb6kT3yvG/CQtySJQgLxnI=;
        b=XzeuPupNS/kG9T4/rQW/KxIpawgAoCZRdzAQGZxBSB6i6662Nt/MBSUxNMvoKbc9ao
         PqaJvOO/63z9jzJe2bWrfIVzYOkvhK7/u8Z4NLvo0L/x8nk2pkNr035AHimZOG46rjYS
         8lLnrPo5/yaXL2EqB3KK7gcU2+gAJSZnw09fMrVi1sObddwiuLvKsej20Dtyj43lA7G8
         sUmjLLx3xa022bqHNp7gC94EkEe3inv+SqiyNMLSAFBREGHG1ub+baxhgzG7DgBzpPKg
         t7j9pfAvD2EmPTg03MA8rIV/91oAJRITWH4k94AmTLS0tnTTb0A1w1lN2HnzPNWJ5gf4
         F21Q==
X-Gm-Message-State: AOAM531U36ycCXX861HKR3kyeeGaqk4Vl1TzXZvmQMZrRLuhgR3Mgjga
        wIC6ogXo6oSrNWsBUMfuZabhDzynjFKcdQ==
X-Google-Smtp-Source: ABdhPJwqoEoXJj1i+JopeV+kxzab3ihxzmDPHguAXpxVm4usRWPW/pmObsqkyALWDOX6irzPhFNIBg==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr10015707wmq.138.1637413292315;
        Sat, 20 Nov 2021 05:01:32 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:32 -0800 (PST)
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
Subject: [PATCH v2 14/20] linux/compiler_types.h, linux/same_type.h: Split __same_type() to a separate header
Date:   Sat, 20 Nov 2021 14:00:58 +0100
Message-Id: <20211120130104.185699-16-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/same_type.h> from <linux/compiler_types.h> for compatibility.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/compiler_types.h |  7 ++++---
 include/linux/same_type.h      | 10 ++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/same_type.h

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1d32f4c03c9e..5a1626e2d331 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -2,6 +2,10 @@
 #ifndef __LINUX_COMPILER_TYPES_H
 #define __LINUX_COMPILER_TYPES_H
 
+
+#include <linux/same_type.h>
+
+
 #ifndef __ASSEMBLY__
 
 #ifdef __CHECKER__
@@ -272,9 +276,6 @@ struct ftrace_likely_data {
 #define asm_inline asm
 #endif
 
-/* Are two types/vars the same type (ignoring qualifiers)? */
-#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
-
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
diff --git a/include/linux/same_type.h b/include/linux/same_type.h
new file mode 100644
index 000000000000..2e45edda6d31
--- /dev/null
+++ b/include/linux/same_type.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SAME_TYPE_H
+#define __LINUX_SAME_TYPE_H
+
+
+/* Are two types/vars the same type (ignoring qualifiers)? */
+#define __same_type(a, b)  __builtin_types_compatible_p(typeof(a), typeof(b))
+
+
+#endif /* __LINUX_SAME_TYPE_H */
-- 
2.33.1

