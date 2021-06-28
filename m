Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFEE3B6930
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhF1ThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236721AbhF1Tgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E7C5761407;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908864;
        bh=VixHw2KTlikVDBG1b6YFg803ity9yB0aKDJzd7eGaQ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P3RWLntk9+cZ7YtBnBdX+pQ7VE76c089AMRvdYiy33uIVSriMKRsnV9Qy+qmH6fnV
         yKWaFBtpcy/ni5nDth2iP4V9j5DJAHmEC0oDdMmoeB+7fChLnezVSo5BL7TLIL24hX
         VpvH6bLICUlNUnW66VjJoSJjFla1KiKIvZ8LItgRpKxD+I8dE1CWGze8yLZxYvtC63
         R8ikXmWgTz1qyJGMVJ53pNVEmmcMZkzHMfhzkoUO4lcbDj0rEbrYIRRHefjmrqKXQ/
         5nG043TUKdRi1SScBPRemHEzYZmhaiDs4iIGGAwLEedDIFUe1G6OqqwAhoRFOPwRbt
         zQXVMaRzYPnCw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DCD1860BFB;
        Mon, 28 Jun 2021 19:34:23 +0000 (UTC)
Subject: Re: [GIT PULL] timers/nohz updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNlzf+i1j/4wIUtC@gmail.com>
References: <YNlzf+i1j/4wIUtC@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNlzf+i1j/4wIUtC@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-nohz-2021-06-28
X-PR-Tracked-Commit-Id: 09fe880ed7a160ebbffb84a0a9096a075e314d2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9269d27e519ae9a89be8d288f59d1ec573b0c686
Message-Id: <162490886389.14456.15131290252613000764.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 19:34:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:00:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-nohz-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9269d27e519ae9a89be8d288f59d1ec573b0c686

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
