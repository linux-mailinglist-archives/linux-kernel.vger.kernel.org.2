Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23235A97A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhDJAQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235231AbhDJAQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1EECD61105;
        Sat, 10 Apr 2021 00:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618013786;
        bh=6iGxlUKMXyqgsleuRifv0ybB3/9CfwefX2uJdip9540=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hXso8hSUVPGt3qVpMwfjAyynRqTFH4xu1H8YRLaTLw/O0C2bslI4Ez/OK6ZO/Um3U
         obMF19RnkzTqemEB4Qd/JYpZOl9GsVIvjtZ+apewLjOkNOmAzDaODD3G7LNuquRicq
         7I935MjbOZ8VtVAv8FK5owXm6L/Rd2/pFXfghNunHvhlMP5dBneGHshnM0qtncgwaZ
         cazm8cA7F6B4wNyLbfA0qgCJMySHVwgvQdfgo6ba1jy3MI01/C8E2Dqhc3KbIVCy4n
         wt036nxtlxFSIppBaZzabAHlnqIHijQQRcEW7u4jPWJ6LZydHSZghBmkByPVHFzj9l
         cBrBENbwXonUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 025D9609F1;
        Sat, 10 Apr 2021 00:16:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.12: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210409183744.1932507-1-acme@kernel.org>
References: <20210409183744.1932507-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210409183744.1932507-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2020-04-09
X-PR-Tracked-Commit-Id: 92f1e8adf7db2ef9b90e5662182810c0cf8ac22e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9288e1f7d396b7702649d78f2c711c3e0020c71d
Message-Id: <161801378594.21932.6673758935828189002.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Apr 2021 00:16:25 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Apr 2021 15:37:44 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2020-04-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9288e1f7d396b7702649d78f2c711c3e0020c71d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
