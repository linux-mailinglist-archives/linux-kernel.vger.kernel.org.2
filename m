Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3644424EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhJGIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240664AbhJGIOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E9AB6101B;
        Thu,  7 Oct 2021 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633594365;
        bh=SQB2zfHQFfQ/x60bhQw8zEe4m6OGM4AGyHdrnROOqbI=;
        h=From:To:Cc:Subject:Date:From;
        b=q9GZXqYsflDS4zc3YJhVc6+repZCqZezIx4Rbg1y9ePoODozTm+GicsmQBxVFE2Kc
         v/IkMTJvxTVdch4/O4a2Qu2f43d4pxVG6HFKu5VWl1HEHHCnvcnb168K2FUsWcAa7n
         HmGr0foNE0Ja1k3TKOgLb6Tesw2DOEF872uSsBWOdAzes4Qa7TzqD5FkdNgCqAGFnp
         F6JzFs8hNEpCLnYeWfB8ffFMlUf0R1M+MZQYxk8SGlwmdgIC3AJvlxTcbu5/kJvLSd
         dm5pU6HZd+XT4daRnXpzC3nnlS92HotwI71boZFzGyR29rG4Elja0QTceu0KC0wqJH
         kR4zzHt+SUCvg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] lkdtm: avoid printk() in recursive_loop()
Date:   Thu,  7 Oct 2021 10:12:35 +0200
Message-Id: <20211007081235.382697-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; h=from:subject; bh=SQB2zfHQFfQ/x60bhQw8zEe4m6OGM4AGyHdrnROOqbI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhXqvxgncc86QaL0J3FCuxZHgZntAYazouYSyk7KgH 9Fw5DF+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYV6r8QAKCRDDTyI5ktmPJBqxC/ 4iRi6Lm21BRUBaN+nO9y7ethkqX74FeMj3Ugip4jr64vqcTnTm35Mpaqx1Xv7UnmtMAGj9Askt/EWY 99feFimeleJPH3dOgj6xgTvdFQ5+foaW+wi68DpH7C1LY52bdRfd+BDzICkcaNz41x3GvSECIwEyRd MMxoo/o85IvWJ2UgGt88raA8gQZzT+CtEpWLs0QYUW4J2gMyiPLg90lbt0+8HgNiVEHrA9Ccj73H3s mNbmsxo3buWDCmgzbfAxwQNUAxBDmSkgIatbPKY4HUFmaG8ZPrtSPo8qf9+R3Bn7Bcc6OU3kvzE4+6 cfuQuejjXa3i1TQa7X/e8KdzCjn0ex0FxMje2K1/1AwFpEIK6uge8JQ3pbOMYr94NoHSd5w1FhuUet maOa8HzCvFSWDCg6ekuUKqn6x5DGqZzcvbIFoTusNL8ocYLdrPWDVWMhJ/6sUCNq9tKLdgHjLfWgEk feYhsyxLLKEovFfTbKN0U+D9BlTIHLMLu3in0xmr0RaNY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recursive_loop() function is intended as a diagnostic to ensure that
exhausting the stack is caught and mitigated. Currently, it uses
pr_info() to ensure that the function has side effects that the compiler
cannot simply optimize away, so that the stack footprint does not get
reduced inadvertently.

The typical mitigation for stack overflow is to kill the task, and this
overflow may occur inside the call to pr_info(), which means it could be
holding the console lock when this happens. This means that the console
lock is never going to be released again, preventing the diagnostic
prints related to the stack overflow handling from being visible on the
console.

So let's replace the call to pr_info() with a call to
memzero_explicit(), which is not a 'magic' function name like memset()
or memcpy(), which the compiler may replace with plain loads and stores.
To ensure that the stack frames are nested rather than tail-called, put
the call to memzero_explicit() after the recursive call.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/misc/lkdtm/bugs.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 4282b625200f..41fa558675c4 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -41,20 +41,22 @@ static DEFINE_SPINLOCK(lock_me_up);
  * Make sure compiler does not optimize this function or stack frame away:
  * - function marked noinline
  * - stack variables are marked volatile
- * - stack variables are written (memset()) and read (pr_info())
- * - function has external effects (pr_info())
- * */
+ * - stack variables are written (memset()) and read (buf[..] passed as arg)
+ * - function may have external effects (memzero_explicit())
+ * - no tail recursion possible
+ */
 static int noinline recursive_loop(int remaining)
 {
 	volatile char buf[REC_STACK_SIZE];
+	volatile int ret;
 
 	memset((void *)buf, remaining & 0xFF, sizeof(buf));
-	pr_info("loop %d/%d ...\n", (int)buf[remaining % sizeof(buf)],
-		recur_count);
 	if (!remaining)
-		return 0;
+		ret = 0;
 	else
-		return recursive_loop(remaining - 1);
+		ret = recursive_loop((int)buf[remaining % sizeof(buf)] - 1);
+	memzero_explicit((void *)buf, sizeof(buf));
+	return ret;
 }
 
 /* If the depth is negative, use the default, otherwise keep parameter. */
-- 
2.30.2

