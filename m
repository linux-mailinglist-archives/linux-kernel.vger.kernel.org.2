Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF93E42036B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhJCSWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhJCSWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DFE261A54;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633285248;
        bh=nO10C9kP7mw0Gj7YTUJ0cfWKH0drvv6BufygsQ2OCnw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hRzDs6VBsIU3wjXnC3aYar1BAtO3lfYRYjwhaX8qjs7bnBwiEe/nX0dFrKgTsiT8K
         6kMtyh49c3xF8CI+4EklomHwiZc49Uk1+dyDjq1u/sd3JulR/jEQsztxQbPO3FdPcN
         uUiC5rhtwVZpmC+9zkJD9qVGHrtbBp7DwWFNScjVYjgiTU1ls+xv5m7Sl6+Hc1UK5s
         U+9/c1kda3SOPC/DjrPsPgRPeOuuBOVsJghAYHnZcvJSGrvet4CqKrhWG4RascgD0Y
         jLZXqSHq7ZX15SPH5gIpcupJtS5eauNVdJZtudg04t4YPBkRbjGD8ygIqHlXdMSBok
         xpHTEhjMt8GBQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 50594609DA;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVmDHIFZyWWVcZHx@kroah.com>
References: <YVmDHIFZyWWVcZHx@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVmDHIFZyWWVcZHx@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc4
X-PR-Tracked-Commit-Id: bb8a4fcb2136508224c596a7e665bdba1d7c3c27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6761a0ae9895fce67536510396bfa63158b0b8ec
Message-Id: <163328524832.23868.9653406325205953400.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 18:20:48 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Oct 2021 12:17:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6761a0ae9895fce67536510396bfa63158b0b8ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
