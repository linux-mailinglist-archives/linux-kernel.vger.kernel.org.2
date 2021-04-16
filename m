Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF62362656
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhDPRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235535AbhDPRI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1FC516109F;
        Fri, 16 Apr 2021 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618592882;
        bh=yU2yD2hb7AoULWvQr+2/jUs6bcPJdw2gUXHVD9sbjvw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YVCGKHLA2/tbN0G2GguCtD/RWJXVBr66zHIbMYAlBiSjdkBfh99KnL+jUFWJmrNGF
         Bd5n+cTmEvX3ACNnqUY2tnEPE1+MSKXDkdQTXYDYjZ2hXL+RLmoexyvHsVCXL/8m2s
         rI+REJqBp8anBSzTdcU8EkJuNYSzdmgQv5RIOVFn1V+XfB8f7KcrsAuHpKmrOXJIgO
         Gout30y0tH0QcPdCX6qO9FRmqnPuVWuhRri3aY5fX0XrRHSkB20D2CZ/dTx2tqXInM
         U1KmW+rANlowGiwdO90LCjNRlGXN1WJQc2E54RvFa8pgR4k7OqXO+GktY0R5wwK3Vd
         PDjGm6U/1lfqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0B4D960CD1;
        Fri, 16 Apr 2021 17:08:02 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.12-rc8 (or 5.12)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-769b7cf7-7dfb-455a-9bb3-99f5cd952dbe@palmerdabbelt-glaptop>
References: <mhng-769b7cf7-7dfb-455a-9bb3-99f5cd952dbe@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-769b7cf7-7dfb-455a-9bb3-99f5cd952dbe@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc8
X-PR-Tracked-Commit-Id: 7ae11635ec90072083503c6b6485cdffe46203b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 151501160401e2dc669ea7dac2c599b53f220c33
Message-Id: <161859288198.9941.13644971507967591628.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Apr 2021 17:08:01 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Apr 2021 09:57:52 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/151501160401e2dc669ea7dac2c599b53f220c33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
