Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD53C3EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhGKSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 14:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235785AbhGKSY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 14:24:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B59161106;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626027731;
        bh=IvP0jUzgOpjWOECiVWJU5c6uz5CNfmClWBSYDQxOC5Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nn/HNS9Bg7+VuVVZmYFXY/HWzZXjI2YZi7xWxKbEwhX0SGnCymlNlyNVJ2M/RH2XL
         EDbTPvrseEbbs9JDyvYVd3IGDiQILYWQV80VB30fQCrxQ7cWGJ5sTs+HSBGgI9/zhB
         YiOme4eQ91sibH1XvahJYSDRapRjhfkhtZeHeHg96DbAdsGa3ilJhFsG9WKeHS9lS3
         M5GjFAEA0zWwMY7UwpQEg8tcW+DMKA3Woww2b9E4RYC7E+YVYUa1zD7U5TSeq1KA0C
         02aLv2Dpeei74HZM47PgkzI5HyHCp4A+phtxvyzKl7j5t3jIervy+Yn1anXQc9Vki2
         WMFH4I5b9lCTQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84C86609F6;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOrzBvSv4xoU3OAX@gmail.com>
References: <YOrzBvSv4xoU3OAX@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOrzBvSv4xoU3OAX@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-07-11
X-PR-Tracked-Commit-Id: 3e1493f46390618ea78607cb30c58fc19e2a5035
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 877029d9216dcc842f50d37571f318cd17a30a2d
Message-Id: <162602773153.20558.1866715899196214297.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jul 2021 18:22:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Jul 2021 15:32:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-07-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/877029d9216dcc842f50d37571f318cd17a30a2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
