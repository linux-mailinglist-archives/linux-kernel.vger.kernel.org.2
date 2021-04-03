Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E235354D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhDCTUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 15:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhDCTUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 15:20:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 77F7861351;
        Sat,  3 Apr 2021 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617477639;
        bh=3KxV4BtDB4xZSg3MbK+MqqWm+MbAf/VN6u0KjYNkXdI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A6cMmeG7cvsxFZrIZ84axgdyEQBB5vSWS3XIUhapIz8mGqWzxYfjhXhX4KZ/BK9VZ
         SSNUC/shzMXSEaiTgNtQlhjdAKJoOOjdcZu7iAu11wGq6DQd7rXOqioGHQ5/uAxeIb
         jqWNZRcYeVynBpDFQfme5rDQ3jbTPGujpmTtK5qOf8/q91Sinhr/+hb91cbxu8rXin
         m1L6o6NADh5z1ZtFTGfPD15TyrSg87DWgK2pmf3u4ZPUeef9LaHYNNcg53Hx2DcHOM
         OM91UYiREwzNnjjAfJavITtXJOu4vT+RQIQpUfkymvDxb1XZWiCEfzKK8/CliMePVu
         v+3ayF8kRVcfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6562060953;
        Sat,  3 Apr 2021 19:20:39 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-7c342428-c3ce-4ed5-b311-cd79458c2f32@palmerdabbelt-glaptop>
References: <mhng-7c342428-c3ce-4ed5-b311-cd79458c2f32@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-7c342428-c3ce-4ed5-b311-cd79458c2f32@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc6
X-PR-Tracked-Commit-Id: 1adbc2941eee8acbe3c7dc6b51cdbc5a9bf19565
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fd7d5c20129d2227b95cbe567b24559f144b77c
Message-Id: <161747763935.5640.13928104203299163960.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 19:20:39 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Apr 2021 11:39:36 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fd7d5c20129d2227b95cbe567b24559f144b77c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
