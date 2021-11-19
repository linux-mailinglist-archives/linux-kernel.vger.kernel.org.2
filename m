Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44533456756
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhKSBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhKSBQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:16:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7FAF2610C8;
        Fri, 19 Nov 2021 01:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637284389;
        bh=Ytk5YwIhhbw8y5O1QsbN+kpY46aLkpSEgdGRP3wZBk4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BjRYj2ZO6wHUKRK9FUcdFCVnhmdy4JGYtAj2pe68suoFP5YBk8w7Eb47FO8E5USmI
         d1XRhMEpz7VkVXDK+08bjlxVh0bw1DVdysn4gDDf/jlcvg0nejXucXIuYJIFmqpmEb
         RG18xQnTsicJGjSmob/Gf6+aSnF2IPBgflM+T30SE5PDnW/x6aCyFI9MLymZT9cpTG
         /ZJaZIbdSDMxGsqvl/uwfoVXNcynEIOGjHOyQh0kzE6ANEeoKwb4bFUiJ6LLTgul+W
         b3oOKkSg/+MXidsD0WGKKju522Y70KphjwltyYR43Gcmt56tMgNdDJ/7qm+cfU8BAX
         NMSeH4hnT6ZIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6A31E60A6D;
        Fri, 19 Nov 2021 01:13:09 +0000 (UTC)
Subject: Re: [GIT PULL] zstd fixes for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1F7E17E1-9B51-4D21-B7FB-9BD3BE4A199A@fb.com>
References: <1F7E17E1-9B51-4D21-B7FB-9BD3BE4A199A@fb.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1F7E17E1-9B51-4D21-B7FB-9BD3BE4A199A@fb.com>
X-PR-Tracked-Remote: git://github.com/terrelln/linux.git tags/zstd-for-linus-5.16-rc1
X-PR-Tracked-Commit-Id: 7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c388a8e740d3235a194f330c8ef327deef710f6
Message-Id: <163728438936.4319.9871804965411245935.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 01:13:09 +0000
To:     Nick Terrell <terrelln@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 21:22:35 +0000:

> git://github.com/terrelln/linux.git tags/zstd-for-linus-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c388a8e740d3235a194f330c8ef327deef710f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
