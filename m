Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5C36BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhDZXh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235066AbhDZXhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:37:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B367061168;
        Mon, 26 Apr 2021 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619480200;
        bh=XWSutckqn4Hsy0due1bqegTl7ZQjAatSUe7hrMS2/aw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KoeW+M6LkxCdw7+koDHvKJ1fQ+sMiA+myf0qR6/p2KBRMPOBvCVSfq9kk3zZjdA24
         2etL0SShikh7gwcdJsnK5BVDpz+U8BTwgJkN/SgbdExOwyx1qBoFqJEGugK3AQzbRh
         Rq6tCOrrvu+vzqHNkl2gLZeY0VTxkXq0R671LRi99K3q4O5YHqf05Q92Mx0AWjiIR0
         od5UIhIz6dHt8UWAbGT1KTeUSmfdcgA2S/TcrM20L9inawpbzwVtcJjyueysPBD7Qo
         1ofWJUQL6330HCQw35Dip91sj/ObSqFIslyWd4Iei1nhYnJFf+G7FqEAC652obQVGA
         XSsqBsVsvcMOg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AD511609AE;
        Mon, 26 Apr 2021 23:36:40 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426144029.45F7361139@mail.kernel.org>
References: <20210426144029.45F7361139@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426144029.45F7361139@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.13
X-PR-Tracked-Commit-Id: ccac12acc0c0d66b26ce7834e2dcf54ae159e63a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fed584c408c123e2a0a7dd1f630d96b84e7f9e97
Message-Id: <161948020070.27003.6397805198695327854.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 23:36:40 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 15:39:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fed584c408c123e2a0a7dd1f630d96b84e7f9e97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
