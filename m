Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9376535B6AA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhDKS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236357AbhDKS4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A43B361003;
        Sun, 11 Apr 2021 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618167396;
        bh=FvMBrRx3xwA19Pu7TODMYXWhDmxG4FQqClQK2sVSsd0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=buobOlO8Z3uelrOtWHi8FukSBl8XSswpFUgJv1XiWpPTofPlhzGn+IkDdxiykeGwE
         1heB9fPYzE6oDK9PrLif2XpO91iLdAJOg8mJKBmPYmUxgPSlhfddkO60dntZm3/+Lk
         BF9Bc3nFxNmBJrArSPp4fz4Oq/mStjfz4u9G5ZKv6uW6+oL4MedNQITZ0x/gMw6ul8
         10U/eI9RVNhwkrRNFJ5iUQvAwr66ynFyHyOOyuGCrguHz1OUU7Bsh362+IFOX2Xowg
         2B2utjfvx9lV8qggl5hdRgx3YwEKFd9parszEpPi/SLDsku1tw8y9Cl+hvL/o8GmEJ
         O432712FFp9Kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9EE54609B4;
        Sun, 11 Apr 2021 18:56:36 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210411121453.GA1145123@gmail.com>
References: <20210411121453.GA1145123@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210411121453.GA1145123@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-04-11
X-PR-Tracked-Commit-Id: 6d48b7912cc72275dc7c59ff961c8bac7ef66a92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: add6b92660b3dca65465d3bd7710b4b1338f34f0
Message-Id: <161816739664.6502.4676125777566962072.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Apr 2021 18:56:36 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Apr 2021 14:14:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-04-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/add6b92660b3dca65465d3bd7710b4b1338f34f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
