Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BD3F6D35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHYBt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:49:58 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60378 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbhHYBt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:49:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UlgvsCb_1629856150;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UlgvsCb_1629856150)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Aug 2021 09:49:11 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     cyphar@cyphar.com, christian.brauner@ubuntu.com,
        baolin.wang@linux.alibaba.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: openat2: Fix testing failure for O_LARGEFILE flag
Date:   Wed, 25 Aug 2021 09:49:04 +0800
Message-Id: <c37fb567a848ec4a5b21ff515f423b9fe2acde14.1629855952.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the openat2 test suite on ARM64 platform, we got below failure,
since the definition of the O_LARGEFILE is different on ARM64. So we can
set the correct O_LARGEFILE definition on ARM64 to fix this issue.

"openat2 unexpectedly returned # 3['.../tools/testing/selftests/openat2']
with 208000 (!= 208000)
not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails
with -22 (Invalid argument)"

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
Changes from v1:
 - Add reviewed and acked tags from Aleksa and Christian.
 - Add failure logs in the commit log.
---
 tools/testing/selftests/openat2/openat2_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index d7ec1e7..1bddbe9 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -22,7 +22,11 @@
  * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
  */
 #undef	O_LARGEFILE
+#ifdef __aarch64__
+#define	O_LARGEFILE 0x20000
+#else
 #define	O_LARGEFILE 0x8000
+#endif
 
 struct open_how_ext {
 	struct open_how inner;
-- 
1.8.3.1

