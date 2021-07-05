Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282BA3BC318
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGET0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 15:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhGET0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:26:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 805EA6141C;
        Mon,  5 Jul 2021 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625513048;
        bh=uVX2yCpdtPvb/0LsatUmREaH7MB/H+IPC31fTSSuQ94=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JdV8+CB1NY2KzmlCyrbmaRm0nAY/pJTi92mAPnJNxO36UenP81ZkBPI4RdMP3zgVL
         +mP3vB0IDPoGBUkMXpIMAix9OLYvJXollazGK0RD54MXUcEHEyWwxHcm1TCp4+cv1e
         OVX9K/141IPkII51eh9NyMAHz/iEc6WHHaW//1axGFdURQ1hxCdAwQXT78VMXqJv1U
         3W5wInV6fCTKuDTH1Bawwn472/lEsmV+jwGtkcGc3EV65UzSKMibFectqlYxSy2G2M
         Tq0dmaqF2ujw5Y2oabuvPQm4btr58Ij1QT3zK7btMEYd7fdLLxhNeJgs3xtBzOAiCD
         /ClzCe8NrRuKg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7971460A4D;
        Mon,  5 Jul 2021 19:24:08 +0000 (UTC)
Subject: Re: [GIT PULL] MTD updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <713549850.26791.1625426900795.JavaMail.zimbra@nod.at>
References: <713549850.26791.1625426900795.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <713549850.26791.1625426900795.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.14
X-PR-Tracked-Commit-Id: 0bcc3939c98d83955397eac1584d5f791fdc88d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da85e7ed6993144a9ca43a1106c7f898626390a3
Message-Id: <162551304848.9654.340536382376523669.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 19:24:08 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 21:28:20 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da85e7ed6993144a9ca43a1106c7f898626390a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
