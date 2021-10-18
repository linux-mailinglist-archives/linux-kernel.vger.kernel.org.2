Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD4430E89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJREKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhJREKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E86661279;
        Mon, 18 Oct 2021 04:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530113;
        bh=jswpxQSYWI18pUGCoP2qUU0WOskc62eFygNdzDJJ1/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B4ILO2wmeV1C1JFbDRWzRmOsD1rVxwBQj+0RhkB9Hr0jLblxxNTaqPKqg5FZTyskL
         dcXSCQrnH+Uej+VtKQPX63Bv+JqTq2HHqaX3B2lqz9/wI3H64R3oCyCj5foY2SFttf
         jx/RNcz0zUXxpwcZc16y2Jiskybed2diH8WIGBHzT+/rnPakhNsEEF4bHD0x+EM4IH
         bIG0RUDZ8TZAl6Z32kbLfkwATCi3gFOpNLqyaxxnfXiugb3HPKwE4Ti5OblvZheCH2
         bv5rXXuoxdMbZhJpZ38QZ6+45N+k8uvxnQ9MDDQAAvn6uUTubcy7fYQ2sH3g/apjTS
         21WPn5v39Sssw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 89F936095B;
        Mon, 18 Oct 2021 04:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv8Ah1dgKZ0ckyR@zn.tnic>
References: <YWv8Ah1dgKZ0ckyR@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv8Ah1dgKZ0ckyR@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc6
X-PR-Tracked-Commit-Id: 86e1e054e0d2105cf32b0266cf1a64e6c26424f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6890acacdee09d7cb7c988175c895ccb4f1bb340
Message-Id: <163453011355.24310.17305577053845570082.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 04:08:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:33:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6890acacdee09d7cb7c988175c895ccb4f1bb340

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
