Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D920343424
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCUSqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhCUSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 61A626194C;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616352335;
        bh=sGkxlq1z5dvNDV8nve8Ewof99tK2yBolhkyG8UEDslY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BJGKzTmGB/fA117qSwkDpwjLitzvLP4w0RidULw5XKN6fVVHhx3iVc5cfe5UXeWl0
         o3OWYPhU8c55UaDONisRXHdfls5igHx5AucldsdEkZ4gKs8ErVn24byqHkrGYLmMzD
         km4weCvnEy2YiIczJQvN9YbpbM270MW02e9l+8Rx/Zdm9V3Tu1MaFtttTRork68wAr
         nv5yajtkim2jz4836vLHYvzqY9/qHIya1+wM/vqO3mWPF6lJ/1n6rRa6t3OrVYvSp7
         RVBmnenTVblcF/SN4FY/VjhMbcOddlTedWdCknq5akU4JcgaVPTmZGR/PlppW7QhW5
         /SVA9FqGKpg+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5267660A0B;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210321105343.GA124289@gmail.com>
References: <20210321105343.GA124289@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210321105343.GA124289@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-21
X-PR-Tracked-Commit-Id: 38c93587375053c5b9ef093f4a5ea754538cba32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ba33b488a04a13268131b0b4748a7c6f3598693
Message-Id: <161635233533.28302.17732530151849660661.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 18:45:35 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 11:53:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ba33b488a04a13268131b0b4748a7c6f3598693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
