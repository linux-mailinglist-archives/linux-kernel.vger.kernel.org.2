Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A7353534
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhDCSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236442AbhDCSSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B7DEC61286;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473920;
        bh=FywnJxMdr1k3pQ1HeIhFN0gSdsokC74HndvCOCCRrQ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kS1YbHDeqm7mpXNvzjM0THgRxSvgNcPonBg/hmHU3F4MYhMkX0f0uVuDA2fFN23Vz
         UmBpViOq6oJlY5ni7vv+YvtmS11T1pBUMj/U8saA6+VzvF7Y7D1eyvZhcu8NkPaJTC
         HB8j38h7FkETdcrDZhqqNHLfC54xcDWAaZGCO6MOqEhKHAHRO1LyewUeaAYUjLHmWd
         aUMDk/ezA1SQ/buH4LnJPyfdOBKlZAt5/nwpob2utZ/IIeyKUnNHqr+Hk6fJVktAOb
         cBBxYRlnB9phKJ4IpvG+jvozXZuZ33kkV75iGUeTJOpEsdr2eUSkaI/szAEJoGdvFQ
         BC0glAq0uB+eA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B201B600DF;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGhIsWHsP474a+dE@kroah.com>
References: <YGhIsWHsP474a+dE@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGhIsWHsP474a+dE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc6
X-PR-Tracked-Commit-Id: e78836ae76d20f38eed8c8c67f21db97529949da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e707eb6b8aa715847c17279f9c17c8dca2d639b
Message-Id: <161747392072.13474.11297671042251072132.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Apr 2021 12:51:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e707eb6b8aa715847c17279f9c17c8dca2d639b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
