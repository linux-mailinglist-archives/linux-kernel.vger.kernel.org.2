Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEEC460836
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358940AbhK1R7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358641AbhK1R5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:57:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F69FC061748
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:54:22 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73FF061055
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:54:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id D56EA60527;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638122060;
        bh=mEzMi77fma705dHqWzNlEhuu3nzJVGE33PG6QKM7gOY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uG6/NBJr7MfctUacWZL629E6zjcy2lGIZsrGZGZ02/MTsN0zyJTpHXVJzvR9o/GYF
         3WcynfCJyVckwOsBtvmtgLSIDqo0t2KoVtW0J9jn0J/KDVsH4kCbiTXYbLqY9iVkHL
         j5UErxDn9Nnjim+AlcbeAM0Sv0We6dnWjpSHCPOE3rrJVsNFClRWBKwemKvBBL3EHv
         mMYW4DTtWpVrKSd0oj52izupgMusn1DJOZxGN5VXV8VH2QUlBZD+jYKHaS8oKADQ2W
         pqV/q2lgQ18LkKMxUpeTSFV9PN73L5+kGF4k3JYuvvaplNp6y8LXSYIlzFxeYQo/ev
         /Ly3Tx5IgSYcQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C3674609D5;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163811728858.767205.8050385026777394335.tglx@xen13>
References: <163811728418.767205.14544746031342483043.tglx@xen13> <163811728858.767205.8050385026777394335.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163811728858.767205.8050385026777394335.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-11-28
X-PR-Tracked-Commit-Id: c0f2077baa4113f38f008b8e912b9fb3ff8d43df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9557e60b8c3521e43bf5f21db95b2b42d7c43ac9
Message-Id: <163812206079.22773.3024568156799791987.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Nov 2021 17:54:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Nov 2021 17:35:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9557e60b8c3521e43bf5f21db95b2b42d7c43ac9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
