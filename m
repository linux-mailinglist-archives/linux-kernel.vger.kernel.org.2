Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8D3B69BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhF1Ug0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbhF1UgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 29D7361CD4;
        Mon, 28 Jun 2021 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912414;
        bh=uLGySjLdzrjde+Ya4RFSiM+RUUfK0eHawbY8hcQzjGo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=noVg056dm6KMQyANxpfv+HsmDW7Z430vKP6zEkNY0sQ34f0dV518NzLdH9hoywlYI
         +j6o9kEUb3NRvZvc6XyR7JTgvzPuV6wXVPaYTGIeu8vZ6ZWu/C4GMYyeweEVxMdD+J
         t1YiWKHp8w7sUwK1swD02gyUD6guLlI/iAs9NSJPfTQgz1vt4Ns5qiHrM6plEx32Rf
         L/BMhOCMq4kFcKW/SBk+ExG+wgXNpoDfWELD0oimEp2WdBlUBnav6JnHdCpjWQjMDp
         ES+hXkkoDoVhYQBpMbSq7kLDOrwqmcIJ9P+hzgF2mZlwEpz9WrJzFJovLlNnXP75f5
         E91im0oqYWkrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21A1460A71;
        Mon, 28 Jun 2021 20:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm change for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl7ihyyWXDascmK@gmail.com>
References: <YNl7ihyyWXDascmK@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl7ihyyWXDascmK@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2021-06-28
X-PR-Tracked-Commit-Id: 314a1e1eabea5b86532e90e0d4e217fa88471e3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f498328a91b59841557b8c4e8f0360e509dd454
Message-Id: <162491241413.14584.18435555042786178770.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:34 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:34:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f498328a91b59841557b8c4e8f0360e509dd454

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
