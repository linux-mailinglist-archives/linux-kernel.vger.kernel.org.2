Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9114C397FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFBEA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 00:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhFBEAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DC40613B1;
        Wed,  2 Jun 2021 03:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622606305;
        bh=+4Pe4fPtemE7mpMXhFS36EOqMJqKYI8Mp2VQKCEYmW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V7OYk9dZX0Ca5AQP6fLWuJsdw1adIuJfzSMEOQ2kHaC+nUDZ8QCYw11Lhc9z5v8ct
         hzbB9AgB7z1YEoyhsRCVeuETOw9aIH4MBNdpxugo/XSQQsOMgZKOVG3OXCdhZFl04x
         7GCVO9TJ2zCsnahROntcGIiE4IW7Ch1teZigIPzcxr8ojqDc+ifkPRtBgElpcNjuF7
         Gb6k05BrWyKKQdImO+dn48mwWWlJ8wlOWNMWwdfe5yMHofl79n1lmdeIHxOY1PgMvN
         B16v5Rkv/y8HdgSkv9wNKzCJBHgqvHv55HxeYbJLAQnGlvfkcL0c+eLh8z+PF0Z6Rp
         AVOg0p2KK64Tg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A66A60A5C;
        Wed,  2 Jun 2021 03:58:25 +0000 (UTC)
Subject: Re: [GIT PULL] Revert "gfs2: Fix mmap locking for write faults"
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210601212200.318607-1-agruenba@redhat.com>
References: <20210601212200.318607-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210601212200.318607-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes2
X-PR-Tracked-Commit-Id: d5b8145455c629e7f157d2da46a9b2fba483f235
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00151f515adda740f4688c529eca61a20359903a
Message-Id: <162260630524.21167.4225798479990860158.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Jun 2021 03:58:25 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  1 Jun 2021 23:22:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00151f515adda740f4688c529eca61a20359903a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
