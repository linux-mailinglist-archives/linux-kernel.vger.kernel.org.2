Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FD307DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhA1S0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhA1SUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:20:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5E0F764E26;
        Thu, 28 Jan 2021 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611857815;
        bh=h6iW122sdP9qqDvhi5wGhx1I6qTVfFZ2xQZzPaE7xdw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LTcnyuLFj1i0v9zOELxJNcXZ/4n9Y3zBauFFWuMWQ1Ss77496lq8Pl1ty5fjqxyBs
         1mq05UVTtskATxRt++TkKQGo+cRb01BN8xjNGmk2q4ir2RkU3AvyqnPxD5M/GERVXY
         zvFqjhic6jIGXjD+k9uutl1HDvpPYutXH4ZTMSomP1S6KqyzXUrFNxxoUOJnn+P6Sk
         CqfCuyN6srEqfDEha7jYMyHWibUksm0HWg1O2KV9FPjSZgCsCgCe2H0ZcWhS5JIT+j
         MRUpYpHSWutGe8SXLWW0yiY2mLrRMtVQGnKDsgTpy6Bg2DANlJ9FKBLR7PywsOWHv5
         4Zj2xg8UFN+tA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 592DE60077;
        Thu, 28 Jan 2021 18:16:55 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2101280935550.5622@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2101280935550.5622@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2101280935550.5622@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 179e8e47c02a1950f1c556f2b854bdb2259078fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25221c99c593bf888bd8faa67ca25b40f046e9f8
Message-Id: <161185781535.19532.6791867788905619170.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Jan 2021 18:16:55 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Jan 2021 09:38:19 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25221c99c593bf888bd8faa67ca25b40f046e9f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
