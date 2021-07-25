Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC63D4F45
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGYRJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGYRJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8ACAD604DC;
        Sun, 25 Jul 2021 17:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235383;
        bh=2B4UZXoj6w5El4M8eDloU7fn3Qn4gWVkterPsihMbOQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MdLtw1svGN2wixIjPgE84fVs7FRfIGAN0mbRgiimw65rD+mrk99wXz15z/9DJnwh7
         wn99Kl3l/D0dVTyWWeRl3QsA/bxfAENG4IaAtwYsPSc3YBayUt7iKRSIOIFo6VdcaE
         VsaiQ6JJU8PSTs0LCSetazVtpb6bn5tL0y0kUjY5pUh9Io18lVSRYh7f6I1mUnIKk/
         Ah1vPChJ/t3odQzfrdwCY3x9CpCqQSfRg8/ddAP1tnJSpkB3bPjAGdxwk5LMP6Gt20
         a67L7soCejjBDFJNId8hrc3/oHWS5VxhczyT3iXX4SzEcjyViiYEIYBcuq7WtNAtvh
         Rm7aexDPvz0NA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 77D9D60972;
        Sun, 25 Jul 2021 17:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lf5u1nls.fsf@mpe.ellerman.id.au>
References: <87lf5u1nls.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87lf5u1nls.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-3
X-PR-Tracked-Commit-Id: d9c57d3ed52a92536f5fa59dc5ccdd58b4875076
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c0ce1497a449b0d150b455628947152c5f6216a
Message-Id: <162723538343.30584.4768137691227508273.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 17:49:43 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jul 2021 00:20:47 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c0ce1497a449b0d150b455628947152c5f6216a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
