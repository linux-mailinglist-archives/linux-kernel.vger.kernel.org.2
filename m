Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7535838DBF1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEWQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231818AbhEWQg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:36:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 69847611CB;
        Sun, 23 May 2021 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787699;
        bh=ZkTUDgkimc8u2uiD5wJP1gvGjtyHlM5Xryxwx3yblco=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GIsldUh/XZrIwpX0HAkbs3gj7QBh2JEW/XV6ENZTjqoK9gJlFvY/tz37LrEFhyYJq
         6x9IfbeFihrOjoaTv4sNs91lRmiEa3/G8xy7mAgUZkn9fy4b2jV0BjmUEy8wzWMBln
         D86lW787sFVyUKd61WkWqbTF/QiORAyqztM3YIxKmX+Is+9ES2BkIpjNPGjqGdp5da
         4GZ+CvJi+fylDunRHx14BFtmvaSCtchPxZlSmaKJJzbU7lKBPmkKAlwQlJxN0rNwA8
         ReTPWxnlr2d1UvZv5pnb6WDR9FoOBffc6rI7YGN8SP6uwHhuFlT1kHuDRZs/xdjlc0
         F6R8X3s8/Zgjg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5E61560176;
        Sun, 23 May 2021 16:34:59 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162177682566.10917.13437446148350571411.tglx@nanos>
References: <162177682324.10917.7221704858691713254.tglx@nanos> <162177682566.10917.13437446148350571411.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162177682566.10917.13437446148350571411.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-05-23
X-PR-Tracked-Commit-Id: 488e13a489e9707a7e81e1991fdd1f20c0f04689
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ebb6814a1ef9573d8488232b50dc53b394c025a
Message-Id: <162178769938.22288.8317980105246952937.pr-tracker-bot@kernel.org>
Date:   Sun, 23 May 2021 16:34:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 May 2021 13:33:45 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ebb6814a1ef9573d8488232b50dc53b394c025a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
