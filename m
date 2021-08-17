Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A933EF2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhHQTuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhHQTuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DA1961038;
        Tue, 17 Aug 2021 19:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629229790;
        bh=C5IN921zOMEhKY7Z0j9eGKEDKkUcoHXOWJiVuFc7ing=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RGy9SzERfq9nGSnW306CGRCXMlzhorePfg9Sr5/jD9v8dvNXXBFn3hXYzqipFI5+D
         O6tI05P6O/wLQEZdKvrYDmSGEK4VoQdDPCykNufYedswTyZPE9e/SNH51qdoB0U6hS
         oXCxjqja6Gein+/NpvY6br/qAKZLqvnUmzBDBsCifOaGcotnPG5ocJNq+TW4wbWEBx
         TcMFSBM6MRrRMUkBRxd6/usNJIKLFyLbNGYrc28K0uP28QvEyZefBmBJmHbeKC2ZCi
         ztH4UxhzAhu+tGK+APNut1BNxg1Uf145k0tuc/Gki2n2C2Jnuh6Ab6N8C11NR/UlcI
         lKbkCC2j3bjPg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 49C6F60A22;
        Tue, 17 Aug 2021 19:49:50 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Limit the shooting in the foot of tp_printk
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210817152419.01539bf0@oasis.local.home>
References: <20210817152419.01539bf0@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210817152419.01539bf0@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc6
X-PR-Tracked-Commit-Id: 6c34df6f350df9579ce99d887a2b5fa14cc13b32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 614cb2751d3150850d459bee596c397f344a7936
Message-Id: <162922979024.28535.7445295719995923459.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Aug 2021 19:49:50 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Aug 2021 15:24:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/614cb2751d3150850d459bee596c397f344a7936

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
