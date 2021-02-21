Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC73320E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBUWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhBUWC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:02:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BC4D864EB4;
        Sun, 21 Feb 2021 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944908;
        bh=l/jq1IbONWDrTDEqtpVTGBNc7tWGPcOHsHzOKQQXLtw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N7EXsHQpItRCKO73+9MR5JBD4qn1FOpSj5o9WKw5dHuQLTiPmk7dC8UEgVIcmQaoa
         YqzH3G15kNqfGtcE7s8TlrKAuuoSenLViIxl+XI6u1TTWfAM4CUVLQVtBt4uJ0nBPh
         eQRu0I3oTH+KbOoTSAdz15CxZozpJuiznKPGgr/6RKRy16IBB/LgexRdC8UsKbIcfd
         RsyRkSezx5mlvrjPFjiNSSSZkYO8XHJedgMz7Ksbn3ZeA9o9cexswQXHnxUljFteB1
         z1ZiNkEOfOXjZnFkNXuZVlXXxaq4Wql7GITNC/JzujcANqA60omKXJ1FJJD1cxot3q
         66K05IyBnbXvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BB9060192;
        Sun, 21 Feb 2021 22:01:48 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215142412.GA1644@willie-the-truck>
References: <20210215142412.GA1644@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210215142412.GA1644@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 1ffa9763828cf73a4d4eaa04c29a4a89fb0708c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99ca0edb41aabd888ca1548fa0391a4975740a83
Message-Id: <161394490857.8676.11199850950433455893.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:48 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, tytso@mit.edu,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        maz@kernel.org, kernel-team@android.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 14:24:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99ca0edb41aabd888ca1548fa0391a4975740a83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
