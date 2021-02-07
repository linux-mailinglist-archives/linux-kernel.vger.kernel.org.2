Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B53126AD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBGSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhBGS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 130B964DDF;
        Sun,  7 Feb 2021 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612722555;
        bh=0RRnWxoZcpthlVeH9Tq4HhK6gtYbL6vsmxwaRELiHuk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fd/U66LAKMdcIJL9sJkSQc16Xs5KTltq6thebRNbVGPiRQnCjGVMDlWsqs5i5L0pL
         ntn6buSqLUsbNee3NXh/4Vvui79kOhZr6x+mrERSSsR7mUkuw7QzHixQhXQAUYO8k3
         20DQnfWEOJQrHCD8nN0Scp6YReJ9O5ItUIiVHGOi1VjZUaxb6dS5XeC41HT8CKJTyx
         1o9W0sRCLIZXq/5/y2UH4B1VUXTR7cI8/8Z270a9aTV7s4BYuCYd38W8WU/BmbMRUm
         GRcSykRdeWj95my6iujlwVVEV3rmm3xYhtKmuWPXOHljzIisgasjBqI9pjVsohTKq9
         0RjelC9YM1mYw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 01E6A60985;
        Sun,  7 Feb 2021 18:29:15 +0000 (UTC)
Subject: Re: [GIT PULL] core/urgent for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210207114312.GD32127@zn.tnic>
References: <20210207114312.GD32127@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210207114312.GD32127@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.11_rc7
X-PR-Tracked-Commit-Id: 36a6c843fd0d8e02506681577e96dabd203dd8e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6792d44d8f08451047051351dfdcc8332a028e3
Message-Id: <161272255500.27145.8714617698922632281.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 18:29:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 12:43:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6792d44d8f08451047051351dfdcc8332a028e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
