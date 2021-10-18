Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDF430E87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhJREKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhJREKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6906F61266;
        Mon, 18 Oct 2021 04:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530113;
        bh=Tg6j43mWWTCkn9dXgoM2US7VpJrFNpUJ+0itggNHr/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VPonLyXUr3UtiRtyv6b8ZJArdOjYiJQSvXvR1/zZuRJHiTGx2+scNhT+ok2KbvCSd
         4lD1oZMnBHpIqc/XHRw0BDQQAeZxm7ugD4TGlumrFanHcvxB1JAI0IB0IfmJNcl34w
         WHaRrgcAUOWGVP7P9XFo4CDu3mgtl77LN6wxsupL6hIycg3eTw3ep0yi3H2Cmavpvk
         VMe2fddOuBiKma+IALzKT+NRcCMXbLvxltSOW2nqfCX+s5lBPcyQfgSMXdu9wo8CLu
         W99J6vzZ8co6tkrLSfPo8HUaIGBRGMwN5TEGcJC4TAaVWJ4tyJHA2g25peM+gtaZgX
         w06rEeQWQI6/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6242D609AD;
        Mon, 18 Oct 2021 04:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWvy9bSRaC+m1sV+@zn.tnic>
References: <YWvy9bSRaC+m1sV+@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWvy9bSRaC+m1sV+@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc6
X-PR-Tracked-Commit-Id: b2381acd3fd9bacd2c63f53b2c610c89959b31cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89f6602d4b952470e068638a90bc16dd75b22ee7
Message-Id: <163453011339.24310.11634713066295708301.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 04:08:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 11:55:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89f6602d4b952470e068638a90bc16dd75b22ee7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
