Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFA32440D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhBXStm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235014AbhBXSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DF9064F19;
        Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192395;
        bh=BTuoDJ3PmpKLsQK8yIGPMN2BAbZ8xeCErvBmPJwajsA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FhF+Y4sxLiBkE6j5VzS2T5Eb7I9UvsGuRQt2I5fCjxaAy/XkQsY+WzH3P8843OeOV
         X2Z7aHjzWnnDA2vcRw0p9VOlQowUshFTL0chzCDSjqzycXPZ9jIEqwIs8Gw3H1cd0T
         DIJcN22qU5vE3oynn/5kkagZrXBx4cESn4ig4UiQqCaYMVyL5Qh7mqk1hrW7goCTXT
         erfCnUWO8mB/1U5j+guVUz7qkAtrciNNkXv6NwKpEJNiZiJtjEsygD42AZATVfAf9s
         j/0Mdp79/hhxtsqL2ysdYAiQ5CQf0Rrs9hY0+Kfw+yEasiRQd4sPq99+KKzJc+XJ+i
         ziiwzCj4HOH3g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5834F60176;
        Wed, 24 Feb 2021 18:46:35 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core / debugfs changes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDZiQoP8h/QDSNkJ@kroah.com>
References: <YDZiQoP8h/QDSNkJ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDZiQoP8h/QDSNkJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc1
X-PR-Tracked-Commit-Id: 3e4c982f1ce75faf5314477b8da296d2d00919df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ac1161c2789be25d0d206e831b051f43028866e
Message-Id: <161419239535.20610.11579361989515138548.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:35 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 15:27:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ac1161c2789be25d0d206e831b051f43028866e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
