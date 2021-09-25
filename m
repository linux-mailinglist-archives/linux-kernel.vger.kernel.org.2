Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5A41843A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhIYTno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhIYTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 15:43:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253CEC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 12:42:08 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a13so12824020qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dWLCl1Ta8aGVxDUUVFw2BPmtno28cmmgizVUy46lVL0=;
        b=HSJzzwW4BbqnMNk0XmqyowtBHwdMaqSuK8twbntIJu6nIrDNEjSyQzC9TdfMrdVkEY
         /uvsB1HqSH+UOu1/hYpXbOZdlAvD2bstmbPp/9DbcrVRZLlpyGoc8ccvni4Or4GBmerR
         YjqgIw9nkaBZ2SXLi8KBbKzoBzx0nxL+2JSGPPPp+VLqlzVZTF1kY/SQtOe5ZAE9P0Us
         /seoocJ8CUXBj9XOhohFB9rSDYKTQLayMYYVUUeMq/o/03N3gmXAHQvybMEgBT7c1QBV
         cf8rHsh0MkwdHqOBvihHJbuseq76/4vs486JZ1+IGLd0ewzpzhw2LI4aNuq4ZkpYmfQ6
         qWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dWLCl1Ta8aGVxDUUVFw2BPmtno28cmmgizVUy46lVL0=;
        b=20hX3rXgO3urHklVMG6ElT1b74BiIWNLDLABw1YlnVDf9uKnLEt9l5La1xQ5d9ubha
         624148mjQVKjYNkYMdRu78ANjFfjSyp8Cgmkm7JVzaH9UvZh1WWh+BhUZc3xlvn3lML6
         TLhFEALACAPa+mEMISEb8e6qDrevNmr0TpEP0yDVdqkSXEWtVMn53bUdFdkVx86nPs/J
         lJ48fXbWZ1kQoh1AKBRFUoRx6CTiQrwQlsMk4kMMTRCbYf/5wLOwiId4It/NWdFcDr9Q
         kVwKyxwhLGQmf51U3ht6ewg6arX7D6pu7U68Fx2F9/m/Ah2MtaQT1nUoeAgZAFqitwCq
         T/PA==
X-Gm-Message-State: AOAM530NNYmiIq2DsUnLpGHNRo24ql3dCYqs5e4IrYVuMwCd54S0seTf
        QAJUsUjPSlgCd6X9jflwZOI=
X-Google-Smtp-Source: ABdhPJwlVqco6NS7TuSV6K9+mmUYOg7WWPK3D/E/7dz7JChsO/C7vbX35HP/U7PS8ZBpq0BNXAo/kg==
X-Received: by 2002:ac8:5c8e:: with SMTP id r14mr10812550qta.37.1632598927305;
        Sat, 25 Sep 2021 12:42:07 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:95c:7f00:4a55:391d:16ef:6119])
        by smtp.gmail.com with ESMTPSA id m11sm8893162qkm.88.2021.09.25.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 12:42:07 -0700 (PDT)
Date:   Sat, 25 Sep 2021 16:42:03 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     brendanhiggins@google.com
Cc:     andy.li@unisoc.com, andersonreisrosa@gmail.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v2] kunit: mock: add support for function mocks with no
 parameters
Message-ID: <YU97ixGUTLducy0P@marsc.168.1.7>
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
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---
Not sure if we are allowed to add a Reported-by tag to credit Andy Li, so we didn't.

 include/test/mock.h    |  2 +-
 include/test/params.h  | 12 +++++++++++-
 test/mock-macro-test.c |  7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

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
index 14da7ebe752d..d97cf3642bb3 100644
--- a/test/mock-macro-test.c
+++ b/test/mock-macro-test.c
@@ -59,6 +59,8 @@ DEFINE_VOID_CLASS_MOCK_HANDLE_INDEX(METHOD(test_void_ptr_func),
 
 DEFINE_FUNCTION_MOCK(add, RETURNS(int), PARAMS(int, int));
 
+DEFINE_FUNCTION_MOCK(no_param, RETURNS(int), PARAMS());
+
 struct mock_macro_context {
 	struct MOCK(test_struct) *mock_test_struct;
 	struct MOCK(void) *mock_void_ptr;
@@ -216,8 +218,11 @@ static void mock_macro_test_generated_function_code_works(struct KUNIT_T *test)
 
 	handle = EXPECT_CALL(add(int_eq(test, 4), int_eq(test, 3)));
 	handle->action = int_return(test, 7);
-
 	EXPECT_EQ(test, 7, add(4, 3));
+
+	handle = EXPECT_CALL(no_param());
+	handle->action = int_return(test, 9);
+	EXPECT_EQ(test, 9, no_param());
 }
 
 static int mock_macro_test_init(struct KUNIT_T *test)
-- 
2.33.0

