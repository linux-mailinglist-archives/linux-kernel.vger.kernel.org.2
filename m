Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B995240114C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhIETIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232996AbhIETIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C2D7661054;
        Sun,  5 Sep 2021 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630868826;
        bh=WAy7AwFQMkZqSv1On+4Aj57+KgG6VrmgBD9E2UYoupQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A3E5DsU0lbllmOPugMWCsq1V7RGiLtIXkyZm9m22I7bn0luG0iuQUR8DYg1U617Zv
         I9ybxqORH6km1SRkD/I4Pwf4xPa/RFC8pkatbnYu6riuxYVZ2Ug6Lk0Kbd0JXvuImO
         ZjGK5h+NEBwLEvCa5NiHc3P64JE3vPi3l1S52h219NSBFbAqp+rawj1D2zmnNeKUzR
         x3rufHlecsYwnciCjO+41xsBYcsrl30Yj990bKyW754S93DS/JtEQ4I3XY+pB+fO5g
         86ZlVzKMe+eNhY7d6AH/rjT3lfx1sMDMtnhdLXc8IlPlCtph8itHdQkkdXxID8miC8
         lxuXe+ezEMYrA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B885A609D9;
        Sun,  5 Sep 2021 19:07:06 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.15 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e13c978a-0771-4577-9adc-3a4b807fbfc2@palmerdabbelt-glaptop>
References: <mhng-e13c978a-0771-4577-9adc-3a4b807fbfc2@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-e13c978a-0771-4577-9adc-3a4b807fbfc2@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-mw0
X-PR-Tracked-Commit-Id: c24a19674258dcc968a198d8e0d4717c8f27700c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 063df71a574b88e94391a3a719cf66d1b46df884
Message-Id: <163086882674.6256.7268690011083399997.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Sep 2021 19:07:06 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 04 Sep 2021 17:15:57 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/063df71a574b88e94391a3a719cf66d1b46df884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
