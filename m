Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D283FCF48
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbhHaVtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 17:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhHaVte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6B4A60200;
        Tue, 31 Aug 2021 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630446517;
        bh=Ko/P9GbxpuZgs4rSJ6mM6VxsFME888QczXjXrK2/i10=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pA0siQSQx54t4w6jcw8X/z5yCRCJ22DCQEmbtpR33ZG+p1cVxK6D4RSqkRjwk76V8
         /q3N2aS8KHYDuQzpwD62npNtWt6SNuQhpMAFzBizcVzdY7vaUxh026TywQIA5lpXT/
         Gd9TNdBY0NUTbs254P63HNqPq8MPnZY+t+nF/DB92btgUqQH5WlQaFFiKFdFwM1GCL
         72OTLBD+ReNhwv5fCmYIKqgpBkp22uInPZt2QnA8kNwCHdxrc4rbpwruXI/JMZVxEF
         RBsbKPXhlC7N0MnGR8wXYz1nfd9JcEsL3fom/SqDaoMhYuSCmK24xiGYSLIO4It0ca
         wGFYTqiuKfguw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2E4C60A6F;
        Tue, 31 Aug 2021 21:48:37 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830100856.512711-1-ulf.hansson@linaro.org>
References: <20210830100856.512711-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830100856.512711-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15
X-PR-Tracked-Commit-Id: a75c956162978097c0a60d95971c97ae486a68d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359f3d743f3a762cc2cc7ddb7c6fb4c57b9a06cc
Message-Id: <163044651767.1462.2797514515885449194.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 21:48:37 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:08:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359f3d743f3a762cc2cc7ddb7c6fb4c57b9a06cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
