Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56B13701A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhD3T43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhD3T40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:56:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C3967613F8;
        Fri, 30 Apr 2021 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619812537;
        bh=BvX1LaaBuQ/yRF1yDgnbGnnpPU1c3qOxtJee3c2QR6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CFyMenwOtTcO0YPVKiNxIXTU3RqU8AcFlOxX9qBRBSbinGAxCMe+xGcYdQyaee/nx
         4hWTCQRTi5i/69xN/eSwLW36el9codMMDIcTEJ+2mG1D0gOb2Ab/YaGpgLsnrh0Ze6
         gVZqZkeUngrgek4l8AfoL06kO+0bwY1LzCHNTtpKul9HPiC09i5NqS77GYvxNrDOdP
         yAZHfIqyUI+UBJwPx3eldnAw5EZdIyLqaeGRvsLE6uxKJKcPRt5ZBwBIF3NhuB+zlJ
         NmBdoBHxJoeNsfx4bWNEqUyn0lpfNRsMmWfJt8ympR/AkLOeQGU3F835sVzG5GEpGw
         hQVlVND2BZBag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B047460A23;
        Fri, 30 Apr 2021 19:55:37 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2104292151220.18270@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104292151220.18270@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2104292151220.18270@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: e16e9f1184181a874cf432302ffe4689cc56b9e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efd8929b9eec1cde120abb36d76dd00ff6711023
Message-Id: <161981253766.15988.10478332375327202060.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 19:55:37 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 21:55:21 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efd8929b9eec1cde120abb36d76dd00ff6711023

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
