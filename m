Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57F3FBDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhH3VFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236628AbhH3VFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 58EDC60E98;
        Mon, 30 Aug 2021 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630357458;
        bh=UW1SnqGjF5hshKy3omm3eviARTQ5Z06ybhx2R/FemEA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g0gRPedF44q2YGre2qFv6zCkgxr3NA+uuwo0MYsrRlleDObOOVLx8DU9NeqxCWg9c
         Cztv407HEQqO+ORCUxdd/1lxMssaljvxJpfwQY3CIRmqIuNx7kgW8lZ5R305+iiCu6
         j3C8O1eA6jmi1eL1Oy6ELA1XME3joOAuDJQ5xTnIkHAguNZ+6j3UuOldeUYTskdkt7
         9s1yA/oMVyPIMcKr5V1qlt+z2dNKk+yFCvMBmCMnV2CAQFpSm0CC98Jwo5HLOC3PaR
         NlYfaY3SKpCWEI75F3c1YYoI3K/qsyKK0FlmWPG8rkPJTfInntHF0ZqQqqEo1C+VFM
         hKe4VCnKf0giw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3336B60A5A;
        Mon, 30 Aug 2021 21:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSysfvjjG6UboKMD@gmail.com>
References: <YSysfvjjG6UboKMD@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSysfvjjG6UboKMD@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-08-30
X-PR-Tracked-Commit-Id: b542e383d8c005f06a131e2b40d5889b812f19c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d3c0db4598c5de511824649df2aa976259cf10a
Message-Id: <163035745814.10236.3166431138247546653.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 21:04:18 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:01:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d3c0db4598c5de511824649df2aa976259cf10a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
