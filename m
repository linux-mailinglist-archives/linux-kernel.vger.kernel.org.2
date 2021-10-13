Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130DC42C6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhJMQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJMQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF8F460C41;
        Wed, 13 Oct 2021 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634143464;
        bh=nb+sp5ClcMQ4pk4Ln34K7Xw8zsyPZG2MvygL0U+P4pE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=djWf7Fv85noHdnX31z0rQeMU567e3L9U4JkP4B6HcJ/RrmHgVR1bz7yBtLk4rC6GK
         nZUhhA5FFuU2zT1+DkSAoVEnIPNeXbnBEZMChs3LPh9by6bPGF8UEwYQDBjAaBgaU+
         MkuA0H6pOA90niCxm4ilYXiJEEoXa1EqaQb2q5qG7twunxz6SVUcidqxdHmuc6WT4w
         0IOon0IZBCnrXWehVpTNdKoNiWmI10fhs9USWoJ8m+v4giZDDZi23sreyKusMtOxB8
         tC1RzHIDuUILlGm4R3n4PgFCNY1rKfYJGsovwcwkqo9Oe2uH6OWvDOOZW1nwETRq3X
         xo+vte9mL3n/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B0ACC5C0687; Wed, 13 Oct 2021 09:44:24 -0700 (PDT)
Date:   Wed, 13 Oct 2021 09:44:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     elver@google.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com
Subject: [GIT PULL kcsan] KCSAN commits for v5.16
Message-ID: <20211013164424.GA2842388@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains updates for the Kernel concurrency sanitizer
(KCSAN).

These updates fix an initialization issue, update tests, improve reporting,
and provide support for scoped accesses.

These updates have been posted on LKML:

https://lore.kernel.org/all/20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1/

These changes are based on v5.15-rc1, have been exposed to -next and to
kbuild test robot, and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan

for you to fetch changes up to ac20e39e8d254da3f82b5ed2afc7bb1e804d32c9:

  kcsan: selftest: Cleanup and add missing __init (2021-09-13 16:41:20 -0700)

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
