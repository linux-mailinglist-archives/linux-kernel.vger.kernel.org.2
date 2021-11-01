Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E334423C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhKAXNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232375AbhKAXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 36A3261053;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808257;
        bh=ldbouAT197+DFrgbP7DuvwJzaeOQDCc7/v1eaDeIyvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=InfK2QYvOR1zgY7evZvqXsTM+AGAUFLXjLeBmL3u/T9JL+4WxlE9M9krHa4ccyANb
         7b8gKYgWePCltPkIP1lu3s6rfi7yhSTvPlbV/lg796EpMz0gyN4uex9TLIFyLyaOoO
         q7gWvKnel8qGZ4o0Yi+Wk/PY/p/eRxleVqip6pKsJERbQFhrOmsneW8756NEvbo7A9
         4Iy7nzoMZUFux9PLy5cf5R9SwE4km3ua8KtclB69WMg3B9SfKhy6U4vfdDggea+sKQ
         OfgyjYlUpCCblzIb8WPSEWnG6vOJQV0q+dn2dy0/EEH2ODegOIggznIO2ZpAnBt2mh
         AtrAKt8ry9z7w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28EDE60A94;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX/DU1kH6/cRrgxR@zn.tnic>
References: <YX/DU1kH6/cRrgxR@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX/DU1kH6/cRrgxR@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.16_rc1
X-PR-Tracked-Commit-Id: f96b4675839b66168f5a07bf964dde6c2f1c4885
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 160729afc83c0053cb3c574b85e84574ad892bd7
Message-Id: <163580825716.31036.3343312640860087219.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 11:37:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/160729afc83c0053cb3c574b85e84574ad892bd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
