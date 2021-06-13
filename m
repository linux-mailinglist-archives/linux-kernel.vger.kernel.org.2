Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78843A5A4C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhFMUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhFMUTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7197B61040;
        Sun, 13 Jun 2021 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623615470;
        bh=5YkpZ5RjE15+6B7JPDekltCZKh7XScF+l+pnbuJNC5Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Adi1WldE/xGzSSRm8720E7pips3fB0jo3JGNLuyH0vjdW3WQ2f3sI3tSWenML1HeM
         CtQIFY1uyJFCFANyWeoDgLN69E5vBDmg0yMX0Gx6NGgju0aGd/c2xKgEoxfd+zz8sA
         73R85itIsbJd/GyiLXD8BsX3nHltuZuQ91GucfAnhB4LIfPoPVCkHtAQoxsY/xPba1
         WoSyhol3Fd5AhFHdF2pr/+stg59riPc3ZpRmYp9C9M7+cwoThA9tEGQgK8x22Lff+F
         dWEVo76d/DBcfslJiNEwvsh51zhzbv+0KAowmbRFBlzdvKWNM4pZcIM3NpDBR5+uoD
         Gb4SXmFEfPKHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 67A2460953;
        Sun, 13 Jun 2021 20:17:50 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210613141849.718097-1-acme@kernel.org>
References: <20210613141849.718097-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210613141849.718097-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-13
X-PR-Tracked-Commit-Id: 36524112aba3246d1240c1791c72b26fa54008a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4e453434a199cdfa1e1e5cc723d8736f522354a
Message-Id: <162361547041.15542.7232797618226587372.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jun 2021 20:17:50 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jun 2021 11:18:49 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4e453434a199cdfa1e1e5cc723d8736f522354a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
