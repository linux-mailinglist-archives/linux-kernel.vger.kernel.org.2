Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5E35744E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355320AbhDGS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355294AbhDGS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BB8CE611C0;
        Wed,  7 Apr 2021 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617820090;
        bh=cCzZXNrMRRC80ydYBW+yDhSEfM2uPDHTpD2ThNp65/A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PfTDeB1wlo08D+r9Z8bduDdvXae1aV9+NavLocBii85mrfT9A042faX8W2AA4q/ED
         ws/u+6bbOZFJfhbVjUAo5lM3Us1DuXituz++u4FhMNjYUmEVaDC2wiMkoALMqsRXyP
         HxmAqYfqb5wI8sYL9H2YFJxGv7eu3B6SHBLBlRFC52XEJScMSjW6x6dg80cd4XAqLB
         8x56XgUHpGK+Wva34Ax5CE6sfbYKv0l2WRncK9lHyzLw19ZIZPmKHhJOzuhYKO2gPO
         87K69JeHHIl+znsFQDiPpzCGCUowjQ3UY6iAOr7SWiLl4/jMRwxJLMvNJ3OpuhP2k1
         h56D/3jqO0M/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B6D3F609D8;
        Wed,  7 Apr 2021 18:28:10 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210407125410.DFA6B6113A@mail.kernel.org>
References: <20210407125410.DFA6B6113A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210407125410.DFA6B6113A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.12-rc6
X-PR-Tracked-Commit-Id: 1deceabbdc0dd3162def1e26acb2e57a93275909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3bb2f4f96a653f85b3bf19bc482064d47cdb98c
Message-Id: <161782009074.7121.6760399360036758555.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Apr 2021 18:28:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 07 Apr 2021 13:53:41 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3bb2f4f96a653f85b3bf19bc482064d47cdb98c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
