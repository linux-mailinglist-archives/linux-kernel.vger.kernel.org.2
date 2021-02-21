Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C96320E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBUWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhBUWCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:02:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 014DB64EC8;
        Sun, 21 Feb 2021 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944911;
        bh=dwRDg5jNz8Zp8rEPN2dZ9dovdk1dBdGQUuB9UGzIf9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E4Uu+/hXx40xMpgaKkm2oNdDqgzJtvPCfZYHmqRznEnC8keGxe0xRp9fur702/rPz
         W2M/C4GTmroZHhTf1qjVmI8c3csUP0NUv+N4iyKaIkgq+WLXnfieEgz+h4xxuLagkl
         sJdn9dSZDkfmDa9qa6DXZYm1zpILSNdafHFZJRJ0ED6uRviO1SyBx1b37X64yCmETC
         M/+ekH+3Z6gIqj9SIrAFiHM2mwwzft/lXQMMLHIRHGfwQJCehXKwxWMjqx+Br4l/vd
         3ODARGASXiJ386185loQ6d46WLJifjEuAA1sycZhciTNMrMvXARuJhbE+MXDBAyJ/q
         RkhCFLklIZUGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F0E1760192;
        Sun, 21 Feb 2021 22:01:50 +0000 (UTC)
Subject: Re: [GIT PULL] MTD changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1860844222.14898.1613937724518.JavaMail.zimbra@nod.at>
References: <1860844222.14898.1613937724518.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1860844222.14898.1613937724518.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.12
X-PR-Tracked-Commit-Id: 6e9dff6fe3fbc452f16566e4a7e293b0decefdba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69e9b12a27a1b2d099e528928162428df4d6e93f
Message-Id: <161394491098.8676.12625244745780820419.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:50 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 21:02:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69e9b12a27a1b2d099e528928162428df4d6e93f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
