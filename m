Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9961036A877
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhDYQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhDYQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D973F61360;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619369528;
        bh=3zl1pwABnDlKKO+MEhgnxtpeGeEMeJ9JrXaIWtayBLw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tilc9ya6lKbwuIHtTABFPeZEariWX8wiWTXCFMz7b3p5HbyRNxSuqdSNYCyHh7uAW
         U+6vtsEJwaZZvs2K0+urZTiyyN7zH5RxHm7bAKvf6oyPLChvTp/h31QE7ciPtsWXX4
         +AbQxcaPQ7IkVUDPHQjaDRXe5HTs7XAwgd5xj9EOq6hOKLSwDdaL3Acj7WHCLBAOke
         j+TdezvBXr6taURiQIDfCR80WFcmSz5vNzdEJSZG5geZcOUL0r2eAG+Qud8V/JMemN
         SUXiL1FQ3trPv4UGODFwU/N4yB7Ai++0dNGXM4GqDbg1qGxFls6bDWHY32V5Fi3Xai
         t1/2RA8X3FAjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CA10C60283;
        Sun, 25 Apr 2021 16:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIU4005K55S20FU1@zn.tnic>
References: <YIU4005K55S20FU1@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIU4005K55S20FU1@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.12
X-PR-Tracked-Commit-Id: 84a24bf8c52e66b7ac89ada5e3cfbe72d65c1896
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0146da0d4cecad571f69f02fe35d75d6dba9723c
Message-Id: <161936952882.1859.8694577051649508705.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Apr 2021 16:52:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Apr 2021 11:39:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0146da0d4cecad571f69f02fe35d75d6dba9723c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
