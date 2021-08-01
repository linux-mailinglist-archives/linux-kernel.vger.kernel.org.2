Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA43DCD41
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhHAT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhHAT2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41E2061050;
        Sun,  1 Aug 2021 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627846112;
        bh=h7lMpajtRgA6JSFT0rCwE44PESYr/kUlVATNxxiqA6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mYdMc0QgdQ0GGrKNRxqtJ287LBQY2GglcwbrhOzli2GuvZWz7yO0S5SU58TbE9XQG
         B2/FkqtpBcRDlNizjxz0GHEmFG7/BAbZ3m37Y719NsXv6w+Z9ZJspO3oN/a3LBfyqB
         O9kCi38TAAN/mRXXpa7Hu2QblSw8mOuv9K922CDIYkaSFHR0Q3Ne0ksKYme1CTa5MH
         m/j18tSYieQluO0X7VpXRNBS/r7bFmsoOHFRNjFu0kZ2qBwZpJbEASm+gWyfv8McP8
         Jx6zR/7IlgN+eIjKPW6Tljwn/GTwPvGUxkFEeeIeQNIhZ+x2lAinVyF5JirqO9+Vyr
         +o+6x2o6N8xaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3AF7360A2E;
        Sun,  1 Aug 2021 19:28:32 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.14: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210801143904.473154-1-acme@kernel.org>
References: <20210801143904.473154-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210801143904.473154-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.14-2021-08-01
X-PR-Tracked-Commit-Id: 9bac1bd6e6d36459087a728a968e79e37ebcea1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4affd6b6e81443ec8d00de0306ca61911e81441
Message-Id: <162784611223.1186.17070052772026197284.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Aug 2021 19:28:32 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  1 Aug 2021 11:39:04 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.14-2021-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4affd6b6e81443ec8d00de0306ca61911e81441

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
