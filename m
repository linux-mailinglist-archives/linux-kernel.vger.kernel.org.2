Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E6E381A52
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhEOR43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhEOR4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:56:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0B1B9613AF;
        Sat, 15 May 2021 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621101303;
        bh=8FRdzytvTaxAy6y7DXq+VN40DGKssNJPsrGb1GD1AQ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TbjcV+j8BK5Qn1QFNZJByM3LGw7iAItnC+rKBOdgLAjmxrr2ujb+2jkC1fqbLgbjW
         snIN7GTMEgMPzfZHhm5NNT22fOoMvanKlRECva/swA1b4auiR4euG15wyaFKhpz894
         Lz833wxC26Mz4yf8310cDnZva9PoG9B+PxedxWzDEm6FYQdbIBC/w1XZzXlyr2vnQP
         zOke31jQvDARYoikTlHR6wWdLWJ0MVW6sTkI8mjhWJ3kMzAjYZf2rjWPjBq7/jyLJf
         Fj7bnG2wQgApaQRkm9lC+m+Fhc1BX4vHnAgkFSu8ZivUWeDYNfdpBJyTKNKC0wGXjV
         SjXQa1/MZfVPA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F32AF60963;
        Sat, 15 May 2021 17:55:02 +0000 (UTC)
Subject: Re: [GIT PULL] Stack randomization fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210515073453.GA78379@gmail.com>
References: <20210515073453.GA78379@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210515073453.GA78379@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-05-15
X-PR-Tracked-Commit-Id: 2515dd6ce8e545b0b2eece84920048ef9ed846c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91b7a0f0637c14ce0d252111cf9bca3830e16593
Message-Id: <162110130293.14651.1541995795200839618.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 17:55:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 May 2021 09:34:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91b7a0f0637c14ce0d252111cf9bca3830e16593

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
