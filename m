Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A936B70D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhDZQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234583AbhDZQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C211D613B4;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455220;
        bh=aVeJEQ07SS6huwWvUQja5vlJ/11TnYRnH0hXHDhwSCg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o4tHqti17QdQIIzXtVn3OrwJYl3JxJvJos0lYdlN/80L6WB/I+M0bHqMIqp/bXCDT
         nTvMmbrfzmthNRU8IYhz3j4ZnfTfWXSZyAVWeLtqna4aBNHURyoFt1BWqyIz2+aAZS
         iXsJJ5AwRzhRFn+F3ErZYustVmJAJyE3aC8fH4ViLCCd0lYPTMaT8rtoYhEdJ+y7Yp
         p/NGbppvDDXJ5mkCW+AwmTG3cyAN7kbme5B6U6LyOMkjiAnzRJnaEDp5s1TV0l3pBr
         ZhTSq+KIZSNhm6J7pil6q8ilxJb8vkErhhIv/RASdhWCSAXAjRQVLZrZn0QWHtFsbY
         ZYr9vMAWBNToQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BB3676094F;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/seves for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaSN9AnCi2jSQ/Y@zn.tnic>
References: <YIaSN9AnCi2jSQ/Y@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaSN9AnCi2jSQ/Y@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.13
X-PR-Tracked-Commit-Id: 799de1baaf3509a54ff713efb768020f8defd709
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26a4ef7e481c9d70d2e0cf0be1ad37279fe0b6de
Message-Id: <161945522076.27394.5597793934972717214.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:13:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26a4ef7e481c9d70d2e0cf0be1ad37279fe0b6de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
