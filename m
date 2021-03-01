Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0A4329F91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574108AbhCBD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243530AbhCAUgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:36:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BB405601FA;
        Mon,  1 Mar 2021 19:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614627846;
        bh=l45ty/HFbjr+ZLhTroAE/uIvi9MJDqUv5TB6w6QYZ4k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TBviZ7YQxn0yVsob1u3McCXC813NscezVYoJWQXAW2xncl4J7lj2vv6S6pCq/1sb2
         f6XC8/gSZTc1UvfSG9VHLkDoYHSXPLCHIzzYwqV7TnaAquYPt8CYBwD+MA1L/aK+oi
         L7tNRNMpmgMG7ch2nzgvm/NtDWgwmH3PMlrZJ36Bbdtmpy5sjeZfufwVw+xGvIuU6a
         VqP4rftyMvT34qTNtZf9t/J9e2zKyLp0npVv67Eh7633qoJb+BZ2S8z5wUMObuT5Wi
         Kmx6EdaxHY/9ANJUjD8lKK4psy/z/tD1xCAwT8ana63LKGE/DNGGiirLF0yFKL+BCi
         izGJvaSBA4inQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AB94B60A1B;
        Mon,  1 Mar 2021 19:44:06 +0000 (UTC)
Subject: Re: [GIT PULL] Kmap conversions for 5.12, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1614616683.git.dsterba@suse.com>
References: <cover.1614616683.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <cover.1614616683.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git kmap-conversion-for-5.12
X-PR-Tracked-Commit-Id: 80cc83842394e5ad3e93487359106aab3420bcb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a7fd0de4a9804299793e564a555a49c1fc924cb
Message-Id: <161462784664.2736.1330381612543622506.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Mar 2021 19:44:06 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com,
        linux-mm@kvack.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Mar 2021 17:50:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git kmap-conversion-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a7fd0de4a9804299793e564a555a49c1fc924cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
