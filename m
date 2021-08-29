Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1E3FAE2D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhH2TsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhH2Tr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B1A660F39;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630266425;
        bh=nmnVsDlLRxR42xbrYiG0VsuIrICUST6Eq684rM+eCO4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fs0ZcUnBhtQ5NPmSuikh2KDk+jUt4IWCTeiGJlNtE1xGiCBGqYzn54+Zo4welooDd
         AbpmZui1HTFNwPF0gSpQzFYhxgx9waC/Ql05CPJJLupDvWxaxcSJmR1z7AHXsJ+bbK
         CkaM4+LSCrFGLthBYLSWsyfTLgNHGGCESugYgLjfvilxtiI4RYRTDPX7U+TTy8iZ8c
         MNT0GUAarb/adV5DlF4RPCRQO3rlgbXuf7wDQLW/FqaluH2gAxcTL+wCfy4K3MExuU
         uFxaxEXN7nIqjq1nLiiehDt6f7vXkHhX9/tV6GukpN3FaObBFfZPevGOl6tEc/xwPP
         qVQi/Lz/rMKrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6ED5C60A3C;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YStprPbm18fl8JC6@zn.tnic>
References: <YStprPbm18fl8JC6@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YStprPbm18fl8JC6@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.14
X-PR-Tracked-Commit-Id: ccf26483416a339c114409f6e7cd02abdeaf8052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98d006eb49cba379c50536b5de24f05df927c126
Message-Id: <163026642544.27261.16610468030724849033.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Aug 2021 19:47:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Aug 2021 13:04:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98d006eb49cba379c50536b5de24f05df927c126

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
