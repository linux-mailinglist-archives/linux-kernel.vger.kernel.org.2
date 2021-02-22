Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29317322241
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBVWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBVWjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:39:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 34D8564E27;
        Mon, 22 Feb 2021 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614033543;
        bh=UbYbIp4FKJqKLIr6OvJG5dzkozXdK3yFqwH/pvSXG8w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lRSqlP3jLJQRPkoJdU8FQrYeMty+Qkl5j/wh8FjxcFAvXPT382Bah3CtCr6Tk3u6E
         7fv/pte/vMV5SPJ+PGz2aMRcvDnTKX9+Tf8P2L7JS5+sp67FGMr59WUlqQRmX7cJ7E
         nsntGcdP3ZIHxsJCVipRpX99N5PYhqkEs3HZ1M6JcnvMuNcwrffEne4Dck/GrzFLDb
         Go8h2krayqQsshtkK9r2lTKIj21ZFWUhzgVE6cZgTGZWH4g3Rk2kkBvIb82IoDe+MN
         QJaDoVHXP4gAc7tJAlQpustN6UQ1KgkGtqA6zKAvITquK9rzrGedIXucNLTg/jWBIW
         UpdaZLADp9BaA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 173B660963;
        Mon, 22 Feb 2021 22:39:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o8gctii6.fsf@mpe.ellerman.id.au>
References: <87o8gctii6.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87o8gctii6.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-1
X-PR-Tracked-Commit-Id: 82d2c16b350f72aa21ac2a6860c542aa4b43a51e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b12b47249688915e987a9a2a393b522f86f6b7ab
Message-Id: <161403354303.914.13622504126022266023.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 22:39:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ananth@linux.ibm.com, aik@ozlabs.ru, kernelfans@gmail.com,
        cmr@codefail.de, zhengyongjun3@huawei.com, oohall@gmail.com,
        sandipan@linux.ibm.com, cy.fan@huawei.com,
        elfring@users.sourceforge.net, jiapeng.chong@linux.alibaba.com,
        skirmisher@protonmail.com, f.fainelli@gmail.com,
        unixbhaskar@gmail.com, eerykitty@gmail.com,
        aneesh.kumar@linux.ibm.com, haren@linux.ibm.com,
        ganeshgr@linux.ibm.com, msuchanek@suse.de, nathanl@linux.ibm.com,
        robh@kernel.org, kjain@linux.ibm.com, npiggin@gmail.com,
        broonie@kernel.org, cai@lca.pw, clg@kaod.org,
        hbathini@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        fbarrat@linux.ibm.com, po-hsu.lin@canonical.com,
        linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 23:05:37 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b12b47249688915e987a9a2a393b522f86f6b7ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
