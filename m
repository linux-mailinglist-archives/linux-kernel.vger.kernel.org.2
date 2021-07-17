Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A43CC5F8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 21:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhGQT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 15:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234719AbhGQT4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 15:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D0B7A61159;
        Sat, 17 Jul 2021 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626551615;
        bh=yYf2+EYtaVaPG0UsjRXw/olRd2r37JYfJ6thWnq2GPo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bRNt2MY6yF++iUIwF7KfVw4EyuwzrzJbWhdaWUHt/2kgu6EfNxrKz1jIUbJ+sYKKO
         XjCvBpkyw6CtLfmVKWNg5yytR7Q5IayLJOXBxsfHnM79jHPD+47Xb6HepFpy9Lcaq6
         EcRDdacj0hoND0sWd33PzMLGmex5fgdgiPkMJ9UFlbWzkIWEMaBxUzLyh8jo1K++je
         m8g2mQ6zax7hvdm1t8917xIIHUv9sVhtvwG+n4xMS9CQOll//aK+TVr+yFig5SDL24
         X5LbIstCgiufxSQ1YaK+M2ZNdk20GfXdIna7C3BqRpDWxT9HRVC8+uCXZffaOYylrR
         QDmJ6Aj1KGOFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BB6A5609A3;
        Sat, 17 Jul 2021 19:53:35 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Do not reference char * as a string in
 histograms
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210716174517.033472e4@oasis.local.home>
References: <20210716174517.033472e4@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210716174517.033472e4@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-5
X-PR-Tracked-Commit-Id: 704adfb5a9978462cd861f170201ae2b5e3d3a80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fdacf402bb2221c77940f68ef56a0214c098ee0
Message-Id: <162655161570.18489.2521491561719779671.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 19:53:35 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 17:45:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fdacf402bb2221c77940f68ef56a0214c098ee0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
