Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E330136B70E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhDZQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234598AbhDZQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EE9D8613BC;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455221;
        bh=0V24SRhevfDKkNO8VPV5eX0T0la5JwUaj4RlLKBET04=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nB0yhUvbW5bx0apziXmsIcbIwG7qWYbRw1QBa8qGaBrBINRYZ0N9Pu9EBVEMjk+u9
         R7/jTkgn/srNwiqD0fOL6QtZ8zIoQSjAF6X4sKQVsN2EiZKVoUQWK4m8CGMP6Jzr0L
         tg/GednFwiS4PI3gVPXCJLv+p3L8cB+8ZTksl0oTR2q4YgY6sr4fk6jbPy51WBfWJJ
         Y64AUo4iIPEctoHXHF7feDh3RQq2hHu+mtxqwMfFhwxNp93y8aDojRPIO5YHLNveMK
         Hy5f1qiJmqxfuV7unohSblc/NkAbI/AlNXVety/gQVdQb5h1o7EpY7+5IQ5PFX5VuA
         wxK/ZVSiO3LAQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E8ED3609B0;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/vmware for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaVAdqPcW2mQyBA@zn.tnic>
References: <YIaVAdqPcW2mQyBA@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaVAdqPcW2mQyBA@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vmware_for_v5.13
X-PR-Tracked-Commit-Id: 0b4a285e2c65c2c9449c6eccb87298e385213e7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47e12f14108170c36af9a0ee2271abb3dfb73e0e
Message-Id: <161945522094.27394.4551513555257021813.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:25:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vmware_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47e12f14108170c36af9a0ee2271abb3dfb73e0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
