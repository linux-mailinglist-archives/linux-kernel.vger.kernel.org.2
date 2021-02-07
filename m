Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0803126AA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBGS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D72BC64DD4;
        Sun,  7 Feb 2021 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612722554;
        bh=MGG5W0qXzL3y8LK/rWc8OTfIml8X7zBWcVXs/Dv+cZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dm5t3xplq3d/8JJlxNce5EGhDmZDw+Nth+dAxBNkBw90LwqSo1cuIJZLftxJYrMm2
         MBt/NeZjzcuBop4s87NDDkjI2JQ5ngU2hdWJwiGRFSVcD8QwGHH9bo6NrUIAQieAnF
         Blei5FHMShB1y/OlCJs1voHhKenIh9ESEiHj7BiJ1BG4zqVQIiWChHUNREvaOsmNUi
         vSvvV0iuMGpejmZzeqmfF1rf3TSaKzH1gNLTsvyNo5k2K0L3xuXMqJmn/HgAMyqDrJ
         dyDxuGrQeGejGaGRe4I5h1jw4YVjsb/FRlCaDhLNozx1H9irjDKT3D8tFvwTg9B3Qm
         B2ddZri2DgSMw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CE0D160985;
        Sun,  7 Feb 2021 18:29:14 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210207104022.GA32127@zn.tnic>
References: <20210207104022.GA32127@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210207104022.GA32127@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc7
X-PR-Tracked-Commit-Id: 816ef8d7a2c4182e19bc06ab65751cb9e3951e94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e24f9c5f6e3127a0679d5ba5575a181b80f219c9
Message-Id: <161272255483.27145.3577736292700936464.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 18:29:14 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 11:40:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e24f9c5f6e3127a0679d5ba5575a181b80f219c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
