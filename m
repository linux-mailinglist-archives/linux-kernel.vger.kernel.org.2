Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C13E9B84
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhHLAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhHLAOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A2F60EE5;
        Thu, 12 Aug 2021 00:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628727239;
        bh=021TbhbozKzIGt/dBgga3vdayxGKi7jU6XRqoXGNOPo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=SPHbW4wdLn+g+3xPyu9wOnZbEMsc8PJhajFu/b+Dbjqa7JmIhvdLB/GKYrTrRp65B
         Zf3OAPh9qDUfUa6W+MNvEkSUaLdCL1iQhX4pKnDTnY5asujtLtrqtWPbhCw1Lozj1I
         nJY+z1YsKJFMFlHBBVtyun5WBocTjyyTQqpCxxvnumoXiV5X2DYIUNSyR964OP//Bd
         sTz8cBRI6eh2BI9fo+ONy3oGG1s2l2jZlaP6Oq7WCaip5AjCHQ/qu92N6NHDn909Qm
         wjOTGuTQUCjmBl6VmXLVPFu+4PhLvmGBSh0WZAoEYfCTtgGMMWoC3ReCTVSMdGoulk
         6HX7QG+rPWu7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 465075C0981; Wed, 11 Aug 2021 17:13:59 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:13:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     elver@google.com, mark.rutland@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com
Subject: [GIT PULL kcsan] KCSAN commits for v5.15
Message-ID: <20210812001359.GA404252@paulmck-ThinkPad-P17-Gen-1>
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

These updates improve comments, introduce CONFIG_KCSAN_STRICT (which RCU
uses), optimize use of get_ctx() by kcsan_found_watchpoint(), rework
atomic.h into permissive.h, and add the ability to ignore writes that
change only one bit of a given data-racy variable.

These updates have been posted on LKML:

https://lore.kernel.org/lkml/20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1/

These changes are based on v5.14-rc2, have been exposed to -next and to
kbuild test robot, and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan

for you to fetch changes up to e04938042d77addc7f41d983aebea125cddbed33:

  kcsan: Make strict mode imply interruptible watchers (2021-07-20 13:49:44 -0700)

----------------------------------------------------------------
Marco Elver (8):
      kcsan: Improve some Kconfig comments
      kcsan: Remove CONFIG_KCSAN_DEBUG
      kcsan: Introduce CONFIG_KCSAN_STRICT
      kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
      kcsan: Rework atomic.h into permissive.h
      kcsan: Print if strict or non-strict during init
      kcsan: permissive: Ignore data-racy 1-bit value changes
      kcsan: Make strict mode imply interruptible watchers

 Documentation/dev-tools/kcsan.rst | 12 +++++
 kernel/kcsan/atomic.h             | 23 ----------
 kernel/kcsan/core.c               | 77 ++++++++++++++++++++------------
 kernel/kcsan/kcsan_test.c         | 32 +++++++++++++
 kernel/kcsan/permissive.h         | 94 +++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan                 | 42 ++++++++++++-----
 6 files changed, 217 insertions(+), 63 deletions(-)
 delete mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/permissive.h
