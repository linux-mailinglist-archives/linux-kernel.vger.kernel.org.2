Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98D236BC16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhDZXhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhDZXhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:37:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A6BB161178;
        Mon, 26 Apr 2021 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619480193;
        bh=97uBwar4GVjgpXwPL1lpYqz0PZOQSdYeCcQN4bNW2TU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZWC/mAERwRHpQSMWvQ9sm7n8jKbonhO+uMR4yobmiWaWpgaBnVkt447uZknhdGQNG
         RbP3IgNGm1JMKDYogNwdJQ2i3pEGwgT9g2nWz6rEeO+E3tq2bxc6zwsiczdeqL4ius
         16z2EVquaI5YlaXlXBleBVi/FfqXz8JGZaLule/ZvD3QpuiK0eQSCuQHP7VkIonabA
         nMbcgnLsqgnYnVmmaHDtRNmEetTRrCsqTO6XdJ61ExsDBhD/2UE2AqlmTNwqZSKRLv
         8m/WNCmCodUD6jthJbBIXgufeZtfWVck1Z3LAN2GvbCuaoH7WAf9zFVIE0+93DC3zt
         IKUlSFeng1juw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9CE1A609AE;
        Mon, 26 Apr 2021 23:36:33 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426152647.5522f59c@xps13>
References: <20210426152647.5522f59c@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210426152647.5522f59c@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.13
X-PR-Tracked-Commit-Id: a881537dfaf281bfcb94313d69dcf9ef8fc89afe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 070a7252d21b8e8900ee8540f82f0f1a348f8816
Message-Id: <161948019357.27003.14199252693076955726.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 23:36:33 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 15:26:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/070a7252d21b8e8900ee8540f82f0f1a348f8816

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
