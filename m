Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B678321F06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhBVSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232059AbhBVSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:14:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6416C64F0C;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017537;
        bh=g3zNeoqYJULiQc2Vo/7c0WbbifNrqJgWmkOSNhJvkj0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=csbwCy62xRTO331nFEua0LBuwXGpuNGmtHv5EaxiNAfcDPGGnYbYMFoDd79NzW36j
         OUyVoChoMqnUIACS6TxMurMRoSGOyD5EMjUS5vhH6bJEW3emYv2xRKv9cNJJO5uhUS
         3gXiseHvIEyDF4w2lF+TgDzpuiK8/SpXX7M7R+0YVhb8U0NpDv+ULLlfH1bOckRxpC
         Hdzp8ewB/wJ6LG0kD+XpVpucWnl8Tx89QEK0E+gSkzu5nPEb29hrD1gU4zzLzG2A7X
         b++FOuLacnzeIekD693sOe/A5hCwrDpVg573xcl2jYlUb163sYi+eYYlKea03BOwN5
         kUhTpKP3SbmOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6022060963;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215204511.0B9DE64DF4@mail.kernel.org>
References: <20210215204511.0B9DE64DF4@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215204511.0B9DE64DF4@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.12
X-PR-Tracked-Commit-Id: f03e2a72e5e8772ba0c2a0fc4539e4ffd03d411b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6560052c2f73db59834e9a3c0aba20579aa7059
Message-Id: <161401753738.943.15593271722723249392.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:17 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 20:44:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6560052c2f73db59834e9a3c0aba20579aa7059

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
