Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E033C289C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGIRo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhGIRo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 02007613C8;
        Fri,  9 Jul 2021 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852504;
        bh=pJcmaCaIOLENKJ1KBUdlbNR4S7+k03oVcRerjYEwjgY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KdEuD1W0bKSp4KKyPxXXVwfa5ABTF52rqygCkCk+sIv1spd1a+HOMonipbN6Ecle0
         JLEREbD3lgB3ORLEi2X6FzEej8p6leMmrD7eLLtN7dduyNEjH5TYiy2xKl5LvUf3gH
         3lfXTncDpRhJT8jvryLy2VzJLmFKB6GmUiDFuV+qSwJaaQz3Y2Hhxj58dvBMnX27xY
         WC6uCACalNu+KgPqg00lVyM1zaZC9Q+a4XHzqgoSxVhtL02I8L0HSRnvQY3OJ3x2u6
         xZueEA7yvE2aO5m54DTR5YEls1BPk7M8nlMaraPqFI3bwwbF1J1FqcvYVYg9vYcyGn
         m7+nF85hNfz6g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F07A7609B4;
        Fri,  9 Jul 2021 17:41:43 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.14 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-423e8bdb-977e-4b99-a1bb-b8c530664a51@palmerdabbelt-glaptop>
References: <mhng-423e8bdb-977e-4b99-a1bb-b8c530664a51@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-423e8bdb-977e-4b99-a1bb-b8c530664a51@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-mw0
X-PR-Tracked-Commit-Id: 1958e5aef5098e28b7d6e6a2972649901ebecace
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b76d71fa8be8c52dbc855ab516754f0c93e2980
Message-Id: <162585250397.25269.12449826811960534294.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 17:41:43 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Jul 2021 07:53:58 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b76d71fa8be8c52dbc855ab516754f0c93e2980

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
