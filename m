Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01682443CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 06:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhKCFl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 01:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhKCFlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 01:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 290976112E;
        Wed,  3 Nov 2021 05:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635917927;
        bh=SX/3duytOA47V7kVa8cT/3JrMVIHRQ0b4X9WNBZDroU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HzkWExkPpcrYlnBeps2pTBDcjbPw71/9aeUtXUdpR3JHH6gRbdwhhRfJGSgF90+hG
         TBBVKQkKVKuuubY1+v/29CyfLpjUICfC+f37wt5zC5EwVj/k2joWwEAk2WPFhWfESq
         /lcRm2/f5oZxQCK2CYSaUQoT2PKaNV+ndwCVu04xTZwOk5mYLxtVllhuI+wrCF0JCq
         djehEwciGCOYPMEiDdV60o3B6rKrvG+9qfkY6uGwg7Wd1Quz9uuFlMAxE0/fDAF1IM
         09dCtRwlEI2FfTRPjHLbo0S4vap1TjUKnXaBV6Yt1cXx7pg9bxCQdsqTh0VsCa72C+
         rmqC56Q1ACT7Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21F5360176;
        Wed,  3 Nov 2021 05:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.16-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <34147942-cc36-29ae-02ed-226bd3a56bec@redhat.com>
References: <34147942-cc36-29ae-02ed-226bd3a56bec@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <34147942-cc36-29ae-02ed-226bd3a56bec@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-1
X-PR-Tracked-Commit-Id: 97ae45953ea957887170078f488fd629dd1ce786
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ab1d4839a486727fdd412bd8bab27417388d381
Message-Id: <163591792712.8140.5833962565605898136.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 05:38:47 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 16:20:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ab1d4839a486727fdd412bd8bab27417388d381

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
