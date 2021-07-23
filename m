Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FED3D42CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhGWVj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhGWVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:39:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C989C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:19:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a9so4134707pjw.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jlmstEu066pP3YhxC79bMGS+VilIbwFqztm27jrw3Q=;
        b=lUnEi8nS/vJ7VDO+BFSCYYitcL5nuSPI8LUT00Ru5vAPcm8Cx0YkaUc9J7fsSun5V9
         WRNWkeB72UFKtrjDeLmtQNTtaXOQuIhVRVsddrhRXTwRuLLE4jQhKYwhcHsgdWjedEmc
         VOmNUEHmLxv9V3uuyD0528AGh+HLfr0HgQiBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jlmstEu066pP3YhxC79bMGS+VilIbwFqztm27jrw3Q=;
        b=avqjQhYrQWJBgencZfscmrvqqQGgc/5Nj6Hypzy/n4ELNZ9BHDaPTfz5OYVVOMet9W
         mmrMgtLrEC9WgCapUk5yDx5cYKe7BvfjTuRgRKrgKQYBMEsJBH9pJ1TgP10MT5DQp6sy
         3/NNNV1I0g7LVL4TyNU85avccUwuMZ8dmkyyxiV0MuAG39fMzXFfHe66jCYWL2ig/kNs
         NqbmxAmue031963O7T/wN58sqGyYU9A6kH1LMNfa4W6DxZ19yCOWcfSledA4ZfPS0OHG
         5lB72a7rHXWHXRg69dFr60hJ+0CjbY/LFmm+W6gpiUNJYfPiqwIsIEceF5agpW9Rc7Km
         h8Lg==
X-Gm-Message-State: AOAM530rQjGJ/btncPygct3JVmL+PQBxN2geg1M4y5ZtXk2dVh4Zn0Lx
        RCh02da6GSaaQkk2GDKr11I0tQ==
X-Google-Smtp-Source: ABdhPJwVXFjy1JsasmHU37scw7ue+zpgc6v4ciHaZX3Fc+ofmlbRTbg5OCQuIrntdNTMDCQvNdyMOw==
X-Received: by 2002:a63:e303:: with SMTP id f3mr6919250pgh.182.1627078778494;
        Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c83sm10000215pfb.164.2021.07.23.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 3/3] lib/test_stackinit: Add assigned initializers
Date:   Fri, 23 Jul 2021 15:19:33 -0700
Message-Id: <20210723221933.3431999-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723221933.3431999-1-keescook@chromium.org>
References: <20210723221933.3431999-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10668; h=from:subject; bh=iSWxOlmNCNs49bxDVuNh5+ox7FP0jGMOAHrRoZMp1Is=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg+0B0yxWnqV76KYZVdMeLp4ig/EkFDYYZ+hdxYm1i 2tscz4WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPtAdAAKCRCJcvTf3G3AJlXrEA CqEMrJR5oToO6R8s6RLJCMGiY+sBN8OzhepMCsQnJvPRbvauJIOCkMHmEzm83M5wFzrBwT3QMbz304 51x9i80nUc5l2JR25l/3bqiekAiYG3rjNrm3md3smGbBrPGmXES+HaGsEBNHGJfb21jRYePgtuszfw +qAxx10xERr+PXpt1kiHTXvJir6xJ8NoapOSQn7Tv1CVSpMvbqMfiBFMJe88LOy3NGaHw1UlahEWyQ hSBsC8jBFPjUHQ7ibEl3obvlzS/nL42E4vS74u+cfpSABEPfXxF1DtpPaw/hL3mOLaMadurPyP7pjZ J884fwUBhqp363edzsQAaQIX2DCRlVdE/hnX3QgzwTvcE+4qUObnfCkqYHG+slKTd26z+8T6PwrG8w nUoc2b9z8QtdisM0nymzUdisEWqScxKhQXeO+jvYrm/R/7VCQTJc5V9OECdxfg3TBtykmQqo72Otlz HmHTGec/UYQUZhPQVWuIZC6CqH7inykhkFrg+nugKFi4oTHRkccwSNslCQ84yDh/ie4WLTt632/YHE Wng30pAHZp7H5L3dempmf1yxtM0+/2J6cDyHBSlMMRTMGHtdnVyRHsTQ+Vbrt2/9XfDGD+2C9e8iyk K6XSGKKib/Alj10qBdiREbqUF4iY2fhgR1+tfK6V/S46oGKbdCyJVUZyFkBQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whole-variable assignments of cast static initializers. These appear
to currently behave like the direct initializers, but best to check them
too. For example:

	struct test_big_hole var;
	var = (struct test_big_hole){
		.one = arg->one,
		.two= arg->two,
		.three = arg->three,
		.four = arg->four };

Additionally adds a test for whole-object assignment, which is expected
to fail since it usually falls back to a memcpy():

	var = *arg;

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_stackinit.c | 169 +++++++++++++++++++++++++++++--------------
 1 file changed, 114 insertions(+), 55 deletions(-)

diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index e2713b639873..05f6dc8486c7 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -94,6 +94,10 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
 	return false;
 }
 
+/* Whether the test is expected to fail. */
+#define WANT_SUCCESS				0
+#define XFAIL					1
+
 #define DO_NOTHING_TYPE_SCALAR(var_type)	var_type
 #define DO_NOTHING_TYPE_STRING(var_type)	void
 #define DO_NOTHING_TYPE_STRUCT(var_type)	void
@@ -119,34 +123,74 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
 #define INIT_CLONE_STRING		[FILL_SIZE_STRING]
 #define INIT_CLONE_STRUCT		/**/
 
-#define INIT_SCALAR_none		/**/
-#define INIT_SCALAR_zero		= 0
+#define ZERO_CLONE_SCALAR(zero)		memset(&(zero), 0x00, sizeof(zero))
+#define ZERO_CLONE_STRING(zero)		memset(&(zero), 0x00, sizeof(zero))
+/*
+ * For the struct, intentionally poison padding to see if it gets
+ * copied out in direct assignments.
+ * */
+#define ZERO_CLONE_STRUCT(zero)				\
+	do {						\
+		memset(&(zero), 0xFF, sizeof(zero));	\
+		zero.one = 0;				\
+		zero.two = 0;				\
+		zero.three = 0;				\
+		zero.four = 0;				\
+	} while (0)
+
+#define INIT_SCALAR_none(var_type)	/**/
+#define INIT_SCALAR_zero(var_type)	= 0
 
-#define INIT_STRING_none		[FILL_SIZE_STRING] /**/
-#define INIT_STRING_zero		[FILL_SIZE_STRING] = { }
+#define INIT_STRING_none(var_type)	[FILL_SIZE_STRING] /**/
+#define INIT_STRING_zero(var_type)	[FILL_SIZE_STRING] = { }
 
-#define INIT_STRUCT_none		/**/
-#define INIT_STRUCT_zero		= { }
-#define INIT_STRUCT_static_partial	= { .two = 0, }
-#define INIT_STRUCT_static_all		= { .one = 0,			\
-					    .two = 0,			\
-					    .three = 0,			\
-					    .four = 0,			\
+#define INIT_STRUCT_none(var_type)	/**/
+#define INIT_STRUCT_zero(var_type)	= { }
+
+
+#define __static_partial		{ .two = 0, }
+#define __static_all			{ .one = 0,			\
+					  .two = 0,			\
+					  .three = 0,			\
+					  .four = 0,			\
 					}
-#define INIT_STRUCT_dynamic_partial	= { .two = arg->two, }
-#define INIT_STRUCT_dynamic_all		= { .one = arg->one,		\
-					    .two = arg->two,		\
-					    .three = arg->three,	\
-					    .four = arg->four,		\
+#define __dynamic_partial		{ .two = arg->two, }
+#define __dynamic_all			{ .one = arg->one,		\
+					  .two = arg->two,		\
+					  .three = arg->three,		\
+					  .four = arg->four,		\
 					}
-#define INIT_STRUCT_runtime_partial	;				\
-					var.two = 0
-#define INIT_STRUCT_runtime_all		;				\
-					var.one = 0;			\
+#define __runtime_partial		var.two = 0
+#define __runtime_all			var.one = 0;			\
 					var.two = 0;			\
 					var.three = 0;			\
 					var.four = 0
 
+#define INIT_STRUCT_static_partial(var_type)				\
+					= __static_partial
+#define INIT_STRUCT_static_all(var_type)				\
+					= __static_all
+#define INIT_STRUCT_dynamic_partial(var_type)				\
+					= __dynamic_partial
+#define INIT_STRUCT_dynamic_all(var_type)				\
+					= __dynamic_all
+#define INIT_STRUCT_runtime_partial(var_type)				\
+					; __runtime_partial
+#define INIT_STRUCT_runtime_all(var_type)				\
+					; __runtime_all
+
+#define INIT_STRUCT_assigned_static_partial(var_type)			\
+					; var = (var_type)__static_partial
+#define INIT_STRUCT_assigned_static_all(var_type)			\
+					; var = (var_type)__static_all
+#define INIT_STRUCT_assigned_dynamic_partial(var_type)			\
+					; var = (var_type)__dynamic_partial
+#define INIT_STRUCT_assigned_dynamic_all(var_type)			\
+					; var = (var_type)__dynamic_all
+
+#define INIT_STRUCT_assigned_copy(var_type)				\
+					; var = *(arg)
+
 /*
  * @name: unique string name for the test
  * @var_type: type to be tested for zeroing initialization
@@ -166,7 +210,7 @@ static noinline __init int test_ ## name (void)			\
 	BUILD_BUG_ON(sizeof(zero) > MAX_VAR_SIZE);		\
 								\
 	/* Fill clone type with zero for per-field init. */	\
-	memset(&zero, 0x00, sizeof(zero));			\
+	ZERO_CLONE_ ## which(zero);				\
 	/* Clear entire check buffer for 0xFF overlap test. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Fill stack with 0xFF. */				\
@@ -209,7 +253,7 @@ static noinline __init int test_ ## name (void)			\
 		return (xfail) ? 0 : 1;				\
 	}							\
 }
-#define DEFINE_TEST(name, var_type, which, init_level)		\
+#define DEFINE_TEST(name, var_type, which, init_level, xfail)	\
 /* no-op to force compiler into ignoring "uninitialized" vars */\
 static noinline __init DO_NOTHING_TYPE_ ## which(var_type)	\
 do_nothing_ ## name(var_type *ptr)				\
@@ -225,7 +269,8 @@ static noinline __init int leaf_ ## name(unsigned long sp,	\
 					 var_type *arg)		\
 {								\
 	char buf[VAR_BUFFER];					\
-	var_type var INIT_ ## which ## _ ## init_level;		\
+	var_type var						\
+		INIT_ ## which ## _ ## init_level(var_type);	\
 								\
 	target_start = &var;					\
 	target_size = sizeof(var);				\
@@ -251,7 +296,7 @@ static noinline __init int leaf_ ## name(unsigned long sp,	\
 								\
 	return (int)buf[0] | (int)buf[sizeof(buf) - 1];		\
 }								\
-DEFINE_TEST_DRIVER(name, var_type, which, 0)
+DEFINE_TEST_DRIVER(name, var_type, which, xfail)
 
 /* Structure with no padding. */
 struct test_packed {
@@ -295,42 +340,50 @@ struct test_user {
 	unsigned long four;
 };
 
-#define DEFINE_SCALAR_TEST(name, init)				\
-		DEFINE_TEST(name ## _ ## init, name, SCALAR, init)
+#define DEFINE_SCALAR_TEST(name, init, xfail)			\
+		DEFINE_TEST(name ## _ ## init, name, SCALAR,	\
+			    init, xfail)
 
-#define DEFINE_SCALAR_TESTS(init)				\
-		DEFINE_SCALAR_TEST(u8, init);			\
-		DEFINE_SCALAR_TEST(u16, init);			\
-		DEFINE_SCALAR_TEST(u32, init);			\
-		DEFINE_SCALAR_TEST(u64, init);			\
-		DEFINE_TEST(char_array_ ## init, unsigned char, STRING, init)
+#define DEFINE_SCALAR_TESTS(init, xfail)			\
+		DEFINE_SCALAR_TEST(u8, init, xfail);		\
+		DEFINE_SCALAR_TEST(u16, init, xfail);		\
+		DEFINE_SCALAR_TEST(u32, init, xfail);		\
+		DEFINE_SCALAR_TEST(u64, init, xfail);		\
+		DEFINE_TEST(char_array_ ## init, unsigned char,	\
+			    STRING, init, xfail)
 
-#define DEFINE_STRUCT_TEST(name, init)				\
+#define DEFINE_STRUCT_TEST(name, init, xfail)			\
 		DEFINE_TEST(name ## _ ## init,			\
-			    struct test_ ## name, STRUCT, init)
+			    struct test_ ## name, STRUCT, init, \
+			    xfail)
+
+#define DEFINE_STRUCT_TESTS(init, xfail)			\
+		DEFINE_STRUCT_TEST(small_hole, init, xfail);	\
+		DEFINE_STRUCT_TEST(big_hole, init, xfail);	\
+		DEFINE_STRUCT_TEST(trailing_hole, init, xfail);	\
+		DEFINE_STRUCT_TEST(packed, init, xfail)
 
-#define DEFINE_STRUCT_TESTS(init)				\
-		DEFINE_STRUCT_TEST(small_hole, init);		\
-		DEFINE_STRUCT_TEST(big_hole, init);		\
-		DEFINE_STRUCT_TEST(trailing_hole, init);	\
-		DEFINE_STRUCT_TEST(packed, init)
+#define DEFINE_STRUCT_INITIALIZER_TESTS(base)			\
+		DEFINE_STRUCT_TESTS(base ## _ ## partial,	\
+				    WANT_SUCCESS);		\
+		DEFINE_STRUCT_TESTS(base ## _ ## all,		\
+				    WANT_SUCCESS)
 
 /* These should be fully initialized all the time! */
-DEFINE_SCALAR_TESTS(zero);
-DEFINE_STRUCT_TESTS(zero);
-/* Static initialization: padding may be left uninitialized. */
-DEFINE_STRUCT_TESTS(static_partial);
-DEFINE_STRUCT_TESTS(static_all);
-/* Dynamic initialization: padding may be left uninitialized. */
-DEFINE_STRUCT_TESTS(dynamic_partial);
-DEFINE_STRUCT_TESTS(dynamic_all);
-/* Runtime initialization: padding may be left uninitialized. */
-DEFINE_STRUCT_TESTS(runtime_partial);
-DEFINE_STRUCT_TESTS(runtime_all);
+DEFINE_SCALAR_TESTS(zero, WANT_SUCCESS);
+DEFINE_STRUCT_TESTS(zero, WANT_SUCCESS);
+/* Struct initializers: padding may be left uninitialized. */
+DEFINE_STRUCT_INITIALIZER_TESTS(static);
+DEFINE_STRUCT_INITIALIZER_TESTS(dynamic);
+DEFINE_STRUCT_INITIALIZER_TESTS(runtime);
+DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static);
+DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic);
+DEFINE_STRUCT_TESTS(assigned_copy, XFAIL);
 /* No initialization without compiler instrumentation. */
-DEFINE_SCALAR_TESTS(none);
-DEFINE_STRUCT_TESTS(none);
-DEFINE_TEST(user, struct test_user, STRUCT, none);
+DEFINE_SCALAR_TESTS(none, WANT_SUCCESS);
+DEFINE_STRUCT_TESTS(none, WANT_SUCCESS);
+/* Initialization of members with __user attribute. */
+DEFINE_TEST(user, struct test_user, STRUCT, none, WANT_SUCCESS);
 
 /*
  * Check two uses through a variable declaration outside either path,
@@ -393,8 +446,8 @@ static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
  * non-code areas (i.e. in a switch statement before the first "case").
  * https://bugs.llvm.org/show_bug.cgi?id=44916
  */
-DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, 1);
-DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, 1);
+DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, XFAIL);
+DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, XFAIL);
 
 static int __init test_stackinit_init(void)
 {
@@ -420,12 +473,18 @@ static int __init test_stackinit_init(void)
 	test_structs(zero);
 	/* Padding here appears to be accidentally always initialized? */
 	test_structs(dynamic_partial);
+	test_structs(assigned_dynamic_partial);
 	/* Padding initialization depends on compiler behaviors. */
 	test_structs(static_partial);
 	test_structs(static_all);
 	test_structs(dynamic_all);
 	test_structs(runtime_partial);
 	test_structs(runtime_all);
+	test_structs(assigned_static_partial);
+	test_structs(assigned_static_all);
+	test_structs(assigned_dynamic_all);
+	/* Everything fails this since it effectively performs a memcpy(). */
+	test_structs(assigned_copy);
 
 	/* STRUCTLEAK_BYREF_ALL should cover everything from here down. */
 	test_scalars(none);
-- 
2.30.2

