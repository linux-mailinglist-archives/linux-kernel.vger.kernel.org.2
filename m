Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E73397EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhCLUDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234572AbhCLUDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4144464FA6;
        Fri, 12 Mar 2021 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579414;
        bh=kGKIw/e3syyXYyBTIr8hLkoq32vW6eVrvDWXloQG96E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1iBU7doNNDyTEnDbjG/oSDG+WLzTbUslRBajAYTxy5Z5c/asHv2BjasfVso7195S
         yD2Gh9D46OYH9/5fYumyDIQCcj83CiAYeFvRs0FFroXkULqCHI8VahbSWXci6tbdk+
         86ZHe775zJuX0lo6FpFJaOPey3D2nc4rp126vjzeBRXvRsRwA4P2PsJixX4yHK35JD
         n7agueNLMhurCo12+GOs6CIKCd2yy8qWeX5+mnvPYgxZTdfxYVBtICu0dhVmEEhz0S
         wclWTmFNJ+l4th3pFMLR1w3U+DStIZYsRvw/Mrc0IXXlo9f4OyFCdptzMKDqnY0jUe
         QTHxN0ni1RUrw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3BF69609CC;
        Fri, 12 Mar 2021 20:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210312191230.DE78564F80@mail.kernel.org>
References: <20210312191230.DE78564F80@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210312191230.DE78564F80@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.12-rc2
X-PR-Tracked-Commit-Id: d450293c55005a3b0a25d209e981ac425483fead
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 270c0551abd69c7b5cfe8a10007dfbd2c29777e0
Message-Id: <161557941424.10515.12946009231925878185.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 19:11:05 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/270c0551abd69c7b5cfe8a10007dfbd2c29777e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
