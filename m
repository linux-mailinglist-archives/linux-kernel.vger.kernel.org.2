Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828173BEFCD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhGGSsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhGGSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C7F8461CCD;
        Wed,  7 Jul 2021 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625683533;
        bh=gTuxEqJfVEMQwe/ZO8qPWLKh96UDDnAlA531/Ulhj7s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VMv/zWw8anDpL6PEAPWoe96DuqOfRGVILAOKbaA9gclc0JfMBAdtTs5Bbwk1prF3b
         2xo0eg0Rd8jmRZ52SYSE/qrwd5zIg+mjEmgYmUNlu9h4BEOAcXThx3hb2jA+9lL6M9
         JGivH0tBGb9Cr9IRwwuLcWFM46PmfNd/0HgeoKNrpoJlna5ynLyCDYUaOToECI/7d9
         eGXX3JW1MWwc53PrA0o/tPx6ze+SZEClkxsaPZar4FNFj9SeJJ8UuJT5gH4bblyuW1
         R1AibJ2jW07O0dJpPG7QtGA7Wv0TmBbAt9+FklLQ0FdEFtwDo9A3c7/zrPbNUQLjp5
         j1UfmggYl7ifg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C21526094F;
        Wed,  7 Jul 2021 18:45:33 +0000 (UTC)
Subject: Re: [GIT pull] x86/fpu for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162565008209.29791.8510279419712030267.tglx@nanos>
References: <162565008209.29791.8510279419712030267.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162565008209.29791.8510279419712030267.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2021-07-07
X-PR-Tracked-Commit-Id: 93c2cdc975aab53c222472c5b96c2d41dbeb350c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1423e2660cf134a8f21f2451865a04792013e49e
Message-Id: <162568353378.3837.123412378491908449.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 18:45:33 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 07 Jul 2021 09:28:02 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2021-07-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1423e2660cf134a8f21f2451865a04792013e49e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
