Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC693B69BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhF1Ugc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235815AbhF1UgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4501A61CDE;
        Mon, 28 Jun 2021 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912414;
        bh=e9Nx33ITp/Cz67mZ6oqYOECW3c6XLrOawayUPiz8zgA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g0qPb8o1PAftffrbNCuqMluX9OhtSsNYjuIwEM5g+ykoh4NqkT5UMlRw0uozVyjFS
         2bpS7J7Q5hzfP0qTB5XSncpFkrsRsBz5GNR82bFSyG6IHA8rGiSsoxNU11zMnLa6pf
         cms/sCoXSUyEM4i3FCyErQJUDDw73T4jINBqNKqMmw/UkS2d1i6JCoal6OUhfsJeap
         vKfU/jiSec1IwmHN6iXKiDDItcAYvhLiqkDEymnBxT0HcCOKFDSkptryXW1qtZed/v
         pj/yq6pJWAX98PPmUQDOWVa8kzhfOz71uY/UvljIs5c5IacERtKHKShWf/LzYAWmnS
         gtuY0R3ZPCmqg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3E92760A6C;
        Mon, 28 Jun 2021 20:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/splitlock changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl9XqC0V+tdJsjI@gmail.com>
References: <YNl9XqC0V+tdJsjI@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl9XqC0V+tdJsjI@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2021-06-28
X-PR-Tracked-Commit-Id: d28397eaf4c27947a1ffc720d42e8b3a33ae1e2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b1cf8fe99830e8c95f0fe110b02ba51c2bbc4e0
Message-Id: <162491241425.14584.1503802132887566153.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:34 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:42:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b1cf8fe99830e8c95f0fe110b02ba51c2bbc4e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
