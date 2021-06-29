Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C123B78FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhF2UA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235033AbhF2UAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 47DA061DEB;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996662;
        bh=N5ElimLm9JZMAfufjk4oerlVc2+NsFmpUmVwFkTAHHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rYlrUiRkcj7mUk5r291PpvUnist61g921mMNMmtIyRWQkIUWXAObB3oK+gLEOWVsx
         py9hp9gd5SzMOuE5UufJng7Upli4T5V6aSFfx41mPPmtTLlj2PCjNiscIT66qKX5rh
         wCQa4YF3Imj2dSXz/lSWoYqiRSY90Ozx9/+Cdjb4RVHTU/Pdvy++CrOGLfJbnCKsLo
         gl1v5/IOFI7j1oxl95Obd9stma7NgMvtoqtiXL39vMx4GIHVPG+G+Q21SUgwVWNZ0Y
         lS+ArkeHCuaQrHPbH/iT8vjjoUOz9gifYjbshqSgNeiHSzZWjbW8di6OHTV9lT2qIG
         6Z/11wVEu6iYQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 402F4609EA;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162497731576.6531.7816162765274356961.tglx@nanos>
References: <162497731214.6531.6083197571290189651.tglx@nanos> <162497731576.6531.7816162765274356961.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162497731576.6531.7816162765274356961.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-06-29
X-PR-Tracked-Commit-Id: 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a941a0349cf11ed250a04864fef268c2e05a1d32
Message-Id: <162499666225.30376.11309179729769227678.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:15 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a941a0349cf11ed250a04864fef268c2e05a1d32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
