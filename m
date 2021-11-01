Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1084442282
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKAVWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhKAVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9087161053;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801600;
        bh=u8bB1HhqSLSZHypZwi7W9ezNlwu1NborIGO7aY8n/Qg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bdfpSCMWBuZNl699Bop9u/cBq5h7oPBmBSQWGfGeurxFNVN6sGWZRlOmOgMChekiP
         rONOyxD7Wrdma6dcjYeEDge+ScVA3r0gddB1E37A8IH1L6AmfgH7wec6sw0ZI36nVW
         SxpSk8RNLyNuct/z7Ds6pMzkVnQFkpOc/Z1Ep3z2ADrpLBkw9l0KM0yFlxYP5tF96h
         vwPMK5lDQq3agdivUFMWwEYmzDV7Sol+UXkZOZxp6SqwewJ2OTB/trILkplnVik40W
         6SyNXhA+YN0SJJCVagq5C/AV1E3pfyENHAy9xq4RDYfBQBZd9KioAUDO/Zcyxrksgo
         QYV5Z85hdg/PQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8AD6660A0F;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572865003.3357115.14627825438101527879.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572865003.3357115.14627825438101527879.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572865003.3357115.14627825438101527879.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-10-31
X-PR-Tracked-Commit-Id: a8da61cee95e627ed3d4274861428013aa9604ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57a315cd7198907326e691cc909df2beebc2420d
Message-Id: <163580160056.7741.6844853562374623855.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:20:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:16:06 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57a315cd7198907326e691cc909df2beebc2420d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
