Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32ED3ADBDF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 00:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFSWCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFSWCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:02:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C13561154;
        Sat, 19 Jun 2021 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624140025;
        bh=k3eDDPEgvmkuSZ6YOxFh8Tyiry1Nm3Fr7wLOq5A6tY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LViSjAtNkHInriBadjOdk33uMoTCAcjk+rKJYBxvhN5DA7cp1jOvNv2lipPs2z8VA
         Sr18BOcXQAmVnaLaqs9GunGbWgrhFn08tP9wMP5RhtxkD4vpjwyGFU8ZN/0sGsaKy+
         T3PTtSJ5cxJeZSFlt8t8QijKBVgol43x+bV7qbKKqscQOjIKhHEeoFQU973pmYuTP+
         X33KyLwTmEVQFoo/66ox7DH9CDSWG92w4pwt3l4pIva3VOKGytGuSFhQrfW4D/xJSh
         2sDNcBcN/mbZf+RZJlktm31AH4iBsb1cOY8YSgHjFCX61BW20kfh/FgVQdIQ7gS3xS
         1fokoh/6U8sIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 78AF560A54;
        Sat, 19 Jun 2021 22:00:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 6th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210619165417.871997-1-acme@kernel.org>
References: <20210619165417.871997-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210619165417.871997-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-19
X-PR-Tracked-Commit-Id: 1792a59eab9593de2eae36c40c5a22d70f52c026
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 913ec3c22ef425d63dd0bc81fb008ce7f9bcb07b
Message-Id: <162414002543.7314.2421544741704852907.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jun 2021 22:00:25 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Jun 2021 13:54:17 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/913ec3c22ef425d63dd0bc81fb008ce7f9bcb07b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
