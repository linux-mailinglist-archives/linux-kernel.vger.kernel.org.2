Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1177E320863
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhBUFMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhBUFIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 62DB864F16;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=FMheFChznSqlm0/KZPqm6b9ThJOQpOfNBJsmdMJCcsg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WInZCPFKP8nQIb/K/dtdy2Ir9CInXrazPZEyTWFmRRw33A0jphTsyIB9E6cfJ/Mw9
         KHMuqqJ6Xmbw9TVyqw98qv20ppjnWCDtWGhTswZVh10aZbYqQGV3t/Y5GAnjBR8OZm
         kI7jougCnM5J4zRusw7zioghePfQ94yFyPqy+DVG/K9Rk5sIoGDbOceQmLye8X6oq+
         v78fQc7FQnsixmlsEtfNTG4zzfg+DzApcIc2qaBJgu1rFWNG21jHibWR5J6vFU9e5F
         ZVLAQ3DoBUE5iqOZuuYu36u7aICN4Khuk8pGdEhvm76CiCsTD2xwaC79Jn/ZfMKTKT
         cwqWDacOsCAWg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5AA2E60A3D;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215115538.GC7265@zn.tnic>
References: <20210215115538.GC7265@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215115538.GC7265@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.12
X-PR-Tracked-Commit-Id: fb35d30fe5b06cc24444f0405da8fbe0be5330d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0570b69305276a349ef7a17c8c54dfeed76f3954
Message-Id: <161388399636.9594.3583814388989804002.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 12:55:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0570b69305276a349ef7a17c8c54dfeed76f3954

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
