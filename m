Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636B4434FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJTQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhJTQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E0F9613A1;
        Wed, 20 Oct 2021 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634746566;
        bh=ksXQfp0Nfjr1nFxsWEhn6gyu4DhqenciIB7Rca3KBH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XuKwQ28p1DcCHt/t+4086kCDSO4mJ1ify1QogyxiHUKnyFfCeaii4GZDADsJVZxft
         otcb9E8L4MMf+WQ3UhB0Zqw5W6rFisox7V1vSjKn7Vw8EoYS5szH2gl/8pnc7pwgSr
         wJg1vQMINu9l9GP+UO7Cdlo/lY67mpUxXaTF/f/U5aRwMnMRhB7Xp3mu5fW4z/iumG
         B+Xd3yZxDcH6DRJL5dpZ86BjYBnDP6zW1qEyihoU0GHPTmicbwt8sazO9KiGsGf+sY
         2W9vMjK0ruofInLLbWOxWHOTIysR21Ihwe3AY+phLoVaG6YEBai0+wDRzIMGzMtTzL
         kXDI0vOR9//Kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 681C4609D7;
        Wed, 20 Oct 2021 16:16:06 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211019091344.65629198@gandalf.local.home>
References: <20211019091344.65629198@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211019091344.65629198@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc5
X-PR-Tracked-Commit-Id: ed65df63a39a3f6ed04f7258de8b6789e5021c18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc9b289344b845576aedefe0691a4210987f3711
Message-Id: <163474656641.19537.15428986009399310361.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Oct 2021 16:16:06 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Oct 2021 09:13:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc9b289344b845576aedefe0691a4210987f3711

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
