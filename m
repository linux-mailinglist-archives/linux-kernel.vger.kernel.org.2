Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A732C948
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390773AbhCDBG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453001AbhCDAlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:41:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C4564E28;
        Thu,  4 Mar 2021 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818422;
        bh=L14/jHzOV62jtTL1xIdI8+Ada6c0kEVxvh6n+nW0dBo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=K99jB5k2yioy+FS4wtf6DHLaROwjg2PMqHDPtLzWhY8jZo8Z4WmNtcSCW9uv+T6m9
         xBXxJGIN4r6HSoXjoS4geYw3GudrOTqo1c7tUzxXf3/2eN+t7j8w2SHTXha/rE0Nqv
         vwaXSGWT8qkD4nopiBavDGUqihTvGiyHXfeZNKBtf3wbgJI4iVo7aRwOiNDunTYyS8
         BtnZfd/6VaReBlF2akWVV+hOAcU3ss+kWEDn70bz27+5bb5kq4dBKuYmtSEGq9UVK3
         Va2sF7pdTP4ifxx1tJnTTum1lJ0lNluC6z5nApxd6KJ5Lb2wQ6uf4BEDb0ZD6K9o8n
         7NYCPJA/8k1Ug==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 97FB03522591; Wed,  3 Mar 2021 16:40:22 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:40:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/4] KCSAN updates for v5.13
Message-ID: <20210304004022.GA25013@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains KCSAN updates:

1.	kcsan, debugfs: Move debugfs file creation out of early init,
	courtesy of Marco Elver.

2.	Make test follow KUnit style recommendations, courtesy of
	Marco Elver.

3.	Switch to KUNIT_CASE_PARAM for parameterized tests, courtesy of
	Marco Elver.

4.	Add missing license and copyright headers, courtesy of Marco
	Elver.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/dev-tools/kcsan.rst |    3 
 include/linux/kcsan-checks.h      |    6 +
 include/linux/kcsan.h             |    7 ++
 kernel/kcsan/Makefile             |    4 -
 kernel/kcsan/atomic.h             |    5 +
 kernel/kcsan/core.c               |    7 +-
 kernel/kcsan/debugfs.c            |    9 ++
 kernel/kcsan/encoding.h           |    5 +
 kernel/kcsan/kcsan.h              |    8 --
 kernel/kcsan/kcsan_test.c         |  118 +++++++++++++++++---------------------
 kernel/kcsan/report.c             |    5 +
 kernel/kcsan/selftest.c           |    5 +
 lib/Kconfig.kcsan                 |    5 -
 13 files changed, 111 insertions(+), 76 deletions(-)
