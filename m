Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA894322448
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBWCsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhBWCsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:48:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E1E8E64E41;
        Tue, 23 Feb 2021 02:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614048446;
        bh=hqVAWJPCzbYsogLlP1zAVotA/UoQ/H0XxH2aHqtzXBM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s1SHtleOiyaCYa/RWdM6//jDfWBZRh1aPllE+KHv/9+uVUIT0bQ4WWtxYePmBqwrJ
         2COhf8zpXtr+fHCuzseAfWzjV/1JR54a+YNI9Q0k19VT6kRLs6gyCupA77i6GIg7Q0
         i8+LsfNL76SJMeA9WVxOOUOLlndJ6JEvUHDwg6wrqrWu7bV4iMXkKoAi7vzj8imRpy
         L/jX23EJxdHoa1J46POU7H2gzpHLdGZTT+bDrZHaiHP8Dok3wTci0jWKTFnn0Xn0TI
         eMNahOUoTRqUn23Bt6CfY5k8mlFdWmVOMQCQMTiM/LGwoDbUL68Ws0yQGo5C4n0Tzt
         R3WHC2dcgmQOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC227609D1;
        Tue, 23 Feb 2021 02:47:26 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222180924.GE3859@minyard.net>
References: <20210222180924.GE3859@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222180924.GE3859@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.12-1
X-PR-Tracked-Commit-Id: fc26067c7417e7fafed7bcc97bda155d91988734
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f81f213850ca84b3d5e59e17d17acb2ecfc24076
Message-Id: <161404844689.27009.12939248074446924631.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 02:47:26 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 12:09:24 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f81f213850ca84b3d5e59e17d17acb2ecfc24076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
