Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF03FBD7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhH3UmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235293AbhH3UmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:42:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 29BF160FE8;
        Mon, 30 Aug 2021 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630356079;
        bh=PtMRri+lxtYLqjmJ6bkdQbOelbsSjGtHHJGkQj3XiPk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y0KNam3pJuKZGKTZlehItk6QvrjuegpQnWDJky2EE3g9sLu2R3iijP//AqF1X8WxH
         my6uZhwr3ibzf6I8DeAQp+KpAcBEOsLlhjkq1/k+BVAuJ7ArD1+w8ksT87cSwr+uYK
         V9CipC8z8JNOD96m17g4gFAYyCLUWWGNKCBTQfj+yMpFHWEAI17rvLPvgCI4YFoPLo
         z3zty6lqdNnBkK71Fefpq1Hx0b529wxsQ1qgXtSy+4huS2BQNs2XvFVh+JIGzC+62y
         uvpRcutR0hJCJowMz8Vlt5NnfwJcATxAgaQFgDlSr7aJj4jP5IqoUCorzAkvrR0Vps
         QdL/N+XjQthsw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1E95D60A5A;
        Mon, 30 Aug 2021 20:41:19 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSytntfrU9n4fuo/@zn.tnic>
References: <YSytntfrU9n4fuo/@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSytntfrU9n4fuo/@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.15
X-PR-Tracked-Commit-Id: 5b3fd8aa5df0244fc19f2572598dee406bcc6b07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 230bda0873a6ce4d089afde22aa5e487888ddebb
Message-Id: <163035607911.29257.13505669613434626681.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:41:19 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:06:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/230bda0873a6ce4d089afde22aa5e487888ddebb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
