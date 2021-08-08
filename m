Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02223E3C53
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 21:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhHHTBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 15:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhHHTBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 15:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CDFEB60F92;
        Sun,  8 Aug 2021 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628449254;
        bh=SBnOx8yOLXbhDJVlG0gHNxTWQqNjqVdY8HgvBljGFAw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TbtrhVFsx1ovwiVq88Vzd8AOpKUtDXMAix2/HAh16JF5QrqZlfq3lyS3X7l0XCS2W
         7enNGNtPMB+vubhiMFKDNG7ZvMTRmy6v6RRr1be6wphNxnAxx5/xNBKIig13MSQ/aC
         WwlxF1O1Zv1UUTnaC5orf1dxo7+1dm/68GtBup6MvaduFvbxmikT+aYRzIyvbRtqI8
         oYn6P1hsjtItDvFU8mYAInDlKVi5LDpStEyAGeIzVFKePC6aGhBEVarjhf6xdsOPTT
         tFRDy6Phy0C65uPc3KA03xk9t0RuwdADwxJYPzF6jjWjsNd6iFoR209Wi987OnOHee
         PRC6P3DWk1Rag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C62D560726;
        Sun,  8 Aug 2021 19:00:54 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162842243782.9524.4044852683603062793.tglx@xen13>
References: <162842243492.9524.2294192686333344509.tglx@xen13> <162842243782.9524.4044852683603062793.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162842243782.9524.4044852683603062793.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-08-08
X-PR-Tracked-Commit-Id: bb7262b295472eb6858b5c49893954794027cd84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cceb634774efca60f8cc57041234f00faf97f22d
Message-Id: <162844925480.12585.325311415353212342.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Aug 2021 19:00:54 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Aug 2021 11:33:57 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-08-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cceb634774efca60f8cc57041234f00faf97f22d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
