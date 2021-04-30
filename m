Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E6937015D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhD3Tjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhD3Tjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 04B4261474;
        Fri, 30 Apr 2021 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619811528;
        bh=qp/S/COg3VqjVEOH4i7x4BmiGnldnKJ0xJ1i629BSaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AR5yXuzj7Ox0rg28tg19D810RchM6D9ocOgv94S08TP3m19clXrL77rTG2vJ4Vpip
         YzyBrlDehTMYunySkkPmEeNGpbQAF4wsYoXpXU6lx0Y4rTJdwHk8AYPPwP0gpyf8gC
         jJ6aYcxImNYtNSbUErqOMnuxzUdYqMosZezdYMrxJjT4jzfgwwihbPTzkj3SIeiVtx
         JtBToRvKFtDJKdpxTwcwFFLDWZoxLbkduW9XjL+K6Xd4t4NAsr9bu+JVWy80EeQWYT
         4eU7FuibcWQikxy0JYaGGO1cF+4bycVtIB6SEIzyWy4hfJ1WqqmqZhOoBAsYSMVZEQ
         1x5IhR90mpF5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F39E560A23;
        Fri, 30 Apr 2021 19:38:47 +0000 (UTC)
Subject: Re: [PULL 00/14] xtensa updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210429193406.12947-1-jcmvbkbc@gmail.com>
References: <20210429193406.12947-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210429193406.12947-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210429
X-PR-Tracked-Commit-Id: 6a8eb99e130f3f7658de2776934374fe1c41279e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 437d1a5b66ca60f209e25f469b395741cc10b731
Message-Id: <161981152799.3374.10533486221145636062.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 19:38:47 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 12:34:06 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210429

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/437d1a5b66ca60f209e25f469b395741cc10b731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
