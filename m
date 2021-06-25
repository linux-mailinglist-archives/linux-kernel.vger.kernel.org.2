Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE31A3B4871
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhFYRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhFYRv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EAE016199B;
        Fri, 25 Jun 2021 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643348;
        bh=fFZMlJLGPYQgewS1zoJMpUxXrNrlQPvtuU6N7lX8RVI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kYoBs2LoRqXE2cPeIzOmJUFDQq9afzp43mBSr52Zi1wsqb0Ayt5KcDiz43UGMGDAx
         UmuZC0y8eKJnOURbSA/v6dD18q6RNpQC+BJqLEDlHiM0faHtF3KOgS8DgqBDAX8nOY
         d653/tuiOT3mEsko/17SMS/5j5zJmk8PSDsPeCcNp9J+GkUydLjAAp84fKMPzEFS0B
         oO3AxseUIVRTVedDAukoN1MLa9gBNtB6mvkQW2Vsgm9HzD7tvN4uSeehxI3UiAJtR/
         yqukrIzPDPtuXxkijA+87rRT6/isBxeuwVYFgyzHSIJpkIvZEi2tWeXba5oH6G2tWr
         P6qoEKPl/LwUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E0BA660A38;
        Fri, 25 Jun 2021 17:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNWZrnCpcCtlJBt7@zn.tnic>
References: <YNWZrnCpcCtlJBt7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNWZrnCpcCtlJBt7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13
X-PR-Tracked-Commit-Id: f9dfb5e390fab2df9f7944bb91e7705aba14cd26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94ca94bbbb5f50180ecaac31566dfe5ed44c7994
Message-Id: <162464334791.2214.11747637048209748795.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jun 2021 17:49:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jun 2021 10:54:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94ca94bbbb5f50180ecaac31566dfe5ed44c7994

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
