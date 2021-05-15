Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0296381BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 01:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEOXvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 19:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhEOXvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 19:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 257D76113E;
        Sat, 15 May 2021 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621122601;
        bh=4Jzaoiv/lK4bxd1aXbkugLZkcv3eCvI1H+Hf+520C68=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mfE7h2fyVlBcigPJsyxuOMZMKVF19iZgekU/M/HBzeUmBNnbGVdUCIxHPPyVVZnu8
         cWqp7Dh92s78zk9MRrnH+18nc4V9pwM/L4JCoBk6PLG8C8pdpnklvE+/Z4w6C21cod
         2JswqRLIK+Km+ZQstN7h6WrjL7JWEkxOTmwutUS0+YnXUKUvGlqRPnzcxEpNKczEwA
         YqDkMJRd+hDhL6wPgdHlLpaFJyfXlpg0rPAaO/VdHngnMppA9ipW9PjPPfTnc4A/cJ
         UAFulxZpf82Zqa+dMXUwK7MAfpReKhqzs6M3uumjVG/05AMxg3stMf9BNcj6+hsA26
         HD8ZYKFZJl1WA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 102296095D;
        Sat, 15 May 2021 23:50:01 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871ra7lge5.fsf@mpe.ellerman.id.au>
References: <871ra7lge5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <871ra7lge5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-3
X-PR-Tracked-Commit-Id: c6ac667b07996929835b512de0e9a988977e6abc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63d1cb53e26a9a4168b84a8981b225c0a9cfa235
Message-Id: <162112260100.14324.6897731706758836782.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 23:50:01 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 May 2021 09:35:30 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63d1cb53e26a9a4168b84a8981b225c0a9cfa235

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
