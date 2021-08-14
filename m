Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10983EC3E5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhHNQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235824AbhHNQiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6CDD360F9F;
        Sat, 14 Aug 2021 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628959107;
        bh=usl2dHOeVd2/n1Dj7xONUdcyHGEOpZSc2wjxJW5H6Uc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZUsULPyUtp1xevDliWYOX4rp+Ufhm/VrOqRNkrbJZKwDGjWuQf+0ZZLmlPBtXKDXN
         c919A6MMNMnQC0ZAKnLyVDSR9baRxX3bKuxWHhNf32sDc8QWMb1ecC2A0QQrBBG9RY
         KeS9uuefLrJ7UivngIy2LONGgcgmv24bTRZLy4vZmE8AeRhQxkjIeToiqftrhxTWVN
         WtcUhsI8AnbLqUCytVwcHzww5k9QI7MLsBQ4/9nAE09/TurMFiIjn67t2a+QFSliH1
         919s4bp/inMCXVYtBAHf6f2Hzpzv+Dd5WApZHVI0gsw1KZHVP1bSKhSci3ALlIzu95
         0NvCNIEb/9xgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66F2A60A4D;
        Sat, 14 Aug 2021 16:38:27 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-eb8a31c1-f921-487c-8e96-8d4c32f8ed16@palmerdabbelt-glaptop>
References: <mhng-eb8a31c1-f921-487c-8e96-8d4c32f8ed16@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-eb8a31c1-f921-487c-8e96-8d4c32f8ed16@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc6
X-PR-Tracked-Commit-Id: fdf3a7a1e0a67a52f631b055975c6ac7e0e49a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7a4f1c0c8455657b3e19eaaffbad64a5f750c43
Message-Id: <162895910741.32142.6255521916706120489.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Aug 2021 16:38:27 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Aug 2021 23:51:59 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7a4f1c0c8455657b3e19eaaffbad64a5f750c43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
