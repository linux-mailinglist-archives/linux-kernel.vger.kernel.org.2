Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9338B7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhETUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237013AbhETUCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:02:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 231E3611ED;
        Thu, 20 May 2021 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621540888;
        bh=Q3csBOQeByhZjHPRLnlAU/yn4rf98Hq1cPTlQACOEGY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sJlqMCivTi+HYwANuUOLXbrSiifmQfwCbJBUKJmV8lyBeVptW5rOvu4NQs9QEQZdz
         yuV4yO6xYOOObpCGSVHbLEXrxQWU8IXzz7WDpTj6g0xidtXKddErT0tPD0QewqNb8m
         xwC1zgXVC+MLK4vMwKoZ8lsIKtDN9r7nJ0EQfivzPYUf957k51y6x81fSTaU6j9J9E
         hB77BWWQjH9QEgeyKnwrtxghqwJEABoHUWzsfHRFDTb124myMlm5auFzGrUmFa6I/D
         0uOYBa39EWwccwjh0YbETh2gHGlh3Koqg1+dtnXpDUO9tIhcpHdE1uFCSa6KG8bnqc
         nI9kOgInDnPwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DDF5C5C0343; Thu, 20 May 2021 13:01:27 -0700 (PDT)
Date:   Thu, 20 May 2021 13:01:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, tglx@linutronix.de,
        elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        gregkh@linuxfoundation.org, nathan@kernel.org, ojeda@kernel.org,
        arnd@arndb.de
Subject: [GIT PULL] kcsan: Fix debugfs initcall return type
Message-ID: <20210520200127.GA2227122@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This pull request provides a fix for a regression introduced in the v5.13
merge window by commit e36299efe7d7 ("kcsan, debugfs: Move debugfs file
creation out of early init").  The regression is not easy to trigger,
requiring a KCSAN build using clang with CONFIG_LTO_CLANG=y.  The fix
simply makes the kcsan_debugfs_init() function's type initcall-compatible.
This fix has been posted to the relevant mailing lists:

https://lore.kernel.org/lkml/20210514140015.2944744-1-arnd@kernel.org/

It has also been exposed to -next testing and has been subject to more
than the usual number of reviews.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent.2021.05.20a

for you to fetch changes up to 976aac5f882989e4f6c1b3a7224819bf0e801c6a:

  kcsan: Fix debugfs initcall return type (2021-05-18 10:58:02 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      kcsan: Fix debugfs initcall return type

 kernel/kcsan/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
