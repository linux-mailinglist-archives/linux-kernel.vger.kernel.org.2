Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A4455160
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbhKRABl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241732AbhKRABP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:01:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CF8E561BA2;
        Wed, 17 Nov 2021 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637193495;
        bh=xeTh/dEYhY17tazF24+Nhdn/qw/Hyvfj2e+72V9LvkI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dWqfbBoo0iEF79FX2Hg8LyBxxTYV795MP9FYXcgFvODBEi2e3N4cRE157xZT5qLLc
         l/vZ2TqUbFa2tBVXaVt1wu5fmcen8miYjbN2J0Mbv7Ei9FJvwzehR0UussXCZZy/TB
         lVYdtIVmJq4thfUM1UWHlJHvYOwI32RuGCrz/FNmNvWUx5UDrohwkhq7FvkUaKbEdj
         c4xgQMIs+ShjIFeA3L0T8DV/R5SZfYu05S6PXKkyOOEG0JmtC0FNiBvCMSAdhGshBw
         rMkaKJ4IbDKIbcP9AAX3HX7YskysjYfvs5p7p+YMuPeybZLqfuEltJ16N0e/6BmBKV
         ZkcUmS0laCPdA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C698B608B9;
        Wed, 17 Nov 2021 23:58:15 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211117233656.77861-1-agruenba@redhat.com>
References: <20211117233656.77861-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211117233656.77861-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc2-fixes
X-PR-Tracked-Commit-Id: 554c577cee95bdc1d03d9f457e57dc96eb791845
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42eb8fdac2fc5d62392dcfcf0253753e821a97b0
Message-Id: <163719349580.8069.10143163990861223565.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Nov 2021 23:58:15 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 00:36:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42eb8fdac2fc5d62392dcfcf0253753e821a97b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
