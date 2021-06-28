Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CA3B6834
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhF1ST4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234928AbhF1STu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3CBAF61C3D;
        Mon, 28 Jun 2021 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624904244;
        bh=mwcqjKgCnoUd9i6lwaMIHjc8t2tQM3BBn/Uffiq4P1U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZmeJnOHdFpLQK8ZLYvqBqSeC+Yh/0cekUwJBabF2Y+37GHJpX7JNwN9MVPHyvzHLf
         NYOaGCoYm63cHLNgOt8kqyQtpgT0BsDnr/2rp+Ktxjqzs+UtyWF5Io3HxtEG70Z2k5
         FrNi3eUNk3ZciP3gw24hrqL1gF5E39Hv83rqkuRORMBmeqiQRZYJAb0L+QOfi/vMrY
         OcVbW5JhSnHBTyOERWZKZmZwTq7th2s6WCWDN11bL5tDILirO5hWJEENETbAo3V8dK
         KLmt6etKjhEFoYgi5ouPQBDk49hZVWDga6dTtQ1ajks+a0uGWIVvo6Psv4sID86Auu
         g7aXtyoccrzHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3681D60A71;
        Mon, 28 Jun 2021 18:17:24 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628145442.0C5CB61221@mail.kernel.org>
References: <20210628145442.0C5CB61221@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628145442.0C5CB61221@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.14
X-PR-Tracked-Commit-Id: d17032f2befaceef2c8c6b761ae657bc700b0be3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52f8cf8b0b540a8e4ebba52fe5ee3f57c2682f92
Message-Id: <162490424421.3852.10156829430335760815.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:17:24 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 15:54:02 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52f8cf8b0b540a8e4ebba52fe5ee3f57c2682f92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
