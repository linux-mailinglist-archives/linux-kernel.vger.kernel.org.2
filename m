Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228FA36B910
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhDZShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233842AbhDZShD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 706FC613C3;
        Mon, 26 Apr 2021 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619462181;
        bh=vS0HVzmmxn3SFna8GVj6KhMWZEDg6DWYQylmfZUFsSc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qG1XEuq2IAfDjDvP6n1x6qPG9qjNnVYznPW8ErBCWfg2nUnqpghHez1+Lb/MexVO0
         OkcP8fWm6PV2bXU87/bPnBE0u9nEeERaOs88YIwcaroDI0VDcVCvu7q9sc+YVQ1vqB
         9R6oS/hw3I9te08E31qIhuCpBg1jwVNcXcjitkgpDZtevuhZrRITEA2+bQ7+oMDKqK
         yrXRrOyERI7Xq9wMkiiiW2O3mmqAPUdukKKlnRNA+ftxzZ1AlQOhT0ZA8eyXEI5WcU
         TWHJ/at++eWC6zSjDlEo2K2ZF1KoARQh+UWZJERFeMhKU2yLE20UGiWDf7EcSaN8vO
         0/jPuwQfgd8Fw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66012609AE;
        Mon, 26 Apr 2021 18:36:21 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.13-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9f212b4e-c153-8c68-15da-9474c41e0769@redhat.com>
References: <9f212b4e-c153-8c68-15da-9474c41e0769@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9f212b4e-c153-8c68-15da-9474c41e0769@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.13-1
X-PR-Tracked-Commit-Id: e7882cd7aebe0696fbe178df1f30257e5729fdda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90035c28f17d59be660b9992757d09853ab203ec
Message-Id: <161946218135.19244.15720585505054266224.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 18:36:21 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 11:31:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90035c28f17d59be660b9992757d09853ab203ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
