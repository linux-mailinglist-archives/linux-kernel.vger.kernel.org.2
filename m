Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AEC3F3C11
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhHUSb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhHUSby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 50DFB61242;
        Sat, 21 Aug 2021 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629570674;
        bh=gtuorF777HderxSoz2+Udup+2Uw8Odvzs2uRZGMo9TI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TPY+QGlE4sXA24aIg3opl50Nvxljs8u6z6PMz5yvgKV5nzWt439Aa4+I/HT24Ui39
         PNcW0kw2US/GFHcJ47J9UXpCS9bq3kUMqhbH4UIvlLS3+XUT4gd5yRkeZi7iZRwTIz
         JR0D/n6uWHoj6jLig913XUTz0V04rU7Zc8e+nbge+ccN5oZG7Q/d+U1KAwG2ahj6Zf
         6LF2IwxISSZQxLW3FWUKRRnBcuswW4vOCsQgC2yNjfZSOsWTrkUuCwBwb+EnTQQ/pz
         9gp1o+EOl+4LQ6/EcYX/7Tlx8/w6COFFLpgl46UpACzcL7YsZGnHxaY6HuiChQNneD
         WYXyesiHQ3xnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 45F2F60A94;
        Sat, 21 Aug 2021 18:31:14 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSEjTuxs84bqTkCe@kroah.com>
References: <YSEjTuxs84bqTkCe@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSEjTuxs84bqTkCe@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc7
X-PR-Tracked-Commit-Id: d30836a9528906ee9d42b7cd59108f3bb4e16b01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9085423f0e2114fb1a1ca494b872f7d2352b5699
Message-Id: <162957067428.18934.14658745066294498790.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 18:31:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Aug 2021 18:01:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9085423f0e2114fb1a1ca494b872f7d2352b5699

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
