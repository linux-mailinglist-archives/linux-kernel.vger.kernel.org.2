Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC743D4226
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhGWUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:43:36 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39481 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWUne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:43:34 -0400
Received: by mail-pl1-f182.google.com with SMTP id e5so2614654pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N38DMthYZjCTqPg2P7l8cGhAUZRCRT2NqFd5WOUTqII=;
        b=muB7avTLiyFI1VEck9J49EAkXaU7mhzzLCyPHenvCxFZd9IIYpehsKqaoCRriL73yq
         sC9N0ug7DhjUfC+zRnkYjjeExTuzhTs/o0MCIo6ibrhAzU9L8MbxqB/doqkkAELQ0x2K
         FrhCqMWl0+Y9YMVDc0Z7r+5RAM4em65VXdTmqvBtrfjxq2GMxUhyGrQeMruSlnYe2NNn
         hMZ6yb/Fuo84cjZ3crMuxpU79Vzc4cPi5I8q/9C18D5ITeaoAoSA4SmIm3wtH4MB3KVY
         R19WRglhdQXr8HH4d2yFZUXT+uZCvCg7WPP8SlJ65tv00E53dj3uU3Rdnav92I2P0vcS
         erew==
X-Gm-Message-State: AOAM533ryo2PZr2pJCbftTmbvdn0gKj7zAVU3oYjKdg0cbwgnRdV32kd
        yTG1CoSU/e4CQhQuPttFRZg=
X-Google-Smtp-Source: ABdhPJz+5Nxren+3JS04wJdw6hTGcNqRgshk0vM4ol+R6QjUIMPk38mPlql6n66R2E4ct20eCDJFGA==
X-Received: by 2002:a17:90a:fb86:: with SMTP id cp6mr15842332pjb.211.1627075447137;
        Fri, 23 Jul 2021 14:24:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:db72:85bb:463f:5c41])
        by smtp.gmail.com with ESMTPSA id w16sm39854011pgi.41.2021.07.23.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:24:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/4] kunit: Add support for suite initialization and cleanup
Date:   Fri, 23 Jul 2021 14:23:52 -0700
Message-Id: <20210723212353.896343-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210723212353.896343-1-bvanassche@acm.org>
References: <20210723212353.896343-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/kunit/test.h |  4 ++++
 lib/kunit/test.c     | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 24b40e5c160b..a6eef96a409c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -215,6 +215,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
  * @name:	the name of the test. Purely informational.
+ * @init_suite:	called once per test suite before the test cases.
+ * @exit_suite:	called once per test suite after all test cases.
  * @init:	called before every test case.
  * @exit:	called after every test case.
  * @test_cases:	a null terminated array of test cases.
@@ -229,6 +231,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 struct kunit_suite {
 	const char name[256];
+	int (*init_suite)(void);
+	void (*exit_suite)(void);
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d79ecb86ea57..c271692ced93 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -397,9 +397,19 @@ int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
+	int res = 0;
 
 	kunit_print_subtest_start(suite);
 
+	if (suite->init_suite)
+		res = suite->init_suite();
+
+	if (res < 0) {
+		kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT
+			  "# Suite initialization failed (%d)\n", res);
+		goto end;
+	}
+
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
 		test_case->status = KUNIT_SKIPPED;
@@ -439,6 +449,10 @@ int kunit_run_tests(struct kunit_suite *suite)
 				      test.status_comment);
 	}
 
+	if (suite->exit_suite)
+		suite->exit_suite();
+
+end:
 	kunit_print_subtest_end(suite);
 
 	return 0;
