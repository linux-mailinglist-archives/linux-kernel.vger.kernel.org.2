Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC2538F248
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEXRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232820AbhEXRcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:32:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A65D5610A8;
        Mon, 24 May 2021 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621877475;
        bh=vN1JyiqdtA9BPa+em9Y3ehGT42c2WrfTTfXvenWlKRs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qKYxdH/dP1U0lTrFGYZvLEFEBXSaiE3yVfpkiDvr7RQ2IaKb5hv/yXNUBBBDKFj1w
         OQD7VpR50EPxHhTm7VbIVpoK3iuW+WLpWIBv9K2waFQ38xsR5DKPJW0gr8kGV3ATUY
         F0xElB08DhzAzZwCBHDOgCM5PwNHtoRSA4Stdq7nM/hr3cWB0zacINCXdzURrF4PB7
         dDLVsoAwc+ZOhO/lJ6iqloe93ca5HFH9OnkLuK9bQ7lWb47w4ALhExE+Q558+MkIGu
         4hMp5Ewj7wXXbs494HyvuLLXppPYNVVP+QmrOjfSziRbR8mPjHhkkgKf62oUW1y0E/
         10s7UTnRqu+AQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9B9EC60A71;
        Mon, 24 May 2021 17:31:15 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKvZP+qDl1+NvbW3@slm.duckdns.org>
References: <YKvZP+qDl1+NvbW3@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKvZP+qDl1+NvbW3@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.13-fixes
X-PR-Tracked-Commit-Id: 940d71c6462e8151c78f28e4919aa8882ff2054e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5df7ae7bed412aa3f2e26ee8271abb24885ee557
Message-Id: <162187747563.9813.12935074144119261634.pr-tracker-bot@kernel.org>
Date:   Mon, 24 May 2021 17:31:15 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 May 2021 12:50:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.13-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5df7ae7bed412aa3f2e26ee8271abb24885ee557

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
