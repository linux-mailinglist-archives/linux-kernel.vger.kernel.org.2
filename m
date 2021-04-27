Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A267A36CD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhD0UzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236965AbhD0UzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D7B0613F9;
        Tue, 27 Apr 2021 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619556878;
        bh=cHjICHP9xj/Tbn1YA/cBBkRR3Zu5/0tutesQG8W78/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vEFYgIlQ3tT8TI5ko8QdNfKFBfy+gqEvs3yYy4yPgTwaujRQN2ZH3D5ktMAfn6sQC
         ivm3mZZ19bxD9h9fztQwh44LFcUJD8YgvYjck7ym9f4E2uk88Xntf9QAw3YHH6AX8z
         KEMdfjHsp5MS2PTn3/GCoDvJjhuRrehhurZMpX109scv46AUwu0ZhxMst8x6aV0oYk
         PmPdJAxq9KYCRlWwDbo4dhOUo/bTHqAVXzmkMWXXLXgT7eQjBSUbBARnGExZT9qrDU
         HJON9YvivcBed+xbBDncI3bnzHp5wjS6V29Lr7NDwJV+PGtIlagPXw3bwd1VR8LIRN
         yjOtjZVPDnKTA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6833E609CC;
        Tue, 27 Apr 2021 20:54:38 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRBXj+WfsvqTKJNWBUOQgb=Ezarbm47RKMN4rRby5fd+Q@mail.gmail.com>
References: <CAHC9VhRBXj+WfsvqTKJNWBUOQgb=Ezarbm47RKMN4rRby5fd+Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRBXj+WfsvqTKJNWBUOQgb=Ezarbm47RKMN4rRby5fd+Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210426
X-PR-Tracked-Commit-Id: b75d8f38bcc9599af42635530c00268c71911f11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e359bce39d9085ab24eaa0bb0778bb5f6894144a
Message-Id: <161955687842.8723.8585981321129107536.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:54:38 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 19:35:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210426

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e359bce39d9085ab24eaa0bb0778bb5f6894144a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
