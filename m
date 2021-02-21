Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66C1320857
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBUFH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhBUFHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8556564F09;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883995;
        bh=7eXey+Jle6K77NOHnXFNh8cjWJgyH3cOAeenSkLCS8o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LY4pkgUk0eQlAxfa5n2IHty4uMf0iscp72+ZgqcBpONsLMzG52nYrAVVKZYdbqceL
         9snjuPW5rG29qCdGxZYQozk5VRoDougo0WXxmpO8oNb11yhFJeFqpyse5oFJBrgcy3
         0RRjZ8VzR9QnKFPaoY1mXpi5kiEjwi35xWbn8pdPhHp0lEdfTQvPbeWIf31ZpfGMP+
         23NAMiQ0DnCjnHQkgaasjQ6OLaNs3M71ZpX7VsBrRq8kxiPCYRsqPghaC1ODHzeBUS
         LLkwOkh+x4OeSlGLZhmpC+1ZcVDwu0csWY4OQvHcKW6/iotkLh2cGdWzPs/c6ldKJv
         orpuAn4i6N5Bg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7E68260967;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/seves for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215104339.GD23409@zn.tnic>
References: <20210215104339.GD23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215104339.GD23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.12
X-PR-Tracked-Commit-Id: 62a08a7193dc9107904aaa51a04ba3ba2959f745
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9cdab6820ae740dad1e87e609d78dbea7a297f2
Message-Id: <161388399551.9594.2280178964146659062.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 11:43:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9cdab6820ae740dad1e87e609d78dbea7a297f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
