Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F594041D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhIHXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245543AbhIHXdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 13BC360F01;
        Wed,  8 Sep 2021 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631143916;
        bh=EgI1XxARXKZiQ0HISuzGRYn7egNJtb29N8zQfDXv1wo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GWEGviiXKNlkcRWuk7bpXN65QZKbUm5zgjdy5WBm7go9v3IziiZmAc5HP8Iknkn8a
         rtc2VoeIzLNToWQ6+Mf5Bm6zITspJ0bP0ebqV9sayH7Z+oXsQJjtf5DpCh+8V/zAcL
         Hs7V/TFMzOO9Vh8Wrj6tNdlYdrhDplgr8lN2YSXl8tmgIvkqgrUiZ+ertNdZqw+Kuj
         tpeYW5SBOqtA838h+EQIlZ+0W62nM1Kb0pAu1gn0/Nkb4N/495qoEyyrPrX7vC3Y8e
         SvpH7801BqhPUCia1D7WrXFI6oQlgPXyBBI+tZLTOB8jQ/mQchB0Bjl4Fl2zKwdo+C
         ofExXYFKd647g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0AF6C60A38;
        Wed,  8 Sep 2021 23:31:56 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a453ca42-98a8-04ee-0584-673b1e661627@monstr.eu>
References: <a453ca42-98a8-04ee-0584-673b1e661627@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a453ca42-98a8-04ee-0584-673b1e661627@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.15
X-PR-Tracked-Commit-Id: 315511166469a641c1b838eaca6bdd3af5c362c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1511e5d64a51292a84d38e4146304393ebe4d080
Message-Id: <163114391603.13056.7683566268492820325.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:31:56 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 10:05:59 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1511e5d64a51292a84d38e4146304393ebe4d080

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
