Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF345862A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhKUTm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 14:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhKUTmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 14:42:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 58EB160C4A;
        Sun, 21 Nov 2021 19:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637523560;
        bh=oc+cr+aCb2ZYVdGYDIYeJMkXKZoH5MqM9N5prfUHn18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BblavEip/kThopXNVN7wjFBC1BfW+mUF36THHNanLKIDOO4tP9avfWWK1xZ768H6N
         hZ6Kta1wFMCGjEgf5cyOTf1zqePoTd7be5h6RbvVxRR5nt34LQvTgZxOsjmuJw6VaY
         CdAmudmlDcTTFo2529q9wSVW6IKzJ6EQ4zfAD1egUGNq6t1XuF3kuBOF5EQB3iYltI
         hQx3RsjJY4RFx5l40jJL6TczS0oFZFKqHzszWtKsrDO+uuTszyOD/kdM7KEBG1XkVg
         3CCnLeypR94SkGm9c+Z2FN2aaC0NCaaT/3ciFuQ3K7MZ8+uLltsD9zfEYn04mcmqx7
         OxKiJCvygV5eQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46064609D9;
        Sun, 21 Nov 2021 19:39:20 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lf1iqflp.fsf@mpe.ellerman.id.au>
References: <87lf1iqflp.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87lf1iqflp.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-2
X-PR-Tracked-Commit-Id: 8e80a73fa9a7747e3e8255cb149c543aabf65a24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75603b14ed142fa142976bd962c1b44b8e0d2714
Message-Id: <163752356022.15895.14088560581974981189.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Nov 2021 19:39:20 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        maz@kernel.org, masahiroy@kernel.org, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, clg@kaod.org,
        u.kleine-koenig@pengutronix.de, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Nov 2021 15:48:02 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75603b14ed142fa142976bd962c1b44b8e0d2714

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
