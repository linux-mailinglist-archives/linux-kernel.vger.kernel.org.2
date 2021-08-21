Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E543F3C12
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhHUSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhHUSby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3D3C461245;
        Sat, 21 Aug 2021 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629570674;
        bh=CysLeMVOuEHNavno2qCLrulUMc6pyYQGXOjkDL2VIAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oxNB93FDPvRYLvaXg05wyIJXHm/GGICTyY8F3nbKz4+lW3LIQS0We2nB++COSVNGM
         Djjjrtwv3rCiFPbBmXO4TuDmpKf8+LKZwh+WjYqq0WUwTJg7tslZOvL6W8EnYBGwE0
         6uwAts8yqw/lBhWJYyx/U3TzxhWBaXZ0P/kswELzZgz8Vs7FLJs6z28rl4i+L2xGhw
         pm3kOhLVzW1U3nTd8w4vrHz/jKS8XUPMf4f5eg3Zh8Gx90R0J47Dl1t6ND+9GnLW98
         e3+pkp/mlHdtFmWvVpm99mHUWBRfzhqZyvRV/zgYBsWPrNrTBuEnVi0UgY2O5JSyEk
         4boTHAqMypMkg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 373AB609F2;
        Sat, 21 Aug 2021 18:31:14 +0000 (UTC)
Subject: Re: [GIT PULL] USB fix for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSEjOWqWv/mo6eOQ@kroah.com>
References: <YSEjOWqWv/mo6eOQ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSEjOWqWv/mo6eOQ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc7
X-PR-Tracked-Commit-Id: 5571ea3117ca22849072adb58074fb5a2fd12c00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4ff9e6b0126706078a5241561546743b7d92628
Message-Id: <162957067422.18934.10699452253170377117.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 18:31:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Aug 2021 18:00:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4ff9e6b0126706078a5241561546743b7d92628

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
