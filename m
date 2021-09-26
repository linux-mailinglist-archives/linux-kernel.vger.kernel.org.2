Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694B0418A5A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhIZR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 13:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhIZR2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 13:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4872760FC1;
        Sun, 26 Sep 2021 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632677224;
        bh=esKhdZdCXDqjsbkEFjr2Rr4ZWaHgdxocG8WzQoqveho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g+9gzzPU2FWVcku/wCHhW/pfMso4ZYu8GxkzrgrVv+xSca05Nago8ncQvppLLrIoM
         0+hjXCPi478eALfp21RxI9tMCjWUasRsfYW6XTIQSERkOHBwO0xg+9F94F5RKRieti
         FVjTMei9jYv52jU9g9NXGfN6gEUra+9S+qH4BLlYtfZHJGBJ/O2N6/uiUlfnI/doiQ
         mHMhVvv1eLcd1ZmW2bpbt67azUYSRDFxyp104G20ut5i4MU/xOL3AzmF1IUuB6dSej
         bE+siEQN6yRplE0DfnThtQNz7QyF1GbMfwkEMZDbN0SiJCRQQi0/A8vwnQ3cpeCPZG
         FX1xaPNUaUpXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3E13760A48;
        Sun, 26 Sep 2021 17:27:04 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163265189517.178609.6605494600326137493.tglx@xen13>
References: <163265189226.178609.9712455554034472888.tglx@xen13> <163265189517.178609.6605494600326137493.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163265189517.178609.6605494600326137493.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-09-26
X-PR-Tracked-Commit-Id: 5ba1071f7554c4027bdbd712a146111de57918de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bb7b2107f8c8e97750a36a723f3f74f819f6ff1
Message-Id: <163267722424.5286.5872759649654125070.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Sep 2021 17:27:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Sep 2021 12:30:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bb7b2107f8c8e97750a36a723f3f74f819f6ff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
