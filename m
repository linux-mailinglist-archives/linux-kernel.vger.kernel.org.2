Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE63DCD40
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhHAT2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhHAT2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:28:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 27ED561059;
        Sun,  1 Aug 2021 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627846111;
        bh=2JJz0y+ATsHS6uVWislQr6P/pBs393cIDrmfSXK8vW4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S/C7HcQGuFOJRCj4LOaiPIo2x5jSItqr04OO5Mw51A7D3XZQH18bZQokvoBVxVuV6
         zRUNhDfa+lGO2NLyD+2IMptfCTtyz2RwJ8B0BXWYgtF1KZLLuHT+y3br8RSv8B9LfZ
         +bflaUgnrXAtoCB7T7dAhfVuytkQqokrw6/I28Su6CIN78WGhe7nI7TIdOgBtRwUUy
         KkH1ti/Y+zrTlFpz7G6SIfFQ5Hh87lWRG8SDtq356zbcJmCN4bh7LwPUQTe1DMf5IW
         LSYAwJJlGScr7hTBaxL+Mz0aY2oQZFiMDAjrwu0ypoDnCCxoRfu25Oy2e3hAyYBnM0
         7l1/GlwxJeRFQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21F9B60963;
        Sun,  1 Aug 2021 19:28:31 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y29lz4nz.fsf@mpe.ellerman.id.au>
References: <87y29lz4nz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87y29lz4nz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-4
X-PR-Tracked-Commit-Id: a88603f4b92ecef9e2359e40bcb99ad399d85dd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c82357a7b32c0690b8581f72f197b1ce6118543c
Message-Id: <162784611113.1186.13853752798498083379.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Aug 2021 19:28:31 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Aug 2021 23:16:16 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c82357a7b32c0690b8581f72f197b1ce6118543c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
