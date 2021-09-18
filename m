Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF67441086A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhIRTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 15:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbhIRTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 15:45:47 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 12:44:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id ay33so28564678qkb.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rC5GjEyzVJZXdEXdii3f3/gHGylOiV4NmDN2+/G2wyI=;
        b=ao2A2sVw/JcFJm4VYUtDWrP8HrGyHx/m9F3CGuTNPrCFEKPDraRcb0dcPQIEcCQzlc
         JOwz1+2DFsHSlYXZUon1sej7A1VS8TZp3SrIJSzWL/8Hmtc21dsCIG/o7KUiZKRu/52R
         2xFlMTkUXyseLUCUJHr8Rlr6mbb/jTO4oBRs1Q2ZdtjqwnBjTV3WNoEC11z1VYU5HRL9
         8zr0E63qQ4/zUZIvH45de0xcpyko1fdD1Wsqm7aSjzAXOkYsXIlr0TGgV1STgIPPiuAu
         lh8qejuS103B+m5OOienvzrgLYk/S243Y0Bc8KAyqCr3wdU9mKA7vXj/WrV8rRzmN9m2
         iPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rC5GjEyzVJZXdEXdii3f3/gHGylOiV4NmDN2+/G2wyI=;
        b=Q5ILO532S5KG/GZIrvHxQpYpxZqzwIpEkMEzCJ510aZVTzi45M4CiS7fzb3xctyEnj
         TgT5FA0+DL/QCtZxLxpi/NVzVgoTX8RtvXKxAx0/DLtQlw914tkSz0/YfMEVeJIQw5bA
         kk+A34uH7SB2IwK4/xhWeecdn+ErkNAMTFvgJSvwOQWVwAiNXL2qwIRDyLzqrfvgiX5e
         U3OEvTdB+X5f8pV6BL3ya7GS6CekHtK5XOYKepmjvjgWBsn6H9LK0L49hX92hur1ol24
         IROh/3fy/UZIqjsfAxO4H8+psEA+XzRjlZHXB/2kJyAziFmEMPbCftvqw16HkerHOd9i
         4bLQ==
X-Gm-Message-State: AOAM532IWpAjN6xKzvTGD0PFc3ynHAZeXu5R7YOrLeP4ORK62jgQXAYX
        ii54TPZMRdo0PxLzI4cB5wSQVoaWkmY=
X-Google-Smtp-Source: ABdhPJylt0qeN0MT7JVI1XGP6XXo0e1VQCiQu9EPTuqbi+e0eG2of1xiQD3qZ04Nqp6feW/EeaI62g==
X-Received: by 2002:a37:8387:: with SMTP id f129mr16739045qkd.79.1631994260948;
        Sat, 18 Sep 2021 12:44:20 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:95c:7f00:4a55:391d:16ef:6119])
        by smtp.gmail.com with ESMTPSA id x29sm6036249qtv.74.2021.09.18.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 12:44:20 -0700 (PDT)
Date:   Sat, 18 Sep 2021 16:44:17 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     brendanhiggins@google.com
Cc:     andy.li@unisoc.com, andersonreisrosa@gmail.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH] kunit: mock: add support for function mocks with no
 parameters
Message-ID: <YUZBkZhQsF5SlcLb@marsc.168.1.7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mocks defined with DEFINE_FUNCTION_MOCK(...) do not support
empty parameters list due to strict function prototypes enforcement
(-Werror=strict-prototypes). Add support for function mocks with no
parameters by adding checks to declare strict function prototypes when
an empty param list is provided.
Further, add an expectation to test that the generated code works.

Co-developed-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
Signed-off-by: Anderson Reis Rosa <andersonreisrosa@gmail.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
We noted that the proposed changes added a few checkpatch errors.
However, as checkpatch reported the same errors for other macros at
params.h, we didn't spend a lot of time trying to find a fix for them.

We hope this may solve Bugzilla Bug 205495 
https://bugzilla.kernel.org/show_bug.cgi?id=205495

 include/test/mock.h    |  2 +-
 include/test/params.h  | 12 +++++++++++-
 test/mock-macro-test.c |  6 ++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/test/mock.h b/include/test/mock.h
index 8b8031c13b2a..c46c90abc12a 100644
--- a/include/test/mock.h
+++ b/include/test/mock.h
@@ -640,7 +640,7 @@ int mock_in_sequence(struct KUNIT_T *test, struct mock_expectation *first, ...);
 				  return_type,				       \
 				  RETURN,				       \
 				  param_types...)			       \
-		return_type name(PARAM_LIST_FROM_TYPES(param_types))	       \
+		return_type name(FUNC_PARAM_LIST_FROM_TYPES(param_types))      \
 		{							       \
 			struct mock *mock = MOCK_SOURCE(mock_source_ctx,       \
 							handle_index);	       \
diff --git a/include/test/params.h b/include/test/params.h
index 50d54035175d..ca4689dd0576 100644
--- a/include/test/params.h
+++ b/include/test/params.h
@@ -264,6 +264,11 @@
 			       not_used,				       \
 			       args)
 
+#define FUNC_PARAM_LIST_FROM_TYPES(args...)				       \
+		IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)		       \
+		IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))			       \
+		(PARAM_LIST_FROM_TYPES(args))
+
 #define PRODUCE_TYPE_NAME(context, type, index) #type
 #define TYPE_NAMES_FROM_TYPES(handle_index, args...)			       \
 		FOR_EACH_PARAM(PRODUCE_TYPE_NAME,			       \
@@ -282,12 +287,17 @@
 		IF(IS_EQUAL(index, ctrl_index))(struct mock *arg##ctrl_index)  \
 		IF(IS_NOT_EQUAL(index, ctrl_index))(			       \
 				struct mock_param_matcher *arg##index)
-#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)		       \
+#define MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args...)	       \
 		FOR_EACH_PARAM(PRODUCE_MATCHER_AND_ARG,			       \
 			       FILTER_NONE,				       \
 			       ctrl_index,				       \
 			       args)
 
+#define MATCHER_PARAM_LIST_FROM_TYPES(ctrl_index, args...)		       \
+		IF(IS_EQUAL(NUM_VA_ARGS(args), 0))(void)		       \
+		IF(IS_NOT_EQUAL(NUM_VA_ARGS(args), 0))			       \
+		(MATCHER_PARAM_LIST_FROM_TYPES_INTERNAL(ctrl_index, args))
+
 #define PRODUCE_ARG(context, type, index) arg##index
 #define ARG_NAMES_FROM_TYPES(ctrl_index, args...)			       \
 		FOR_EACH_PARAM(PRODUCE_ARG,				       \
diff --git a/test/mock-macro-test.c b/test/mock-macro-test.c
index 14da7ebe752d..91a926558551 100644
--- a/test/mock-macro-test.c
+++ b/test/mock-macro-test.c
@@ -59,6 +59,8 @@ DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
 
 DEFINE_FUNCTION_MOCK(add, RETURNS(int), PARAMS(int, int));
 
+DEFINE_FUNCTION_MOCK(no_param, RETURNS(int), PARAMS());
+
 struct mock_macro_context {
 	struct MOCK(test_struct) *mock_test_struct;
 	struct MOCK(void) *mock_void_ptr;
@@ -217,7 +219,11 @@ static void mock_macro_test_generated_function_code_works(struct KUNIT_T *test)
 	handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
 	handle->action = int_return(test, 7);
 
+	handle = EXPECT_CALL(no_param());
+	handle->action = int_return(test, 0);
+
 	EXPECT_EQ(test, 7, add(4, 3));
+	EXPECT_EQ(test, 0, no_param());
 }
 
 static int mock_macro_test_init(struct KUNIT_T *test)
-- 
2.33.0

