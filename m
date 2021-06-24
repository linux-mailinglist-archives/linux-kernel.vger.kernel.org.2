Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC63B3401
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhFXQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhFXQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5F17D613EC;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624552446;
        bh=xje8wIaGQ5ia6f7UyFDftlInuvMNKqx+ewccszyvvR0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nZHN4ojPy6PZfJ0Bee0erbx2s0d7qUbopq5161ekbNj6d5HDzjGvIn0gg9bUw6VFI
         YRp/ezQJuk4Gqv/MWaZeMfurI+mpH6hRabCRmkqA5S+i7gJQ25F8ApauDqZnEd43tY
         EGQkb3cW3WxBsjKeyPXjnflLWeehNEKDp47RDntO17rQwBiFhqnf57UBSC9V46gz1R
         z+UU3zns6CYrVaoLfCS0x2pQIBDwCiEfEMuofq3iK53Fsitj5bhfTOklrQB67lOUDW
         75XeUbHz1MER/zjA3qolPzlm6VWvSHE03n6cZu5mpTKZma7MEx+ng0+6RUEJVuflYj
         lzBD/minlvspA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 59B8160952;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] sigqueue cache fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNQwgTR3n3mSO9+3@gmail.com>
References: <YNQwgTR3n3mSO9+3@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNQwgTR3n3mSO9+3@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-06-24
X-PR-Tracked-Commit-Id: 399f8dd9a866e107639eabd3c1979cd526ca3a98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7749b0337b4e92d83f7e04b86434dcf4fe531377
Message-Id: <162455244636.8751.3260006944334329783.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jun 2021 16:34:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jun 2021 09:13:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7749b0337b4e92d83f7e04b86434dcf4fe531377

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
