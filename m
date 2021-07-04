Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761A93BAE0E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhGDRbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 13:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhGDRbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 13:31:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B509613B1;
        Sun,  4 Jul 2021 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625419752;
        bh=ZuV5BXUvbs3huoDUJEAVkMexU2AKhja2qLYClna7Gek=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=gKineXn8THpmccO8/y5bBdudK0r/UlAzmdJCPigUryzF8l7QOfly5rT3fFoIhg56c
         84sMMqbClykPwqa6qI1vYO7DBUonUc1H0Sorvw90Hijp9oeSqm7wOzki6H0ZFg4WIl
         MMjrAFgZwN6fSlUD+DY8QbLCXSvAVzxJPThAI7VQdcMPdATfi8bNqa/+otjiyXt7pH
         REMCWL15RabvdI0isLYLjKWCUalQzi59WEx8EnMb2m14jJQEDvIjiVrL+Tm0FzB3sI
         kA/cq6hTTg/uzFlX7Q2TrPDul/f493rTPBXxS15YMNpoLAWmpCvCnf1BYEkqPLOH6P
         DJkovs2We3F6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 365325C0147; Sun,  4 Jul 2021 10:29:12 -0700 (PDT)
Date:   Sun, 4 Jul 2021 10:29:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [GIT PULL] KCSAN changes for v5.14
Message-ID: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest KCSAN tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan.2021.05.18a
  # HEAD: 117232c0b9126e254d84f38ccaf9e576ccfcd990: kcsan: Use URL link for pointing access-marking.txt (2021-05-18 10:58:15 -0700)

							Thanx, Paul

----------------------------------------------------------------
Akira Yokosawa (1):
      kcsan: Use URL link for pointing access-marking.txt

Arnd Bergmann (1):
      kcsan: Fix debugfs initcall return type

Marco Elver (1):
      kcsan: Document "value changed" line

Mark Rutland (8):
      kcsan: Simplify value change detection
      kcsan: Distinguish kcsan_report() calls
      kcsan: Refactor passing watchpoint/other_info
      kcsan: Fold panic() call into print_report()
      kcsan: Refactor access_info initialization
      kcsan: Remove reporting indirection
      kcsan: Remove kcsan_report_type
      kcsan: Report observed value changes

Paul E. McKenney (1):
      kcsan: Add pointer to access-marking.txt to data_race() bullet

 Documentation/dev-tools/kcsan.rst |  93 +++++++++------------
 kernel/kcsan/core.c               |  53 +++++-------
 kernel/kcsan/debugfs.c            |   3 +-
 kernel/kcsan/kcsan.h              |  39 ++++-----
 kernel/kcsan/report.c             | 169 ++++++++++++++++++++------------------
 5 files changed, 168 insertions(+), 189 deletions(-)
