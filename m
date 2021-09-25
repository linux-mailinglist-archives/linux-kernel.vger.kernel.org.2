Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5444183CA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhIYRte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhIYRt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:49:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A2F4610A3;
        Sat, 25 Sep 2021 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632592074;
        bh=CYdQvtSs6vj67yvQNZeoFWmRKqqg0+dlPktBuYrHvvU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HjfhnMCVjafeTi4QgvI3Vzv1/ntNa5R0fD268y03U7Uprz1CfsBL8km899LVMaq+2
         JeJniiqXD82lVrWPlsPA5Lb/Rd6gSCnkzH2jXYTgUs6u50MjAtO1mGTBdZGVedXW4k
         3nNoYM0VQdTMZ6Qm+WnL/6HEyPgkaao+7SvLXMBRjGssWVto8XMgjKbJsLwL3VpA0d
         qDGmcVFOime9UgFsrYPNEn4F6rsThyvbdGHwPOUvsf7b6KxLqmy8QjjoY6Gw68bmiq
         iuk2lmHe/DDpaLtp2vak6+5dEH0N3dIiKKA6sP8p/GoYy0rtvVQrJeWWafDZbS11dc
         1itcAz/VH4ULw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5D7566097B;
        Sat, 25 Sep 2021 17:47:54 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YU8umcrWhi65i8PU@kroah.com>
References: <YU8umcrWhi65i8PU@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YU8umcrWhi65i8PU@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.15-rc3
X-PR-Tracked-Commit-Id: aa3233ea7bdb6c4004f5032a3a07417ea51dc409
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cbef3088619286de66f587e0c770f83f524925b
Message-Id: <163259207437.4008.7039754998169721859.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 17:47:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 16:13:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cbef3088619286de66f587e0c770f83f524925b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
