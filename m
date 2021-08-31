Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251313FCBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbhHaQm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240125AbhHaQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:42:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A264A6109D;
        Tue, 31 Aug 2021 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630428093;
        bh=PU9wpiz+fuFXgX+LtYaZrKmGjaZfQWGECf8RBzyFwEc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WOV06KPaZJ1lfLKMdYchyTiVa0cnR0K2YiIoAhniNcD7onfPQVRoUrvYyWwRwOK2/
         V+TYNUpxyqfPWaH47X/BffIgTp2MR1kmzfq5GZIB4rXzT7YCuoH8IOZhbQ1gFT9v8U
         oEpQs9M1k8Wsgi9WldeexKVfh1sXoZzpedVAVxBe9PNCLjvsbK9du0URNDc9ouMZEL
         C2jx6SfjV+C0r8Rz8jo3Tzq9yjazfZ1qd3kw/l4QefTgPZi5TyzyCq527f4cfEq7Db
         VvVm8b6goUzYD9UMise3W7SaLtz64zV4i/dAN1OWfW1X4YPMt3mM5kfZ3X+5DNNLI8
         fkensPvwiUinA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 99C3660A6F;
        Tue, 31 Aug 2021 16:41:33 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvVdBoUW-0BfsxiRAE6X30cqhBtNDvG7pwKdQwsu+wXfg@mail.gmail.com>
References: <CAH2r5mvVdBoUW-0BfsxiRAE6X30cqhBtNDvG7pwKdQwsu+wXfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvVdBoUW-0BfsxiRAE6X30cqhBtNDvG7pwKdQwsu+wXfg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-smb3-fixes-part1
X-PR-Tracked-Commit-Id: 3998f0b8bc49ec784990971dc1f16bf367b19078
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c849ce86e0fa93a218614eac562ace44053d7ce
Message-Id: <163042809362.7406.10134157407796941349.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 16:41:33 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 00:48:32 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-smb3-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c849ce86e0fa93a218614eac562ace44053d7ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
