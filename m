Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74F6322243
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhBVWkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBVWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:39:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9CCE664E31;
        Mon, 22 Feb 2021 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614033557;
        bh=FpuZ12EzRhnr/TUcuH8bjTCRQEIhkdOozLVZpvb46wE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PsRWz8KTo9ydRy/E8Bk0ar9+uZ4wg25rc1XOwIhVlffd1PIRQRtt3BnR8iTQvjFR7
         6y2uLa5bS5RY7sqYH6GlLCzG9wnb1U+yDfvrA4iVicucD92g/ZD5dp9A5gzFuB3YwN
         I1hPH9TyQfytSSYwavbGKVETM/MkG1uROX2mSe742qbAlXqGcKTcnUeaPxN5fh64wk
         Wr+V+lNg4mZT5fp3oKo3YUYoRk68oFOsAS3HiNnvsXvPo3Jb2i1/OVf6rJDjpVJ82z
         OrUDAcdQ1ZlLVqHtaJpCJjDpU9R8Vcr2pFiWQkY2Vy+mfu4VWd6x8Iq/3xWiEe4kpV
         PGof+4+1Jax9g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8EF22609CC;
        Mon, 22 Feb 2021 22:39:17 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210219194619.1780437-1-acme@kernel.org>
References: <20210219194619.1780437-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210219194619.1780437-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.12-2020-02-19
X-PR-Tracked-Commit-Id: 3027ce36ccbae74f2e7c1afbfc3f69fee0c2a996
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a36281a17199737b468befb826d4a23eb774445
Message-Id: <161403355757.914.3841151125844310818.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 22:39:17 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Safonov <dima@arista.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kees Kook <keescook@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Mike Leach <mike.leach@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 16:46:19 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.12-2020-02-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a36281a17199737b468befb826d4a23eb774445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
