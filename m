Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDC33A7C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhCNUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233722AbhCNUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 521EF64EB0;
        Sun, 14 Mar 2021 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615752109;
        bh=qoZ8ixxM4Fsm3dNyRaedDkPEKAps+FUOAHve2r6kW8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mOH+UVsJr7BLeD+3rCqZ3efcRh3mTEgZ6rto3nNrwPMyj/HO0pjmCPtgHdypn1D+l
         f5/nt8l0E1+fuI+Pne5ce2N2JiIiYFtZjJR1FHfzubjjQ8aumZYLnQlPwBtgyjtJWM
         fIX3eDQHUuuYlVp3fqQW36wst26K+ItlyMTEZrI55Bw+JZSJ9jU+t4JnSd9kPHhLDv
         ENycejFrrrSxlHtekkYoZeWzDrFDRXu9yGELtbpOi1agN6r3zHm2tZ2EFf5Bm+HtGG
         TGDvR06TtP4jAKzsxuLomP5XYAfW+Ek/vNq4G4riwWJSJYx+p9yDUQzX4JQIYWNTU5
         KLriJXlpWl1xQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4D18B609C5;
        Sun, 14 Mar 2021 20:01:49 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210314120726.GA27191@zn.tnic>
References: <20210314120726.GA27191@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210314120726.GA27191@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12_rc3
X-PR-Tracked-Commit-Id: bffe30dd9f1f3b2608a87ac909a224d6be472485
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a7c10df49eb69dd888ea8b8ddd29bde2aa2fd48
Message-Id: <161575210931.6248.5819239026223979285.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:01:49 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 13:07:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a7c10df49eb69dd888ea8b8ddd29bde2aa2fd48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
