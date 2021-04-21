Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A82366D36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbhDUNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242908AbhDUNvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:51:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 288C46144D;
        Wed, 21 Apr 2021 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013065;
        bh=XM1Gf5TjV0huuiDNxDVZnKlvxmEpVi4ZXaKValILsC0=;
        h=From:To:Cc:Subject:Date:From;
        b=OouB3r7bsuSp5QASDPQSL7nijaYXWwDqkfh2k2DnV9rfS8olwShefe4KonuZC/WIW
         SiAU06a+iRORDzBSEfOY3Er5tZHku870EyrtD7jUhljI2I598l0XvUSbc17v+txsby
         PRprxFdm+mI54bPd6wXfwgoYxaojaPgZyIhYNxqVwjlFlcgvJO3z+RUTWftW5MkK9a
         FkKZ1aLzqx/f6WHUrJv/SCU6c472vWz1SL/7QMGaeplDOt+cTc4H3g9DdV8QtSPFob
         0DyeCMhHcCGDOrOH9BaCoYrwbpY1GSf+FnJ0nbdCkJb+vyTamiUnZ6Qiwgs0F8flGy
         NE3tVIR0dG0jg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Gow <davidgow@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kcsan: fix printk format string
Date:   Wed, 21 Apr 2021 15:50:38 +0200
Message-Id: <20210421135059.3371701-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Printing a 'long' variable using the '%d' format string is wrong
and causes a warning from gcc:

kernel/kcsan/kcsan_test.c: In function 'nthreads_gen_params':
include/linux/kern_levels.h:5:25: error: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Werror=format=]

Use the appropriate format modifier.

Fixes: f6a149140321 ("kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 9247009295b5..a29e9b1a30c8 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -981,7 +981,7 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 		const long min_required_cpus = 2 + min_unused_cpus;
 
 		if (num_online_cpus() < min_required_cpus) {
-			pr_err_once("Too few online CPUs (%u < %d) for test\n",
+			pr_err_once("Too few online CPUs (%u < %ld) for test\n",
 				    num_online_cpus(), min_required_cpus);
 			nthreads = 0;
 		} else if (nthreads >= num_online_cpus() - min_unused_cpus) {
-- 
2.29.2

