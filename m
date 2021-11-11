Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15C744DA40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhKKQW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhKKQWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:22:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB6261058;
        Thu, 11 Nov 2021 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636647605;
        bh=Q7gEjq4LBdZx7HvfIZyYrR7/naOzZ5hyMO1OyxxWkkE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KfbuoMFsoeyXJspXqcP0lfVhUbgsXLDk+xkgNxL6WdneO5NQ7ZUIJPCR7HasaZqhI
         xuA/xEn6OP2pQ/WewZgCLzYoKWdBUQN3rXZYr3W26WNY0ejgJWkBiKnPMt7Ao8ddt/
         ifUTnrJywSQO1bxUPxhikF2BYIx+D+ZtLfxnEexvpKZ6rJuTBlS0ZBXxgLbVNW3m3z
         8iFE4gubLt/Y6e3OkqWbVLCwKcVmvhW8Nq3z/O+3qj71i7ISGaZeZH1RUYYdVTyMR7
         MAYT6/esIqJ+TAKIytK5ttHO8vTfHPmVgy3YXwzR+fszN+S7qReDcTPwxtu4RvR/qC
         LLDL6QHx2N0xQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4CCD85C0527; Thu, 11 Nov 2021 08:20:05 -0800 (PST)
Date:   Thu, 11 Nov 2021 08:20:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, elver@google.com,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw, boqun.feng@gmail.com
Subject: [GIT PULL] KCSAN changes for v5.16
Message-ID: <20211111162005.GA305579@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2021.11.11a

for you to fetch changes up to ac20e39e8d254da3f82b5ed2afc7bb1e804d32c9:

  kcsan: selftest: Cleanup and add missing __init (2021-09-13 16:41:20 -0700)

----------------------------------------------------------------
KCSAN pull request for v5.16

This series contains initialization fixups, testing improvements, addition
of instruction pointer to data-race reports, and scoped data-race checks.

----------------------------------------------------------------
Marco Elver (9):
      kcsan: test: Defer kcsan_test_init() after kunit initialization
      kcsan: test: Use kunit_skip() to skip tests
      kcsan: test: Fix flaky test case
      kcsan: Add ability to pass instruction pointer of access to reporting
      kcsan: Save instruction pointer for scoped accesses
      kcsan: Start stack trace with explicit location if provided
      kcsan: Support reporting scoped read-write access type
      kcsan: Move ctx to start of argument list
      kcsan: selftest: Cleanup and add missing __init

 include/linux/kcsan-checks.h |  3 ++
 kernel/kcsan/core.c          | 75 ++++++++++++++++++++++++------------------
 kernel/kcsan/kcsan.h         |  8 ++---
 kernel/kcsan/kcsan_test.c    | 62 +++++++++++++++++++++++------------
 kernel/kcsan/report.c        | 77 ++++++++++++++++++++++++++++++++++++--------
 kernel/kcsan/selftest.c      | 72 +++++++++++++++++------------------------
 6 files changed, 186 insertions(+), 111 deletions(-)
