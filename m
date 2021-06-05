Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846BC39CA6F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFESNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhFESNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D5CEE6120D;
        Sat,  5 Jun 2021 18:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622916719;
        bh=7KYBz/oKZyC/NsLkk9MJ4z8alzLXXucMcPXIxcoyKFY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lMr3hJ4Ceiup822nQUPEmO1Qofj4XAarSede7K0cUSirfVHF5YMhevmn2ugYbo/IT
         ItiSCOB+TE+GS+NyeYhTFyj0c2LGb1amzZGHKOxYzY0XZ8TRKtHR9WjNM+9K1gV3Bg
         061yG4n9bJJYX3Jy+hiX+6nnEaFYlgx7R6MtezTse7eTJa+BVVJN34sIOacjXNC/oh
         XCSyUlw2mdY8G6rT5w0zB9ij3v/hGXRFZ5bbP+HVjxBl3COaZDBtANAgXcWi89b4fn
         l7RQjHiKqWrGHyoaaPNwOh2yrAO46Mt6TYjoH0uCmurzvLNaZ2k6yJ2IvmeLXxy2/9
         LPs83blsrgI0Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C44E6609B8;
        Sat,  5 Jun 2021 18:11:59 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-8b83335c-43d4-4912-a2b6-2d609e10d7bf@palmerdabbelt-glaptop>
References: <mhng-8b83335c-43d4-4912-a2b6-2d609e10d7bf@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-8b83335c-43d4-4912-a2b6-2d609e10d7bf@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc5
X-PR-Tracked-Commit-Id: 160ce364167fabf8df5bebfff1b38fd5d8c146c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af8d9eb8407601e3a95206831464bfa6f889df38
Message-Id: <162291671974.15499.15261472941439509336.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Jun 2021 18:11:59 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 05 Jun 2021 07:36:40 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af8d9eb8407601e3a95206831464bfa6f889df38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
