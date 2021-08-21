Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9825D3F3C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhHUSbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhHUSbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:31:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1BC0561184;
        Sat, 21 Aug 2021 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629570671;
        bh=BpQqXvAho9CbXg0NpQBYb1l0B79F8xSK87cdIzZ/PgY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qThNznKKx7fr69LaqCCC5VAjnYpjNOjFWajNChqAJ0MYAUpcICYCHdkbPh06tDuHJ
         o1gJCGQITw1TI/qmsa1gfVzhA6rwkLVmwvZmsVRzikMrDh40Ix0U3/5//bb6PerLg8
         vF+kPGx0K8xF+8lNxygdveqmNVOw5kpib9Gvkw/HHGUlyXrYOYPe1vSHXIsTJ5oFL5
         6415sPE1Mwdijd5Sk67dtwQKGYyh09LX0OPGLRXFjE5zWPyXBtbIt33u1E7AOKQgSd
         R6v44JaaZ7TvndauQpVCB8pzbaNdONLxS/Em2cn0l8cZMbGDhmGxbtzEiPtQPOxSMX
         8EviSncGHBisw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 07477609F2;
        Sat, 21 Aug 2021 18:31:11 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-182cc50e-78d7-4a85-a5bc-19e7a4648e87@palmerdabbelt-glaptop>
References: <mhng-182cc50e-78d7-4a85-a5bc-19e7a4648e87@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-182cc50e-78d7-4a85-a5bc-19e7a4648e87@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc7
X-PR-Tracked-Commit-Id: aa3e1ba32e553e611a58145c2eb349802feaa6eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a09434f181f3ae3a0a6a42bfcf0dc375f0eb26a2
Message-Id: <162957067097.18934.15011514073992976615.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 18:31:10 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Aug 2021 08:38:34 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a09434f181f3ae3a0a6a42bfcf0dc375f0eb26a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
