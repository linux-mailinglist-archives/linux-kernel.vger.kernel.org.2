Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1836A874
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhDYQws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhDYQwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:52:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6B9E86124B;
        Sun, 25 Apr 2021 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619369527;
        bh=DXaRvJX1b/FLnxAe1i403lzf//Eky8k50+97Im2JqN0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=amBu5kR4Aub1imX+rv0dbawQMEGx2xGpUi03VADaMGaGVuGcMnuVXIJUBsOvMUXdw
         bAxvASFJy5xPLH1yTLGFLQewvHsvcWaTRNvzYIRVHwV9NgxrNUH28Pibwx3dW+PDSd
         D/e3fdRGNNTOlBf0jAz7HMH1bhs+fdwOTo9qnBaC5kneQHUSt277Ta1/BemyTs6eS5
         zalaPjB9aNaw8JUfAX088P37umK48EQ//FG4djXpKThZa6/Ofh6myUdWmCsyXfyN25
         2jG4Z5PcfxJy2B4PmQ/q3GNuQJl6KfvRx5y6EGZkHB/kUM8UOYoJMecA+hUaSTP0jF
         EdG6L7jDAnj2Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5FE5A60283;
        Sun, 25 Apr 2021 16:52:07 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.12: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210425142918.2469270-1-acme@kernel.org>
References: <20210425142918.2469270-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210425142918.2469270-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2021-04-25
X-PR-Tracked-Commit-Id: c6f87141254d16e281e4b4431af7316895207b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2d09fbe33f80ec17536b6a687ac5274feb927c7
Message-Id: <161936952733.1859.11138592948747205099.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Apr 2021 16:52:07 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Schmidt <alexschm@de.ibm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Apr 2021 11:29:18 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2021-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2d09fbe33f80ec17536b6a687ac5274feb927c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
