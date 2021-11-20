Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC8457E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbhKTNEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbhKTNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so9602363wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJrSVpQsBXRy/vyICokdXjsFuRkYeGF0hlXqz2QbRmQ=;
        b=nstFNt8oh/B3ZtE+PlYkHRB7TlIQFw9uxuYvr/WrnaOH4OdrBctXXJx7K/9bf7FRjO
         z234yoDBU7j20k5JAaRDgjBhbh0COVurdRqeHv5gfgtOcMOpI4fy52IoUm7m63qdQj4a
         K1xtKmFnkGabdKmzb6JBk+fkpIT7Bwd7udpD2VY7Yg5UZ2Iv9ro8aONsoBFyidWRXSNs
         hzIEjFm5lFQtbkFQifJdsZvVqGzoZz8fAsrS7hOq7yD14sK4/PsUAAGEjIG5MN4YkSWk
         8E70As2JpUbfc3c+Q6tPZLnRe+Cv5qeDy52x86470Q3kcNebGXGZkie718Qi3DWf33j4
         m5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJrSVpQsBXRy/vyICokdXjsFuRkYeGF0hlXqz2QbRmQ=;
        b=piGOZcErxKu3ItVDY4sC05Ho3Va77Jw5XftYM/FScFX5DF+XFplJiV1lxcaKdx0wzg
         w38XdeVE9yoDZmcQM5XBsi+ajaIa7qK3CgMXelm2QNte8S99Wp/Wu4fl2N/1OFALZ+/l
         +zdxH22AeADr1PjEENeb44RuSMxGWGLbbYxVIhhTnaTl5+Ae0nVaqu3coHx3K3GKGZNV
         0mCvzWEeQcsQ61UeAEzfUx9igI9zP+2sTZ919v+C9+eLqRpy8rjB6D/fWzyO7voa13gT
         YopAPBgy+xQNaA4+x4YKlbUPwZoCgyTs0sKrODbuRpc1HoihbHFvP/ljn7Q51NdsWHwV
         tOlA==
X-Gm-Message-State: AOAM53309BmPIFvmBPF8I8nyclKbgHhK2qLpvnSbMPryavdinaSFGIMM
        69LErZycxSf27X9b13/CcXJgIW8x9Vo1EA==
X-Google-Smtp-Source: ABdhPJy7/yyrWv30zP2M+qGo/HFoEORyhty/layGqytbRUNRWzDds4oAgA/mbT28OlrRmp+pzk7VvA==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr10075910wmj.55.1637413286298;
        Sat, 20 Nov 2021 05:01:26 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:26 -0800 (PST)
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
Subject: [PATCH v2 09/20] Implement offsetof(), sizeof_member(), typeof_member(), and container_of() in terms of memberof()
Date:   Sat, 20 Nov 2021 14:00:52 +0100
Message-Id: <20211120130104.185699-10-alx.manpages@gmail.com>
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
 include/linux/container_of.h  | 3 ++-
 include/linux/offsetof.h      | 4 +++-
 include/linux/sizeof_field.h  | 5 ++++-
 include/linux/typeof_member.h | 5 ++++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 03809348f333..d1a66e72d246 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -5,6 +5,7 @@
 
 #include <linux/build_bug.h>
 #include <linux/err.h>
+#include <linux/memberof.h>
 #include <linux/typeof_member.h>
 
 
@@ -17,7 +18,7 @@
  */
 #define container_of(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+	static_assert(__same_type(*(ptr), memberof(type, member)) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
diff --git a/include/linux/offsetof.h b/include/linux/offsetof.h
index 3db431197687..656c758479e8 100644
--- a/include/linux/offsetof.h
+++ b/include/linux/offsetof.h
@@ -5,12 +5,14 @@
 
 #include <uapi/linux/stddef.h>
 
+#include <linux/memberof.h>
+
 
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(T, m)	__compiler_offsetof(T, m)
 #else
-#define offsetof(T, m)	((size_t)&((T *)0)->m)
+#define offsetof(T, m)	((size_t)&memberof(T, m))
 #endif
 
 
diff --git a/include/linux/sizeof_field.h b/include/linux/sizeof_field.h
index 15dc10fce8f3..a64accc76055 100644
--- a/include/linux/sizeof_field.h
+++ b/include/linux/sizeof_field.h
@@ -3,13 +3,16 @@
 #define _LINUX_SIZEOF_FIELD_H
 
 
+#include <linux/memberof.h>
+
+
 /**
  * sizeof_field() - Report the size of a struct field in bytes
  *
  * @T: The structure containing the field of interest
  * @m: The field (member) to return the size of
  */
-#define sizeof_field(T, m)  sizeof((((T *)0)->m))
+#define sizeof_field(T, m)  sizeof(memberof(T, m))
 
 
 #endif  /* _LINUX_SIZEOF_FIELD_H */
diff --git a/include/linux/typeof_member.h b/include/linux/typeof_member.h
index 1f3bfb3c17d2..529535a55d40 100644
--- a/include/linux/typeof_member.h
+++ b/include/linux/typeof_member.h
@@ -3,7 +3,10 @@
 #define _LINUX_TYPEOF_MEMBER_H
 
 
-#define typeof_member(T, m)  typeof(((T *)0)->m)
+#include <linux/memberof.h>
+
+
+#define typeof_member(T, m)  typeof(memberof(T, m))
 
 
 #endif	/* _LINUX_TYPEOF_MEMBER_H */
-- 
2.33.1

