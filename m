Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE90D3A48A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFKS1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhFKS1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9296B613AE;
        Fri, 11 Jun 2021 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623435950;
        bh=nWvtG4Wv9M++TxjMwYBqv9HkMwiUURIxSQjo9Kc/CR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hh+Pe98945Co6J4Go6XFD9evZ4oJq2pQcIbs+7AnlxGMe9EmLFx1WZ1HUy3G9TVlU
         f8yPEQp9mJYlsnut4HekiA3k6QLZ9Pobrmu4sFOHY1gzwen1MUXMppA298CDTpNQ9P
         wVXgHCz9LCibnhsyQDzJ7xfiIIPcrD9XBt5JXP7DO2nWH1B6lO+J4mPnv9ad9BEXIH
         R/g1/WxSSCwAhV3ctN6X/BfbUQH4H0wZwR4Ib7fQb8v/ii6Qm2WEJ1tnGBFr/l2eUj
         chCEcrtGe9FCJwPChEh8UqI+GaQil7OvlFIgUESqJ7u89FYXYbnn3EfAIUxRLBIGwN
         26/m+OgTcQJcQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8D8D560A0C;
        Fri, 11 Jun 2021 18:25:50 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210611104310.35824-1-linux@roeck-us.net>
References: <20210611104310.35824-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210611104310.35824-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc6
X-PR-Tracked-Commit-Id: e13d1127241404f1c3eb1379ac4dd100eaf385b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4244b5d8725b28bde37eb2f979385bf782b5dde8
Message-Id: <162343595057.23611.6330180669030852949.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jun 2021 18:25:50 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 03:43:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4244b5d8725b28bde37eb2f979385bf782b5dde8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
