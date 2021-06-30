Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499F3B7C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 05:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhF3DiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 23:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhF3DiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C900661D04;
        Wed, 30 Jun 2021 03:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625024146;
        bh=YFRVnizrstqotfJsQg1QUlMrl0pw0EfRqv/eak10pB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OKPRjuoifvQTZKKC2MNn2wubKWDgnDbfHKdqopwFZ3ISq70yB55UqgkXNzmYQvy9u
         PFAje36H1RdIiki5N/A2qTeu0HbolBXp0bj9UdVd4xa/y4p0/SCoD0bZcCFkyOh7/2
         Y1OuILMhB+TWdINwMFVVwzB+CZBx6EKWJBIAzXnsjfIyQLGi0/goH+bbXU5YLJU+kE
         Jgou1s2DJkF70MwMDWC0IaCrRpA/oG4WzwCSwfHp5aIg49R57UAQC3OShwljHSmY8k
         NGfgairQq/Cz6amzhaKjzYsl7OwvHrMgz/fYcroAlPhC1Kz+kxJCfQAV5DZoW4LxUG
         uQlKFa0I7HJvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B48BB6095A;
        Wed, 30 Jun 2021 03:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mursRhnq7Cgk-kG-kKeV=F-NL9XaGsEREo4WR-NBAhGPA@mail.gmail.com>
References: <CAH2r5mursRhnq7Cgk-kG-kKeV=F-NL9XaGsEREo4WR-NBAhGPA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mursRhnq7Cgk-kG-kKeV=F-NL9XaGsEREo4WR-NBAhGPA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc-smb3-fixes-part1
X-PR-Tracked-Commit-Id: 0fa757b5d3ea6e3d3d59f0e0d34c8214b8643b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbd91626f71c1582301044f5942751eeb4ca98ba
Message-Id: <162502414667.31877.9621447535724601347.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 03:35:46 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 18:52:17 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc-smb3-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbd91626f71c1582301044f5942751eeb4ca98ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
