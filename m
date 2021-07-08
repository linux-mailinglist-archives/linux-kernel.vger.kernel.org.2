Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E523C1A21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhGHTwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhGHTwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:52:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 36A4261624;
        Thu,  8 Jul 2021 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625773759;
        bh=B9RCB4X19xbIZdutfXulFdU1lYb6hchiDOkejg+sW0E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QoVFKOCjOy2t0UdjTrXWP77g1caS+xsamDtoNY4NOfFtaJ7lpBcYla7sxmuk4Oyfq
         7WqOfPW2Eeoky7FHehH93cIO43BXYY3nPQ8YCxvtAWWAt9E6O11gNdXShJdzHCSKaG
         1Duw7jD7kYUCP5+SagkmOHOWggByH51Dim9sg3XFbH8et0C8jJMAQOgKfSO4WICDrO
         x3Dr0gZjHlgYsgD8TI8HkTud1KZrI/iLuwDIaYPQd34keW3He8Ji4XW6OojQ/HWeRE
         uY8Y24r7VUdcQxODvMBdAxZrP2W626uItlz2sAtWLfJXnOwm/KyS86HmD1WbxW5Efk
         /IuThED3B3Xmg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 30D59609F6;
        Thu,  8 Jul 2021 19:49:19 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210708001431.437073-1-sboyd@kernel.org>
References: <20210708001431.437073-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210708001431.437073-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 783d08bd02f5d33d6e9e7fea62b727e2b6fe6462
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0dfd9af28b60d7ec42c359ae84c1ba97e093100
Message-Id: <162577375919.18035.2259842155066295152.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Jul 2021 19:49:19 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  7 Jul 2021 17:14:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0dfd9af28b60d7ec42c359ae84c1ba97e093100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
