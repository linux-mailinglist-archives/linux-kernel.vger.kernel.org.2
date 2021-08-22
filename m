Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E913F409F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhHVRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhHVRKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:10:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5BDD461266;
        Sun, 22 Aug 2021 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629652213;
        bh=gaJ9wHL88SpphYcVif0RN4HGPXwlZsWqDIhFdweDQOw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ErUOWLhlUTQbstBK5fWWmWKm2LXzVdnU1vJ0MebifgvtNUhxuw3BpswBvehjnKiC2
         mKZnpr2hbDAMSIJswOfAVamvyXRQTEMZyyaPefYNUJdBve48w61eY0XWdbczMaBzEp
         JLOV48/V4JFZ8JZpL+g+9b7ASpJ59FcapF78hCFNBSyJ4v2/1pYTSLuW61vM+G+ZyA
         41gLgT/a8Z4mrIreLJrvgo9jJ3NJxNqlj7fWhIpLPiv1oWOpprxX5N6FP0fWnWzoJG
         +Dlveq9EoGFYj/m43AvZ/IMk53iTIIFTS7pCjwNbnmIcjyp3VWyAEugzA6TQi9Kbfr
         HYulQoV6QDopw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4745960A02;
        Sun, 22 Aug 2021 17:10:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mtpacq35.fsf@mpe.ellerman.id.au>
References: <87mtpacq35.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87mtpacq35.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-6
X-PR-Tracked-Commit-Id: 9f7853d7609d59172eecfc5e7ccf503bc1b690bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bdc3d5be7e199ff56f39dafb0e5f63a9b8c975d
Message-Id: <162965221323.3005.13288383826569608839.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Aug 2021 17:10:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, nathan@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Aug 2021 09:53:18 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bdc3d5be7e199ff56f39dafb0e5f63a9b8c975d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
