Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B01438AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhJXRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhJXROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:14:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 422F560FE7;
        Sun, 24 Oct 2021 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635095552;
        bh=kPsS7giPAQgBS0FN0v5UNufqJtO3S4oF3kk5OWrtpM0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TRLOsUIRKZ/SIiNLB5/AJ4d/GBtnW93KvY72SSRxe2hUKcg/EDfGsRdoYHEG4LVqX
         bzUCeuAhvf1wjJcGepFXxQrv8OgUc7g3vkse7vXqRE5p9a/0fjUsmUOyMgboqjegLr
         Rc4bLC7v/m/6XeV0A2gmcRlG5xkgJmdsWFU41qQRcMLTXU0cwrEXsGNwMgXdw0/XTr
         NeScbxwvIXRL7rlLLx0BmxDv/JRXkFFEPiYtKMbzVHk230Q3cxmR2dpVN2hHdB/e58
         /XeH99K7GdOdVwyicz0h9+jjgdn1P9Qrh0lWRbG/qH4RfNo6wELu97qlEpYBigkhLh
         TarnqBZtxg8rw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3172F60A47;
        Sun, 24 Oct 2021 17:12:32 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YXUr3ouAhEJ2Ppi0@zn.tnic>
References: <YXUr3ouAhEJ2Ppi0@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXUr3ouAhEJ2Ppi0@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc7
X-PR-Tracked-Commit-Id: 63acd42c0d4942f74710b11c38602fb14dea7320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c62666d8879238578b727f8e0a821e90c88f87e
Message-Id: <163509555219.13231.13911022452081185538.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Oct 2021 17:12:32 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Oct 2021 11:48:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c62666d8879238578b727f8e0a821e90c88f87e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
