Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4603D4090
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhGWSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhGWSaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:30:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F36760F21;
        Fri, 23 Jul 2021 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627067439;
        bh=ylk9ugtwcUgWuBuAeLKm/0EkbKBuRKf5YvIL6syo4/M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rrmPQnphw7d09L5hDp9tSM4bQ+e18qEfK34AE0u71AX+NY7cOg4qcyjDyriuBsNHn
         OXf1ihMsvWhpLlPpJEValtI76HVtSfYbnhGTRHLcxk938ZkNig86M/bTsk5H13GBWn
         McXuHYZLs4eAYWh37Zk/qyDvKzgo/AY8RhTQ/PZOibFFqoF8WazKhWkY5pE1+QO9U3
         PfcYps0f8lxXBbrsb7aq01rp7Ad2HlSWYsRWdzPezEXXRWGQRGMspKryACrpB5u7BO
         jUmJt9u+RC1L/Yex2FP3uJNILlP7M6VyjnecRBnkQNvIT31JITplFMLlnSwkEKC4V4
         f5B/FCJdG9TWA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1490560972;
        Fri, 23 Jul 2021 19:10:39 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210723125527.767d1c18@oasis.local.home>
References: <20210723125527.767d1c18@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210723125527.767d1c18@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc2
X-PR-Tracked-Commit-Id: 352384d5c84ebe40fa77098cc234fe173247d8ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05daae0fb033f63f96652d8aaf4cc31b330d4527
Message-Id: <162706743907.23984.14307226059412551175.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 19:10:39 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Haoran Luo <www@aegistudio.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 12:55:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05daae0fb033f63f96652d8aaf4cc31b330d4527

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
