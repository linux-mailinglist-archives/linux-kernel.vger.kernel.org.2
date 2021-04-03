Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70251353532
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhDCSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236403AbhDCSSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 91287610D1;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473920;
        bh=N3rr3qFGkZMIyQGSFBafQKbWlSdoZX+TVylILD6FuPI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KQnROjIl+Yp52jTAvv8IX5le/BR5t769Z/XsQsYwCI+J3/TJeWILCFXBHbfQkJktu
         iY7YvwyODnoBi3WtDBwTMkLH5z/kQ9Ot64uhrRBql3utTsoIUiY+EJ0Bk5q6JQJT9k
         ARjUTLiDWkJGip1ljwoYfcGymbaQbdbenon7teIxMmkfXePCHG+bWZtc7I5n/PpjJe
         fFAxARM7j/yUS93FQAo8jSt0X/nGV/0eAm4eJG2LiCnkF/lAdtO7nxSOjbPSes8PTz
         v8qcvtO/ImpV6nYP6EsA8cjOAm/ePSy9JoY4GoM9FDb+wn/dfCqe30gL//NKOkyvPv
         Ktr+ltN74V3rg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 850016095A;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fix for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGhIlsp8p19O+yy3@kroah.com>
References: <YGhIlsp8p19O+yy3@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGhIlsp8p19O+yy3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc6
X-PR-Tracked-Commit-Id: 29d96eb261345c8d888e248ae79484e681be2faa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d2c5a9e15179806fd9ff24409d2c0d689fc422f
Message-Id: <161747392053.13474.1468539077697157873.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Apr 2021 12:51:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d2c5a9e15179806fd9ff24409d2c0d689fc422f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
