Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9432F5AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCEV7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhCEV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:58:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C6FF964FF0;
        Fri,  5 Mar 2021 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981538;
        bh=qSlvjd7lHX1IcSdwxpNWwpReotxsICV4duCsNmcvrfI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EmCM/87KgHedXkXHJFNusqiY06qC2Z5E/9QrlYIZCWff/9BaSC1pM1X/Q82qibA2L
         gGkzK+YQpg8GA5Jdg8BYqERYCUjH1D4qgBJGGBCXJDptW3e3yQvLaQV5zh1nnC2w3J
         oxk6LL1AoYphLyPKHOagJVnn3Kl9ybg4RpjGatrIOHOSEVI0c212Myr/IBsPXXL0XD
         1SJXYxvN8F6x95xWA4VX4qJxAgC4P+MKs2YFaTSc9M/KTgU22pQUX/hIqrojEkNo02
         FZmKIvY6cSjMuKNZdAHWthnWkyQ1QKlFV/W3MMgks6KOWFn7xCUM3WjRtffId0udLc
         ce4iJiTS9SeMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BE72560A12;
        Fri,  5 Mar 2021 21:58:58 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210305091313.08f87d9d@gandalf.local.home>
References: <20210305091313.08f87d9d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210305091313.08f87d9d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc1
X-PR-Tracked-Commit-Id: f9f344479d8b40b3b001c913fb992d85d19261d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54663cf398e7b2c9e44aeffe41be04cecb9d47c5
Message-Id: <161498153877.14373.16775641735458776191.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:58:58 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Jun <chenjun102@huawei.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 09:13:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54663cf398e7b2c9e44aeffe41be04cecb9d47c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
