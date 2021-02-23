Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5759232322C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhBWUeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234327AbhBWUc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:32:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 79E0D64EC9;
        Tue, 23 Feb 2021 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112336;
        bh=/MNmKgkJToVbYUTB+m/UC1MEozIvjP/4gftyFP/tHoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=afr14hvzxCNzpE6jA48GBjSoD3NH3iASNiOBltdrwDo8cdX/0Nn3DRe+gBhVjxD9h
         und0E9VePgYCv0dHYeyG/F0Iq0TOTx+KhQb11QMNyCO95lC67pTh+CjEXLHv115xw1
         WTqK0xca7xGNCHrNe5UMH4hfISr4Stf2U0Rr/Pakf4zSPWBIOd3CX0tpsUhwC/L6lW
         wMh8dKccy2m6m61Z/v4nmaHpGKkhO0Zphc4fsKAsHpnThRsZAPCy+YLj5ApVdVGPSj
         1H6jzSojoF+5+YXW1WOlZfVYzZIMAderNgl7yBHbwfj0rEu+SKlA93sgJ3LgJTeeUw
         RrviN+mP0zOlw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 752D36096F;
        Tue, 23 Feb 2021 20:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDUibKAt5tpA1Hxs@gunter>
References: <YDUibKAt5tpA1Hxs@gunter>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDUibKAt5tpA1Hxs@gunter>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.12
X-PR-Tracked-Commit-Id: 1e80d9cb579ed7edd121753eeccce82ff82521b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21a6ab2131ab0644eeef70507e20273338bf065c
Message-Id: <161411233647.28784.13669489495484079253.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 20:32:16 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 16:42:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21a6ab2131ab0644eeef70507e20273338bf065c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
