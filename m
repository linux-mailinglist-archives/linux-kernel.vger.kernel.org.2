Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0DD427BD5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhJIQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhJIQNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:13:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 031DF60F48;
        Sat,  9 Oct 2021 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633795886;
        bh=Zkm9WMyVZJvHlnzzyGSk2xNb4qHWVCVklol1no09I7Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kBpEHw6yB9t68qgY+pD6fqIGJ/py+k+rDej3aDqBe/uKhu0oLT8yB+EYgtWv79ELM
         Ugmhlp2ELWRyUmdT3jzCxgzh3w3GGD4dOF+2OUk0A42nbAvi3pOQW0zue5fgwp3VHE
         J2eB1IPq8F1b8Nw1fHFwJ1ziPkgmSUh0Phiwirtv23QyTrjPriFuNEd9/R1Kux4qYX
         nMEDxIlDea5Wlf34GWc9Ht/Yo72KKaN0uW+TjARcKa/kwOyVLs96ePT5rhOLI9GchV
         /ZJHRkQFqDIu4GwYrmeVKrOWdyKVIY7gv0BtXdM5bgO6AeRPNuuDmHI5BkyALtzc19
         4ST6VT59MjETg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EB04860A38;
        Sat,  9 Oct 2021 16:11:25 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-26107d68-d2af-46eb-a8a4-43c1496a9ef4@palmerdabbelt-glaptop>
References: <mhng-26107d68-d2af-46eb-a8a4-43c1496a9ef4@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-26107d68-d2af-46eb-a8a4-43c1496a9ef4@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc5
X-PR-Tracked-Commit-Id: 3ef6ca4f354c53abf263cbeb51e7272523c294d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 717478d89fe22df61a4ecf73b1adb31b5f8d1bba
Message-Id: <163379588595.23991.2589894586404146995.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Oct 2021 16:11:25 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Oct 2021 21:38:14 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/717478d89fe22df61a4ecf73b1adb31b5f8d1bba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
