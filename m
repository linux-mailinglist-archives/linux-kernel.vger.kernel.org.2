Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748DD40D0E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhIPAdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233601AbhIPAdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3FE46008E;
        Thu, 16 Sep 2021 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752307;
        bh=Eq58ZGMDPeIZQQBGH2eVCplUfyu+t6H3ib17Q8WuSVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkqA+aI9SdDFjpDsJqvG7AAXK2ny/iECHhD9OB2r6HF6KEFfjA4CL6YPgqA02KtUo
         NzsRp6f7dKUrEAc7mjFbV+wnCazI3VzocZuHtNZOV2Jtb84zJDeAG1V/hOX4eEDSIF
         aAoABY0LQgvhXxTCvTgPQLgkabVD/DDnazlPiUKCt7fSIwaHeVCfvDl+fbiTkdLOQB
         4iB/kF21nR1ucB0CPNQyPmTIFEWKmoHM+R1GWJisK3r4nk2yB1ipQ7nH1aREeN2OkP
         ukFRGIUsYn9C4gu2HlWtRz7wd/GORuwO0u99Sdn+5IMEmAvRHsRnygyHfZgiTONoJD
         WEN86kVFF+NNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ABB635C054E; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 1/9] kcsan: test: Defer kcsan_test_init() after kunit initialization
Date:   Wed, 15 Sep 2021 17:31:38 -0700
Message-Id: <20210916003146.3910358-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

When the test is built into the kernel (not a module), kcsan_test_init()
and kunit_init() both use late_initcall(), which means kcsan_test_init()
might see a NULL debugfs_rootdir as parent dentry, resulting in
kcsan_test_init() and kcsan_debugfs_init() both trying to create a
debugfs node named "kcsan" in debugfs root. One of them will show an
error and be unsuccessful.

Defer kcsan_test_init() until we're sure kunit was initialized.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index dc55fd5a36fc..df041bdb6088 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1224,7 +1224,7 @@ static void kcsan_test_exit(void)
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall(kcsan_test_init);
+late_initcall_sync(kcsan_test_init);
 module_exit(kcsan_test_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
2.31.1.189.g2e36527f23

