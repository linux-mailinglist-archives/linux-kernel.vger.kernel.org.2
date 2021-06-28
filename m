Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB93B6A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhF1VSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237613AbhF1VRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A320561CF1;
        Mon, 28 Jun 2021 21:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624914926;
        bh=jqM8wxROc4TOar3V1LKzeib9ko6pzkfK/oBd3DmA5ns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HKyEmGekOoApwppiThAk8rRTmZ9/ESn11Jxu5g2oLm+Q2A9XySfNuhEVEnpY83dEj
         F7IfUf5GAGFY/U+L8cVue3laPPGcx2j8zHYm0Iyn502x23kys1NTQKbpVuj+RTT2Jg
         6GrAp8yP9v+thW/bj/mPyNdutDX/3Em+T8qKpqHllkecx4c3sPuHb8zDhm7/3WmDuN
         dTzLGjQ001NdyanPiyM4/g4O/Kd1ZgszkLOuxI4/bdhkLVb1JdQdvQ41zA1EWmFJyt
         qwEYNTKlUGOq9fTKMvSTUNMnB1PvLh9FDePR7iOtzz5Jg2J/OboWCSBrRglpnGMqfg
         dKoQhMskKrIcw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9D23B60A38;
        Mon, 28 Jun 2021 21:15:26 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628150943.GA6205@willie-the-truck>
References: <20210628150943.GA6205@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210628150943.GA6205@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 3d1bf78c7b13a0ad88e77dce94df88400f47e0dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9840cfcb97fc8b6aa7b36cec3cc3fd763f14052e
Message-Id: <162491492663.5391.5145188930230145937.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 21:15:26 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 16:09:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9840cfcb97fc8b6aa7b36cec3cc3fd763f14052e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
