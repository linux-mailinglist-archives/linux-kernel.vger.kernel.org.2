Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1943D4A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 00:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhGXV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGXV4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:56:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BCC5260E8B;
        Sat, 24 Jul 2021 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627166197;
        bh=+eTds5OYF8X7qt3SB/xIKyAKtIDCGCpqjkJ/noOqiyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nax7lVlj/OdKUGc3ra9wFoqRHjoZqAahfSSIVkh4vfTO/x2ykjsSjJ3E1sf0r3PU+
         cb/iQ6eyLmgkQBPi+soX/qEAez460aS6LUpM0xhomzgObwGBMHbzLYURHQAFM7f+8R
         od7Q0fWuLcxpZuFpfvfPSvu8FVQoTbbxeCQ1y+hLXLtXYKnOnw9aNLbHCWsVcyTQhH
         qUSxB2bls2/JRX8HFBLIEj0aWe25hdzneURTWiBV7Pa1/fJk2P+IzMSXksbv6L7xFF
         Z8qk6r3+v2nvGhqF+sKdDmvxqnVhsa+3oEMmoPbMl9ERnOpaWZvna/liBuZtjUFr3l
         BjbJtSpyYiELQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA6F060A0A;
        Sat, 24 Jul 2021 22:36:37 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-5cd676be-7ed7-48de-b740-0e809ae67a56@palmerdabbelt-glaptop>
References: <mhng-5cd676be-7ed7-48de-b740-0e809ae67a56@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-5cd676be-7ed7-48de-b740-0e809ae67a56@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc3
X-PR-Tracked-Commit-Id: ea196c548c0ac407afd31d142712b6da8bd00244
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6498f6151825f1e5aac5543fa9ea4ea218dcbe8c
Message-Id: <162716619764.31495.14247900326730279549.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Jul 2021 22:36:37 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Jul 2021 13:44:02 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6498f6151825f1e5aac5543fa9ea4ea218dcbe8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
