Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79B3749B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEEUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEEUuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C7DF3613ED;
        Wed,  5 May 2021 20:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247775;
        bh=y6dvmY+44w5nV2u8QnR+DFmiQb0gfCnttIm36iMXMfs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u4EMlFdUui/LqXflV/0aj2V2K/tX0ZIU91x+2cC+M6+5yWuLO4faL+Bl9lmreIjK2
         t1uCwW1EeNgVr4lVI8BJ/YOZao4+LPJZ5a/cPIgRr92Wrt0zGbpPLb6zGStqj1LLev
         qwWjt66nREyj9LSMh8VJSWAneIN0DzzKOIYVIw1rxauBNrADgolUnQZW6LgzFDwOZL
         H7J3IWHkOsymfTEmPrnZEttXDxNzsWxX03+nORBDZOejz5rKCtcFifwvUa9JArz+Yf
         MEvu8+HmDKef+GzkqaXz1CMM2lu53ts/KME6Lhicu1PL9nhx1u7+9qbysoZ/sf3qwK
         EucZz6lphIS4A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BB8BA609AD;
        Wed,  5 May 2021 20:49:35 +0000 (UTC)
Subject: Re: [GIT PULL] ktest: Updates for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210504142715.518514f3@gandalf.local.home>
References: <20210504142715.518514f3@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210504142715.518514f3@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.13
X-PR-Tracked-Commit-Id: c7ceee6958770c447b86a8917a603a20d646b608
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd8c86c6dd366294acad24d7b48601fa101dc86b
Message-Id: <162024777576.12235.15254769186506375290.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:35 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 14:27:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd8c86c6dd366294acad24d7b48601fa101dc86b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
