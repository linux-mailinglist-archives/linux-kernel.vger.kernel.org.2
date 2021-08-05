Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BAF3E1CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbhHET02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242893AbhHET0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 10BD960ED6;
        Thu,  5 Aug 2021 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628191566;
        bh=5AbhAIqr2s5H4PwXj4qsXocDlFq3mPIDDZNmLjBu+e0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WuS8bpAPg5MvUWTz5uvBO6Kc+jX0lh3gcFNbDbuTb+Kyr2Vp1TMTeusimcAoRXp5S
         ooF1BQEciywqPQWlou14lUsTtaerWSxbkPIwlhWkzoiV4E2bREqq1fjT9a+swsKtC7
         ykQyVlknNR5y8mqkhF7jhhZrEupnHmnDn/V6eFVrJhIqwBLxJxI8nQ0JVD60cnQFN4
         RWLeozi6LgisCwzvoKEwfuD4TECoCIbLmWx7UdKISDASTNl8Sgj5nkUS/1/2KVy1jd
         IPNIQG3XdiB7HL/DcV/1E2rrfKNM8yi/js5BxHARB9I/3WTVHAYa0ckGIactDFOPb0
         hb9A7+S3xFeYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 079EF60A48;
        Thu,  5 Aug 2021 19:26:06 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210805123539.2a707e63@oasis.local.home>
References: <20210805123539.2a707e63@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210805123539.2a707e63@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc4
X-PR-Tracked-Commit-Id: 51397dc6f283bb570e1cf8226017d300d8ea1f5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c3e9027071c979cfa7e48d9c2a39a4d56829236
Message-Id: <162819156602.13342.4703068793610417587.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Aug 2021 19:26:06 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hui Su <suhui@zeku.com>,
        Kamal Agrawal <kamaagra@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Aug 2021 12:35:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c3e9027071c979cfa7e48d9c2a39a4d56829236

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
