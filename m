Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE0324410
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhBXSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235126AbhBXSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A8F4E64F1A;
        Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192395;
        bh=LRZa8BiAPEVrsJmvqTpGUsOInLTtb0dp7aTcTFhvWL8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tx9uwnMfZJzBRuPs3Agdz6dCazZVY6dU7xmJ1pP3opiIAjGrZhN/RAvwjR8t4ski5
         4fmz+wah/HyUB+yN2JprTKKDoU2/81Yzx5buQNQtFdJyppRkOU7vH33X7gZrW+yV9w
         Ep+b/QTKc/t9R6IEcB9CUR8e1idM/rjKV0vUDXQ2FXKW4L6sPgJCZp35zKhDZEtrlb
         SfjVLE2O1vJlBVsWMjR9Ym/p1qc7QFoIxXS0tf0GR2cNLb99MXKXAQSBORliZGytUY
         al030CJQy5HHY49aLXt2j6x4oCGx2K+5Uvgv/AG9eAhe6sJ1seRsS8lGekxZv0+0MI
         tgeLJsqEeuKMA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A476C609C5;
        Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDZiWiBZsuTaPatM@kroah.com>
References: <YDZiWiBZsuTaPatM@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDZiWiBZsuTaPatM@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc1
X-PR-Tracked-Commit-Id: d19db80a366576d3ffadf2508ed876b4c1faf959
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e229b429bb4af24d9828758c0c851bb6a4169400
Message-Id: <161419239566.20610.4750227752337810052.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:35 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 15:27:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e229b429bb4af24d9828758c0c851bb6a4169400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
