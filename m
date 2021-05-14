Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C4380F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhENSCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhENSCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 210F1613C5;
        Fri, 14 May 2021 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621015253;
        bh=vsnP8XxSGeXkU2mbDvoXIjpdwW8d6Yy8xM8vQzxnDLc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mYisM0SsstagzvAXPi4Dp49DsfQUO58D76BKON118G2danCHZTbk+q+J//v6h0B/L
         /3RfdqlVe+p7LRL2GmD9C2wX5pHL7iuI7DxHty8wVIi/blKmcr7txAHoO5riTD7GbF
         e4yf4Me6VCDYbDUlWsZOjdP4wpODCSRBMr6VnheTxTSeEDrk3aLpAZnR1/CHgrst2S
         iAmmfTxLdSZTru0cJ6OiOjnV2ep7YtHlv8ghWGbZ/VGl+uLrSsEWzveCVABQwhQOek
         e6tLd+wSwiukSqzHasc6SjAV+STyy/OT3373MQTPK63MLsrklHsKoIcC/ZcrDC0APz
         II0t50/6AS+ng==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 14C1D60A0D;
        Fri, 14 May 2021 18:00:53 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJ5NdFzVb1f9aVqG@google.com>
References: <YJ5NdFzVb1f9aVqG@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YJ5NdFzVb1f9aVqG@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-5.13-rc1-fix
X-PR-Tracked-Commit-Id: f395183f9544ba2f56b25938d6ea7042bd873521
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac524ece210e0689f037e2d80bee49bb39791792
Message-Id: <162101525307.30508.17143855236769719252.pr-tracker-bot@kernel.org>
Date:   Fri, 14 May 2021 18:00:53 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 May 2021 03:14:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-5.13-rc1-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac524ece210e0689f037e2d80bee49bb39791792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
