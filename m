Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEB3BAEB1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGDUMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhGDUMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E38086141C;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429386;
        bh=3D8sjx+xhAOCtqY7CWI9mz/fbfBHTpE3SDuHBEmQwcU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XS/gG0J4DXVOkzSfnmbi5kkQloJ4D3XOxOb+jz1SlMIfrDQoST3/RNqwsjQAMr5LY
         kwi1KSts3GLYHzFQb55TI+e7k0q2M9FB/0p8K01dtXRRffvP/utTUqnhEiHpcHnPN3
         dCo19h1b5RIdztJZEYHjx03P4bGnmpOxrm2yQ0vQN7AXjpge/MZZbVRnkRbbLcPfpm
         CaXoBftFL09OpRb28gTdr9YQ2PsI2awyzDmCx5xP7AaTPHt8YzhvDWzf+bAaLh8Ci5
         baLpLXcW0Txfdld7wDBIvTp7mj1bp++oOFBcpTz5jss7dKm8z4vw482rU6n6Bm/Jnm
         cOutgB1wX6Kkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE14C60A27;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] Linux-kernel memory model (LKMM) changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210704173353.GA2970051@paulmck-ThinkPad-P17-Gen-1>
References: <20210704173353.GA2970051@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210704173353.GA2970051@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm.2021.05.10c
X-PR-Tracked-Commit-Id: d25fba0e34742f19b5ca307c60c4d260ca5a754a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da803f82faa5ceeff34aa56c08ceba5384e44e47
Message-Id: <162542938690.15409.15705873778864438304.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:46 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 10:33:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm.2021.05.10c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da803f82faa5ceeff34aa56c08ceba5384e44e47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
