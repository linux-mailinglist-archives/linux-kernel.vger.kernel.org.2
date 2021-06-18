Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1973AD2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhFRTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233430AbhFRTcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:32:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3653F613BD;
        Fri, 18 Jun 2021 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624044626;
        bh=ltTvNTMwFkYJTPxjAqKMsOTKLtt1NT5IwT7W1f0kua4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I6lVmofZzICzAqQbKRT5BVdXfeEJil48C1TwbwGWUUCL5/rSlLtZLifiVIyvbx/UA
         gwZVZDILLhriCqrZ4HO1Lc685YOcOPFtppkSrK8fJjHZWXuUNZdCUZlMeu+cNdc471
         1x/ftAZfvorFjqpYDfhU4Vgggs52NeN5HWl0cZfqw9032yJEKa+uuWKrOmaGlAzdR8
         PIrCtoVxNm0u7jhrBXWCc4H2ETvD3jDEL9HBKpLtyas46u97HBzoerzHQU227JOzkH
         MDS08/NnLg8UhM/S9ZWtJDjfjNjZhn7MKwsT4Wpg6/Ma7reO10CAHbW/4q4UzMc/PY
         i8NrL3a/p81Og==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2D99060C29;
        Fri, 18 Jun 2021 19:30:26 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210618102323.3b630647@oasis.local.home>
References: <20210618102323.3b630647@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210618102323.3b630647@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-rc6
X-PR-Tracked-Commit-Id: 89529d8b8f8daf92d9979382b8d2eb39966846ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89fec7420354ff2d23ed46e62aaea402587efd1c
Message-Id: <162404462618.17995.7308625891019380946.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jun 2021 19:30:26 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jun 2021 10:23:23 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89fec7420354ff2d23ed46e62aaea402587efd1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
