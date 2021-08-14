Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD53EBF47
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhHNBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236200AbhHNBMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 56DD0610F7;
        Sat, 14 Aug 2021 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628903548;
        bh=VBhsYMHITM3svleXFbzvHen6AfX5opWzSq5Lu+b2Jak=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=imC8tz4sm9kRHV188mpHHVwZ7f9ukVJUYOafej38GfzOykL8PNLMG+wZP1jB9rcm6
         yvQJrxW1E8p3p/pvT+kImwSNc1J6gePMaOD7NQuW7BirR1zjYfWYlDPbb0yM6pSuN0
         QfFCNh8vZJ+Rq9Xb9OOLBpmg/NOPKKz9+b2sm5ZQiP6DWL3UII48bje3DjjAOM1bOG
         0deI4HNzL/M6HbJJeSnsB8WlyO5oU2cEvPyw3LRyyGwiwIuRioWqOVZO3aJzX3wXGX
         WhG5tsaSQmTZ7yJOsTDtxp3aLsQYIM4SsdfgaKRYOSLldDJ9nnKN+Xtof+C8RMFkud
         hRWZTGSklPdhg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 51BFF609AF;
        Sat, 14 Aug 2021 01:12:28 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muFb-0+8EXCqBZ=sHCkrsna4+cQ9R1xVWEFHZd1Hogmhw@mail.gmail.com>
References: <CAH2r5muFb-0+8EXCqBZ=sHCkrsna4+cQ9R1xVWEFHZd1Hogmhw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muFb-0+8EXCqBZ=sHCkrsna4+cQ9R1xVWEFHZd1Hogmhw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc5-smb3-fixes
X-PR-Tracked-Commit-Id: 9e992755be8f2d458a0bcbefd19e493483c1dba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27b2eaa1180ed0e0e3fd0c829e230b6bffd76ba5
Message-Id: <162890354832.25277.1321039201260484010.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Aug 2021 01:12:28 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Aug 2021 16:41:15 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc5-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27b2eaa1180ed0e0e3fd0c829e230b6bffd76ba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
