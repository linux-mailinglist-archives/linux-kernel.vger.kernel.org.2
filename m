Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8541309827
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhA3UCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhA3UCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8F36564E13;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612036880;
        bh=h3yiFeGtDdkyP966NeMZXxypjb9ER8N5jG6QqOVFOP0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SdJ54BvZ0LAxj9/FpKC+68usAEPt14drXRDv2CaJ8J12OZMzOi5ntlZ/LRVwUcmx0
         WpW9bmqItMv50K0Q5u/xCGKkefEf79Ymp3ZQLKF5iisitKcrHjmKju98nwQhySm9Ed
         CvRq4gHLDF3ZMdwAxbODTGWLykmTFQ7oQJDlFeymDNmZ96vrXKSdYxMeCF6itKRNAd
         OK0G71K+PN7+MMXCosyGnhF3r1rUnvqI/wHJBgygJFV8HAm4EdRXAlw4cCJM+cp+jj
         9OYJZs5dgq03wkfIUzF2hp8x3fHI/za1mE1a84F1SAsH2+yVvai2dPbPdto3Rw59Gu
         q4sVc/aWeFNOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 806BF60983;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] A Single RISC-V Fix for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-72236532-fb2c-406a-9a7e-509c579364c5@palmerdabbelt-glaptop>
References: <mhng-72236532-fb2c-406a-9a7e-509c579364c5@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-72236532-fb2c-406a-9a7e-509c579364c5@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc6
X-PR-Tracked-Commit-Id: 336e8eb2a3cfe2285c314cd85630076da365f6c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e37c0fbabd8e1d50bdd6cd0a1a07b72e1048a9d0
Message-Id: <161203688052.22475.17138244263808539799.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Jan 2021 20:01:20 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 18:52:51 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e37c0fbabd8e1d50bdd6cd0a1a07b72e1048a9d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
