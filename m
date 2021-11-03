Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86C4445DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhKCQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhKCQ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EE0D2600EF;
        Wed,  3 Nov 2021 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635956817;
        bh=eBJLdBzlBvPH/vziSGIhJJBi8wzOiQuI+d0HEyR+gYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BF1p8LXQlXMRXfCNBV9wlDEKpNsncL5NUhKvtO/KG8cOUAICadt0PajTP7J5Qp8Ne
         KvBDB2bI3aSh+dGH+ALNxziSY5X+jEwpznGBCsCsO9jE51JD7bLmpSTT6jbm7TXWPW
         TqsTT2zCVT5/5L7lmWdo0ExgABa3tg7ppxuhaR2Aa6W3viYA7bmQgSWGG4YARjkgMF
         bWov1XuQcaStcaJ2hZCnFl2GA3yAJV8JZAPmPc6phGXsP6vWOxUpZRZGrAk+EP9Xub
         d4uAtMsCJ521eMtW2HOHiuuv1/VRq4xRiJkbPpJ4FOLa7bQs0/6UC0IhmrS1hI5r7O
         HGrY0XSgEDhXw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DB61860176;
        Wed,  3 Nov 2021 16:26:56 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Set two for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211103100507.368812ee@gandalf.local.home>
References: <20211103100507.368812ee@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211103100507.368812ee@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-2
X-PR-Tracked-Commit-Id: 67d4f6e3bf5dddced226fbf19704cdbbb0c98847
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1fd0b2acde6359a598dd4aeb158713fc0a361b2
Message-Id: <163595681684.8679.11979356712129706258.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 16:26:56 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Nov 2021 10:05:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1fd0b2acde6359a598dd4aeb158713fc0a361b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
