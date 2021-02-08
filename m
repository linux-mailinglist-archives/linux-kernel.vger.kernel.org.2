Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A43141F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhBHVgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234137AbhBHUuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:50:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4673164E74;
        Mon,  8 Feb 2021 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612817407;
        bh=li2NAobTJG3oc0OG+xvjZKwIuUSVHXfc4xUHq2heFdo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i4B/+GVFKy2Ogn0fCNGoTEcnbHboVGgd/BgxvKXRPO6vrEyrZ6vr+8uPITm4Nbq61
         mcXce+uDOa8P3XoEMwYwNeSk1JcxWQ6EDVQoHlwp3Lib2mwFR9Y9BTOBxkcvv3iVzr
         q8tvd1/gQkdiuLKZM3dmmBrL62xyXE6YaoV1RE/PftPMjjPhghV8Vb3JVMpzosmZJL
         o4QA4XALDw6Szd998AnnadBPzO+QCMor49Fo+oz/aytSZplRUNlqVne4URIDo/YFay
         TzHac4DpfILHX05G2bO+aGdQt3tuKHNeYcO+5LB2SLkrqP8UnnoSxGs+8Un5XWAS6B
         wCT/2VIb5Yj7g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3278460981;
        Mon,  8 Feb 2021 20:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix output of top level event "enable" file
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210208142258.643b54a3@gandalf.local.home>
References: <20210208142258.643b54a3@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210208142258.643b54a3@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc7
X-PR-Tracked-Commit-Id: 256cfdd6fdf70c6fcf0f7c8ddb0ebd73ce8f3bc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0756cfc7d7cd08c98a53b6009c091a3f6a50be6
Message-Id: <161281740715.23853.3666136256611303440.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Feb 2021 20:50:07 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Feb 2021 14:22:58 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0756cfc7d7cd08c98a53b6009c091a3f6a50be6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
