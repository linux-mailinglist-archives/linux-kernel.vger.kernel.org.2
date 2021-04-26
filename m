Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764436B652
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhDZQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234177AbhDZQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:00:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A828D610FA;
        Mon, 26 Apr 2021 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619452762;
        bh=uH4neTZw9H4nHFb2ieKsg1KBKM5ybcHOij+T+y2luqE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CH5XKWwgd5ck5zfKHXh+YssDwuDf6XO+pIl39he4oRoGfend4MlWGd/oR0cjbjm8z
         L6+M86XdMAAOnuoWQLEWzH5jy5okDnZRjrlrt2xw8HRJ3o5s0CTNQDRhPMh9KZsGCr
         tQsoHMl3a4YW5XT4vJzG0gS+XjPgc9CC0HxSDqpEKbVf0i23HCwd0ej5RU/iqtW7/w
         KkfSzOWW6hSjQZZgBtzr4eVdNgqZrIyfDsRHVYXSJYP6uvD5kLO4sd/S1ZYMdUgmz1
         M173+Qh/8zwzT/tJP7rI3UiJ5Q4Z+Fj7hmUO0TUKQTOZIpLBP7gZaSeL0ycZ/8olOu
         Foe5BPK2m1MZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A29CD609AE;
        Mon, 26 Apr 2021 15:59:22 +0000 (UTC)
Subject: Re: [GIT PULL] a lockdep fix via tomoyo tree for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ec57ed59-7498-312c-4fdb-10cd924c5b87@i-love.sakura.ne.jp>
References: <ec57ed59-7498-312c-4fdb-10cd924c5b87@i-love.sakura.ne.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ec57ed59-7498-312c-4fdb-10cd924c5b87@i-love.sakura.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20210426
X-PR-Tracked-Commit-Id: 5dc33592e95534dc8455ce3e9baaaf3dae0fff82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffc766b31e900e91454d53b8619f0ff5377df945
Message-Id: <161945276265.5751.1305670996106305853.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 15:59:22 +0000
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 07:26:19 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20210426

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffc766b31e900e91454d53b8619f0ff5377df945

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
