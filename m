Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9253759DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhEFR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236414AbhEFR6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5F47161166;
        Thu,  6 May 2021 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620323863;
        bh=OF+Mnpjym3DQzjbk3KShm58/KXblqlVxNA6IvcCPgDw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PeEWD0E0hQxBxMKLZfEZeQrIrhF/JL/jkRLQFRJGV4d0UGG+Bbz84Kv1ob3dj5Xtv
         gcZvUDiyX/kbxQYhpfzFG2DknpWevP7hxjXQLamqjGBjA02yI/6UYCd0RzmksJ5N2K
         UQtZoBzafuNKAO3sGoKcUt7M4KPlroXSwvFgXgsOqoyWMMfrgVym1CU1xY5vKv30wp
         5Y1ruVLYRbuy7AfeNG4l8CYuG7ZKUdDgwzsKwIQI3fJPR6M3rkrl+CTioC6X4gKkZ0
         cok2OjvbSqZXO98cihfn5vn30qIxyB4ugvskRESqVy7ez+YDktBC7KTZV9Y4ha7M1z
         EkIKrKFuFZUkQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5965A609AC;
        Thu,  6 May 2021 17:57:43 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix probes written to the set_ftrace_filter
 file
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210506101120.77792a09@gandalf.local.home>
References: <20210506101120.77792a09@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210506101120.77792a09@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-2
X-PR-Tracked-Commit-Id: 8c9af478c06bb1ab1422f90d8ecbc53defd44bc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ec901b6fa9ce5be3fc53d6216cb9e83ea0cf1da
Message-Id: <162032386335.1989.13580390575065024402.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 17:57:43 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 May 2021 10:11:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ec901b6fa9ce5be3fc53d6216cb9e83ea0cf1da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
