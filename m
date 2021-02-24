Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5555A32440C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhBXStN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhBXSrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CA7A764F11;
        Wed, 24 Feb 2021 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192394;
        bh=bxSpYPF1Y6BcoFky5dWPulKSKawFTHQHcWAEAQXJ0so=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XnYCsFDv/Z92q+SPVNpEYwteVVXuCnk/NBsYE2Y3dTfPSnsoVz+jF009RXCKK1Uc3
         n7LBBRedwPYQJ8432ShwR8h3SyWBGt6H4rsKYoLwThUFbOfS2fWAXmFmTxNax1D9vW
         8sKnILP65NOIjFsF5pWj1/hSxGXcYdvfcDtE4s95Y5nzfzV35YYQaj+CinDAwP6Mbg
         G9YGKINbJfFnLf44CaaNiCAbYu/aS1Besi1nMNMT/bE8SMHYR3tW5mQhMi+ePtOM9b
         t8U1rWYw6va3afZUoAx2dot+0BqdxQfOaTQ/k2geyoAU/phR/HdqF3leNy7aPjGN7Y
         fxMdDNt+ggWNQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C2F4960176;
        Wed, 24 Feb 2021 18:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1kZ-6Lo5z3h0tcSD_o8GH9uCdd2d9+2xvVV22+2hRTcQ@mail.gmail.com>
References: <CABb+yY1kZ-6Lo5z3h0tcSD_o8GH9uCdd2d9+2xvVV22+2hRTcQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY1kZ-6Lo5z3h0tcSD_o8GH9uCdd2d9+2xvVV22+2hRTcQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.12
X-PR-Tracked-Commit-Id: 6b50df2b8c208a04d44b8df5b7baaf668ceb8fc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b817c931233b24129ac8d2c858669ee656a473dd
Message-Id: <161419239479.20610.10982218695374145754.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:34 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 22:51:04 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b817c931233b24129ac8d2c858669ee656a473dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
