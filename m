Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC632745F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhB1UO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhB1UOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:14:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 716EA64E83;
        Sun, 28 Feb 2021 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614543246;
        bh=0Pl9rfApdTbzy47R2qOHGTpwbQ8m6Wv3tQpN2O2dDYc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ggDg3c9ftZ+lwvELtMluy8dQQxddcRLfvXEyPZ71ZbCJFUV9RAYZXZqW45gd6/SjG
         CacrmkPnMSecmypPCzEFslOKdO1kJu3wa+dz0rjPOT6EOZzpGNpt6WpBH78Fp9X4l6
         rGa/OB1z3SRi9V1sVfofvIovG4oF58fpbNvNqBt9C2Pl35jYX+Wd+8ToH+h24GhKVm
         Owmu3dOGUcfZ8ykjeajQGibyt0ZrYXF46nqA03SE/1tsaz7ddwK2em9+hzs547j/60
         gg+zbxWmlE8J0j/D5so+/VjYte+Fl0HLqMQaJvOczvZhQmT9YfQPkByVkKigztcu/F
         DQpGXMjdXC9TA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DDC560A2E;
        Sun, 28 Feb 2021 20:14:06 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.12 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-bd8c36a3-301b-4412-b3cd-a6eebd336f6c@palmerdabbelt-glaptop>
References: <mhng-bd8c36a3-301b-4412-b3cd-a6eebd336f6c@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-bd8c36a3-301b-4412-b3cd-a6eebd336f6c@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-mw1
X-PR-Tracked-Commit-Id: dd2d082b57602156e0c587ddb5ba04d0d624a6df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d19ea5e99731f5346b047003bbe65117a86d12d
Message-Id: <161454324644.2182.13358051381920056871.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Feb 2021 20:14:06 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Feb 2021 12:28:39 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d19ea5e99731f5346b047003bbe65117a86d12d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
