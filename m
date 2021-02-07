Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8853126AE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhBGSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBGSa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:30:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1FA4564E35;
        Sun,  7 Feb 2021 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612722555;
        bh=1zgaeYx43Si3vUM1SeG1tFfspfULk3bHLVW784V7OlM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kl2Ch8sROCjPXkbpjgFEtsUw4s3egWZUTvj2OorhRXvVtqhNxRvguoMuYM00e6E5H
         cN4e7fMLpaQoO03XjfKiVz1tQM9VsPh7HYw1yFA/f8brYjXT7JmUrs7s+o7X/w4DTV
         4t6rGEWy1YXUSHATKbAIzRqI2PbfhkrOeiUEdEa81iJmQ0A8I265rzTJHufNuLDzPG
         UYpTbjdM3mD4ijcUdCGRwhlIk+YDZK3Y6ChdxOJkqrjfeqQSHBlvbu5dwoozbbkIUA
         Qm1A/u0SHJFCHRAy7HZRtZ770eUqwgjppFSdwpziawwgpZhTJrbS8gvsrvRL+Hc9AR
         GrpMjbc5NvMlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 10D3960A10;
        Sun,  7 Feb 2021 18:29:15 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210207141543.GE32127@zn.tnic>
References: <20210207141543.GE32127@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210207141543.GE32127@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.11_rc7
X-PR-Tracked-Commit-Id: 4c7bcb51ae25f79e3733982e5d0cd8ce8640ddfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc6c0ae53af40f4cd86a504a71778d924cef43df
Message-Id: <161272255506.27145.6076505154402094564.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 18:29:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 15:15:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc6c0ae53af40f4cd86a504a71778d924cef43df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
