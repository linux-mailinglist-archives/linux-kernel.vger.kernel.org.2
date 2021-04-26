Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490BE36B713
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhDZQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234617AbhDZQlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0B81D613BA;
        Mon, 26 Apr 2021 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455222;
        bh=4g8SUTm9uBC3p5TjxFGq+YtNJ8hxf4blvBS30OS6Pyo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rwDSnKXFcbiN4+EOcCdbgGar3mV4TuqLpnAUxtWm6JkJ2SlZcFs91RGvVx34ZO4fE
         r/04qtOFxuEuveTJRxg1nh6ATNdh5bwCLlAHQFTDX3llcj7zrvMS+adlpdOh8Jf9QH
         AFE1hyX4YRHEqhvBvyKHG6t+dRFMq1k8mrh6Z6PQbAlITs3YNV7nD9MBZpv97azWJz
         bYufG31QNr0mmSuLYZtKyBFmcXUp/OfSeVyCLYu/ethNFaWfbjGlOXxlPyJIfWZMUV
         zUZzYzZwQNQdRYNwkBqAdby757KvvXUt0fMSeuhDRWEjzais/WJG5mDBEq6lwYolYy
         AIF0gwauu0smw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0282B6094F;
        Mon, 26 Apr 2021 16:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIac22TH/Lcp/aBe@zn.tnic>
References: <YIac22TH/Lcp/aBe@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIac22TH/Lcp/aBe@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.13
X-PR-Tracked-Commit-Id: 27743f01e391ee1d80e3be2a09237507b965f91b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64a925c9271ec50714b9cea6a9980421ca65f835
Message-Id: <161945522200.27394.9794737483973985437.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:22 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:58:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64a925c9271ec50714b9cea6a9980421ca65f835

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
