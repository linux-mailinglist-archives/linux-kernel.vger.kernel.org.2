Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6060D3C2898
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGIRoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhGIRoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D6ECF613E1;
        Fri,  9 Jul 2021 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852497;
        bh=MOul283O27ZPovFHmST+I98tyMjYlh5cPQnCahGxJV4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RlrkjDc/LLmCwdiUVWHl3XMUakqy/hSR/3b+Nph8eVEbZZZUBmz3MWyTJUgQ/w3Ps
         Z8Lz0syhxW0XT6W/dKDUJI/fgXCeT20NIu1Oxc7ZDdG/2F+LYHZAzRVYoMMYhudXJs
         nuwpmo8kONhyYF6Lra0Rpfb0EpRDZSxep5Ly1gPcA5/7CjaEVjYSFjshvJ+XSKUKR5
         Wldjbb4KVrEM18mLTisZgMzHHiqMO0yvQSvalDAhTdfds29QL5r/6y7F5jYBaiED8z
         1rizsNuzAQofs1mTaHT63lWa0rKYCyTX3u6ixgkFd+qrwWkVzXci0tX59E9RKHLz+J
         jb18LOxnLENcg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D00E3609B4;
        Fri,  9 Jul 2021 17:41:37 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87czrrob2g.fsf@mpe.ellerman.id.au>
References: <87czrrob2g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87czrrob2g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-2
X-PR-Tracked-Commit-Id: 2c669ef6979c370f98d4b876e54f19613c81e075
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1459718d7d79013a4814275c466e0b32da6a26bc
Message-Id: <162585249784.25269.8545698719361257106.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 17:41:37 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, ast@kernel.org, clg@kaod.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        valentin.schneider@arm.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Jul 2021 23:45:27 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1459718d7d79013a4814275c466e0b32da6a26bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
