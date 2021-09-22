Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B3414C99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhIVPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236303AbhIVPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E357361153;
        Wed, 22 Sep 2021 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632322770;
        bh=EQ2C98TlWZE0g0z7OwmAB1xVVZKpvfN8eAHsxQ9nREM=;
        h=From:To:Cc:Subject:Date:From;
        b=shnmOzmwe+3AOy8qFTNgKnx7ggtL0b6NXMWIp29AuJDQhUZHXkCdV6I2uTYdniQSu
         6hdeFIQUmEf7hnKAYzY1yLAkQYcPP1eG7zA1sP+U8lnNya0J7TP6qCRCzvmi7aVHkZ
         4TED4NMmUrQs1ZKybwalh1M7Hjo3tmjSCQerRXl86ozoZ/1QGx4s4C09jfVP7EKs+j
         kXJw9SaR85Mfw3s/j3KtPQU9XDhFvmRyjnkkBfpP0H0BbeqG108AjA0g31aoR4gDdm
         pY6uqGsoynszFhFIQ1SMTDd45pXAqPR9F81ip5J71012wtUgYFrnsB7iEowFqSBjv2
         YEAIXj84M0iyw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] locking/ww-mutex: Fix uninitialized use of ret in test_aa()
Date:   Wed, 22 Sep 2021 07:58:22 -0700
Message-Id: <20210922145822.3935141-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.514.g99c99ed825
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

kernel/locking/test-ww_mutex.c:138:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                if (!ww_mutex_trylock(&mutex, &ctx)) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/locking/test-ww_mutex.c:172:9: note: uninitialized use occurs here
        return ret;
               ^~~
kernel/locking/test-ww_mutex.c:138:3: note: remove the 'if' if its condition is always false
                if (!ww_mutex_trylock(&mutex, &ctx)) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/locking/test-ww_mutex.c:125:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

Assign !ww_mutex_trylock(...) to ret so that it is always initialized.

Fixes: 12235da8c80a ("kernel/locking: Add context to ww_mutex_trylock()")
Link: https://github.com/ClangBuiltLinux/linux/issues/1463
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index d63ac411f367..353004155d65 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -135,7 +135,8 @@ static int test_aa(bool trylock)
 			goto out;
 		}
 	} else {
-		if (!ww_mutex_trylock(&mutex, &ctx)) {
+		ret = !ww_mutex_trylock(&mutex, &ctx);
+		if (ret) {
 			pr_err("%s: initial trylock failed!\n", __func__);
 			goto out;
 		}

base-commit: 12235da8c80a1f9909008e4ca6036d5772b81192
-- 
2.33.0.514.g99c99ed825

