Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDE3FAE2E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhH2TsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhH2Tr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 741CA60F38;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630266425;
        bh=+NSTZf1xJf7ehYyVKoQfg7TH54RlMYm99Tq5Ln0bhXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aY9PqWWtvJik/4lsDB529JzPr/yhcJUKXnb+xDOURLXQWQ9+O8sOw5NR3r29s6N6x
         NxeDajmKieAMKP5CvO15PZ8zcP3fthmFvIWiPIw9kmWvpiWL6tq0duRvv6bln1aqvT
         AKjzHcDFwaQSxZJwwN9jCyZpqQCuU4XSziPkFRIcmR9Cxi0i3mxNXzLclr1JgQmRiv
         7r/cRPliQP8eqS45AQ44Y41BbAoITbZNzqbGs8aUR9AfaHe2HZ07m6m7Mu5kTJft52
         LpQLXe1Vnh66TO1tWNiEvhKGUKPLHOEImql7sRwmtnHTipHfAAzflpkNbNhGYaRDKm
         KtAi9GBMGI1pg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6109960A27;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YStmdmbJidlytmUh@zn.tnic>
References: <YStmdmbJidlytmUh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YStmdmbJidlytmUh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.14
X-PR-Tracked-Commit-Id: 527f721478bce3f49b513a733bacd19d6f34b08c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 072a276745da10620c9b84a08519620670ba7496
Message-Id: <163026642533.27261.48754461354421131.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Aug 2021 19:47:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Aug 2021 12:50:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/072a276745da10620c9b84a08519620670ba7496

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
