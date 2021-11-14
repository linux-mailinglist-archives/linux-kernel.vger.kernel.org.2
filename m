Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A667544FA10
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbhKNTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236196AbhKNTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:13:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9683E61152;
        Sun, 14 Nov 2021 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636917023;
        bh=w578E4BBYcOGMWLvTjf2RMhTJshpmrw9+Gt6wEvkgAs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fQnYSviEE7VR98D0kqKUDB33x49m+hiaJS+s2b5t6hR6GKpi2OpA+Vl5hfjiO45MI
         V2PUeLT1QkKQc/Txkp0Cfs9otB5cYgx76A0e9D5NxaxTtfkdmAYV+UYdWVfRqdWAZN
         SYIQ+eAHrjJHGZf8cfdPsZnXZNSwNpMZdD7SPYIIq0Qm40rZthA4Xrty9625hdOkKJ
         8VK7spByStqhO5A/rf0mCFgDtvZai/byruiuDsRsActVP6H5ub1m3yFQR+u1NDzTTr
         k/SLQ33TqX5O2a/UHSFlmkHh+zJ5n1RrSoS3WOVJtvGbPtSpFv4tb4JG4X6kOAHNKv
         YY+oWfcNj1QIg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 81F736097A;
        Sun, 14 Nov 2021 19:10:23 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163689642456.3249160.13397023971040961440.tglx@xen13>
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163689642456.3249160.13397023971040961440.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-11-14
X-PR-Tracked-Commit-Id: 979292af5b512c27803316de2cd06970c54251e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c36e33e2f477052b0f4b1da45af403f98d3f7eb4
Message-Id: <163691702346.341.7990554606397296373.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 19:10:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 14:30:56 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-11-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c36e33e2f477052b0f4b1da45af403f98d3f7eb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
