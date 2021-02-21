Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985F320DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBUUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhBUUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:55:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2ACFC64EF1;
        Sun, 21 Feb 2021 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613940826;
        bh=Odvf/6apu5DTNxb6e5c1BO/3ThD+Op6QL03+Gl2yzFY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jAQm7hICY37p3XVl1Ixsj5XRe4n77c1zBeLLpZXKZCZgCDJesgrHgZr2y8iRLLrs0
         RfbjHi1rcnnT/vh26urRoKTYcTybeUmKxeEKHnm771YxZDy5TmzyPfh2NrCeVMVOLt
         sIiQr59IiypTBPYggNpJc8Y0Am5CXpo2zDQtOY+k1pTwOkd9Cs7MLUuZ7KF0U3dXZc
         h+sYZPR5D/FZi2V924llRGEIr/D1Ru10M2RO3/V432G1Q2fU85OCCXyJSq7AA3H+sK
         XGuvxDPuH78FwkQM475tuHwBWSIjVTbWPWrY3KVIZknL+AVvvv03aroew64tLvu8jK
         +aX6QIw3g4EFQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2682A60967;
        Sun, 21 Feb 2021 20:53:46 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210217204444.GA505189@gmail.com>
References: <20210217204444.GA505189@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210217204444.GA505189@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-02-17
X-PR-Tracked-Commit-Id: 8bcfdd7cad3dffdd340f9a79098cbf331eb2cd53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d310ec03a34e92a77302edb804f7d68ee4f01ba0
Message-Id: <161394082615.25590.8454164689480801457.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 20:53:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 21:44:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d310ec03a34e92a77302edb804f7d68ee4f01ba0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
