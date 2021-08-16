Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C643EDB13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhHPQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhHPQlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:41:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EA31261029;
        Mon, 16 Aug 2021 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629132035;
        bh=WEyHCN3pbkK3mpnpo//myd2NHCLXBBQX2jeA9+kHG98=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sH308Vnc4J/j+2qXjabnSzX/y11s8MwwPUp9/INyN7SvYB5uHv9/SaYy5ei1KPB+a
         YWhJY2M8lYscYeTLDWiCvcLxHDdjvsyRgqEx39GiiO+33PzE7UWABWjFD/+pY+j6c0
         uCnGdma4EMxwnN+fxkGC/lpgByK5sbWYBKM/6Fl0FDg6MNbzJA/8ytscBLK0+hbOeu
         KH8YUh6K3VBarWoK/H3MfPSMV9eiwuGM9s6HdvRh5WAteF2e6bl3zbyXO9oqGLbK1W
         pFrRlaAmoyzSh2CXhxphFK/MbIMjMkKQdHqdv7flpAhIsESd2AI6S9s2EvviBQtXGd
         WllhiSl+s/GPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E3A84609CF;
        Mon, 16 Aug 2021 16:40:34 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210816172040.7a67f8da@xps13>
References: <20210816172040.7a67f8da@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210816172040.7a67f8da@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.14-rc7
X-PR-Tracked-Commit-Id: b48027083a78b13356695555a05b0e085e378687
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2824f19e6065a0d3735acd9fe7155b104e7edf5
Message-Id: <162913203492.19716.4161960278018208717.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Aug 2021 16:40:34 +0000
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

The pull request you sent on Mon, 16 Aug 2021 17:20:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2824f19e6065a0d3735acd9fe7155b104e7edf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
