Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8098940114E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhIETIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235479AbhIETIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CDFB60F5B;
        Sun,  5 Sep 2021 19:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630868833;
        bh=fdPqun7GMHXgxN665LHlKYd0ZpkzRvCRmLmfU7a82X0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J+evpf64v9OexXPngM4vgezuN257dZiJv38E9W2i6IanNRVK4TBc8CK3uqA20aV4f
         wkBWqmR8Yy2404bouOpb3Ce0WlJZM385Nw0mhDJN9tnv8TzQkY00KeyHGC0pqXNdY0
         OU6gb6G7wEd1Dky9pk/xOJ1i+P3D5/Es4ymGIkL0YYtFyZrYrPX94Wc2WxtELy4Ggp
         JgRgK/R0pcEkcKStx3qcjJWMVzG3dGl2HJQSBuGWD1cbUwmizbZv6b36piN9JFiQbx
         0dxYUQvRqrPYWr/ebHXhNWZp2u4WXNpd5B91gOGBeUH55fVt6iXrraOpNwM6BW0eqO
         xKWgkiam/zm3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 02BED609D9;
        Sun,  5 Sep 2021 19:07:13 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210904184924.16279-1-acme@kernel.org>
References: <20210904184924.16279-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210904184924.16279-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-04
X-PR-Tracked-Commit-Id: c7a3828d98db2730079265b5f51933dfcef8bb5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27151f177827d478508e756c7657273261aaf8a9
Message-Id: <163086883300.6256.13962330438613798761.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Sep 2021 19:07:13 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alyssa Ross <hi@alyssa.is>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Colin King <colin.king@canonical.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Eirik Fuller <efuller@redhat.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Joshua Martinez <joshuamart@google.com>,
        Leo Yan <leo.yan@linaro.org>, Li Huafei <lihuafei1@huawei.com>,
        Nghia Le <nghialm78@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        St ephen Brennan <stephen.s.brennan@oracle.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Sep 2021 15:49:24 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27151f177827d478508e756c7657273261aaf8a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
