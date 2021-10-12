Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB942AC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhJLSrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234911AbhJLSrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E2CBD60F38;
        Tue, 12 Oct 2021 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634064345;
        bh=yJMGLEN4kiAm0stsIklFSANLFeAHX2lD2w0VH5TtETE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fejikyBHiUXY2SZEhiywmgvhu6JCHwV5sfy4rSlC3eAKIOAzGoe2uxhhr9SRsjkQB
         pGhVEuXf/luPy9Cicqy+UByOb/EYxEZSR1WkikjWhWAy3stDxdeql7iLhh7C2UzrR8
         gU9PGeT4dl1avgV+5V/zhJ+znzLtNL5x9UJPhmEO+LUUbd1hphGY1BG7WuA1sRzx1n
         svkoA+MQUyC62GAKUulZLK/aYmzurz8+NSaV+OewlTGBhhZ2ZCG4mWj+fZvGtn8qez
         4g6KJEcNMS+VE44Ya41snA1CLSC4IqODDMiSfb9N9auoeju5Kg0+Oxweo3RboVipoh
         weHerVT62pRsQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D6159609EF;
        Tue, 12 Oct 2021 18:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWW+CSv9tLuteHQm@arm.com>
References: <YWW+CSv9tLuteHQm@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWW+CSv9tLuteHQm@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 596143e3aec35c93508d6b7a05ddc999ee209b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4d0cc426f77df6890aa868f96c2de89686aae8a
Message-Id: <163406434587.24253.11671685230581187428.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Oct 2021 18:45:45 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Oct 2021 17:55:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4d0cc426f77df6890aa868f96c2de89686aae8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
