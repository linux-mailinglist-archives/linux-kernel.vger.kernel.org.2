Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BF32322A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhBWUd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234325AbhBWUc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:32:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 16FEF64EC1;
        Tue, 23 Feb 2021 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112336;
        bh=95Oh/CQUnALhNclkImD21/m82D05incyg1IOkqcJji8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JE6B5tWlhFO4OramXAUKDOEGUh8VRRcOj9/P6luPY8LSzvN2vVAVVHDU+nqmeX2iz
         DAHkZzD4QEjC/kShn/KH8/bWEZJttWfFMWv5YYmLaN3irZuVYRCScAhMoizu1sq2gs
         Pd3ezXGMLcIzPkI60TyvVoLL3akzIobvCGBfZthxem2HEX5hTYFOet0GdpWZnM3wJx
         pPzM6PmCD+8tC0zxt7BLsnDE1tMO74XOGctjny9CNQben1l1sTXhdVG/dI/SLPAUrm
         /l07TBIGlBX/lAs3ePpKEl3AmozskmWHhoJO1jnqx7NC1hV0atnQ3EtLiyFdxe6HdC
         AEgoTKyI65Z1w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1337B60176;
        Tue, 23 Feb 2021 20:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e90de819-ecb0-cb69-3a05-f75df0edb4fb@monstr.eu>
References: <e90de819-ecb0-cb69-3a05-f75df0edb4fb@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e90de819-ecb0-cb69-3a05-f75df0edb4fb@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.12
X-PR-Tracked-Commit-Id: 48783be427c70a377c83a17d045eee98c90220da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74268693e0f751381688743a48e37cf63a45deef
Message-Id: <161411233607.28784.4450544380109295204.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 20:32:16 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 15:22:27 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74268693e0f751381688743a48e37cf63a45deef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
