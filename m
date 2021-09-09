Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDBC405E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345399AbhIIUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 16:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245195AbhIIUlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:41:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C07806115A;
        Thu,  9 Sep 2021 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631220006;
        bh=UuqfyaUZwjVk2T1K6Otxslqo1hOd2YuFf7SmBusu6/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CJ8qiogBBNiTsIhyV6J9IC8BktRPXvB3caiXz+R8kREh+uxApu6/4KxxYa3EvoVM1
         0g0MJUZl8kPgN2W2EtmAgoNErkR/uWJh7rEwPJ22bMLe082yWx50pHYSXWLVx8vwRP
         +GagA+64wTWqxVT/bEuzSJgqyqfRyFgWf6hd+D9sAi6et5PhqHLFX9LLi1X/tT5QZG
         suLIneSOK1Nien+47krklC/4rKnewLwnh9JXkMegtx8QUeLgsU9rW+GJG7HAwY64jO
         0nHl/QMlJadgQWbHhcI8BhmDEd++nTYlgxiIZvRbym9Wf8CCTcJjzoDAq7MLfOoh7P
         fsIk1tdCqbsiw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B8CBF60978;
        Thu,  9 Sep 2021 20:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: More updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210909090601.43810362@gandalf.local.home>
References: <20210909090601.43810362@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210909090601.43810362@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-2
X-PR-Tracked-Commit-Id: cfd799837dbc48499abb05d1891b3d9992354d3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43175623dd0dffccacbf014e368ee77f77c73898
Message-Id: <163122000674.1978.12428875535789769544.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 20:40:06 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Julio Faracco <jcfaracco@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Qiang.Zhang" <qiang.zhang@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 09:06:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43175623dd0dffccacbf014e368ee77f77c73898

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
