Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6BF430E22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJRDY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhJRDYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 295B260EB9;
        Mon, 18 Oct 2021 03:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634527355;
        bh=tyfPVKxOqAclQc9rBYN3Wq9KsE1IBnkS53WnjTiyLiM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IBG+Ngr7UkC/NMeZDZ8DCst/RCAZ8vKPTV1PKLim4V4oA0Ey4PvtsGma4LMvAQCwH
         oWBBdvSbiPqcZSmDt/yAJg2X5WqwkknNr2AppOCAFXCxmW0IjuAo0b9r3AaTZwiR+c
         +485R0hIqe47wrmfnqTMXkBKdlGvEAI1IZA8cR//FxxKqo0q/0V5Tgmf640jgaVpmS
         QcArLXrXYJWkcYzIvgw+Wck2lXmIcg5JRAOovDbMjrXZEvI4wjd+ClL9Wk2NuVA2FX
         Xaud7fAeotqH2enxQ9147gWUdfIiaraK7VcVLasaKcH5wi1q+TVcORS6mDS2WEuupK
         5CGr9eIfRxu4A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2009D60A50;
        Mon, 18 Oct 2021 03:22:35 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv1zE2QO+Dsmt64@kroah.com>
References: <YWv1zE2QO+Dsmt64@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv1zE2QO+Dsmt64@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc6
X-PR-Tracked-Commit-Id: f42752729e2068a92c7d8b576d0dbbc9c1464149
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3572dff127986cbf7ac01147720b4aa3e81878a
Message-Id: <163452735512.4914.9094813385550404156.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 03:22:35 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:07:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3572dff127986cbf7ac01147720b4aa3e81878a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
