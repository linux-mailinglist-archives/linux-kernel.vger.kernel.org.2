Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E067B410D59
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhISUi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbhISUiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4897161004;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632083806;
        bh=oL5DK29DZiD8EJnXk081cm+yiXfY+yJk26PyFjy9CBg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UOkDck99C1bfPniXGaCyDwGFFcBmT6c3iZG+93SaAKOMEO8payRN8n1VIEWLnWO0/
         xRAUOUB2qAmGe9lZLotxlxqO+JscjrUpIheiuknaeA7vdz5VsqyMMwLo/wC5mexPCV
         a0rV98robDOmFY6K1CZ4OuBxq1JNdzjeFUx4UlzxeMUMhzTNTTUP1OMlE/Utlb3hIN
         uR+5o5KfMhfunrt+bM3Zfkv9CACXfy7hkilgTq3glYxchxOT+oNN+7JQGUQiSGzOV9
         8BeqNLuGW++l+LRFQRrvCAwIiGygJl9GqqxItu9LPOK93zJg8m322aUytzYxO80LNb
         HJZZzpuqqDhBA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 32FDC60A2A;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163207602242.947088.16824174748243890514.tglx@xen13>
References: <163207602242.947088.16824174748243890514.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163207602242.947088.16824174748243890514.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-09-19
X-PR-Tracked-Commit-Id: 81121524f1c798c9481bd7900450b72ee7ac2eef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5e29a26c42b2c1b149118319a03bf937f168298
Message-Id: <163208380620.27843.13519687686916533818.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Sep 2021 20:36:46 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Sep 2021 20:28:07 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5e29a26c42b2c1b149118319a03bf937f168298

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
