Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626DD41127C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhITKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhITKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:03:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C2260240;
        Mon, 20 Sep 2021 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632132096;
        bh=4gD2TQrQ9ZQPtwTDSOABdc4IqZHTrav1yleSQy9Mgsg=;
        h=From:To:Cc:Subject:Date:From;
        b=OlPgtVP0ASanA3SKCfhRBq5E40+FCybrysC/24NG3R047YblWuao+S4eIPN4P9GnM
         otbP72YvfPrmvSKSTEhDpObFdm3hz8SP2mQBaZ52ZDsT+xkwD0CbvF60eueSY71SJp
         HdBFgM926vdsfrBjvC3MKGZCSdVcGhBtmlwphfnKya1m34IqohiZlAWwwWP//ycKzR
         P+VeQjD7FL/KSdVvRPcqqfzxQ2G3pSt/y7xe3NhlMckwtvclJBN567WSEzwEZEWOR9
         0dFaen5gDyESmYzGtXt7sTpWkKdDumTRyLBkhXERQiK0o7pdcsGMcETyU+oC3V3c5C
         JOsn4NYsjwFRw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: fix stringop-overread warning in kunit test
Date:   Mon, 20 Sep 2021 12:01:23 +0200
Message-Id: <20210920100132.1390409-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 points out that strnlen() with a fixed length on a constant
input makes no sense:

In file included from mm/damon/dbgfs.c:623:
mm/damon/dbgfs-test.h: In function 'damon_dbgfs_test_str_to_target_ids':
mm/damon/dbgfs-test.h:23:47: error: 'strnlen' specified bound 128 exceeds source size 4 [-Werror=stringop-overread]
   23 |         answers = str_to_target_ids(question, strnlen(question, 128),
      |                                               ^~~~~~~~~~~~~~~~~~~~~~
mm/damon/dbgfs-test.h:30:47: error: 'strnlen' specified bound 128 exceeds source size 7 [-Werror=stringop-overread]
   30 |         answers = str_to_target_ids(question, strnlen(question, 128),
      |                                               ^~~~~~~~~~~~~~~~~~~~~~
mm/damon/dbgfs-test.h:37:47: error: 'strnlen' specified bound 128 exceeds source size 5 [-Werror=stringop-overread]
   37 |         answers = str_to_target_ids(question, strnlen(question, 128),
      |                                               ^~~~~~~~~~~~~~~~~~~~~~

Use a plain strlen() instead.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/damon/dbgfs-test.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 930e83bceef0..4eddcfa73996 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -20,27 +20,27 @@ static void damon_dbgfs_test_str_to_target_ids(struct kunit *test)
 	ssize_t nr_integers = 0, i;
 
 	question = "123";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
 	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
 	kfree(answers);
 
 	question = "123abc";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
 	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
 	kfree(answers);
 
 	question = "a123";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
 	kfree(answers);
 
 	question = "12 35";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
 	for (i = 0; i < nr_integers; i++)
@@ -48,7 +48,7 @@ static void damon_dbgfs_test_str_to_target_ids(struct kunit *test)
 	kfree(answers);
 
 	question = "12 35 46";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)3, nr_integers);
 	for (i = 0; i < nr_integers; i++)
@@ -56,7 +56,7 @@ static void damon_dbgfs_test_str_to_target_ids(struct kunit *test)
 	kfree(answers);
 
 	question = "12 35 abc 46";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
 	for (i = 0; i < 2; i++)
@@ -64,13 +64,13 @@ static void damon_dbgfs_test_str_to_target_ids(struct kunit *test)
 	kfree(answers);
 
 	question = "";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
 	kfree(answers);
 
 	question = "\n";
-	answers = str_to_target_ids(question, strnlen(question, 128),
+	answers = str_to_target_ids(question, strlen(question),
 			&nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
 	kfree(answers);
-- 
2.29.2

