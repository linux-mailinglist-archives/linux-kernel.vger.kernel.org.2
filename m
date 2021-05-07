Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E116376A92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhEGTQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhEGTQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C84496135A;
        Fri,  7 May 2021 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620414939;
        bh=3eNOhAaGDsdMOXsH/imlsl+CkkzbJM7QoqTZoigCLCo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tImiMRfV5LURFSuYmaPA4QQdwCP1tpXKN++qmfqZ1sZioQRYkbddPe3B4sORCDJIL
         eZ7Spd5MGN+0qXJW8gEUfjoVE9mKMhf3JKlw0AZVD/N6cgiPmSxhDLGPasOSKljHNU
         sb4vFFTgNRmhLbUVMkoFa5YRAqhx1T1xQMMs0005cBgufO4Wtnb5mnEMBj2JDUp7y/
         Hu7wYnLmZJFDm3s1wNddbZjCDnFG8f4VezYeGcILcdRLx8S7nB77kTS3XOzRjsEnQa
         yidCbsEoOHew299+HhTSAFBPmZrtVSjlPFWivkXNAseTnn3JCMBVlm5V74hmDMBwBb
         /z9EhIZHr82Yw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B4E55609F6;
        Fri,  7 May 2021 19:15:39 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.13-rc1 (2nd set)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210507165302.1626-1-catalin.marinas@arm.com>
References: <20210507165302.1626-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210507165302.1626-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: c76fba33467b96b8234a1bbef852cd257c0dca69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51595e3b4943b0079638b2657f603cf5c8ea3a66
Message-Id: <162041493968.19340.1690423367691488352.pr-tracker-bot@kernel.org>
Date:   Fri, 07 May 2021 19:15:39 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 May 2021 17:53:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51595e3b4943b0079638b2657f603cf5c8ea3a66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
