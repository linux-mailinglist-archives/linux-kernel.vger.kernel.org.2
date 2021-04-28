Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01C836E08C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhD1UuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhD1Ut4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BD68E61453;
        Wed, 28 Apr 2021 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619642950;
        bh=WyOPY3xDhGWRB5CZasXdr2CV+Ehfd9pXZTgxrD5bJuQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZpsiA5ohexEHO/pfWOGGETtzHnzkmeQnF7QDhlBMW6CxHpyocYmej/FYWcVm/tmJR
         wmWHO5A1gehldSm8j32Yqj29CdvWdQAJUxhpp3R2oFFuAnQFh3QtaaPLgTdyqYgceF
         Etz3ygbr7cIiE5QBsi86Ud6IGMVqUo7QPy/tt/0LwCirlbiW8lg4EtUGayhVdesqks
         QJ901um6YibaV7hLmgf2bvlFB+ZNNa3mZHpzA1iload523JwTYp79KSkoseMFx5Y/O
         1RNYzNxyVDJAZK14ghodSJcT7mk8f6XZWoaOlkoiG4g+Q5MGfrtH/Qm+/3OUzu9h54
         eX5eje/4YQf2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B726D60A36;
        Wed, 28 Apr 2021 20:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] objtool updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428074027.GA206401@gmail.com>
References: <20210428074027.GA206401@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428074027.GA206401@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-04-28
X-PR-Tracked-Commit-Id: 7d3d10e0e85fb7c23a86a70f795b1eabd2bc030b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03b2cd72aad1103127282f39c614e4722e5d9e8f
Message-Id: <161964295074.5673.4821131142308982982.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 20:49:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 09:40:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03b2cd72aad1103127282f39c614e4722e5d9e8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
