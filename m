Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0372B40D0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhIPAcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233317AbhIPAcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:32:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90D70610A6;
        Thu, 16 Sep 2021 00:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752286;
        bh=4ON6gyVcGSyrQgrpSEGDCD192PiA2ByJhyQhpyyA36o=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hghhs7SMSs85lF+dhEHSLxNeFP/mA49FHmT0l8gmx2ly3tTM7VWBQtK/g/zzcxprd
         kJoDZFE3ZTw0GjMzblxe8TEIMMDdClah80QXgEs+RjF+18uzEq8TXyuM354n8sRcaf
         0poYJVH+FcRmzTXutMzLx3ip3uwqwuVdOU8Ic01OWd30wNpbdj3Y0iid9u/nZwklr2
         +fvJbFfbxkjlhMnKjsapd6mXlOXnZ9xKHGWP8UCSEzPSlAqFytR+SyyHwm6B/lErkn
         SSjE7aJuffOnXu6LSGO+roPlA91Vw/5pAwJe7vb/oZ0BbC+OL9OoDs0HDu5x7/SI8A
         vQINQYCExV+cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6325F5C054E; Wed, 15 Sep 2021 17:31:26 -0700 (PDT)
Date:   Wed, 15 Sep 2021 17:31:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/9] Kernel Concurrency Sanitizer (KCSAN) updates for
 v5.16
Message-ID: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates, all courtesy of Marco Elver:

1.	test: Defer kcsan_test_init() after kunit initialization.

2.	test: Use kunit_skip() to skip tests.

3.	test: Fix flaky test case.

4.	Add ability to pass instruction pointer of access to reporting.

5.	Save instruction pointer for scoped accesses.

6.	Start stack trace with explicit location if provided.

7.	Support reporting scoped read-write access type.

8.	Move ctx to start of argument list.

9.	selftest: Cleanup and add missing __init.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/kcsan-checks.h |    3 +
 b/kernel/kcsan/core.c          |   55 +++++++++++++++++--------------
 b/kernel/kcsan/kcsan.h         |    8 ++--
 b/kernel/kcsan/kcsan_test.c    |    2 -
 b/kernel/kcsan/report.c        |   20 ++++++-----
 b/kernel/kcsan/selftest.c      |   72 +++++++++++++++++------------------------
 kernel/kcsan/core.c            |   20 +++++++----
 kernel/kcsan/kcsan_test.c      |   60 +++++++++++++++++++++++-----------
 kernel/kcsan/report.c          |   59 ++++++++++++++++++++++++++++++---
 9 files changed, 187 insertions(+), 112 deletions(-)
