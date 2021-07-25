Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A8B3D4F4B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhGYRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhGYRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4123160F42;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235389;
        bh=cTlcmYAnDbW6oCy4EAdNUEs9kQUevw2ti3r5ihDoB/Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MpvME2e6T6ek5TmOw3QQO0DxwPXLPbs+OJ9hmBqth//hn4xg3T5iSohWtVIRKUYui
         17RFSy7Y8TdOcTcSJZ5wXPzGQifr4rAbF5DoIgL0mbp5ALwvhMCBmUfIjnM0kKxaqQ
         +MONFk7jDOVuLnjDXoVNfuSD8DtRc+2d74/r6kYeeabnsSdOh8nND/SjBqqYTELNYx
         Xzd9SBvJ7xrzy2UZuXUuc0pn9GSHlSWvDqnRy1bGFIl1RmgoFORO1mpESc/MmMmTA9
         /N1e1ZZVh3brKe9aYe0ZBY8dVKmRy7f+B+s7jdzh1Z5yJAbmj0uOxVYe6P97hV4YCg
         8bg0ZxdrL0WAA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3954660A3A;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162720492312.8837.12317399957006920016.tglx@nanos>
References: <162720492071.8837.4047241618315201209.tglx@nanos> <162720492312.8837.12317399957006920016.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162720492312.8837.12317399957006920016.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-07-25
X-PR-Tracked-Commit-Id: e48a12e546ecbfb0718176037eae0ad60598a29a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1b178254ca39a89b3c6407e29e87dd25734399e
Message-Id: <162723538922.30584.18118658203544490898.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 17:49:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jul 2021 09:22:03 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1b178254ca39a89b3c6407e29e87dd25734399e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
