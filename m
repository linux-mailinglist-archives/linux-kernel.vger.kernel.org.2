Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3298A36CB32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhD0Si1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238463AbhD0SiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BE5F961029;
        Tue, 27 Apr 2021 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619548659;
        bh=xB0l9+mxuoM02HIic6ni7frJXt3JyeuC3JT/itzBjac=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lW5MCSU0saJtEzUQe6BFkokOttV5yCLllXvnMTmsUGuYMbQjfGKfjmkFtGPWmOj+M
         W4alcXdRIO6eLxxV4ztY7moM5iZ43owVsmGDlhPUWHo0FUYvlnpfvIEqvBl8OAvnJ1
         P1EbECqii7kC58gR7HqNxguEGVTSaTe8+VrSGnipLN6rJaz52G8ofwkfmEQeq14uaH
         CN09OfLxeJh1bv3ewh9CvUgfvZT6xFbkxAaxArfVsj4uTeiCWh0kwTGg7pKawM1gEp
         ykdIsoTY/4k7+tOB+Qox1rvVfb8sWbYuZNm3mlSb0cFm25Fer1rbhofhXUtS978/ph
         HSZUnuzoLRGQw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B925D609B0;
        Tue, 27 Apr 2021 18:37:39 +0000 (UTC)
Subject: Re: [git pull] coredump-related stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIc/uDc9dCe9KXq9@zeniv-ca.linux.org.uk>
References: <YIc/uDc9dCe9KXq9@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIc/uDc9dCe9KXq9@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.coredump
X-PR-Tracked-Commit-Id: a64b89088bb1413bb84424f0b16a4d1f9bb0e947
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e6720888523eaac7c548df0d263739c56a3c22e
Message-Id: <161954865975.8916.447485640846937121.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 18:37:39 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 22:33:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.coredump

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e6720888523eaac7c548df0d263739c56a3c22e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
