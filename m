Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452FC3661B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhDTVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhDTVnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:43:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E4C91613DB;
        Tue, 20 Apr 2021 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618954954;
        bh=atAfhWVtNsOQcEu4whMD98pSku8m8vnooSUCkjSlDAc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qius8H5jUDckjVGEAULeSJJK3M41FLXbscwY9x0a6JKGQdjZLAzsgS3FExiNxLUID
         uWvtZ3MR7G+Yatc7ctGvR+DKQ1ciy/HRAGO9vpuwJJZ7psVIfhu1vWrAsfik6r773a
         76dMIln2BuH4gPS9GNnCtry9bbmQpW8weaZsBm6eZorDLp77gZzCTgwAt9rk5gt57A
         4LNOkCV8xx2hXVobvbFY7BsjzuyALS7Egj/lcfv0oj3rU+wJrMLmx5dxrv+cox35HK
         ryGrfYeqHeEWSNbIAKiWAvna8X6H6txnqHI7DmTCG0aW0RxN8CLxHrA9ypAbCGsXEB
         GsxD9GMc9ydsA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DA70060A37;
        Tue, 20 Apr 2021 21:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix checking event hash pointer logic when
 tp_printk is enabled
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210420143843.1ba9e20c@gandalf.local.home>
References: <20210420143843.1ba9e20c@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210420143843.1ba9e20c@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc8
X-PR-Tracked-Commit-Id: 0e1e71d34901a633825cd5ae78efaf8abd9215c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fe5501ba1abf2b7e78295df73675423bd6899a0
Message-Id: <161895495483.9583.695793260249230740.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Apr 2021 21:42:34 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Apr 2021 14:38:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fe5501ba1abf2b7e78295df73675423bd6899a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
