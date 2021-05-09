Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B676C377861
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEIUUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhEIUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 217056140A;
        Sun,  9 May 2021 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620591539;
        bh=INnMswU6psEDMlkuYfTYX0XUS+frkj8G3OdKH6FmWwU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gAPuPC8b+V708bSqYoUqn88/FBEBYFRIxAGd7g7pmPii7ECCkR7tadhk5cGyNjS7o
         2mNtXaTFUS1h7fPY5dH/vbZi/MrGHLAVSrVS5C7FBiQHHLIpI/rT5W+1t5rZdwRYud
         by/4x4AfDp32Fc8w9CjiNSEveQmgM8qfsleeEEpC5h/V9Z+cvPCNQSgIUGIKXXeHo8
         pcS/I6RBagWGhnLTH/jgBnLCT/+cjyK0NQyvkqS3UPb+xgWRP6g7zjP17H0S4E4tqc
         oPLXuHrsaJrTfkr3cgwySRfnOnPEncgkPEVgHCfbRjJ0yhGbusBo+xTNyWrb6K/6AH
         Oyol5yRwA1LZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1C7E360A21;
        Sun,  9 May 2021 20:18:59 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162056844193.15118.15395219660989373296.tglx@nanos>
References: <162056844193.15118.15395219660989373296.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162056844193.15118.15395219660989373296.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-05-09
X-PR-Tracked-Commit-Id: 0258bdfaff5bd13c4d2383150b7097aecd6b6d82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9819f682e48c6a7055c5d7a6746411dd3969b0e5
Message-Id: <162059153911.28372.6563515964547866605.pr-tracker-bot@kernel.org>
Date:   Sun, 09 May 2021 20:18:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 May 2021 13:54:01 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-05-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9819f682e48c6a7055c5d7a6746411dd3969b0e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
