Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B809144259D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhKBCWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhKBCWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C605260F0F;
        Tue,  2 Nov 2021 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819609;
        bh=uQl6cO8dcGtDqGSCZKOCifxTFjPPzsfeMqwtHQLojEI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P4+/opj6uL6LXCiZOmzOY5gR3o4+PXGZXpJJ6mtIhHRyl+6FgBgw3fRciLnqeBCCO
         IDifEk1s0CQ4tkK8gCbmq4EnTbDQnFOb7sm0JSS+Hwyyp4Y79JYZv3wT3yzeL67tyP
         vWLXqFP4srHFYWp+HdmnYsSUL1qhC1kCEFXurRS4Sfgq7QkznZcCorSCMQALWLo7yT
         j+3NtaD3ait+1WdQwEYWcflr22Lcx1NG/FzwpatavuXf4fUMIEnEx5aV+KdfS7/hC2
         VoFuo3StuSrRlfn+TJoyD025plUcoJGWCIII3tWVW3oWsnC+/M5hXzJIDxB+yxvCru
         EHmsazMKSzWlQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BF86C60A0C;
        Tue,  2 Nov 2021 02:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101152117.5E62660F3A@mail.kernel.org>
References: <20211101152117.5E62660F3A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101152117.5E62660F3A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.16
X-PR-Tracked-Commit-Id: 7492b724df4d33ca3d5b38b70fb4acb93e6d02bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1260d242d94ae423c585050bbaabe9064741f419
Message-Id: <163581960977.22980.17418637509532006710.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 02:20:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 01 Nov 2021 15:21:03 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1260d242d94ae423c585050bbaabe9064741f419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
