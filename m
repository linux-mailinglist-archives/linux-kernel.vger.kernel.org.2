Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA27E320DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhBUUyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhBUUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:54:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E8B0B64EE0;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940826;
        bh=QKFU6lKpHAdBuyZC+4uFBuF/Kn47bl/Vf/k3D6e7bGw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TGUtdG3uPHCXejVkAYJuUWeoLCCKhqhepGVCo9Arjv1tXz8Z9G0VxB3uta5RYCZzY
         jUZO2hSpz3xboeayuRkiSsfGOiLsZ1iJOaw4Qs9+1qR8w/vmNs5rFej/lX6MzYLFZ5
         Noi9QFyL4RKaoOfv8aU4lqzcXIh3EPnWvSq5P+hR/TtzuBM8r0jJuaDGRhNIODBHsh
         HEdgp4kdrdMHSHYGwrxRDWKMU4hBcaQofnYH4iWMj+FqYGkSj0L4Lt+GZEut9vpRHC
         PgTxksBUBcIm4zEsAMlHJOHgOPqp9ThBWfI9F3KogtHpaCY0jZ7/3ExqZeXul7nU/P
         FC6BoQ+AgsLpA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D9F1E60967;
        Sun, 21 Feb 2021 20:53:45 +0000 (UTC)
Subject: Re: [GIT PULL] core/mm: Fix (soft-)dirty bit management & clean up the
 TLB gather API
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210217114833.GA145460@gmail.com>
References: <20210217114833.GA145460@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210217114833.GA145460@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-2021-02-17
X-PR-Tracked-Commit-Id: 8cf55f24ce6cf90eb8828421e15e9efcd508bd2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b15c27e2f7b6d114770c2922b2c49d2e8f3867c
Message-Id: <161394082588.25590.18174385884262626300.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 12:48:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b15c27e2f7b6d114770c2922b2c49d2e8f3867c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
