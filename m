Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E972E3545FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhDER1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234018AbhDER1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:27:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 81D5E613B4;
        Mon,  5 Apr 2021 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617643623;
        bh=BiDyJc1S1gUSqLJmvDYKO/gwaNnN8QWy7sh4C8wIaaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kq5hbfOrDUbfCOupDAREjSGpKkTmUZjkD3mA/GhVZ1dnWgknZMk2Hq/4Gzcgk605l
         xPFgF0wUYkd0BCSPlaxhtxKjJNLqTSCM/zMzacoQHu9Y+1uGbhJKvhuO7UQ6131GVj
         qHgkIRDKIhf02jER/ZSgpuiwEUnyBNqBl9j6ZppxD5Atno3HpfxuMPiOgQZUbD6VQ2
         MGNF9hepXl6np3G5XZFIKDtxl885HZAJYwxPUa5Dbh4ho53hT9uumy2SfqNDDzaoIa
         GYki3Ja41VV50sxu8aq+fg9q0rG2WMqPvurXZILhfxjHz6jAsHgx2KjqYuF+okF6N4
         aV6+rNVJJif6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 76CB3609FF;
        Mon,  5 Apr 2021 17:27:03 +0000 (UTC)
Subject: Re: [GIT PULL] wq fixes for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGrfb6lPelb7Gcbv@slm.duckdns.org>
References: <YGrfb6lPelb7Gcbv@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGrfb6lPelb7Gcbv@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.12-fixes
X-PR-Tracked-Commit-Id: 89e28ce60cb65971c73359c66d076aa20a395cd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a50438c84363bd37fe18fe432888ae9a074dcab
Message-Id: <161764362342.10684.7702591378491028163.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Apr 2021 17:27:03 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Apr 2021 05:59:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.12-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a50438c84363bd37fe18fe432888ae9a074dcab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
