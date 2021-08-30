Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1CF3FBF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhH3Wkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238281AbhH3WkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E38E16101C;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363168;
        bh=cOaj/Yaz4jTwzbz66PeUJoxn6eEwaLTXKqls8Ow/gG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KndvJrKP/cNXV524AEUoMynbZYMaDwjJudYEwLLc29JhLBTE4AygkjFpW66rLqZMJ
         RK8+zI6G5Y44GLvE0xhNah20UHc1irnIgCwhIq0GGAthJRPMNXiwb77sPX7NxpzhJ6
         l9LTXXz5jPhxB2EB02ngln+7k8xk/67XzEx1IrPz04t+RxNgo7Wmonad/6pfrIE2PS
         kXEJ+n0IgZ3jGUJar8/cMlhQ7JbT7Kn2p1aqelO2ohNu3e1oNv5z8APyNt+VHR6TY9
         20Ye+eHAHWV0n2eufFGbMMUgno/zab2y+Fu13y+53+tXejMrR6iPTGodE2QEjXvAmZ
         l7NPNRtVMisEw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D8B4E60A5A;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
Subject: Re: [GIT pull] x86/cpu for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993742.58256.16683258988343657253.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993742.58256.16683258988343657253.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993742.58256.16683258988343657253.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2021-08-30
X-PR-Tracked-Commit-Id: b7fe54f6c2d437082dcbecfbd832f38edd9caaf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a096f240aa1992ddac65f8e704f7b0c0795fe1c
Message-Id: <163036316888.23007.5874209421945393404.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:48 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a096f240aa1992ddac65f8e704f7b0c0795fe1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
