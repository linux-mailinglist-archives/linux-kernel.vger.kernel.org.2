Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7D3C2894
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhGIRoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGIRoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 69111613C3;
        Fri,  9 Jul 2021 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852494;
        bh=s7NHSmEvVLDK8ELKiralJ+3di6Ye5BtwUViSqtRFX9E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GUTyEm8xPp6iORWjK6uruak4u9nf4kfLoAsM4KWDhlw+xGDGwO95Jw11ZqjDwpyva
         Ypj8QRLqIOXIYe4DfaSdM7ZCkYv4W1RWANvEHZZL/Avim5HWi0ZiNvTVnmzGmrwSjN
         4UKPPsnDq7hbJNDASy8dBK9kYGL2RYAOK3frgsrHl4o/JNQ+YDRa9vq0lW5lIaw5FN
         A3JKpCyhR8D65nYZBaSIX/zO5v/sL5eWzGJbxX6o3FI9MmHqD+uWBhuHCsPc+5y4PR
         +IgWN1MGNzCNvBLUiVbnAJH24DijZPnjVTdObtSXyDPNZ5g05deuJkexC6n1unsDsy
         Y+/xILoq/hz6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5866A609F6;
        Fri,  9 Jul 2021 17:41:34 +0000 (UTC)
Subject: Re: [GIT PULL] UBIFS changes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <245242026.4934.1625778600867.JavaMail.zimbra@nod.at>
References: <245242026.4934.1625778600867.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <245242026.4934.1625778600867.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.14-rc1
X-PR-Tracked-Commit-Id: a801fcfeef96702fa3f9b22ad56c5eb1989d9221
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a400bf28334fc7734639db3566394e1fc80670c
Message-Id: <162585249429.25269.16275890531912140965.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 17:41:34 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 23:10:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a400bf28334fc7734639db3566394e1fc80670c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
