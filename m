Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33604438AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJXROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhJXROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:14:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 28A7F60F9B;
        Sun, 24 Oct 2021 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635095552;
        bh=vy2TfxcbCGYjjDuEnaqScB9Wgv7dUejqmxkKp0VQirc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qiQRCK2c93ZgkZ1Ndg4ea5UPExy2wOQqKXtBtJL00N1XpHtMq7cnXix1f2+vUR0DU
         PVkEo2yxRyRLuXTizY+E8gwzjqOH/YoYr6ZXpryiBviBpN5pxERNtwALL5l/NHhpbG
         JH5X1GqjZ5r0C8G0XvzsLaQaZgYSiOolOtsQegeY67XiqE2bkDB3DsnaR36EQBiO6g
         TL8IUgEhl4DVqSD1OvwQcPO88yFLmJX7ZnzGWWtsUHjYBB5Nt32pAyQ+fpYB7gM+fw
         e6+WS6RHFmSIBnB6NLnNoK4I/xq4lNIgsWKR2AhFdNYmlL7yHFAcAQhFnH2I9zFmzg
         gaGngDdtHw5kw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2163760A1B;
        Sun, 24 Oct 2021 17:12:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YXUpy05ML9v1enXe@zn.tnic>
References: <YXUpy05ML9v1enXe@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXUpy05ML9v1enXe@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc7
X-PR-Tracked-Commit-Id: 0a30896fc5025e71c350449760b240fba5581b42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16bc177666c037b4aa3e1f68f4eac685006c622b
Message-Id: <163509555213.13231.12950867925943502180.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Oct 2021 17:12:32 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Oct 2021 11:39:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16bc177666c037b4aa3e1f68f4eac685006c622b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
