Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21C636B7EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhDZRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234703AbhDZRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7E1A3613A9;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457560;
        bh=nJgAoaRJUV23gOMcOgo4H3hesiFSjIU65D/0BTWN9Rg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t+l+qlrkU8hosIZf/3kvTxNDBfvVvK/5/jPYtD1/QQl9qMH+ZZ5JkNsc6J8AGjUjs
         7ovOoGZRW4+amIfQJOxqzKTWOtGsu2tQ12SOwirqEk6H1u66fpJA3TNm7S86VbDJry
         n10mqyWlgwKgVyhzWG6WkwKN+lVDs03p/tWgwYsoT1AMmE6+Vq/ZeywAaQ+JRN/oXx
         Em8TsLtv0mQqgSecZJ+dCHs6p/9f5IfXC5w/ITDgBdMut30RJs9L7KDw8ojTKh8Jmx
         eIPOhw7Ke6RUyO7nN4LehTTdIaStDdVSHqPr6xTpSoC23IKR/z3/HbKdPTveKwoEsP
         vn4Ms6pswaqlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 789826094F;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161942992226.31799.8533344578176639891.tglx@nanos>
References: <161942992226.31799.8533344578176639891.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161942992226.31799.8533344578176639891.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-04-26
X-PR-Tracked-Commit-Id: 2d036dfa5f10df9782f5278fc591d79d283c1fad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87dcebff9262330ceffad8f1732f29fd35feab5a
Message-Id: <161945756048.14705.15121604568945161745.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 09:38:42 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87dcebff9262330ceffad8f1732f29fd35feab5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
