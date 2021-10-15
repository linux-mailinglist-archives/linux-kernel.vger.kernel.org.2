Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17D42ED15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhJOJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbhJOJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:07:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A023DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:05:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so39320894lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmzSrjTAZEQ7N3R2i2Z86dnNVR/pshIwOWi26WbD4R0=;
        b=OXrBFUPYT5iXWiAtLLHhBy7KA/lg9vqaQ4jvCMSvyFgtnq5wdPw3ORmv8IYKQglzJQ
         KJSYvutHRRjpXPYPUua+Bd64k0nlsvuczjMXRCE6DEx0yjDLHxj0PUNHqZSllUwJawXE
         2W1W/G8Wr3Zx1iLn9mToAIvsEbMNP4+nsBpGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmzSrjTAZEQ7N3R2i2Z86dnNVR/pshIwOWi26WbD4R0=;
        b=GHCkdKNE91g4xInD2GCyGSJaEfId2pxVAmgTpzFvgc2kNYhljbS7A7AefeV+p0U4oF
         Qf2O4Cchn6NjPxNuXouL7Nbb7viuoMIw2k8ceAvhFDLP7wnkKghAfk199/1WmIsGU4sY
         L8yzASz3JUpIbNLuQb4lhw//7QCUTzYkQvbMVZVlUryS3GE1zrtKL5JwPGMsoB5i/sBY
         ixm2aXpiwxXDBvpGLSvH7UdoKNbfQPKz9HEr1pC1cybFKCD/sRpkT8BktGSaZWMDIhep
         2iPrKSJ7lVDAKwyUyWWlgWdWmCX8EcnMjwFenM8N9wSSlu8aZzAWZ0bcCkF4bMV0keJT
         V/Ww==
X-Gm-Message-State: AOAM532Rwk+WIHD56D1Gi8s5ESgDIweMbDltNyJidfM0+tadEbNFrpig
        AB5iQPktVyWiKEBlsjaBtei0zw==
X-Google-Smtp-Source: ABdhPJxyKQlE5zcgtUlqEhvFs/tAugf+7V2YEmfP278GklO7ekewZIRLa0CPWQgAZL5zzZsDmIlSwA==
X-Received: by 2002:a05:6512:338b:: with SMTP id h11mr10530600lfg.310.1634288736951;
        Fri, 15 Oct 2021 02:05:36 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v12sm491708ljp.124.2021.10.15.02.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:05:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     akpm@linux-foundation.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] linux/container_of.h: switch to static_assert
Date:   Fri, 15 Oct 2021 11:05:30 +0200
Message-Id: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_Static_assert() is evaluated already in the compiler's frontend, and
gives a somehat more to-the-point error, compared to the BUILD_BUG_ON
macro, which only fires after the optimizer has had a chance to
eliminate calls to functions marked with
__attribute__((error)). In theory, this might make builds a tiny bit
faster.

There's also a little less gunk in the error message emitted:

lib/sort.c: In function ‘foo’:
./include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)

compared to

lib/sort.c: In function ‘foo’:
././include/linux/compiler_types.h:322:38: error: call to ‘__compiletime_assert_2’ declared with attribute error: pointer type mismatch in container_of()
  322 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

While at it, fix the copy-pasto in container_of_safe().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
akpm: This is obviously on top of Andy's kernel.h splitup series, so
should go along with those if acked.

 include/linux/container_of.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index dd56019838c6..2f4944b791b8 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -16,9 +16,9 @@
  */
 #define container_of(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
-			 !__same_type(*(ptr), void),			\
-			 "pointer type mismatch in container_of()");	\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
 
 /**
@@ -31,9 +31,9 @@
  */
 #define container_of_safe(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
-			 !__same_type(*(ptr), void),			\
-			 "pointer type mismatch in container_of()");	\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of_safe()");	\
 	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
 		((type *)(__mptr - offsetof(type, member))); })
 
-- 
2.31.1

