Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5D449AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhKHRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241008AbhKHRmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:42:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C87AF619E8;
        Mon,  8 Nov 2021 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636393163;
        bh=S+wgw2Ktpwg/dAHS/Ee/D1mNBL5A2YwFak3nrXSV91U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lkbdp5A7jeT/w+z+qfpQBZiItuc3aDkrFw1AN98x8y+qg839RT/XKWuz01iXEl68L
         j/JitheXABdvN+uuGpCKz5hiuVKykMzZ1UVkwVvlWc+3U4tKIL+0he44UaipoujLax
         wfI+YqC+GgrhVjCPNGRs9BkIz3meferkJ0+jCYQFcPuRXJ2ChK9H/4FXVtwlZX6leq
         Hx52TQj61xvojaeF/A1EfC4CWQiuOaEAlJ67zGwos4JnzPYEEeklxyjGY+E0rMd5wU
         oCS8/JzmRBWUccyTGTj9Sq1ceUv8W2FXNAoFbT/a4M4hqob7r3wNJTxTJsLLGmO4hM
         E/BReHkhawAMA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C320B60985;
        Mon,  8 Nov 2021 17:39:23 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYg/JpmfY9/Z8qO1@antec>
References: <YYg/JpmfY9/Z8qO1@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYg/JpmfY9/Z8qO1@antec>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 27dff9a9c247d4e38d82c2e7234914cfe8499294
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2b03e48e961be442560796105211fc71bed02ae
Message-Id: <163639316379.31155.7303820771805964253.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 17:39:23 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Nov 2021 06:03:34 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2b03e48e961be442560796105211fc71bed02ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
