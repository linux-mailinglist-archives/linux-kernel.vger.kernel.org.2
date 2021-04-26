Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C763036B846
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhDZRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhDZRr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A37C161185;
        Mon, 26 Apr 2021 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459234;
        bh=AkfP3c7uXWzzHU4ILsdwUMUtNDEsa+/IWcgMK4s9unY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Me8Wkv1My1rPOYbgcAJZhXjfFCFG+sgvXhaCspQg+74gnCNphEjnmq5flUEHNTYZc
         7GFM7qhJRb7GQs2WczH60RYxL2/VnU1ZoJkQ2UNt8mumrJXjy7qj0DfiGrHGJhg3WB
         82Jg5UDzl4MkWQaeW6QMm5jO0oN6UBmzHZeIrTIk6m72DjlMQJCsSTZTPuWe6PRu33
         tYqz6ZNWpZEjeh2AHKTtEXLDvzst18DBq+RHALRdlSIVShjBycY/zRQsxQDvcrUfFP
         9JhXCdPFyaZ20OSh6YFVIBBfcBqHfImI57uxe1CCD4C3Ekik1TxkW3WhaNOHFVds87
         7OfbbGUKCnTXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98C95609AE;
        Mon, 26 Apr 2021 17:47:14 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426061618.22978-1-jgross@suse.com>
References: <20210426061618.22978-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210426061618.22978-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13-rc1-tag
X-PR-Tracked-Commit-Id: f5079a9a2a31607a2343e544e9182ce35b030578
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e47c5f0e23234659daea78256bc1b04ea019a4b
Message-Id: <161945923456.30101.3675025824805536211.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:47:14 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 08:16:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e47c5f0e23234659daea78256bc1b04ea019a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
